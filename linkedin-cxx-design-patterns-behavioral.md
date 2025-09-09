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

When an object should notify many other objects about the change of a state, the observer pattern can be used. One of the most common use cases can be seen in Qt signals.

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





















