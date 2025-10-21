# FTXUI
# FTXUI Documentation
## manual
## GitHub
### page
### Arthur Sonzogni
#### surface

#### CMake Integration
##### Library Integration

###### Integrate ftxui library into your project?

```cmake
cmake_minimum_required(VERSION 4.0)
project(Example VERSION 1.0 LANGUAGES CXX)

find_package(ftxui 5.0.0 CONFIG REQUIRED COMPONENTS component dom screen)

add_executable(program main.cpp)
target_link_libraries(program PRIVATE ftxui::component ftxui::dom ftxui::screen)
```

Alternatively, we can integrate it with `FetchContent`:

```cmake
cmake_minimum_required(VERSION 4.0)
project(Example VERSION 1.0 LANGUAGES CXX)

include(FetchContent)

FetchContent_Declare(ftxui
    GIT_REPOSITORY https://github.com/ArthurSonzogni/FTXUI
    GIT_TAG v5.0.0
)
FetchContent_MakeAvailable(ftxui)

add_executable(program main.cpp)
target_link_libraries(program PRIVATE ftxui::component ftxui::dom ftxui::screen)
```

```cpp
#include <ftxui/component.hpp>
#include <ftxui/dom.hpp>
#include <ftxui/screen.hpp>

int main()
{
}
```

###### Manually link to ftxui library?

```cpp
#include <ftxui/screen.hpp>
#include <ftxui/dom.hpp>
#include <ftxui/component.hpp>

int main()
{
}
```

```sh
g++ -o program -lftxui-screen -lftxui-dom -lftxui-component main.cpp
```

#### Library Structure
##### ftxui

###### What are the use cases of screen module in ftxui?

The module `screen` handles the low-level rendering.

This module represents the `ftxui::Screen` type, which is a 2D grid of styled characters, the `ftxui::Pixel` type which is the unit of rendering, the `ftxui::Color` type which is used to define foreground and background colors for each `ftxiu::Pixel`, and the `ftxui::Dimension` type which is taken by `ftxui::Screen` to control screen sizing.

###### What are the use cases of dom module in ftxui?

The module `dom` handles layout and composition.

In this module, the `ftxui::Element` is a tree structure for layout and UI. This module also provides composable and responsive elements. The `ftxui::Render` is also responsible to draw layouts onto a `ftxui::Screen`.

###### What are the use cases of component module in ftxui?

The module `component` provides functionalities for user interaction.

In this module, `ftxui::Component` represents stateful and interactive widgets, provides built-in `ftxui::Checkbox`, `ftxui::Input`, `ftxui::Menu`, and `ftxui::Button`. This module supports keyboard and cursor input and composition.

#### Dimension
##### ftxui/screen

###### Declare a dimension type representing full screen size?

```cpp
#include <ftxui/screen/screen.hpp>

int main()
{
    ftxui::Dimension size{ftxui::Dimension::Full()};
}
```

###### Declare a dimension type representing a fixed size?

```cpp
#include <ftxui/screen/screen.hpp>

int main()
{
    ftxui::Dimension size{ftxui::Dimension::Fixed(5)};
}
```

###### Declare a dimension type representing the size of an element?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element text{ftxui::text("Two Dimensions")};
    ftxui::Dimensions size{ftxui::Dimension::Fit(text)};
}
```

###### Access to the dimensions of a dimension type?

```cpp
#include <ftxui/screen/screen.hpp>
#include <print>

int main()
{
    ftxui::Dimensions size{ftxui::Dimension::Fixed(10)};
    std::println("{}x{}", size.dimx, size.dimy);
}
```

#### Color
##### ftxui/screen

###### What color spaces are supported by ftxui?

* Default terminal color by `ftxui::Color::Default`
* Palette 16 colors by `ftxui::Color::<Color>`:
  * `ftxui::Color::Black`
  * `ftxui::Color::Red`
  * `ftxui::Color::Green`
  * `ftxui::Color::Yellow`
  * `ftxui::Color::Blue`
  * `ftxui::Color::Magenta`
  * `ftxui::Color::Cyan`
  * `ftxui::Color::GrayLight`
  * `ftxui::Color::GrayDark`
  * `ftxui::Color::RedLight`
  * `ftxui::Color::GreenLight`
  * `ftxui::Color::YellowLight`
  * `ftxui::Color::BlueLight`
  * `ftxui::Color::MagentaLight`
  * `ftxui::Color::CyanLight`
  * `ftxui::Color::White`
* Palette 256 colors by `ftxui::Color::<Palette>`:
  * `ftxui::Color::CadetBlue`
  * `ftxui::Color::Tan`
  * `ftxui::Color::Violet`
  * `ftxui::Color::BlueViolet`
  * `ftxui::Color::DarkViolet`
  * `ftxui::Color::DarkBlue`
  * `ftxui::Color::LightGreen`
  * `ftxui::Color::DarkGreen`
  * `ftxui::Color::DarkSeaGreen`
  * `ftxui::Color::DarkKhaki`
  * `ftxui::Color::DarkMagenta`
  * `ftxui::Color::DarkOrange`
  * `ftxui::Color::DarkRed`
  * `ftxui::Color::HotPink`
  * `ftxui::Color::MediumOrchid`
  * ...
* RGB color space by `ftxui::Color::RGB(uint8_t red, uint8_t green, uint8_t blue)`
* RGBA color space by `ftxui::Color::RGBA(uint8_t red, uint8_t green, uint8_t blue, uint8_t alpha)`
* HSV color space by `ftxui::Color::HSV(uint8_t hue, uint8_t saturation, uint8_t value)`
* HSVA color space by `ftxui::Color::HSVA(uint8_t hue, uint8_t saturation, uint8_t value, uint8_t alpha)`
* Interpolate by `ftxui::Color::Interpolate(float t, Color a, Color b)`
* Blend two colors using alpha channel by `ftxui::Color::Blend(Color lhs, Color rhs)`

###### Use literals to create a color object?

```cpp
#include <ftxui/screen/color.hpp>

