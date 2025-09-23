# C++
# C++ Design Patterns: Behavioral
## course
## Packt Publishing
### video
### Umar Lone
#### surface

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

