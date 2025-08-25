# Linux Administration
# SELinux System Administration
## book
## Packt Publishing
### chapter
### Sven Vermeulen

#### surface
#### Mandatory Access Control

##### Fundamental of SELinux Concepts

###### What mechanism does SELinux use to enforce access control?

Unlike its Discretionary Access Control (DAC) counterpart, SELinux gives the system administrator full control over what is allowed on the system by enforcing policies through the Linux kernel over what processes are allowed to do.

Users and processes do not have permission to change the security rules, so they cannot work around the access control rules.

###### What part of the kernel does SELinux integrate with?

SELinux integrates with the Linux Security Modules (LSM) framework in the Linux kernel. LSM provides a way to implement various security policies, including SELinux, AppArmor, and others.

###### Read the list of active LSM modules on a system?

```sh
cat /sys/kernel/security/lsm
```

###### What are the disadvantages of having fine-grained access control policies in SELinux?

If the policies are not written in a least-privilege model, then SELinux might consider this non-standard behavior and allow the actions to continue. For policy writers, this means that their policy rules have to be very fine-grained. This makes writing policies very time-consuming. With more than 130 classes and 250 permissions known to SELinux, policy rules need to take all these classes and permissions into account for each interaction.

###### What are the building blocks of SELinux implementation?

* The SELinux kernel subsystem implemented through the LSM framework
* Libraries used by user-space applications to interact with SELinux
* Utilities to manage and configure SELinux
* A set of SELinux policies that define the access control rules

#### Discretionary Access Control Commands
##### Fundamental of SELinux Concepts

###### Get the access control list of a file?

```sh
getfacl <file>
```

###### Set the access control list of a file?

```sh
setfacl -m u:<username>:rwx <file>
```

#### Enabling SELinux
##### Fundamental of SELinux Concepts

###### Check the current SELinux status?

```sh
sestatus
```

###### What are the prerequisites for enabling SELinux on a system?

Since SELinux is integrated into the Linux kernel, it is essential to ensure that the kernel has SELinux support enabled. Most modern Linux distributions come with SELinux support enabled by default, e.g. Fedora and Red Hat. But some distributions, such as Ubuntu and Debian, do not have SELinux enabled by default but document how to enable it.

#### Contexts
##### Fundamental of SELinux Concepts

###### What is a context in an SELinux policy?

SELinux decides wether to allow or deny a particular action based on the context on both the subject (process or user) initiating the action and the object (file, socket, etc.) which is the target of the action. A context is a label that is attached to every subject and object in the system.

###### How does SELinux identify a process?

SELinux has no notion of Linux process ownership and does not care how the process is called, which process ID it has, and what account the process runs as. SELinux identifies a process by its security context, which is a label that includes the user, role, type, and level of the process. The context is used to determine what actions the process is allowed to perform on various objects in the system.

###### What is a label in SELinux terminology?

Label is the string representation of the security context of a subject or an object in SELinux. Similar to what a context has, a label contains four components: user, role, type, and level.

###### Print the context of your user?

```sh
id -Z
```

###### What makes label-based access control in SELinux more flexible than using path names in other LSM implementations?

An expression as follows can only be used for one binary file, and if the binary file is moved, the rule will no longer apply:

Allow the `httpd` processes to bind to TCP port 80.

But with labels, the rule can be applied to any binary file that has the `httpd_t` type, regardless of its path:

Allow the processes with the `httpd_t` type to bind to TCP ports labeled with `http_port_t`.

With this context, the binary can be called `apache2` or `nginx`, as long as the process is labeled `httpd_t`, the rule will apply without changing the policy. The same applies to the port 80 or 8080 that can be labeled `http_port_t`.

###### What are the four components of an SELinux context?

`user:role:type:level`

Note that the `level` component is optional and is only used when Multi-Level Security (MLS) is enabled. `level` may also contain semicolons, which are used to separate multiple levels.

The `type` component can also be referred to as `domain` when it is used for processes.

#### Process Attributes
##### Fundamental of SELinux Concepts

###### Where are process attributes stored in the system?

Process attributes are stored in the `/proc` filesystem, specifically in the `/proc/<pid>/attr/current` file.

All these files, if read, display either nothing or an SELinux context. If it is empty, then it means the process has not explicitly set a context for that particular purpose, and the SELinux context will be deduced either from the policy or inherited from its parent.

###### What each of the attribute files in the process directory represent?

* `current`: The current SELinux context of the process.
* `exec`: The SELinux context that will be applied when the process executes a new binary.
* `fscreate`: The SELinux context that will be applied to newly created files and directories
* `sockcreate`: The SELinux context that will be applied to newly created sockets.
* `keycreate`: The SELinux context that will be applied to newly created IPC keys.
* `prev`: The previous SELinux context of the process before the last context change.

###### Take the attributes of processes?

```sh
ps -eZ
```

#### Type Enforcement
##### Fundamental of SELinux Concepts

###### What does the type component in an SELinux context enforce?

With type enforcement, SELinux controls processes behavior based on how it got executed in the first place. A web server launched by a user will run with a different type than the same web server launched by the init system.

