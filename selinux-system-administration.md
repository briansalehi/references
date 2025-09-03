# Linux Administration
# SELinux System Administration
## book
## Packt Publishing
### chapter
### Sven Vermeulen

#### surface
#### Defining Policies
##### Fundamental of SELinux Concepts

###### What is the process of distributing SELinux policies?

Policies are first written, then compiled into modules, after which they are bundled and distributed.

###### What languages can be used to write SELinux policies?

* SELinux Source Format: human-readable format
* Reference Policy Style: extended source format used mostly by distributions
* Common Intermediate Language (CIL): computer-readable format

###### What are the policy files?

* `.te`: type enforcement rules
* `.if`: interface and template definitions
* `.fc`: file context expressions that assign labels to resources on the filesystem
* `.pp`: compiled policy module

###### Where SELinux policy modules are usually placed after distribution?

When distributing SELinux policy modules, they are normally placed in `/usr/share/selinux`, usually within a subdirectory named after the policy store.

###### Where SELinux policy modules are placed after they are activated?

When activating a module, SELinux place them in `/var/lib/selinux/mcs/active/modules`. When all modules are aggregated in a single location, the final policy binary is compiled in `/etc/selinux/targeted/policy/policy.00` or other number and loaded in memory.

###### Figure out which policy is active on a system?

A policy store contains a single policy, and only one policy can be active on a system at any point in time.

```sh
sestatus | grep "Loaded policy name"
```

###### Where does SELinux look for the configuration for next reboot?

The policy name that SELinux will use upon its next reboot is defined in the `/etc/selinux/config` file, set as `SELINUXTYPE` parameter.

###### Check if MLS policy is enabled?

```sh
sestatus | grep 'Policy MLS status'
```

A better programmatic way of checking for MLS policy is:

```sh
cat /sys/fs/selinux/mls
```

By which, 1 stands for enabled, and 0 otherwise.

###### How many policy stores are available?

Policy stores are usually named `targeted`, `mcs`, `mls`, and `strict`.

Generally, `targeted`, `mcs`, and `mls` policy stores have MLS enabled, while `strict` has that policy disabled.

#### Unconfined Domains
##### Fundamental of SELinux Concepts

###### How does SELinux react to new kernel permissions that is not yet known to SELinux?

SELinux can perform any of the following actions:

* `allow`
* `deny`
* `reject`

This can be configured through `deny_unknown` value.
To see the state for unknown permissions:

```sh
sestatus | grep 'Policy deny_unknown status'
```

###### Configure how SELinux should react to unknown permissions?

Administrators can `handle-unknown` variable to `allow`, `deny`, or `reject` values in `/etc/selinux/semanage.conf`.

###### Check if a type is available?

```sh
seifo -t unconfined_t
```




















