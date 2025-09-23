# C++
# C++ Design Patterns: Behavioral
## course
## Packt Publishing
### video
### Umar Lone
#### surface

#### Observer Pattern
##### Observer

###### What specific scenario would remind you of using the Observer pattern in your program?

When a change to an object requires changing other objects as well, but we don't know how many objects need to be changed.

###### What is the structure of Observer pattern?

```plantuml
abstract Subject {
  # {abstract} attach(observer: Observer*)
  # {abstract} detach(observer: Observer*)
  # {abstract} notify()
}
note left: notify() {\n  for (auto observer: observers)\n    observer->update();\n}

abstract Observer {
  # update(): void
}

class ConcreteSubject {
  - property
  + attach(observer: Observer*)
  + detach(observer: Observer*)
  + notify()
}

class ConcreteObserver {
  - subject: Subject*
  + update(): void
}
note bottom: update() {\n  auto property = subject->getProperty();\n}

Subject <|-- ConcreteSubject
Observer <|-- ConcreteObserver
Subject "1" o. "n" Observer
Subject ..o ConcreteObserver
```

###### Implement Observer pattern?

In observer there are two objects involved. The subject and NPCs. There is a one to many connection between subject and its dependencies so that when the subject changes state, all of its dependencies are notified.

```hpp
#pragma once

#include <memory>

class Subject;

class Observer
{
public:
    virtual ~Observer() = default;
    virtual void update(std::weak_ptr<Subject> subject) = 0;
};
```

```hpp
#pragma once

#include <memory>
#include <string>
#include <list>

class Observer;

class Subject: public std::enable_shared_from_this<Subject>
{
public:
    Subject() = default;
    virtual ~Subject() = default;
    void attach(std::shared_ptr<Observer> observer);
    void detach(std::shared_ptr<Observer> observer);
    [[nodiscard]] std::string getValue() const noexcept;
    void setValue(std::string value);
protected:
    void notify();
private:
    std::list<std::shared_ptr<Observer>> m_observers;
    std::string m_value;
};
```

```cpp
#include <Subject.hpp>
#include <Observer.hpp>

void Subject::attach(std::shared_ptr<Observer> observer)
{
    m_observers.insert(m_observers.end(), observer);
}

void Subject::detach(std::shared_ptr<Observer> observer)
{
    m_observers.remove(observer);
}

void Subject::notify()
{
    for (std::shared_ptr<Observer> observer: m_observers)
    {
        observer->update(shared_from_this());
    }
}

std::string Subject::getValue() const noexcept
{
    return m_value;
}

void Subject::setValue(std::string value)
{
    m_value = std::move(value);
    notify();
}
```

```hpp
#pragma once

#include <memory>
#include <Observer.hpp>

class Subject;

class ConcreteObserver: public Observer
{
public:
    void update(std::weak_ptr<Subject> subject) override;
};
```

```cpp
#include <print>
#include <ConcreteObserver.hpp>
#include <Subject.hpp>

void ConcreteObserver::update(std::weak_ptr<Subject> subject)
{
    if (std::shared_ptr<Subject> s{subject.lock()})
    {
        std::println("ConcreteObserver: {}", s->getValue());
    }
}
```

```cpp
#include <Subject.hpp>
#include <ConcreteObserver.hpp>

int main()
{
    std::shared_ptr<Subject> subject{std::make_shared<Subject>()};
    std::shared_ptr<Observer> observer{std::make_shared<ConcreteObserver>()};

    subject->attach(observer);
    subject->setValue("something changed");
}
```

###### Implement Observer pattern with a connection manager?

```hpp
#pragma once

#include <memory>

class Notifier;

class Observer
{
public:
    virtual ~Observer() = default;
    virtual void update(std::weak_ptr<Notifier> notifier) = 0;
};
```

```hpp
#pragma once

#include <memory>

class ConnectionManager;

class Notifier: public std::enable_shared_from_this<Notifier>
{
public:
    virtual ~Notifier() = default;
protected:
    virtual void notify() = 0;
};
```

```hpp
#pragma once

#include <string>
#include <Notifier.hpp>

class ConcreteNotifier: public Notifier
{
public:
    explicit ConcreteNotifier(std::shared_ptr<ConnectionManager> manager);
    ~ConcreteNotifier() override = default;

    [[nodiscard]] std::string getValue() const noexcept;
    void setValue(std::string value);
protected:
    void notify() override;
private:
    std::shared_ptr<ConnectionManager> m_manager;
    std::string m_value;
};
```