int main()
{
    ftxui::Color blue{"ff009b"_rgb};
}
```

#### Pixel
##### ftxui/screen

###### What are the properties of a pixel?

Each cell in the screen grid is a `ftxui::Pixel`, which holds a `character` of type `std::string` containing a Unicode codepoint, color properties `foreground_color` and `background_color` of type `ftxui::Color`, and a bitfield of characteristics like `blink`, `bold`, `dim`, `inverted`, `underlined`, `underlined_double`, and `strikethrough`.

```cpp
struct Pixel
{
  bool blink : 1;
  bool bold : 1;
  bool dim : 1;
  bool inverted : 1;
  bool underlined : 1;
  bool underlined_double : 1;
  bool strikethrough : 1;
  bool automerge : 1;

  uint8_t hyperlink = 0;

  std::string character = " ";

  Color background_color = Color::Default;
  Color foreground_color = Color::Default;
};
```

#### Screen
##### ftxui/screen

###### Create a full-size screen?

The `ftxui::Screen` type provides two overloaded constructors. When one `ftxui::Dimensions` type is passed, it sets both width and height of the screen. When two dimensions given, the first represents the width and the second represents the height of screen.

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/screen/color.hpp>

int main()
{
    ftxui::Screen screen{ftxui::Screen::Create(ftxui::Dimension::Full())};
    screen.Print();
}
```

###### Create a custom size screen?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/screen/color.hpp>

int main()
{
    ftxui::Screen screen{ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fixed(5)};
    screen.Print();
}
```

###### Print an empty screen on the terminal?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/screen/color.hpp>

int main()
{
    ftxui::Screen screen{ftxui::Screen::Create(
        ftxui::Dimension::Full(),
        ftxui::Dimension::Fixed(10)
    )};
    screen.Print();
}
```

Alternatively, we can print a `ftxui::Screen` object as follows:

```cpp
std::cout << screen.ToString();
```

#### Pixel Manipulation
##### ftxui/screen

###### Access to a pixel inside a screen?

When accessing pixels of a screen, row and column indices start from 0.

Notice that the returned pixel is a reference to an existing object.

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/screen/color.hpp>

int main()
{
    ftxui::Screen screen{ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fixed(10))};
    ftxui::Pixel& pixel = screen.PixelAt(10, 5);
    pixel.character = U'X';
    screen.Print();
}
```

###### Colorize a pixel inside a screen?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/screen/color.hpp>

int main()
{
    ftxui::Screen screen{ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fixed(10))};
    ftxui::Pixel& pixel = screen.PixelAt(10, 5);
    pixel.character = U'X';
    pixel.foreground_color = ftxui::Color::Black;
    pixel.background_color = ftxui::Color::RGB(255, 0, 0);
    pixel.bold = true;
    screen.Print();
}
```

###### Access characters inside a pixel of a screen?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/screen/color.hpp>

int main()
{
    ftxui::Screen screen{ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fixed(10))};
    screen.at(10, 5) = U'X';
    screen.Print();
}
```

###### Register a hyperlink to a pixel?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/screen/color.hpp>

int main()
{
    ftxui::Screen screen{ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fixed(10))};
    screen.RegisterHyperlink("https://flashback.eu.com");
    screen.Print();
}
```

###### What would happen if we access a pixel outside the bounds of a screen?

A stub pixel will be returned that any change on it will have no effect on the screen.

#### Cursor Control
##### ftxui/screen

###### Reset cursor position to the top left corner of the terminal?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/screen/color.hpp>
#include <iostream>
#include <iomanip>
#include <thread>
#include <chrono>

void refresh(ftxui::Screen& screen)
{
    while (true)
    {
        ftxui::Pixel& pixel{screen.PixelAt(10, 0)};
        pixel.character = U'X';
        std::cout << screen.ResetPosition(true);
        std::cout << screen.ToString();
        std::flush(std::cout);
        std::this_thread::sleep_for(std::chrono::milliseconds{300});
    }
}

int main()
{
    ftxui::Screen screen{ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fixed(1))};
    refresh(screen);
}
```

#### Text
##### ftxui/dom
###### Card

#### Virtual Text
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
