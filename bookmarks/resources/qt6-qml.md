# Qt6 QML

## Chapter 1/20 Qt and QtQuick <sup>(ignored)</sup>


## Chapter 2/20 Getting Started <sup>(ignored)</sup>


## Chapter 3/20 Qt Creator IDE <sup>(ignored)</sup>


## Chapter 4/20 Quick Starter <sup>(completed)</sup>

## QML Syntax

<details>
<summary>Import a QML module to create a window?</summary>

> **Description**
>
> ```qml
> import QtQuick
> ``````
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-qml-syntax
> ---
</details>

<details>
<summary>What identifies an element in QML?</summary>

> **Description**
>
> `id` is a very special property-like value, it is used to reference elements
> inside a QML file (document). An `id` needs to be unique inside a document.
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-qml-syntax
> ---
</details>

<details>
<summary>What is the binding mechanism?</summary>

> **Description**
>
> A property can depend on one or many other properties. This is called
> binding. A bound property is updated when its dependent properties change. It
> works like a contract. For example the `height` should always be two times
> the `width`.
>
> ```qml
> Rectangle {
>     width: 100
>     height: width * 2
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-qml-syntax
> ---
</details>

<details>
<summary>What is a group property?</summary>

> **Description**
>
> Some properties are grouped properties. This feature is used when a property
> is more structured and related properties should be grouped together. Another
> way of writing grouped properties is:
>
> ```qml
> font {
>     family: "Ubuntu"
>     pixelSize: 24
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-qml-syntax
> ---
</details>

<details>
<summary>How javascript functions can be declared in QML?</summary>

> **Description**
>
> ```qml
> Text {
>     id: label
>
>     property int spacePresses: 0
>
>     text: "Space pressed: " + spacePresses + " times"
>
>     Keys.onSpacePressed: {
>         increment()
>     }
>
>     function increment() {
>         spacePresses = spacePresses + 1
>     }
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-qml-syntax
> ---
</details>

<details>
<summary>Define a globaly accessible root element in QML code?</summary>

> **Description**
>
> ```qml
> import QtQuick
>
> Window {
>     id: root
>     width: 480
>     height: 600
>     title: qsTr('Milestone')
>     visible: true
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-qml-syntax
> ---
</details>

<details>
<summary>Specify exact coordinations of an element?</summary>

> **Description**
>
> ```qml
> Rectangle {
>     x: 24
>     y: 16
>     width: 100
>     height: 100
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-qml-syntax
> ---
</details>

<details>
<summary>Create a new custom property?</summary>

> **Description**
>
> ```qml
> Rectangle {
>     property int max_text_length: 80
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-qml-syntax
> ---
</details>

<details>
<summary>Create an alias property pointing to another element's property?</summary>

> **Description**
>
> ```qml
> Rectangle {
>
>     property alias text_length: label.length
>
>     Text {
>         id: label
>         text: 'sample text'
>         property int length: 40
>     }
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-qml-syntax
> ---
</details>

<details>
<summary>Attach the signal of a property when its width and height changes?</summary>

> **Description**
>
> ```qml
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-qml-syntax
> ---
</details>

<details>
<summary>What is the requirement of an element in order to receive key events?</summary>

> **Description**
>
> The element should have the `focus` property set.
>
> ```qml
> Text {
>     focus: true
>
>     Keys.onEscapePressed: {
>         label.text = ''
>     }
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-qml-syntax
> ---
</details>

## Item

<details>
<summary>What element is the most basic type to be inherited by other visual elements?</summary>

> **Description**
>
> `Item` is the base element for all visual elements as such all other visual
> elements inherits from `Item`. The `Item` element is often used as a
> container for other elements, similar to the div element in HTML.
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-core-elements
> ---
</details>

<details>
<summary>What are the basic properties of item element?</summary>

> **Description**
>
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
> ---
> **Resources**
> - Qt6 QML - Chapter 5
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-core-elements
> ---
</details>

## Rectangle

<details>
<summary>What are the additional basic properties of a rectangle over item element?</summary>

> **Description**
>
> Rectangle extends `Item` and adds a fill color to it. Additionally it
> supports borders defined by `border.color` and `border.width`. To create
> rounded rectangles you can use the `radius` property.
>
> ```qml
> Rectangle {
>     color: 'lightsteelblue'
>     border.color: 'gray'
>     border.width: 3
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-core-elements
> ---
</details>

<details>
<summary>Make rectangle edges curved?</summary>

> **Description**
>
> ```qml
> Rectangle {
>     height: 100
>     width: 300
>     radius: 5
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-core-elements
> ---
</details>

<details>
<summary>Make a custom gradient over a rectangle?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-core-elements
> ---
</details>

## Text

<details>
<summary>Display a text on main window?</summary>

> **Description**
>
> ```qml
> Text {
>     id: label
>     color: 'black'
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-core-elements
> ---
</details>

<details>
<summary>Break a long text with an elide in the middle?</summary>

> **Description**
>
> ```qml
> Text {
>     id: label
>     text: 'very long string'
>     elide: Text.ElideMiddle
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-core-elements
> ---
</details>

<details>
<summary>Select a font family and font size for a text element?</summary>

> **Description**
>
> ```qml
> Text {
>     id: label
>     color: 'black'
>     font.family: 'FreeSans'
>     font.pixelSize: 18
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-core-elements
> ---
</details>

<details>
<summary>Set alignment for a text element?</summary>

> **Description**
>
> - `AlignTop`
> - `AlignBottom`
> - `AlignHCenter`
> - `AlignVCenter`
>
> ```qml
> Text {
>     id: label
>     verticalAlignment: Text.AlignHCenter
>     horizontalAlignment: Text.AlignVCenter
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-core-elements
> ---
</details>

<details>
<summary>Use style to color a text element?</summary>

> **Description**
>
> ```qml
> Text {
>     id: label
>     style: Text.Sunken
>     styleColor: '#FF4488'
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-core-elements
> ---
</details>

## Image

<details>
<summary>What are the common image formats supported by QML?</summary>

> **Description**
>
> - PNG
> - JPG
> - GIF
> - BMP
> - WEBP
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-core-elements
> ---
</details>

<details>
<summary>Load an image as a resource?</summary>

> **Description**
>
> ```qml
Image {
    id: profile_picture
    x: 15
    y: 15
    source: 'qrc:images/user.jpg'
    height: 120
    width: 90
    clip: true
    fillMode: Image.PreserveAspectCrop
}
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-core-elements
> ---
</details>

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
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-core-elements
> ---
</details>

<details>
<summary>What are the possible values for image fill modes?</summary>

> **Description**
>
> | Constant | Description |
> |---|---|
> | Image.Stretch | the image is scaled to fit |
> | Image.PreserveAspectFit | the image is scaled uniformly to fit without cropping |
> | Image.PreserveAspectCrop | the image is scaled uniformly to fill, cropping if necessary |
> | Image.Tile | the image is duplicated horizontally and vertically |
> | Image.TileVertically | the image is stretched horizontally and tiled vertically |
> | Image.TileHorizontally | the image is stretched vertically and tiled horizontally |
> | Image.Pad | the image is not transformed |
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-core-elements
> ---
> **References**
> - https://doc.qt.io/qt-6/qml-qtquick-image.html#fillMode-prop
> ---
</details>

## MouseArea

<details>
<summary>Get notified when user clicks on an element?</summary>

> **Description**
>
> ```qml
> MouseArea {
>     id: clickable
>     anchors.fill: parent
>     onClicked: root.clicked()
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-core-elements
> ---
</details>

## Components

<details>
<summary>What is a component?</summary>

> **Description**
>
> A component is a reusable element written in a file and later used in another
> QML document using the name of the component file.
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-components
> ---
</details>

<details>
<summary>Create a button component to be used on other components?</summary>

> **Description**
>
> *Button.qml*
> ```qml
> Rectangle {
>     id: button
>     signal clicked
>
>     MouseArea {
>         anchors.fill: parent
>         onClicked: { button.clicked(); }
>     }
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-components
> ---
</details>

<details>
<summary>Export properties of a component to be used as an API?</summary>

> **Description**
>
> ```qml
> Rectangle {
>     id: button
>     property alias color: child.color
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 4
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-components
> ---
</details>

## Transformation

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
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
>
> ---
> **References**
> ---
</details>

<details>
<summary>What feature can be used to smooth movements when rasterized edges can be seen in graphics?</summary>

> ```qml
> antialiasing: true
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
>
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
> ---
> **References**
> ---
</details>

## Positioning Elements

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
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
>
> ---
> **References**
> ---
</details>

## Repeater

<details>
<summary>Fill out a grid with blue squares using a repeater?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
> ---
> **References**
> ---
</details>

## Layout Items

<details>
<summary>What are the anchoring properties for visual elements?</summary>

> **Description**
>
> An element has 6 major anchor lines, `top` , `bottom` , `left` , `right` , `horizontalCenter` , `verticalCenter` .
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
>
> ---
> **References**
> ---
</details>

<details>
<summary>What additional anchor property does a text element have?</summary>

> There is the `baseline` anchor for text in `Text` elements.
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
> ---
> **References**
> ---
</details>

<details>
<summary>What are the offsets of anchors?</summary>

> **Description**
>
> Each anchor line comes with an offset. In the case of the `top` , `bottom` ,
> `left` , and `right` anchors, they are called **margins**. For
> `horizontalCenter` , `verticalCenter` and `baseline` they are called
> **offsets**.
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
> ---
> **References**
> ---
</details>

## Keyboard Input

<details>
<summary>What input constraints does <code>TextInput</code> support?</summary>

> **Description**
>
> - `validator`
> - `inputMask`
> - `echoMode`
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
> ---
> **References**
> ---
</details>

Get a line of text from user?

<details>
<summary>Make a tab <code>KeyNavigation</code> for multiple <code>TextInput</code> elements in a column?</summary>

> *UserInput.qml*
> ```qml
> import QtQuick
>
> FocusScope {
>     width: 200
>     height: input.height + 8
>
>     Rectangle {
>         anchors.fill: parent
>         color: 'lightsteelblue'
>         border.color: 'gray'
>     }
>
>     property alias text: input.text
>     property alias input: input
>
>     TextInput {
>         id: input
>         height: 50
>         anchors.fill: parent
>         anchors.margins: 4
>         focus: true
>     }
> }
> ``````
>
> *Main.qml*
> ```qml
> import QtQuick
>
> Window {
>     width: 640
>     height: 480
>     visible: true
>     title: qsTr("Credentials")
>
>     Column {
>         UserInput {
>             id: input1
>             KeyNavigation.tab: input2
>             text: 'Username'
>             focus: true
>         }
>
>         UserInput {
>             id: input2
>             KeyNavigation.tab: input1
>             text: 'Password'
>         }
>     }
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
> ---
> **References**
> ---
</details>

<details>
<summary>Get multi-line input from user?</summary>

> ```qml
> import QtQuick
>
> Window {
>     width: 200
>     height: 300
>     visible: true
>     title: qsTr("Note")
>
>     Rectangle {
>         anchors.fill: parent
>         color: 'linen'
>
>         Text {
>             anchors.top: parent.top
>             anchors.horizontalCenter: parent.horizontalCenter
>             color: 'black'
>             font.family: 'OpenSans'
>             font.pixelSize: 18
>             text: 'Note to Self'
>         }
>         Editor {
>             id: editor
>             anchors.verticalCenter: parent.verticalCenter
>             anchors.horizontalCenter: parent.horizontalCenter
>             anchors.fill: parent
>             anchors.topMargin: 30
>             anchors.margins: 20
>             focus: true
>         }
>     }
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
> ---
> **References**
> ---
</details>

## Key Elements

<details>
<summary>What property can record key presses?</summary>

> **Description**
>
> The attached property `Keys` allows executing code based on certain key
> presses.
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
> ---
> **References**
> ---
</details>

<details>
<summary>Record user key presses?</summary>

> ```qml
> import QtQuick
>
> Window {
>     width: 200
>     height: 300
>     visible: true
>     title: qsTr("Keys")
>
>     Rectangle {
>         anchors.fill: parent
>         color: 'linen'
>         focus: true
>
>         Text {
>             id: label
>             color: 'black'
>             anchors.top: parent.top
>             anchors.topMargin: 10
>             anchors.left: parent.left
>             anchors.leftMargin: 10
>             text: 'No key presses'
>         }
>
>         Keys.onReturnPressed: label.text = 'Enter pressed'
>     }
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
> ---
> **References**
> ---
</details>

## QML Performance

<details>
<summary>How to precompile QML to avoid the initial startup penalty induced by the initial parsing?</summary>

> This requires you to put your code into a Qt resource file, and is described
> in detail in the [Compiling QML Ahead of
> Time](https://doc.qt.io/qt-6/qtquick-deployment.html#ahead-of-time-compilation).
>
> ---
> **Resources**
> - Qt6 QML - Chapter 5
>
> ---
> **References**
> ---
</details>

## Chapter 5/20 Fluid Elements <sup>(completed)</sup>

## Animations

<details>
<summary>Where do animations apply?</summary>

> Animations are applied to property changes. An animation defines the
> interpolation curve from one value to another value when a property value
> changes.
>
> ---
> **Resources**
> - Qt6 QML - Chapter 6
> ---
> **References**
> ---
</details>

<details>
<summary>Animate an object rotating horizontally?</summary>

> This animation requires changes on `x,y` and `rotation` properties.
>
> ```qml
> import QtQuick
>
> Window {
>     width: 800
>     height: 400
>     visible: true
>     title: qsTr("Box Game")
>
>     Rectangle {
>         id: root
>         color: '#383838'
>         anchors.fill: parent
>
>         property int padding: 10
>         property int duration: 5000
>         property bool running: false
>
>         Rectangle {
>             id: box
>             x: root.padding
>             y: root.height - width - 5
>             width: 50
>             height: 50
>             color: 'lightsteelblue'
>
>             NumberAnimation on x {
>                 to: root.width - box.width - root.padding
>                 duration: root.duration * 2
>                 running: root.running
>             }
>
>             RotationAnimation on rotation {
>                 to: 360
>                 duration: root.duration
>                 running: root.running
>             }
>         }
>
>         MouseArea {
>             anchors.fill: root
>             onClicked: root.running = true
>         }
>     }
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 6
> ---
> **References**
> ---
</details>

<details>
<summary>Animate an object to fade away?</summary>

> This animation requires changes on `opacity` and `scale` properties.
>
> ```qml
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 6
> ---
> **References**
> ---
</details>

<details>
<summary>How many types of animation elements exist?</summary>

> - `PropertyAnimation`: animates changes in property values.
> - `NumberAnimation`: animates changes in qreal-type values.
> - `ColorAnimation`: animates changes in color values.
> - `RotationAnimation`: animates changes in rotation values.
>
> Qt Quick also provides more specialized animations for specific use cases:
>
> - `PauseAnimation`: provides a pause for an animation.
> - `SequentialAnimation`: allows animations to be run sequentially.
> - `ParallelAnimation`: allows animations to be run in parallel.
> - `AnchorAnimation`: animates changes in anchor values.
> - `ParentAnimation`: animates changes in parent values.
> - `SmoothedAnimation`: allows a property to smoothly track a value.
> - `SprintAnimation`: allows a property to track a value in a spring-like motion.
> - `PathAnimation`: animates an item alongside a path.
> - `Vector3dAnimation`: animates changes in QVector3d values
>
> ---
> **Resources**
> - Qt6 QML - Chapter 6
> ---
> **References**
> ---
</details>

<details>
<summary>What action elements are used to change a property or to run a script during an ongoing animation?</summary>

> **Description**
>
> While working on more complex animations, there is sometimes a need to change
> a property or to run a script during an ongoing animation. For this Qt Quick
> offers the action elements, which can be used everywhere where the other
> animation elements can be used:
>
> - `PropertyAction`: specifies immediate property changes during animation.
> - `ScriptAction`: defines scripts to be run during an animation.
>
> ---
> **Resources**
> - Qt6 QML - Chapter 6
>
> ---
> **References**
> ---
</details>

<details>
<summary>What are the possible ways of applying animations?</summary>

> - **Animation on property:** runs automatically after the element is fully
>   loaded.
> - **Behavior on property:** runs automatically when the property value
>   changes
> - **Standalone Animation:** runs when the animation is explicitly started
>   using `start()` or `running` is set to true.
>
> ---
> **Resources**
> - Qt6 QML - Chapter 6
>
> ---
> **References**
> ---
</details>

<details>
<summary>Enable wrapping on Text elements?</summary>

> **Description**
>
> ```qml
> Text {
>     wrapMode: Text.WordWrap
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 6
> ---
> **References**
> ---
</details>

## Easing Curves

<details>
<summary>How many easing curves are available for animations?</summary>

> - `Easing.Linear`
> - `Easing.InExpo`
> - `Easing.OutExpo`
> - `Easing.InOutExpo`
> - `Easing.InOutCubic`
> - `Easing.SineCurve`
> - `Easing.InOutCirc`
> - `Easing.InOutElastic`
> - `Easing.InOutBack`
> - `Easing.InOutBounce`
>
> ---
> **Resources**
> - Qt6 QML - Chapter 6
> ---
> **References**
> ---
</details>

<details>
<summary>Animate an object moving horizontally with an easing curve?</summary>

> ```qml
> import QtQuick
>
> Window {
>     width: 640
>     height: 480
>     visible: true
>     title: qsTr("Linear")
>
>     Rectangle {
>         id: root
>         anchors.fill: parent
>         color: '#383838'
>
>         property int padding: 20
>
>         Rectangle {
>             id: box
>             width: 40
>             height: 40
>             x: root.padding
>             anchors.verticalCenter: parent.verticalCenter
>             color: 'lightsteelblue'
>
>             Behavior on x {
>                 NumberAnimation {
>                     id: animation
>                     duration: 2000
>                     easing.type: Easing.InOutCubic
>                 }
>             }
>         }
>
>         MouseArea {
>             anchors.fill: parent
>             onClicked: {
>                 box.x = root.width - box.width - root.padding
>             }
>         }
>     }
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 6
>
> ---
> **References**
> ---
</details>

<details>
<summary>What type can be used to fine-tune the animations?</summary>

> **Description**
>
> Besides the `duration` and `easing.type` , you are able to fine-tune
> animations. For example, the general `PropertyAnimation` type (from which
> most animations inherit) additionally supports `easing.amplitude` ,
> `easing.overshoot` , and `easing.period` properties, which allow you to
> fine-tune the behavior of particular easing curves.
>
> ---
> **Resources**
> - Qt6 QML - Chapter 6
> ---
> **References**
> - [Easing Table](http://doc.qt.io/qt-6/qml-qtquick-propertyanimation.html#easing-prop)
---
</details>

## Grouped Animations

<details>
<summary>How many ways exist to group animations?</summary>

> You might want to run several animations at the same time or one after
> another or even execute a script between two animations.
>
> Grouping can be done in two ways: parallel or sequential.
>
> You can use the `SequentialAnimation` or the `ParallelAnimation` element,
> which act as animation containers for other animation elements.
>
> These grouped animations are animations themselves and can be used exactly as
> such.
>
> ---
> **Resources**
> - Qt6 QML - Chapter 6
> ---
> **References**
> ---
</details>

<details>
<summary>Animate an object to cross the window diagonally?</summary>

> **Description**
>
> ```qml
> import QtQuick
>
> Window {
>     id: window
>     width: 640
>     height: 480
>     visible: true
>     title: qsTr("Parallel")
>
>     Rectangle {
>         id: root
>         color: '#383838'
>         anchors.fill: parent
>
>         property int padding: 20
>         property int duration: 2000
>     }
>
>     MouseArea {
>         anchors.fill: parent
>         onClicked: { diagonal_movement.start(); }
>     }
>
>     Rectangle {
>         id: box
>         color: 'lightsteelblue'
>         width: 42
>         height: 42
>
>         x: root.padding
>         y: root.height - height - root.padding
>     }
>
>     ParallelAnimation {
>         id: diagonal_movement
>
>         NumberAnimation {
>             target: box
>             properties: 'x'
>             to: root.width - box.width - root.padding
>             duration: root.duration
>             easing.type: Easing.InOutCubic
>         }
>
>         NumberAnimation {
>             target: box
>             properties: 'y'
>             to: root.padding
>             duration: root.duration
>             easing.type: Easing.InOutCubic
>         }
>     }
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 6
> ---
> **References**
> ---
</details>

<details>
<summary>Animate a ball moving forward and bouncing on the floor twice?</summary>

> ```qml
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 6
> ---
> **References**
> ---
</details>

## States

<details>
<summary>What is the basic form of a state?</summary>

> A state defines a set of property changes and can be triggered by a certain
> condition.
>
> You define states in QML with the `State` element, which needs to be bound to
> the `states` array of any item element.
>
> A state is identified through a state name, and in its simplest form,
> consists of a series of property changes on elements.
>
> The default state is defined by the initial properties of the element and is
> named `""` (an empty string).
>
> ```qml
> Item {
>     id: root
>     states: [
>         State {
>             name: "go"
>             PropertyChanges { ... }
>         },
>         State {
>             name: "stop"
>             PropertyChanges { ... }
>         }
>     ]
> }
> ``````
>
> A state is changed by assigning a new state name to the `state` property of
> the element in which the states are defined.
>
> ```qml
> Item {
>     id: root
>     states: [
>         ...
>     ]
>     Button {
>         id: goButton
>         ...
>         onClicked: root.state = "go"
>     }
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 6
>
> ---
> **References**
> ---
</details>

<details>
<summary>Describe two different states of an object having different colors?</summary>

> ```qml
> import QtQuick
>
> Window {
>     width: 640
>     height: 480
>     visible: true
>     title: qsTr("States")
>
>     Rectangle {
>         id: root
>         color: '#393939'
>         anchors.fill: parent
>
>         MouseArea {
>             anchors.fill: parent
>             onClicked: {
>                 ball.state = (ball.state === 'bright' ? 'dark' : 'bright')
>             }
>         }
>     }
>
>     Rectangle {
>         id: ball
>         color: 'lightsteelblue'
>         width: 42
>         height: width
>         radius: width / 2
>         anchors.centerIn: parent
>         state: 'bright'
>
>         states: [
>             State {
>                 name: 'bright'
>                 PropertyChanges {
>                     target: ball
>                     color: 'lightsteelblue'
>                 }
>             },
>             State {
>                 name: 'dark'
>                 PropertyChanges {
>                     target: ball
>                     color: 'darkblue'
>                 }
>             }
>         ]
>     }
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 6
> ---
> **References**
> ---
</details>

## Transitions

<details>
<summary>What is the basic form of a transition?</summary>

> **Description**
>
> A transition is executed by a state change.
>
> You can define on which state change a particular transition can be applied
> using the `from:` and `to:` properties.
>
> For example, `from: "*"; to: "*"` means "from any state to any other state",
> and is the default value for `from` and `to` . This means the transition will
> be applied to every state switch.
>
> ```qml
> transitions: [
>     Transition {
>         from: "*"; to: "*"
>         ColorAnimation { target: element1; properties: "color"; duration: 2000 }
>         ColorAnimation { target: element2; properties: "color"; duration: 2000 }
>     }
> ]
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 6
> ---
> **References**
> ---
</details>

## Chapter 6/20 QtQuick Controls <sup>(writing)</sup>

<details>
<summary>What modules can be imported to use UI Controls?</summary>

> - `QtQuick.Controls`
> - `QtQuick.Templates`
> - `QtQuick.Controls.Imagine`
> - `QtQuick.Controls.Material`
> - `QtQuick.Controls.Universal`
>
> ---
> **Resources**
> - Qt6 QML - Chapter 6
> ---
> **References**
> ---
</details>

<details>
<summary>What QtQuick Template is offten used to create a desktop application?</summary>

> ```qml
> import QtQuick
> import QtQuick.Controls
>
> ApplicationWindow {
>     visible: true
>     width: 800
>     height: 600
>     // ...
> }
> ``````
>
> ---
> **Resources**
> - Qt6 QML - Chapter 6
>
> ---
> **References**
> ---
</details>

Create a menu bar in on window?

Create a toolbar on window?

Create a status bar on window?

Create a dialog to open specific file types?

## Chapter 7/20 Model-View-Delegate
## Chapter 8/20 Canvas Element
## Chapter 9/20 Shapes
## Chapter 10/20 Effects in QML
## Chapter 11/20 Multimedia
## Chapter 12/20 Qt Quick 3D
## Chapter 13/20 Networking
## Chapter 14/20 Storage
## Chapter 15/20 Dynamic QML
## Chapter 16/20 JavaScript
## Chapter 17/20 Qt and C++
## Chapter 18/20 Extending QML with C++
## Chapter 19/20 Qt for Python
## Chapter 20/20 Qt for MCUs
