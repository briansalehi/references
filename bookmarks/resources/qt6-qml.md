# Qt6 QML

## Chapter 1/21 Welcome!

Nothing to import.

## Chapter 2/21 Qt and Qt Quick

Nothing to import.

## Chapter 3/21 Quick Start

Nothing to import.

## Chapter 4/21 Qt Creator IDE

Nothing to import.

## Chapter 5/21 Quick Starter

### QML Syntax

Import a QML module to create a window?

Define a globaly accessible root element in QML code?

Specify exact coordinations of an element?

Create a new custom property?

Create an alias property pointing to another element's property?

Attach the signal of a property when its width and height changes?

What is the requirement of an element in order to receive key events?

Change the color of an element when it is focused and when it is not?

Apply a key navigation on an element to change on tab key press?

Bind a property to another?

Focus on an element to receive how many spacebar key pressed by user?

Write a javascript function to show each time user presses escape key on main window?

### Item Element

<details>
<summary>What element is the most basic type to be inherited by other visual elements?</summary>

> `Item` is the base element for all visual elements as such all other visual
> elements inherits from `Item`. The `Item` element is often used as a
> container for other elements, similar to the div element in HTML.
>
> ```qml
> ``````

> Origins:
> - Qt6 QML - Chapter 5

> References:
---
</details>

<details>
<summary>What are the basic properties of item element?</summary>

> - **Geometry:** `x` and `y`, `width` and `height`, and `z` for stacking order
>   of lift elements up or down from their natural ordering.
> - **Layout Handling:** `anchors` (left, right, top, bottom, vertical,
>   horizontal, center), and optional `margins`.
> - **Key Handling:** attached `Key` and `KeyNavigation` properties and the
>   `focus` property to enable key handling in the first place.
> - **Transformation:** `scale` and `rotate` transformation and the generic
>   `transform` property list for x,y,x transformation, as well as
>   `transformOrigin` point.
> - **Visual:** `opacity` to control transparency, `visible` to control
>   visibility, `clip` to restrain paint operations to the element boundary,
>   `smooth` to enhance the rendeing quality.
> - **State Definition:** `states` list property with the supported list of
>   states, current `state` property, and the `transitions` list property to
>   animate state changes.
>
> ```qml
> ``````

> Origins:
> - Qt6 QML - Chapter 5

> References:
---
</details>

### Rectangle Element

<details>
<summary>What are the additional basic properties of a rectangle over item element?</summary>

> Rectangle extends `Item` and adds a fill color to it. Additionally it
> supports borders defined by `border.color` and `border.width`. To create
> rounded rectangles you can use the `radius` property.
>
> ```qml
> ``````

> Origins:
> - Qt6 QML - Chapter 5

> References:
---
</details>

Change the border color of a rectangle?

Make rectangle edges curved?

<details>
<summary>Make a custom gradient over a rectangle?</summary>

> A gradient is defined by a series of gradient stops. Each stop has a position
> and a color. The position marks the position on the y-axis (`0 = top, 1 =
> bottom`). The color of the `GradientStop` marks the color at that position.
>
> ```qml
> import QtQuick
>
> Rectangle {
>     id: root
>     width: 500
>     height: 500
>
>     gradient: Gradient {
>         GradientStop {
>             position: 0.0
>             color: 'lightsteelblue'
>         }
>         GradientStop {
>             position: 1.0
>             color: 'slategray'
>         }
>     }
> }
> ``````

> Origins:
> - Qt6 QML - Chapter 5

> References:
---
</details>

### Text Element

Display a text on main window?

Break a long text with an elide in the middle?

Select a font for a text element?

Change the font size of a text element?

Set alignment for a text element?

Use style to color a text element?

### Image Element

What are the common image formats supported by QML?

Load an image as a resource?

Create an image element to show some image?

<details>
<summary>Crop an image reaching outside of boudaries?</summary>

> ```qml
> Image {
>     widht: 680
>     height: 460
>     source: "assets/triangle_red.png"
>     fillMode: Image.PreserveAspectCrop
>     clip: true
> }
> ``````

> Origins:
> - Qt6 QML - Chapter 5

> References:
---
</details>

### MouseArea Element

Get notified when user clicks on an element?

### Components

What is a component?

Create a button component to be used on other components?

Export properties of a component to be used as an API?

### Transformation

<details>
<summary>What are the simple transformation properties?</summary>

> A simple translation is done via changing the `x`, `y` position.
>
> A rotation is done using the `rotation` property.
> The value is provided in degrees (0 .. 360).
>
> A scaling is done using the `scale` property and a value `<1` means the
> element is scaled down and `>1` means the element is scaled up.
>
> Rotation and scaling do not change an item's geometry: the `x,y` and
> `width,height` haven’t changed; only the painting instructions are
> transformed.
>
> ```qml
> ``````

