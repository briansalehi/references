# Qt

## Qt Installation

<details>
<summary>Where the Qt installer can be found?</summary>

> - Open source: qt.io/download-open-source
> - Commercial: qt.io/download
>
> ```sh
> chmod u+x qt*.run
> ./qt*.run
> ``````

> Origins:
> - Cross-Platform Development with Qt6 and Modern C++ - Chapter 1

> References:
---
</details>

<details>
<summary>How to update Qt components after manual installation?</summary>

> You can select new components to download and install or unselect them to
> remove them from your installation.
>
> ```sh
> ${QT_DIR}/MaintenanceTool.exe
> ``````

> Origins:
> - Cross-Platform Development with Qt6 and Modern C++ - Chapter 1

> References:
---
</details>

## Qt Widgets

## QML

<details>
<summary>What is the interpreter of QML?</summary>

> A runtime called the QmlEngine which loads the initial QML code. The
> developer can register C++ types with the runtime to interface with the
> native code. The `qml` tool is a pre-made runtime which is used directly.

> Origins:
> - https://www.qt.io/product/qt6/qml-book

> References:
---
</details>

<details>
<summary>What is the base code for a QML app?</summary>

> ```qml
> import QtQuick
>
> Window {
>     width: 640
>     height: 480
>     visible: true
>     title: qsTr("Sample")
> }
> ``````

> Origins:
> - https://www.qt.io/product/qt6/qml-book

> References:
---
</details>

## Core Elements

<details>
<summary>What elements are grouped as core in QML?</summary>

> - `Item`
> - `Rectangle`
> - `Text`
> - `Image`
> - `MouseArea`

> Origins:
> - https://www.qt.io/product/qt6/qml-book

> References:
---
</details>

## Item

<details>
<summary>What element is an item?</summary>

> `Item` is the base element for all visual elements as such all other visual
> elements inherits from `Item`. It doesn’t paint anything by itself but
> defines all properties which are common across all visual elements.
>
> The `Item` element is often used as a container for other elements, similar
> to the `div` element in HTML.

> Origins:
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-core-elements

> References:
---
</details>

<details>
<summary>What properties does an item element define inherited by all other elements?</summary>

> - **Geometry**: `x`, `y`, `width`, `height`, `z`
> - **Layouts**: `anchors`, `margins`
> - **Keys**: `Key`, `KeyNavigation`, `focus`
> - **Transformation**: `scale`, `rotate`, `transform`, `transformOrigin`
> - **Visual**: `opacity`, `visible`, `clip`, `smooth`
> - **State**: `states`, `state`, `transitions`

> Origins:
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-core-elements

> References:
---
</details>

## Window

<details>
<summary>What properties does a window element support?</summary>

> - `visible`
> - `visibilitity`
> - `title`

> Origins:
> - https://www.qt.io/product/qt6/qml-book

> References:
---
</details>

<details>
<summary>Changed the default size of the window?</summary>

> ```qml
> import QtQuick
>
> Window {
>     id: window
>     width: 300
>     height: 600
>     visible: true
>     visibility: Window.Maximized
>     title: qsTr("Image Viewer")
> }
> ``````

> Origins:
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-core-elements

> References:
---
</details>

## Rectangle

<details>
<summary>What properties does a rectangle support?</summary>

> `Rectangle` extends `Item` and adds following properties:
>
> - `color`
> - `border`: `border.radius`, `border.color`
> - `radius`

> Origins:
> - https://www.qt.io/product/qt6/qml-book/ch04-qmlstart-core-elements

> References:
---
</details>

<details>
<summary>Colorize the background of a window?</summary>

> ```qml
> import QtQuick
>
> Rectangle {
>     id: root
>     width: 600
>     height: 400
>     color: 'lightsteelblue'
> }
> ``````

> Origins:
> - https://www.qt.io/product/qt6/qml-book

> References:
---
</details>

## Text

<details>
<summary>Draw a text on the app?</summary>

> ```qml
> import QtQuick
>
> Window {
>     id: window
>     width: 640
>     height: 480
>     visible: true
>     title: qsTr("Image Viewer")
>
>     Text {
>         id: text
>         anchors.centerIn: parent
>         width: 100
>         height: 30
>         color: 'black'
>         horizontalAlignment: Text.AlignHCenter
>         verticalAlignment: Text.AlignVCenter
>         font.family: 'Ubuntu'
>         font.pixelSize: 18
>         text: 'Sample Text'
>         KeyNavigation.tab: other_text
>         focus: true
>         onHeightChanged: console.log('height: ', height)
>     }
> }
> ``````

> Origins:
> - https://www.qt.io/product/qt6/qml-book

> References:
---
</details>

## Property Alias

<details>
<summary>How does a property alias work?</summary>

> The alias keyword allows us to forward a property of an object or an object
> itself from within the type to an outer scope. A property alias does not need
> a type, it uses the type of the referenced property or object.
>
> ```qml
> property alias <name>: <reference>
> ``````

> Origins:
> - https://www.qt.io/product/qt6/qml-book

> References:
---
</details>

## Signals

<details>
<summary>How do signals work in QML?</summary>

> For every property, you can provide a signal handler. This handler is called after the property changes.
>
> ```qml
> ``````

> Origins:
> - https://www.qt.io/product/qt6/qml-book

> References:
---
</details>

<details>
<summary>Capture key signals in an element?</summary>

> ```qml
> Text {
>     id: label
>
>     onTextChanged: function(text) {
>         console.log("text changed to:", text)
>     }
>
>     Keys.onSpacePressed: {
>         log()
>     }
>
>     Keys.onEscapePressed: {
>         log()
>     }
>
>     function log() {
>         console.log('key pressed')
>     }
> }
> ``````

> Origins:
> - https://www.qt.io/product/qt6/qml-book

> References:
---
</details>

## Image

<details>
<summary>Load an image into the app?</summary>

> First, create a qrc resource file and add the image `assets/sample.png` as a
> resource.
>
> Then, modify `CMakeLists.txt` file to include `.qrc` file in your project.
>
> ```cmake
> qt_add_resources(RESOURCE_FILES assets.qrc)
> qt_add_executable(appsample
>     main.cpp
>     ${RESOURCE_FILES}
> )
> ``````
>
> Finally, add the image in an `Image` component:
>
> ```qml
> import QtQuick
>
> Window {
>     id: window
>     width: 680
>     height: 460
>
>     Image {
>         id: image
>         anchors.centerIn: parent
>         source: 'qrc:/assets/sample.png'
>     }
> }
> ``````

> Origins:
> - https://www.qt.io/product/qt6/qml-book

> References:
---
</details>

<details>
<summary>What are the properties of an image component?</summary>

> ```qml
> ``````

> Origins:
> - https://www.qt.io/product/qt6/qml-book

> References:
---
</details>

## Mouse Area
