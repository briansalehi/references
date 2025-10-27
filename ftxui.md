# FTXUI
# FTXUI Documentation
## manual
## GitHub
### page
### Arthur Sonzogni
#### surface

#### Elements
##### ftxui/dom

###### What types does the dom module provide?

This module defines a hierarchical set of `ftxui::Element`. An element manages the layout and can be responsive to the terminal dimension changes.

###### Render an element onto a screen?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element content{ftxui::text("Flashback, for experts like you.")};
    ftxui::Screen screen{ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fit(content))};
    ftxui::Render(screen, content);
    screen.Print();
}
```

#### Decorators
##### ftxui/dom
###### What is the role of a decorator?

Decorators are function objects with the signature `Element(Element)`, that take an object of type `ftxui::Element` to applies visual changes, and then return it.

###### What operator can be used to apply a decorator to an element?

```cpp
#include <ftxui/dom/elements.hpp>

constexpr auto content{"Flashback, for experts like you."};

int main()
{
    ftxui::Element modifiedText{ftxui::text(content) | ftxui::bold};
}
```

#### Text
##### ftxui/dom
###### Create a text widget?

```cpp
#include <ftxui/dom/elements.hpp>

constexpr auto content{"Flashback, for experts like you."};

int main()
{
    ftxui::Element text{ftxui::text(content)};
}
```

#### Vertical Text
##### ftxui/dom
###### Create a vertical text widget?

```cpp
#include <ftxui/dom/elements.hpp>

constexpr auto content{"Flashback, for experts like you."};

int main()
{
    ftxui::Element text{ftxui::vtext(content)};
}
```

#### Paragraph
##### ftxui/dom
###### What is the difference between text and paragraph?

`ftxui::paragraph` is similar to `ftxui::text` but the paragraph wraps along multiple lines depending on the width of its container, while `ftxui::text` splits when space is not enough.

###### Create a paragraph?

```cpp
#include <ftxui/dom/elements.hpp>

constexpr auto content{"Flashback, for experts like you."};

int main()
{
    ftxui::Element text{ftxui::paragraph(content)};
}
```

###### What are the alignment variations of a paragraph?

```cpp
#include <ftxui/dom/elements.hpp>

constexpr auto content{"Flashback, for experts like you."};

int main()
{
    ftxui::Element leftAligned{ftxui::paragraphAlignLeft(content)};
    ftxui::Element rightAligned{ftxui::paragraphAlignRight(content)};
    ftxui::Element centered{ftxui::paragraphAlignCenter(content)};
    ftxui::Element justified{ftxui::paragraphAlignJustify(content)};
}
```

#### Border
##### ftxui/dom
###### Draw a border around an element?

`ftxui::border` or `ftxui::borderRounded` is a border with continuous lines and round corners.

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

constexpr auto content{"Flashback, for experts like you."};

int main()
{
    ftxui::Element paragraph{ftxui::paragraph(content) | ftxui::border};
    ftxui::Screen screen{ftxui::Screen::Create(ftxui::Dimension::Fit(paragraph))};
    ftxui::Render(screen, paragraph);
    screen.Print();
}
```

###### Draw a border around an element with sharp edges?

`ftxui::borderLight` is similar to the default border but without round corners.

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

constexpr auto content{"Flashback, for experts like you."};

int main()
{
    ftxui::Element paragraph{ftxui::paragraph(content) | ftxui::borderLight};
    ftxui::Screen screen{ftxui::Screen::Create(ftxui::Dimension::Fit(paragraph))};
    ftxui::Render(screen, paragraph);
    screen.Print();
}
```

###### Draw a border around an element with dashed lines?

`ftxui::borderDashed` is similar to the light border but using dashes instead of continuous lines.

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

constexpr auto content{"Flashback, for experts like you."};

int main()
{
    ftxui::Element paragraph{ftxui::paragraph(content) | ftxui::borderDashed};
    ftxui::Screen screen{ftxui::Screen::Create(ftxui::Dimension::Fit(paragraph))};
    ftxui::Render(screen, paragraph);
    screen.Print();
}
```

###### Draw a border around an element with thick lines?

`ftxui::borderHeavy` is similar to the light border but with thicker lines.

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

