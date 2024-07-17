# Qt6 Deep Dive

### Qt Logs

> Reduce QML logs?
>
> ```cpp
> QLoggingCategory::setFilterRules("qt.qml.connections.warning=false");
> ``````

### Palettes

> What module is used for palettes?
>
> `QPalette::Accent`
> `Qt::ColorScheme::Dark` or `Qt::ColorScheme::Light`

### Badges

> What component is used to set badge number in taskbar?
>
> `QGuiApplication::seBadgeNumber`
>
> These methods outsourced to private API.

### HTTP

> What Qt version supports http server?
>
> HTTP protocol was added in Qt6.

### Protobuf

> What Qt version supports protobuf and grpc?
>
> Protobuf and grpc was added in Qt6.

### Multimedia

> What version supports multimedia?
>
> Multimedia supported from Qt6.

## CMake

> What C++ standard is mandatory for Qt6?
>
> C++17 is mandatory for Qt6.

> What cmake function is required to include Qt6?
>
> ```cmake
> find_package(Qt6 REQUIRED COMPONENTS Gui)
> ``````

> What is the least cmake version required for Ubuntu 22?
>
> CMake 3.22

> What official cmake functions are used to setup qt projects?
>
> ```cmake
> qt6_standard_project_setup(REQUIRES 6.5)
> qt6_add_executable(qt6deepdive main.cpp)
> ``````

> What official cmake function can be used to generate deploy app script?
>
> ```cmake
> qt6_generate_deploy_app_script(TARGET qt6deepdive OUTPUT_SCRIPT deploy_script)
> install(SCRIPT ${deploy_script})
> ``````

> What are the side effects of using official cmake function <code>qt6_standard_project_setup</code>?
>
> * Activates `CMAKE_AUTOMOC` and `CMAKE_AUTOUIC`.
> * Includes `GNUInstallDirs` and provides standard installation paths.

> What are the side effects of using official cmake functions <code>qt6_add_executable</code> and <code>qt6_add_library</code>?
>
> `Qt6::Core` is automatically linked.
> Creates finalization steps for certain platforms.
> Requires CMake 3.19, otherwise call `qt6_finalize_target` manually.

> What are the official qt deployment scripts in cmake?
>
> `qt6_generate_deploy_app_script`
> `qt6_generate_deploy_qml_script`
>
> These functions create script for dependencies like runtime dependencies, Qt itself, QML modules, etc.

> What official cmake function can be used to add QML modules?
>
> ```cmake
> qt6_add_qml_module(
>     URI com.example.app
>     VERSION 1.0
>     SOURCES
>         backend.cpp
>         backend.hpp
>     QML_FIlES
>         qml/Main.qml
>     RESOURCES
>         assets/logo.png
>     IMPORTS
>         QtQuick.Controls
>         QtQuick.Layouts
> )
> ``````

> What official cmake function is used to add qml sources?
>
> ```cmake
> qt6_target_qml_sources(
>     QML_FILES
>         Extras.qml
> )
> ``````

### String Literals

> What are the user defined literals for string literals in Qt6?
>
> ```cpp
> file.write(u"some data"_ba); # QByteArray
> file.write(u"some data"_s);  # QString
> file.write(u"some data"_L1); # QLatin1String
> ``````

### Signals

> How do signals should be written in Qt6?
>
> Signal handlers should now be specified as JavaScript functions:
>
> ```qml
> MouseArea {
>     anchors.fill: parent
>     onClicked: {
>         console.log("Button:", mouse.button);
>     }
> }
> ``````
>
> Should now be written as:
> ```qml
> MouseArea {
>     anchors.fill: parent
>     function onclicked(mouse) {
>         console.log("Button:", mouse.button);
>     }
> }
> ``````

