# FTXUI
# FTXUI Documentation
## manual
## GitHub
### page
### Arthur Sonzogni
#### surface

#### Text
##### ftxui/dom
###### Card

#### Vertical Text
##### ftxui/dom
###### Card

#### Paragraph
##### ftxui/dom
###### Card

#### Border
##### ftxui/dom
###### Card

#### Window
##### ftxui/dom
###### Card

#### Separator
##### ftxui/dom
###### Card

#### Gauge
##### ftxui/dom
###### Card

#### Graph
##### ftxui/dom
###### Card

#### Colors
##### ftxui/dom
###### Card

#### LinearGradient
##### ftxui/dom
###### Card

#### Style
##### ftxui/dom
###### Card

#### Layout
##### ftxui/dom
###### Card

#### Table
##### ftxui/dom
###### Card

#### Canvas
##### ftxui/dom
###### Card

#### Input
##### ftxui/component
###### Card

#### Menu
##### ftxui/component
###### Card

#### Toggle
##### ftxui/component
###### Card

#### CheckBox
##### ftxui/component
###### Card

#### RadioBox
##### ftxui/component
###### Card

#### Dropdown
##### ftxui/component
###### Card

#### Slider
##### ftxui/component
###### Card

#### Renderer
##### ftxui/component
###### Card

#### CatchEvent
##### ftxui/component
###### Card

#### Collapsible
##### ftxui/component
###### Card

#### Maybe
##### ftxui/component
###### Card

#### Container
##### ftxui/component
###### Card

#### ResizableSplit
##### ftxui/component
###### Card

#### Process Custom Events
##### ftxui/component
###### Card

#### C++20 Modules
##### C++20 Modules
###### Card

#### Piped Input
##### POSIX Piped Input in FTXUI
###### Toggle processing of piped input?

```cpp
#include <ftxui/screen.hpp>
#include <ftxui/component.hpp>

int main()
{
    ftxui::ScreenInteractive screen{ftxui::ScreenInteractive::FullScreen()};
    screen.HandlePipedInput(true); // enabled by default
    screen.Loop(component);
}
```

---
# FTXUI
#### surface

#### CMake Integration
###### Card

#### Library Structure
#### Dimension
#### Color
#### Pixel
#### Screen
#### Pixel Manipulation
#### Cursor Control
#### Text
#### Virtual Text
#### Paragraph
#### Border
#### Window
#### Separator
#### Gauge
#### Graph
#### Colors
#### LinearGradient
#### Style
#### Layout
#### Table
#### Canvas
#### Input
#### Menu
#### Toggle
#### CheckBox
#### RadioBox
#### Dropdown
#### Slider
#### Renderer
#### CatchEvent
#### Collapsible
#### Maybe
#### Container
#### ResizableSplit
#### Process Custom Events
#### C++20 Modules

#### Piped Input
###### Toggle processing of piped input?