constexpr auto content{"Flashback, for experts like you."};

int main()
{
    ftxui::Element paragraph{ftxui::paragraph(content) | ftxui::borderHeavy};
    ftxui::Screen screen{ftxui::Screen::Create(ftxui::Dimension::Fit(paragraph))};
    ftxui::Render(screen, paragraph);
    screen.Print();
}
```

###### Draw a border around an element with double lines?

`ftxui::borderDouble` is similar to the light border but with thicker lines.

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

constexpr auto content{"Flashback, for experts like you."};

int main()
{
    ftxui::Element paragraph{ftxui::paragraph(content) | ftxui::borderHeavy};
    ftxui::Screen screen{ftxui::Screen::Create(ftxui::Dimension::Fit(paragraph))};
    ftxui::Render(screen, paragraph);
    screen.Print();
}
```

###### Draw an invisible border around an element?

`ftxui::borderEmpty` is a border with space.

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

constexpr auto content{"Flashback, for experts like you."};

int main()
{
    ftxui::Element paragraph{ftxui::paragraph(content) | ftxui::borderEmpty | ftxui::border};
    ftxui::Screen screen{ftxui::Screen::Create(ftxui::Dimension::Fit(paragraph))};
    ftxui::Render(screen, paragraph);
    screen.Print();
}
```

###### Draw a border around an element with a custom character?

`ftxui::borderWith` is a border that takes an argument of type `ftxui::Pixel` and uses the character inside the pixel instead of lines.

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

constexpr auto content{"Flashback, for experts like you."};

int main()
{
    ftxui::Pixel borderStyle{};
    borderStyle.character = "x";
    ftxui::Element paragraph{ftxui::paragraph(content) | ftxui::borderWith(borderStyle)};
    ftxui::Screen screen{ftxui::Screen::Create(ftxui::Dimension::Fit(paragraph))};
    ftxui::Render(screen, paragraph);
    screen.Print();
}
```

#### Window
##### ftxui/dom
###### Draw a border around an element with a header?

A `ftxui::window` is a `ftxui::border`, but with an additional header.

```cpp
#include <ftxui/dom/elements.hpp>

constexpr auto content{"Flashback, for experts like you."};

int main()
{
    ftxui::Element paragraph{ftxui::window("header", ftxui::paragraph(content))};
    ftxui::Element paragraph{ftxui::paragraph(content) | ftxui::window("header")};
}
```

#### Separator
##### ftxui/dom
###### Separate two elements by drawing a line between them?

A `ftxui::separator` displays a vertical or horizontal line to visually split the content of a container in two.

For separators, `ftxui::separator`, `ftxui::separatorRound` and `ftxui::separatorLight` look the same.

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element group{
        ftxui::border(
            ftxui::hbox(
                ftxui::text("Left"),
                ftxui::separator(),
                ftxui::text("Right")
            )
        )
    };
    ftxui::Screen screen(ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fit(group)));
    ftxui::Render(screen, group);
    screen.Print();
}
```

###### Separate two elements with a thick line?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element group{
        ftxui::border(
            ftxui::hbox(
                ftxui::text("Left"),
                ftxui::separatorHeavy(),
                ftxui::text("Right")
            )
        )
    };
    ftxui::Screen screen(ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fit(group)));
    ftxui::Render(screen, group);
    screen.Print();
}
```

###### Separate two elements with a double line?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element group{
        ftxui::border(
            ftxui::hbox(
                ftxui::text("Left"),
                ftxui::separatorDouble(),
                ftxui::text("Right")
            )
        )
    };
    ftxui::Screen screen(ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fit(group)));
    ftxui::Render(screen, group);
    screen.Print();
}
```

###### Separate two elements with a space?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element group{
        ftxui::border(
            ftxui::hbox(
                ftxui::text("Left"),
                ftxui::separatorEmpty(),
                ftxui::text("Right")
            )
        )
    };
    ftxui::Screen screen(ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fit(group)));
    ftxui::Render(screen, group);
    screen.Print();
}
```

