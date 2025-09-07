# C++
# C++ Design Patterns: Behavioral
## course
## Packt Publishing
### video
### Umar Lone

#### surface
#### Command Pattern

##### Command

###### What specific situation should remind you of using the Command pattern in your program?

* When there are two coupled objects and they are directly invoking calls on the other via callbacks
* When can also use this pattern when we want to implement undo and redo behavior
* When we want to create a macro of multiple commands

###### What is the structure of the Command pattern?

```plantuml
class Invoker {
  - command: Command
}

class Receiver {
  + action()
}

abstract Command {
  # execute()
}

class ConcreteCommand {
  - receiver: Receiver*
  + execute()
}
note bottom: receiver->action()

Invoker <.. Receiver
Invoker -> Command
Command <|-- ConcreteCommand
Receiver <- ConcreteCommand
```

###### Implement the command pattern?

```hpp
#pragma once

#include <Command.hpp>

class Invoker
{
private:
    std::shared_ptr<Command> command;
public:
    Invoker(std::shared_ptr<Command> command): command{command}
    {
    }

    virtual ~Invoker() = default;

    void execute()
    {
        command->execute();
    }
};
```

```hpp
#pragma once

#include <iostream>

class Receiver
{
public:
    void action()
    {
        std::cout << "performing action" << std::endl;
    }
};
```

```hpp
#pragma once

class Command
{
public:
    virtual ~Command() = default;
    virtual void execute() = 0;
};
```

```hpp
#pragma once

#include <Receiver.hpp>

class ConcreteCommand: public Command
{
private:
    std::shared_ptr<Receiver> receiver;
public:
    ConcreteCommand(std::shared_ptr<Receiver> receiver): receiver{receiver}
    {
    }

    void execute() override
    {
        receiver->action();
    }
};
```

```cpp
#include <memory>
#include <Invoker.hpp>
#include <Receiver.hpp>
#include <ConcreteCommand.hpp>

int main()
{
    std::shared_ptr<Receiver> receiver{std::make_shared<Receiver>()};
    std::shared_ptr<Command> command{std::make_shared<ConcreteCommand>(receiver)};
    std::unique_ptr<Invoker> invoker{std::make_unique<Invoker>(command)};

    invoker->execute();
}
```

#### Memento Pattern

##### Memento

###### What specific situation would remind you of using the Memento pattern in your program?

Sometimes we may need to store and restore the state of an object (`Originator`) either in memory or a permanent storage, but implementing state management inside the same object violates the Single Responsibility principle.

With Memento pattern, we can give this responsibility to an external object (`Caretaker`) without exposing the internal state of the object (`Originator`) to the public interface, thus avoids violating encapsulation.

###### What is the structure of the Memento pattern?

* `Originator`: the object that we want to store its properties so that later we can restore them in order to take the object in its previous state
* `Memento`: the object that holds the state of the `Originator`, which can be a class inside the `Originator` encapsulating all of its properties
* `Caretaker`: the object that takes `Memento` to store and restore the state of the `Originator`.

`Memento` does not expose the internal state of `Originator` to the public.

The `Caretaker` will not and should not be able to modify the state of the `Memento`.

```plantuml
class Originator {
  - property
  # getState(): Memento*
  # setState(memento: Memento*): void

  + setProperty(property): void
  + getProperty(): property
}

class Memento {
  - property
  + friend Originator
  + Memento()
}

class Caretaker {
  + store(state: Memento*): void
  + restore(): Memento*
}

Originator .> Memento
Memento *.. Caretaker
```

`Memento` has a wide interface to the `Originator`, and a narrow interface to the `Caretaker`. Only the narrow interface should be public.

###### What are the disadvantages of Memento design pattern?

* If the `Originator` object has a large amount of properties, storing its state with `Memento` will consumes too much memory.
* Restricting access to `Originator` properties will make code harder to read.
* Since `Caretaker` does not know much state the `Memento` holds, it might incur storage costs while storing `Memento`.

###### Implement the Memento pattern?

```hpp
#pragma once

#include <string>
#include <memory>
#include <Memento.hpp>

class Originator
{
public:
    [[nodiscard]] std::string getText() const;
    void setText(std::string edited);
    [[nodiscard]] std::shared_ptr<Memento> getState() const;
    void setState(std::weak_ptr<Memento> state);
private:
    std::string text;
};
```

```cpp
#include <utility>
#include <Originator.hpp>

std::string Originator::getText() const
{
    return text;
}

void Originator::setText(std::string edited)
{
    text = std::move(edited);
}

std::shared_ptr<Memento> Originator::getState() const
{
    std::shared_ptr<Memento> state{std::make_shared<Memento>()};
    state->text = text;
    return state;
}

void Originator::setState(std::weak_ptr<Memento> state)
{
    if (std::shared_ptr<Memento> capturedState{state.lock()})
    {
        text = capturedState->text;
    }
}
```

```hpp
#pragma once

#include <string>

class Originator;

class Memento
{
private:
    std::string text;
    friend Originator;
};
```

```hpp
#pragma once

#include <memory>
#include <Memento.hpp>

class Caretaker
{
public:
    void store(std::shared_ptr<Memento> state);
    [[nodiscard]] std::weak_ptr<Memento> restore() const;
private:
    std::shared_ptr<Memento> state;
};
```

```cpp
#include <Caretaker.hpp>

void Caretaker::store(std::shared_ptr<Memento> state)
{
    this->state = state;
}

std::weak_ptr<Memento> Caretaker::restore() const
{
    return state;
}
```

```cpp
#include <memory>
#include <print>
#include <Originator.hpp>
#include <Memento.hpp>
#include <Caretaker.hpp>

int main()
{
    std::shared_ptr<Originator> originator{std::make_shared<Originator>()};
    std::shared_ptr<Caretaker> caretaker{std::make_shared<Caretaker>()};

    originator->setText("Initial text");
    caretaker->store(originator->getState());
    std::println("{}", originator->getText());

    originator->setText("Edited text");
    std::println("{}", originator->getText());

    originator->setState(caretaker->restore());
    std::println("{}", originator->getText());
}
```

#### Chain of Responsibility Pattern

##### Chain of Responsibility

###### What is the structure of Chain of Responsibility pattern?

```plantuml
class Context {
  - handler: Handler*
  + request(): bool
}

abstract Handler {
  # {abstract} next(): Handler*
  # {abstract} execute(): bool
}

class ConcreteHandler {
  + next(): Handler*
  + execute(): bool
}

Handler <|-- ConcreteHandler
Context o- Handler
```

###### What are the differences between Decorator and Chain of Responsibility pattern?

* Decorator adds more behavior to an object at runtime, but chain of responsibility handles a request without specifying an explicit handler
* All decorators perform actions while in chain of responsibility not all handlers may handle the request

#### Observer Pattern

##### Observer

###### 

















