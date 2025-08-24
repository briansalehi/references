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