```cpp
#include <ConcreteNotifier.hpp>
#include <ConnectionManager.hpp>

ConcreteNotifier::ConcreteNotifier(std::shared_ptr<ConnectionManager> manager)
    : m_manager{manager}
{
}

void ConcreteNotifier::notify()
{
    m_manager->notify(shared_from_this());
}

std::string ConcreteNotifier::getValue() const noexcept
{
    return m_value;
}

void ConcreteNotifier::setValue(std::string value)
{
    m_value = std::move(value);
    notify();
}
```

```hpp
#pragma once

#include <memory>
#include <unordered_map>
#include <list>

class Notifier;
class Observer;

class ConnectionManager
{
public:
    void connect(std::shared_ptr<Notifier> notifier, std::shared_ptr<Observer> observer);
    void disconnect(std::shared_ptr<Notifier> notifier, std::shared_ptr<Observer> observer);
    void notify(std::shared_ptr<Notifier> notifier);
private:
    std::unordered_map<std::shared_ptr<Notifier>, std::list<std::shared_ptr<Observer>>> m_notifiers;
};
```

```cpp
#include <ConnectionManager.hpp>
#include <Notifier.hpp>
#include <Observer.hpp>

void ConnectionManager::connect(std::shared_ptr<Notifier> notifier, std::shared_ptr<Observer> observer)
{
    m_notifiers[notifier].push_back(observer);
}

void ConnectionManager::disconnect(std::shared_ptr<Notifier> notifier, std::shared_ptr<Observer> observer)
{
    m_notifiers[notifier].remove(observer);
}

void ConnectionManager::notify(std::shared_ptr<Notifier> notifier)
{
    for (std::shared_ptr<Observer> observer: m_notifiers[notifier])
    {
        observer->update(notifier);
    }
}
```

```hpp
#pragma once

#include <memory>
#include <Observer.hpp>

class Notifier;

class ConcreteObserver: public Observer
{
public:
    void update(std::weak_ptr<Notifier> notifier) override;
};
```

```cpp
#include <print>
#include <ConcreteObserver.hpp>
#include <ConcreteNotifier.hpp>

void ConcreteObserver::update(std::weak_ptr<Notifier> notifier)
{
    if (std::shared_ptr<Notifier> n{notifier.lock()})
    {
        if (std::shared_ptr<ConcreteNotifier> c{std::dynamic_pointer_cast<ConcreteNotifier>(n)})
        {
            std::println("ConcreteObserver: {}", c->getValue());
        }
    }
}
```

```cpp
#include <ConnectionManager.hpp>
#include <ConcreteNotifier.hpp>
#include <ConcreteObserver.hpp>

int main()
{
    std::shared_ptr<ConnectionManager> manager{std::make_shared<ConnectionManager>()};
    std::shared_ptr<ConcreteNotifier> notifier{std::make_shared<ConcreteNotifier>(manager)};
    std::shared_ptr<ConcreteObserver> observer{std::make_shared<ConcreteObserver>()};

    manager->connect(notifier, observer);

    notifier->setValue("something changed"); // registered observers will be notified
}
```

#### Mediator Pattern
##### Mediator

###### What is the structure of Mediator pattern?

```plantuml
abstract Mediator {
}

class ConcreteMediator {
}

abstract Colleague {
}

class ColleagueB {
}

class ColleagueA {
}

Mediator <-- Colleague
Mediator <|-- ConcreteMediator
Colleague <|-- ColleagueA
Colleague <|-- ColleagueB
ConcreteMediator --> ColleagueA
ConcreteMediator --> ColleagueB
```

###### What are the variations of Mediator pattern?

Abstract mediators are only useful when:

* colleagues interact with different mediators
* colleagues interact with a mediator in case of specific events

There are two implementation variations for the Mediator pattern:

1. with Observer pattern, when a colleague needs to notify other colleagues
2. with Command pattern, when the mediator needs to handle an action requested by colleagues

###### Implement Mediator pattern based on Observer pattern?

```hpp
```

```hpp
```

```cpp
```

```hpp
```

```cpp
```

```hpp
```

```cpp
```

###### Implement Mediator pattern based on Command pattern?