> Origins:
> - Qt6 QML - Chapter 5

> References:
---
</details>

<details>
<summary>What feature can be used to smooth movements when rasterized edges can be seen in graphics?</summary>

> ```qml
> antialiasing: true
> ``````

> Origins:
> - Qt6 QML - Chapter 5

> References:
---
</details>

<details>
<summary>Use a helper function to extract the lighter or darker color?</summary>

> ```qml
> import QtQuick
>
> Rectangle {
>     width: 48
>     height: 48
>     color: "#ea7025"
>     border.color: Qt.lighter(color)
> }
> ``````

> Origins:
> - Qt6 QML - Chapter 5

> References:
---
</details>

### Positioning Elements

<details>
<summary>Position multiple elements in a row?</summary>

> The Row element places its child items next to each other, either from the
> left to the right, or from the right to the left, depending on the
> `layoutDirection` property.
>
> `spacing` property can be used to distance each of the child elements from
> each other.
>
> *DarkSquare.qml*
> ```qml
> Rectangle {
>     id: root
>     width: 95
>     height: 95
>     color: 'darkgray'
>     border.color: Qt.lighter(color)
> }
> ``````
>
> *RedSquare.qml*
> ```qml
> Rectangle {
>     id: root
>     width: 95
>     height: 95
>     color: 'red'
>     border.color: Qt.lighter(color)
> }
> ``````
>
> *GreenSquare.qml*
> ```qml
> Rectangle {
>     id: root
>     width: 95
>     height: 95
>     color: 'green'
>     border.color: Qt.lighter(color)
> }
> ``````
>
> *BlueSquare.qml*
> ```qml
> Rectangle {
>     id: root
>     width: 95
>     height: 95
>     color: 'blue'
>     border.color: Qt.lighter(color)
> }
> ``````
>
> *Main.qml*
> ```qml
> import QtQuick
>
> DarkSquare {
>     id: root
>     width: 400
>     height: 200
>
>     Row {
>         id: row
>         anchors.centerIn: parent
>         spacing: 8
>
>         RedSquare {}
>         GreenSquare {}
>         BlueSquare {}
>     }
> }
> ``````

> Origins:
> - Qt6 QML - Chapter 5

> References:
---
</details>

<details>
<summary>Position multiple elements in a column?</summary>

> `spacing` property can be used to distance each of the child elements from
> each other.
>
> *DarkSquare.qml*
> ```qml
> Rectangle {
>     id: root
>     width: 95
>     height: 95
>     color: 'darkgray'
>     border.color: Qt.lighter(color)
> }
> ``````
>
> *RedSquare.qml*
> ```qml
> Rectangle {
>     id: root
>     width: 95
>     height: 95
>     color: 'red'
>     border.color: Qt.lighter(color)
> }
> ``````
>
> *GreenSquare.qml*
> ```qml
> Rectangle {
>     id: root
>     width: 95
>     height: 95
>     color: 'green'
>     border.color: Qt.lighter(color)
> }
> ``````
>
> *BlueSquare.qml*
> ```qml
> Rectangle {
>     id: root
>     width: 95
>     height: 95
>     color: 'blue'
>     border.color: Qt.lighter(color)
> }
> ``````
>
> *Main.qml*
> ```qml
> import QtQuick
>
> DarkSquare {
>     id: root
>     width: 200
>     height: 400
>
>     Column {
>         id: column
>         anchors.centerIn: parent
>         spacing: 8
>
>         RedSquare {}
>         GreenSquare {}
>         BlueSquare {}
>     }
> }
> ``````

> Origins:
> - Qt6 QML - Chapter 5

> References:
---
</details>

<details>
<summary>Position multiple elements in a grid?</summary>