###### Separate two elements with a variable styled line?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element group{
        ftxui::border(
            ftxui::hbox(
                ftxui::text("Left"),
                ftxui::separatorStyled(ftxui::BorderStyle{ftxui::ROUND}),
                ftxui::text("Right")
            )
        )
    };
    ftxui::Screen screen(ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fit(group)));
    ftxui::Render(screen, group);
    screen.Print();
}
```

###### Separate two elements with a custom character?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element group{
        ftxui::border(
            ftxui::hbox(
                ftxui::text("Left"),
                ftxui::separatorCharacter(" - "),
                ftxui::text("Right")
            )
        )
    };
    ftxui::Screen screen(ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fit(group)));
    ftxui::Render(screen, group);
    screen.Print();
}
```

###### Separate two elements with a colorized line?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element group{
        ftxui::border(
            ftxui::hbox(
                ftxui::text("Left"),
                ftxui::separatorVSelector(1.0, 1.0, ftxui::Color::Red, ftxui::Color::Default),
                ftxui::text("Right")
            )
        )
    };
    ftxui::Screen screen(ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fit(group)));
    ftxui::Render(screen, group);
    screen.Print();
}
```

#### Gauge
##### ftxui/dom
###### Draw a bar representing progress?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element bar{ftxui::gauge(0.5)};
    ftxui::Screen screen(ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fit(bar)));
    ftxui::Render(screen, bar);
    screen.Print();
}
```

###### Draw a bar representing progress moving towards the right direction?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element bar{ftxui::gaugeRight(0.5)};
    ftxui::Screen screen(ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fit(bar)));
    ftxui::Render(screen, bar);
    screen.Print();
}
```

###### Draw a bar representing progress moving towards the left direction?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element bar{ftxui::gaugeLeft(0.5)};
    ftxui::Screen screen(ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fit(bar)));
    ftxui::Render(screen, bar);
    screen.Print();
}
```

###### Draw a bar representing progress moving upwards?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element bar{ftxui::gaugeUp(0.5)};
    ftxui::Screen screen(ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fit(bar)));
    ftxui::Render(screen, bar);
    screen.Print();
}
```

###### Draw a bar representing progress moving downwards?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element bar{ftxui::gaugeDown(0.5)};
    ftxui::Screen screen(ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fit(bar)));
    ftxui::Render(screen, bar);
    screen.Print();
}
```

###### Explicitly specify the direction of a progress bar?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element bar{ftxui::gaugeDirection(0.5, ftxui::GaugeDirection::Right)};
    ftxui::Screen screen(ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fit(bar)));
    ftxui::Render(screen, bar);
    screen.Print();
}
```

#### Graph
##### ftxui/dom
###### Draw the graph of a function?

```cpp
#include <ftxui/dom/elements.hpp>
#include <ftxui/dom/node.hpp>
#include <ftxui/screen/screen.hpp>
#include <ftxui/screen/color.hpp>
#include <functional>
#include <iostream>
#include <utility>
#include <vector>
#include <chrono>
#include <string>
#include <thread>
#include <cmath>

class Graph
{
public:
    std::vector<int> operator()(int width, int height) const
    {
        std::vector<int> output(width);
        for (int i = 0; i < width; ++i)
        {
            float v = 0;
            v += 0.5f * sin((i + shift) * 0.2f);
            v *= height;
            v += 0.5f * height;
            output[i] = static_cast<int>(v);
        }
        return output;
    }
    int operator ++() { return shift++; }
    void operator ++(int) { ++shift; }
    int shift = 0;
};

std::vector<int> triangle(int width, int height)
{
    std::vector<int> output(width);

    for (int i = 0; i < width; ++i)
    {
        output[i] = i % (height - 4) + 2;
    }
    return output;
}

int main() {
    Graph my_graph;

    for (int i = 0;; ++i)
    {
        std::ignore = i;
        auto document{ftxui::graph(std::ref(my_graph))};

        document |= ftxui::border;

        const int min_width = 40;
        document |= ftxui::size(ftxui::HEIGHT, ftxui::GREATER_THAN, min_width);

        auto screen = ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fixed(10));
        ftxui::Render(screen, document);
        std::cout << screen.ResetPosition() << screen.ToString() << std::flush;

        const auto sleep_time = std::chrono::seconds{1};
        std::this_thread::sleep_for(sleep_time);
        my_graph++;
    }
}
```

#### Colors
##### ftxui/dom
###### Colorize an element?

There are two color profiles for an element, foreground color and background color.

```cpp
#include <ftxui/dom/elements.hpp>
#include <ftxui/screen/color.hpp>

