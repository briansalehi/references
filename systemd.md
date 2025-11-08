# Systemd
# Linux Manual Pages
## manual
## Linux Manual Pages
### page
### Open Source Community
#### surface

#### Unit Types
##### systemd.unit

###### Which manual pages describe unit configuration options?

- `systemd.syntax`: general description of the syntax
- `systemd.unit`: common configuration options of all unit types
- `systemd.timer`: configuration options specific to timer unit
- `systemd.service`: configuration options specific to service unit
- `systemd.socket`: configuration options specific to socket unit
- `systemd.mount`: configuration options specific to mount unit
- `systemd.swap`: configuration options specific to swap unit
- `systemd.special`: describes special units managed by systemd
- `systemd.exec`: configuration options shared by service, socket, mount, and swap units
- `systemd.kill`: defines the killing procedure of processes belonging to service, socket, mount, and swap units
- `systemd.resource-control`: configuration options shared by service, slice, scope, socket, mount, and swap units
- `systemd.scope`: describes how to manage a group of processes
- `systemd.slice`: describes how to manage resources of a group of processes

###### What are the existing sections in a unit configuration file?

The common configuration items are configured in the generic `[Unit]` and `[Install]` sections. The service specific configuration options are configured in the `[Service]` section. Unit configuration files for services, sockets, mount points, and swap devices share a subset of configuration options which define the execution environment of spawned processes. The execution specific configuration options are configured in the `[Service]`, `[Socket]`, `[Mount]`, or `[Swap]` sections, depending on the unit type. Unit configuration files for services, slices, scopes, sockets, mount points, and swap devices share a subset of configuration options for resource control of spawned processes. The resource control configuration options are configured in the `[Slice]`, `[Scope]`, `[Service]`, `[Socket]`, `[Mount]`, or `[Swap]` sections, depending on the unit type.

```service
[Unit]

[Timer]

[Service]

[Socket]

[Mount]

[Swap]

[Slice]

[Scope]

[Install]
```

#### Unit Configuration File
##### systemd.unit

#### Service Configuration File
##### systemd.service

###### What is the role of service files?

Service files encode information about a process controlled and supervised by systemd.

###### What section is specific for services?

```service
[Service]
```

#### Timer Configuration File
##### systemd.timer

#### Socket Configuration File
##### systemd.socket

#### Mount Point Configuration File
##### systemd.mount

#### Swap Device Configuration File
##### systemd.swap

#### Scope Configuration File
##### systemd.scope

#### Slice Configuration File
##### systemd.slice

#### Special Units
##### systemd.special

---
# Subject
#### Topic Level (surface, depth, origin)

#### <Topic>
###### <Card>
