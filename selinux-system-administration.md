# Linux Administration
# SELinux System Administration
## book
## Packt Publishing
### chapter
### Sven Vermeulen

#### surface
#### Roles
##### Fundamental of SELinux Concepts

###### What is the role of SELinux roles in access control?

SELinux roles define which types can be accessed from the current context. These types on their parts define the permissions. As such, roles are a way to group types, and help define what a user can do in the system.

A user can be assigned multiple roles, but only one role can be active at a time.

###### Where are SELinux roles defined?

The role is defined in the SELinux user mapping file `/etc/selinux/targeted/seusers`.

###### What roles are available in a default SELinux installation?

* `user_r`: for restricted user, for unprivileged users. This role is only allowed to have processes with types specific to end-user applications. Privileged types, including those to switch to another user are not allowed for this role.
* `staff_r`: for non-critical operations. This role is restricted, but it has the ability to switch roles. Suitable for operators to keep them in their least privileged role.
* `sysadm_r`: for system administrators. This role is very privileged but certain end-user applications might not be accessible, especially with types that are used for potentially vulnerable or untrusted applications, to keep the system free from infections.
* `secadm_r`: for security administrators. This role allows changing the SELinux policy and manipulating the SELinux controls.
* `system_r`: for daemons and background processes. This role is quite privileged, supporting various daemon and system process types. But end-user applications are not allowed in this role.
* `unconfined_r`: for end users. This role allows a limited number of types, but those types are very privileged as they allow running any application launched by a user or another unconfined process. This role is available to protect certain processes with other roles while keeping the rest of the system operations untouched by SELinux.

###### Obtain an overview of the SELinux roles?

```sh
seinfo -r
seinfo --role
```

#### Users
##### Fundamental of SELinux Concepts

###### How does SELinux prevent unprivileged access when the Linux user has switched?

Unlike Linux users that can switch to one another, the SELinux policy can enforce that the SELinux user remains the same even when the Linux user itself has changed. Because of the immutable state of the SELinux user, we can implement specific access controls to ensure that users cannot work around the set of permissions granted to them, even when they get privileged access.

###### What restrictions does SELinux user impose on a Linux user?

The SELinux user defines which roles the Linux user can assume, and the role defines which types the user can access. The types define the permissions that are granted to the user.

###### What is the relationship between SELinux users and Linux users?

An SELinux user is mapped to a Linux user, and this mapping can be one-to-one or one-to-many. A Linux user can only be mapped to a single SELinux user.

A Linux user is first assigned to an SELinux user. Then, that user cannot switch to an SELinux role not associated with that SELinux user.

#### Sensitivity
##### Fundamental of SELinux Concepts

###### What is the role of sensitivity labels in access control?

Sensitivity labels are used to classify resources and restrict access to those resources based on a security clearance. This is often used in government and military environments where data classification is essential.

Sensitivity labels consist of two parts: a confidentiality value (prefixed with `s`) and a category value (prefixed with `c`).

###### What confidentiality model does MLS implement?

With MLS, we can configure SELinux to follow the *Bell-LaPadula* model, a security model characterized by no read up, no write down: based on a process's clearance level, that process cannot read anything with a higher confidentiality level nor write to or communicate with any resource with a lower confidentiality level.

###### How many confidentiality levels are available in MLS?

SELinux does not use internal, confidential, and other labels. Instead, it uses numbers from zero as the lowest confidentiality, to whatever the system administrator has defined as the highest value.

This is configurable and set when the SELinux policy is built.

#### Categories
##### Fundamental of SELinux Concepts

###### What are the use cases for categories in SELinux?

One of the functionalities resulting from using categories is to support multitenancy.

For example, systems hosting applications for multiple customers within a Linux system.

Multitenancy is provided by assigning a set of categories to the processes and resources of one tenant, whereas the processes and resources of another tenant get a different set of categories.

When a process does not have the proper categories assigned, it cannot touch the resources or other processes that have other categories assigned.

As multilevel security is not often used, the benefits of only using categories are persisted in what is called multi-category security (MCS). This is a special MLS case, which only supports a single confidentiality level (`s0`).

###### How tenants are isolated using categories?

At least two categories are used to differentiate between tenants.

By having services randomly pick two categories for a tenant out of a predefined set of categories, while ensuring each tenant has a unique combination, these services receive proper isolation. 

In that sense, categories are like tags, allowing us to grant access only when the tags of the process and the target resource match.