> The `Grid` element arranges its children in a grid. By setting the `rows` and
> `columns` properties, the number of rows or columns can be constrained.
>
> By not setting either of them, the other is calculated from the number of
> child items. For instance, setting rows to 3 and adding 6 child items will
> result in 2 columns.
>
> The properties `flow` and `layoutDirection` are used to control the order in
> which the items are added to the grid, while `spacing` controls the amount of
> space separating the child items.
>
> *DarkSquare.qml*
> ```qml
> Rectangle {
>     id: root
>     width: 95
>     height: 95
>     color: 'darkgray'
>     border.color: Qt.lighter(color)
> }
> ``````
>
> *BlueSquare.qml*
> ```qml
> Rectangle {
>     id: root
>     width: 95
>     height: 95
>     color: 'blue'
>     border.color: Qt.lighter(color)
> }
> ``````
>
> *Main.qml*
> ```qml
> import QtQuick
>
> DarkSquare {
>     id: root
>     width: 200
>     height: 400
>
>     Grid {
>         id: grid
>         rows: 2
>         columns: 2
>         anchors.centerIn: parent
>         spacing: 8
>
>         BlueSquare {}
>         BlueSquare {}
>         BlueSquare {}
>         BlueSquare {}
>     }
> }
> ``````

> Origins:
> - Qt6 QML - Chapter 5

> References:
---
</details>

<details>
<summary>Position multiple elements into a flow?</summary>

> The direction of the flow is controlled using `flow` and `layoutDirection`.
>
> As the items are added in the flow, they are wrapped to form new rows or columns as needed.
>
> In order for a flow to work, it must have a width or a height. This can be set either directly, or though anchor layouts.
>
> *DarkSquare.qml*
> ```qml
> Rectangle {
>     id: root
>     width: 95
>     height: 95
>     color: 'darkgray'
>     border.color: Qt.lighter(color)
> }
> ``````
>
> *BlueSquare.qml*
> ```qml
> Rectangle {
>     id: root
>     width: 95
>     height: 95
>     color: 'blue'
>     border.color: Qt.lighter(color)
> }
> ``````
>
> *Main.qml*
> ```qml
> import QtQuick
>
> DarkSquare {
>     id: root
>     width: 300
>     height: 300
>
>     Flow {
>         id: flow
>         anchors.fill: parent
>         anchors.margins: 10
>         spacing: 8
>
>         BlueSquare {}
>         BlueSquare {}
>         BlueSquare {}
>         BlueSquare {}
>     }
> }
> ``````

> Origins:
> - Qt6 QML - Chapter 5

> References:
---
</details>

### Repeater

<details>
<summary>Fill out a grid with blue squares using a repeater?</summary>

> An element often used with positioners is the `Repeater`. It works like a
> for-loop and iterates over a model. In the simplest case a model is just a
> value providing the number of loops.
>
> Repeaters are best used when having a small amount of static data to be
> presented.
>
> A repeater injects the `index` property into the repeater. It contains the
> current loop-index.
>
> While the `index` property is dynamically injected into the Rectangle, it is
> a good practice to declare it as a required property to ease readability and
> help tooling. This is achieved by the `required property int index` line.
>
> *DarkSquare.qml*
> ```qml
> Rectangle {
>     id: root
>     width: 95
>     height: 95
>     color: 'darkgray'
>     border.color: Qt.lighter(color)
> }
> ``````
>
> *BlueSquare.qml*
> ```qml
> Rectangle {
>     id: root
>     width: 95
>     height: 95
>     color: 'blue'
>     border.color: Qt.lighter(color)
> }
> ``````
>
> *Main.qml*
> ```qml
> import QtQuick
>
> Window {
>     id: root
>     title: 'Windows'
>     width: 400
>     height: 400
>     visible: true
>
>     DarkSquare {
>         id: dark
>         anchors.fill: parent
>         anchors.centerIn: parent
>
>         Flow {
>             id: flow
>             anchors.fill: parent
>             anchors.margins: 10
>             spacing: 10
>
>             // replace with 9 repetitions of BlueSquare {}
>             Repeater {
>                 model: 9
>                 delegate: BlueSquare {
>                     Text {
>                         anchors.centerIn: parent
>                         color: 'black'
>                         text: '#' + parent.index
>                     }
>                 }
>             }
>         }
>     }
> }
> ``````

> Origins:
> - Qt6 QML - Chapter 5

> References:
---
</details>

## Chapter 6/21 Fluid Elements
## Chapter 7/21 UI Controls
## Chapter 8/21 Model-View-Delegate
## Chapter 9/21 Canvas Element
## Chapter 10/21 Shapes
## Chapter 11/21 Effects in QML
## Chapter 12/21 Multimedia
## Chapter 13/21 Qt Quick 3D
## Chapter 14/21 Networking
## Chapter 15/21 Storage
## Chapter 16/21 Dynamic QML
## Chapter 17/21 JavaScript
## Chapter 18/21 Qt and C++
## Chapter 19/21 Extending QML with C++
## Chapter 20/21 Qt for Python
## Chapter 21/21 Qt for MCUs