int main()
{
    ftxui::Element text{ftxui::text("Flashback, for experts like you.")};
    text |= ftxui::color(ftxui::Color::White};
    text |= ftxui::bgcolor(ftxui::Color::Black};
}
```

#### Linear Gradient
##### ftxui/dom
###### Construct a linear gradient?

Aside from the default constructor, there are two overloaded constructors for this type. One that takes two colors as `ftxui::LinearGradient(ftxui::Color, ftxui::Color)`:

```cpp
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::LinearGradient gradient{ftxui::Color::Black, ftxui::Color::Red};
}
```

And one that takes an angle and two colors as `ftxui::LinearGradient(float, ftxui::Color, ftxui::Color)`:

```cpp
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::LinearGradient gradient{0.5, ftxui::Color::Black, ftxui::Color::Red};
}
```

###### Define multiple stops for a linear gradient?

```cpp
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::LinearGradient gradient{ftxui::LinearGradient().Angle(45.0).Stop(ftxui::Color::Red, 0.0).Stop(ftxui::Color::Black, 1.0)};
}
```

###### Colorize an element with a linear gradient?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>
#include <iostream>

int main()
{
    ftxui::LinearGradient gradient{ftxui::LinearGradient().Angle(0.0).Stop(ftxui::Color::Black, 0.0).Stop(ftxui::Color::Red, 0.5).Stop(ftxui::Color::Black, 1.0)};
    ftxui::Element title{ftxui::text("Flashback, for experts like you")};
    ftxui::Element document{title | ftxui::color(ftxui::Color::Default) | ftxui::border | ftxui::color(gradient)};
    ftxui::Screen screen{ftxui::Screen::Create(ftxui::Dimension::Fit(document))};
    ftxui::Render(screen, document);
    std::cout << screen.ResetPosition(true) << screen.ToString() << std::endl;
}
```

#### Style
##### ftxui/dom
###### Make an element bold?

```cpp
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element text{ftxui::text("Flashback, for experts like you")};
    ftxui::bold(text);
}
```

###### Make an element italic?

```cpp
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element text{ftxui::text("Flashback, for experts like you")};
    ftxui::italic(text);
}
```

###### Make an element dim?

```cpp
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element text{ftxui::text("Flashback, for experts like you")};
    ftxui::dim(text);
}
```

###### Invert the color of an element?

```cpp
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element text{ftxui::text("Flashback, for experts like you")};
    ftxui::invert(text);
}
```

###### Underline an element?

```cpp
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element text{ftxui::text("Flashback, for experts like you")};
    ftxui::underline(text);
}
```

###### Underline an element with double lines?

```cpp
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element text{ftxui::text("Flashback, for experts like you")};
    ftxui::underlineDouble(text);
}
```

###### Strikethrough an element?

```cpp
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element text{ftxui::text("Flashback, for experts like you")};
    ftxui::strikethrough(text);
}
```

###### Make an element blink?

```cpp
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element text{ftxui::text("Flashback, for experts like you")};
    ftxui::blink(text);
}
```

#### Layout
##### ftxui/dom
###### Horizontally align elements?

```cpp
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element document{
        ftxui::hbox(
            ftxui::text("left"),
            ftxui::text("right")
        ) | ftxui::border
    };
}
```

###### Vertically align elements?

```cpp
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element document{
        ftxui::vbox(
            ftxui::text("top"),
            ftxui::text("bottom")
        ) | ftxui::border
    };
}

```

###### Align elements inside a grid?

```cpp
```

###### Fill the space between two aligned elements?

```cpp
#include <ftxui/dom/elements.hpp>

int main()
{
    ftxui::Element document{
        ftxui::vbox(
            ftxui::text("top"),
            ftxui::filler(),
            ftxui::text("bottom")
        ) | ftxui::border
    };
}
```

###### Make nested layouts?

