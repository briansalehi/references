# Hands-On Mobile and Embedded Development with Qt 5

* subject: Qt
* resource name: Hands-On Mobile and Embedded Development with Qt 5
* author: Potter
* publisher: Packt Publishing
* resource type: book
* section pattern: chapter
* sections: 15

## What devices can be build targets?

* Linux: native build with direct support
* Android: using SDK and NDK with direct support
* Windows: using mingw or cygwin without direct support
* iOS: using Xcode to detect the device and build for it with direct support only on MacOS
* MacOS: using Xocde without direct support
* BareMetal: using SDKs with direct support after enabling plugins
* Boot to Qt: direct support for any device that can boot into Qt

## Integrate remote debugging in a development workflow?

The `gdbserver` needs to be running on the remote device, and there needs to be a serial or a TCP connection.

```sh
gdbserver <host>:<port> <target> <options>
```

```sh
gdbserver rpi:1324 --attach 93248
```

On host device:

```sh
gdb target remote <host>:<port>
```

```sh
gdb target remote rpi:1234
```

