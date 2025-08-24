# C++
# C++ Design Patterns: Behavioral
## course
## Packt Publishing
### video
### Umar Lone

#### surface
#### Strategy

##### Strategy

###### What is the structure of strategy pattern?

```plantuml
class Context {
  - strategy: Strategy*
  + ContextInterface()
  + setStrategy(strategy: Strategy*)
}

Abstract Strategy {
  # {abstract} algorithmInterface()
}

Context -|> Strategy

class StrategyA {
  + algorithmInterface()
}

class StrategyB {
  + algorithmInterface()
}

class StrategyC {
  + algorithmInterface()
}

Strategy <|-- StrategyA
Strategy <|-- StrategyB
Strategy <|-- StrategyC
```

###### What are the definitions of strategy pattern?

* There exists a context class which has a functionality that can be done with different strategies
* We want to be able to change the strategy of that functionality on runtime
* We define an interface for that strategy, because implementing the functionality directly inside the context class violates the Open-Closed principle
* We implement each strategy in a separate class that implements the strategy interface, otherwise implementing each strategy by extending the context class will leave strategies tightly coupled to the context class by only overriding one method which does not make the strategies a kind of context class, which violates the Liskov Substitution principle
* The relationship between the context and strategy is composition
* The context class contains a pointer to the strategy interface, using a concrete strategy class violates the Dependency Inversion principle
* When context calls on the functionality, it delegates the call to the strategy class, or it can have a default behavior if no strategy is set

###### Implement the strategy pattern?

```cpp
#pragma once

#include <memory>
#include <Strategy.hpp>

class Context: public std::enable_shared_from_this<Context>
{
    std::unique_ptr<Strategy> m_strategy;

public:
    Context(): m_strategy{nullptr} {}

    void setStrategy(std::unique_ptr<Strategy> strategy) noexcept
    {
        m_strategy = std::move(strategy);
    }

    void contextInterface()
    {
        if (m_strategy)
        {
            m_strategy->execute(std::weak_ptr<Context>{shared_from_this()});
        }
        else
        {
            std::println("Default Strategy: {}", getData());
        }
    }

    [[nodiscard]] std::string getData() const&
    {
        return "Context Data";
    }
};
```

```cpp
#pragma once

#include <memory>

class Context;

class Strategy
{
public:
    virtual void execute(std::weak_ptr<Context> context) = 0;
    virtual ~Strategy() = default;
};
```

```cpp
#pragma once

#include <string>
#include <memory>
#include <print>
#include <Strategy.hpp>
#include <Context.hpp>

class StrategyA: public Strategy
{
public:
    ~StrategyA() override = default;

    void execute(std::weak_ptr<Context> context) override
    {
        if (auto ctx{context.lock()})
        {
            std::string data = ctx->getData();
            std::println("Strategy A: {}", data);
        }
    }
};
```

```cpp
#pragma once

#include <string>
#include <memory>
#include <print>
#include <Strategy.hpp>
#include <Context.hpp>

class StrategyB: public Strategy
{
public:
    ~StrategyB() override = default;

    void execute(std::weak_ptr<Context> context) override
    {
        if (auto ctx{context.lock()})
        {
            std::string data{ctx->getData()};
            std::println("Strategy B: {}", data);
        }
    }
};
```

```cpp
#include <Context.hpp>
#include <StrategyA.hpp>
#include <StrategyB.hpp>

int main()
{
    std::shared_ptr<Context> context{std::make_shared<Context>()};
    context->setStrategy(std::move(std::make_unique<StrategyA>()));
    context->setStrategy(std::move(std::make_unique<StrategyB>()));
    context->contextInterface();
}
```

###### When do we inject the strategy into the context through constructor and when do we use a setter method?

When the strategy should only be set once and not change during the lifetime of the context object, we inject the strategy through the constructor. Otherwise, we use a setter method to set or change the strategy anytime.

For example, when the context operates concurrently, we can define two strategies for locking policy, one which does not use any locks because the system is single threaded, and another which uses mutex locks because the system is multithreaded. In this case, we can inject the strategy through the constructor because the locking policy will not change during the lifetime of the context object.

###### What is the implementation of non-member strategy pointer?

Instead of constructing a concrete strategy and setting it in the context, we can take the strategy as a parameter in the `contextInterface()` method.

#### Null Object

##### Strategy

###### What is the definition of null object pattern?

* The null object pattern is an alternative to manual null checks
* Null object is a default strategy that the context class uses automatically when no strategy is set
* Null object can be a singleton because it does not have any state
* Null class implements the strategy interface but either does nothing or has a default behavior

###### Implement the strategy pattern with null object pattern?

The `contextInteraface()` method does not need to check if the strategy is null anymore.

```hpp
#pragma once

#include <memory>
#include <Strategy.hpp>

class Context: public std::enable_shared_from_this<Context>
{
    std::unique_ptr<Strategy> m_strategy;
public:
    Context();
    void setStrategy(std::unique_ptr<Strategy> strategy) noexcept;
    void contextInterface();
    [[nodiscard]] std::string getData() const&;
};
```

```cpp
#include <Context.hpp>
#include <DefaultStrategy.hpp>

Context::Context()
    : m_strategy{std::make_unique<DefaultStrategy>()}
{
}

void Context::setStrategy(std::unique_ptr<Strategy> strategy) noexcept
{
    m_strategy = std::move(strategy);
}

void Context::contextInterface()
{
    m_strategy->execute(shared_from_this());
}

[[nodiscard]] std::string Context::getData() const&
{
    return "Context Data";
}
```

```cpp
#pragma once

#include <memory>

class Context;

class Strategy
{
public:
    virtual void execute(std::weak_ptr<Context> context) = 0;
    virtual ~Strategy() = default;
};
```

```hpp
#pragma once

#include <string>
#include <memory>
#include <print>
#include <Strategy.hpp>

class Context;

class DefaultStrategy: public Strategy
{
public:
    ~DefaultStrategy() override = default;
    void execute(std::weak_ptr<Context> context) override;
};
```

```cpp
#include <string>
#include <memory>
#include <print>
#include <DefaultStrategy.hpp>
#include <Context.hpp>

void DefaultStrategy::execute(std::weak_ptr<Context> context)
{
    if (std::shared_ptr<Context> ctx{context.lock()})
    {
        std::string data = ctx->getData();
        std::println("Default Strategy: {}", data);
    }
}
```

The null object can only be injected to the context through the constructor, because it is a default strategy that the context uses automatically when no strategy is set.

```cpp
#include <Context.hpp>
#include <StrategyA.hpp>
#include <StrategyB.hpp>
#include <DefaultStrategy.hpp>

int main()
{
    std::shared_ptr<Context> context{std::make_shared<Context>()};
    context->contextInterface();
}
```

#### Static Strategy

##### Strategy

###### What are the differences between static and dynamic strategy patterns?

* Strategy is defined at compile time, whereas dynamic strategy is defined at runtime
* Static strategy is implemented using templates by passing the type of the strategy as a template parameter to the context class, whereas dynamic strategy is implemented using inheritance and polymorphism by setting the strategy through a setter method or constructor of the context class
* Static strategy does not have the overhead of virtual function calls, whereas dynamic strategy has the overhead
* Static strategy is less flexible but should be preferred when the strategy does not change during the lifetime of the context object

#### Template Method

##### Template Method