```cpp
#include <ftxui/dom/elements.hpp>
#include <ftxui/screen/screen.hpp>

int main()
{
    ftxui::Screen screen{ftxui::Screen::Create(ftxui::Dimension::Fixed(50), ftxui::Dimension::Fixed(10))};
    ftxui::Element document{
        ftxui::vbox(
            ftxui::hbox(ftxui::text("north-west"), ftxui::filler(), ftxui::text("north-east")),
            ftxui::filler(),
            ftxui::hbox(ftxui::filler(), ftxui::text("center"), ftxui::filler()),
            ftxui::filler(),
            ftxui::hbox(ftxui::text("south-west"), ftxui::filler(), ftxui::text("south-east"))
        ) | ftxui::border
    };
    ftxui::Render(screen, document);
    screen.Print();
}
```

#### Table
##### ftxui/dom
###### Create a table?

```cpp
```

#### Canvas
##### ftxui/dom
###### Draw on a canvas?

```cpp
```

#### Input
##### ftxui/component
###### Take input from keyboard?

```cpp
```

###### Filter input?

```cpp
```

#### Menu
##### ftxui/component
###### Create a menu of selectable items?

```cpp
```

#### Toggle
##### ftxui/component
###### Create a toggle option?

```cpp
```

#### CheckBox
##### ftxui/component
###### Create a checkbox?

```cpp
```

#### RadioBox
##### ftxui/component
###### Create a radio button?

```cpp
```

#### Dropdown
##### ftxui/component
###### Create a dropdown?

```cpp
```

#### Slider
##### ftxui/component
###### Create a slider?

```cpp
```

#### Renderer
##### ftxui/component
###### Render the screen with a different function?

```cpp
```

#### CatchEvent
##### ftxui/component
###### Catch key presses?

```cpp
#include <ftxui/screen/screen.hpp>
#include <ftxui/dom/elements.hpp>
#include <ftxui/component/component.hpp>

int main()
{
    ftxui::Screen screen{ftxui::ScreenInteractive::TerminalOutput()};
    ftxui::Renderer renderer{[] { return ftxui::text("Flashback"); }};
    ftxui::CatchEvent component{renderer, [&](ftxui::Event event) {
        if (event == ftxui::Event::Character('q'))
        {
            screen.ExitLoopClosure()();
            return true;
        }
        return false;
    }};
    screen.Loop(component);
}
```

#### Maybe
##### ftxui/component
###### Hide a component based on a predicate?

This component can be used to show or hide any other component via a boolean or a predicate.

```cpp
bool show = true;
ftxui::Renderer renderer{[] { return "Hello World!"; }};
ftxui::Element component{ftxui::Maybe(renderer, &show)};
```

```cpp
ftxui::Renderer renderer{[] { return "Hello World!"; }};
ftxui::Element component{ftxui::Maybe(renderer, [&] { return time > 10; })};
```

#### Collapsible
##### ftxui/component
###### What are the use cases of collapsible elements?

This is useful for visual elements whose visibility can be toggled on or off by the user. Essentially, this is the combination of the `ftxui::Checkbox()` and `ftxui::Maybe()` components.

###### Make an element collapsible?

```cpp
```

#### Container
##### ftxui/component
###### What are the use cases of containers?

Containers are similar to tab, either horizontal or vertical.

###### Create a few vertical tabs each containing elements?

```cpp
```

###### Create a few horizontal tabs each containing elements?

```cpp
```

#### ResizableSplit
##### ftxui/component
###### Split a few elements within resizable areas?

```cpp
```

#### Process Custom Events
##### ftxui/component
###### Handle events other than mouse, keyboard, or window resizing?

```cpp
```

#### C++20 Modules
##### C++20 Modules
###### Import ftxui library as modules?

Use the FTXUI_BUILD_MODULES option to build the FTXUI project itself to provide C++ 20 modules:

```sh
cmake -G Ninja -S ftxui -B build -D CMAKE_BUILD_TYPE=Release -D FTXUI_BUILD_MODULES=ON
cmake --build build
```

```cpp
import ftxui;
```

```cpp
import ftxui.screen;
import ftxui.dom;
import ftxui.component;
```

---
# FTXUI
# FTXUI Documentation
## manual
## GitHub
### page
### Arthur Sonzogni
#### depth
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
