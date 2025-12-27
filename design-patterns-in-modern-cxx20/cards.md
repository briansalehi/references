# Design Patterns in Modern C++20

## Observer Pattern

## State Pattern

### In what scenarios do we need to apply state pattern?

When the state of an object causes a transition in behavior.

### What are the different ways of implementing states in the state pattern?

States can be classes with behaviors and these behaviors switch the actual state from one to another.

States and transitions are just enumerations. We have a special component called a state machine that performs the actual transition.

### Implement the state pattern using states as classes with behavior?

```cpp
#include <memory>

class Switch: public std::enable_shared_from_this<Switch>
{
    std::unique_ptr<SwitchState> m_state{nullptr};
public:
    Switch(): state{std::make_unique<SwitchOffState>()} { }
    void state(std::unique_ptr<SwitchState> state) { m_state = state; }
};
```

```cpp
struct SwitchState
{
    virtual void on(std::weak_ptr<Switch> switch) { }
    virtual void off(std::weak_ptr<Switch> switch) { }
};
```

```cpp
struct SwitchOffState final: SwitchState
{
    void off(std::weak_ptr<Switch> switch) override
    {
        if (std::shared_ptr<Switch> active_switch{switch.lock()}; active_switch)
        {
            active_switch->state(std::make_unique<SwitchOnState>());
        }
    }
};
```

```cpp
struct SwitchOnState final: SwitchState
{
    void on(std::weak_ptr<Switch> switch) override
    {
        if (std::shared_ptr<Switch> active_switch{switch.lock()}; active_switch)
        {
            active_switch->state(std::make_unique<SwitchOffState>());
        }
    }
};
```

```cpp
#include <memory>
#include <utility>

class Switch;

struct SwitchState
{
    virtual void on(std::weak_ptr<Switch>) { }
    virtual void off(std::weak_ptr<Switch>) { }
};

class Switch: public std::enable_shared_from_this<Switch>
{
public:
    Switch(): m_state{std::make_unique<SwitchOffState>()} { }
    void state(std::unique_ptr<SwitchState> state) { m_state = std::move(state); }
    void on() { m_state->on(shared_from_this()); }
    void off() { m_state->off(shared_from_this()); }
private:
    std::unique_ptr<SwitchState> m_state;
};

struct SwitchOffState final: SwitchState
{
    void on(std::weak_ptr<Switch> switch_ptr) override;
    void off(std::weak_ptr<Switch>) override { };
};

struct SwitchOnState final: SwitchState
{
    void off(std::weak_ptr<Switch> switch_ptr) override;
    void on(std::weak_ptr<Switch>) override { };
};

void SwitchOffState::on(std::weak_ptr<Switch> switch_ptr)
{
    if (std::shared_ptr<Switch> active_switch{switch_ptr.lock()}; active_switch)
    {
        active_switch->state(std::make_unique<SwitchOnState>());
    }
}

void SwitchOnState::off(std::weak_ptr<Switch> switch_ptr)
{
    if (std::shared_ptr<Switch> active_switch{switch_ptr.lock()}; active_switch)
    {
        active_switch->state(std::make_unique<SwitchOffState>());
    }
}

int main()
{
    auto light_switch{std::make_shared<Switch>()};
    light_switch->on();
    light_switch->off();
    light_switch->off();
}
```

### Impleemnt the state pattern using states as enumerations?

