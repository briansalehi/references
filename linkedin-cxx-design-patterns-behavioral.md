# C++
# C++ Design Patterns: Behavioral
## course
## Packt Publishing
### video
### Umar Lone

#### surface
#### Command

##### Command Pattern

###### What specific situation should remind you to consider using the Command design pattern in your program design?

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

#### Memento

##### Memento Pattern

###### What are the use cases of Memento design pattern?

Without violating encapsulation, capture and externalize an object's internal state so that the object can be restored to this state later.

###### What specific situation should remind you to consider using the Memento design pattern in your program design?

###### What is the structure of the Memento pattern?

* `Originator`: knows how to store and restore its state
* `Caretaker`: knows why and when the `Originator` needs to be stored or restored
* `Memento`: written and read by `Originator` and used by the `Caretaker` to save `Originator` state

The `Caretaker` will not and should not be able to modify the state of the `Memento`.

```plantuml
```

`Memento` has a wide interface to the `Originator`, and a narrow interface to the `Caretaker`. Only the narrow interface should be public.

###### What are the disadvantages of Memento design pattern?

Memento consumes too much memory. It should be stored in a file or at least incremental changes of the state should be stored in memory.




















