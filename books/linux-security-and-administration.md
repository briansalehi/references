# [Linux Security and Administration](#)
<img alt="linux-security-and-administration" src="../covers/linux-security-and-administration.jpg" width="200"/>

> This tiny book is a good source to understand basics of Linux security and can be a big first step for beginners.

## Chapter 1/12

Nothing to import.

## Chapter 2/12

<details>
<summary>What mechanism should be used to prevent users from logging into <b>root</b> account on a Linux system when high privileges are needed?</summary>

> Using `sudo` accounts.
</details>

* [sudo(8)](https://manpages.org/sudo/8)

<details>
<summary>How to reduce the damage caused by privileged accessibilities on a system while these privileges are required?</summary>

> Using a limited access account and by separating fine grained privileges into activities, causes damage to whole system reduced.
</details>

* [visudo(8)](https://manpages.org/visudo/8)

<details>
<summary>How can we add a user to <i>sudo</i> group?</summary>

> On account creation:

```sh
useradd -s /bin/bash -m -G sudo <username>
```

> After account creation:

```sh
usermod -a -G sudo <username>
```
</details>

* [useradd(8)](https://manpages.org/useradd/8)

<details>
<summary>What file changes the default behavior of <i>useradd</i> command when creating accounts?</summary>

```sh
/etc/login.defs
```
</details>

* [login.defs(5)](https://manpages.org/logindefs/5)

<details>
<summary>How to disable remote root login to prevent full system access from users?</summary>

> Set following configuration variable to `no` in `sshd` configuration:

```sh
sudoedit /etc/ssh/sshd_config
```

```conf
PermitRootLogin no
```

> And restart `sshd.service` on `systemd`:

```sh
sudo systemctl restart sshd.service
```
</details>

* [sshd\_config(5)](https://manpages.org/sshd_config/5)

<details>
<summary>What modules is used to enfore users from following strict password policies?</summary>

> **Pluggable Authentication Modules (PAM)**

> **CentOS** and **Red Hat** distros already come with **PAM** enabled.

*archlinux*
```sh
sudo pacman -S pam
```

*debian*
```sh
sudo apt install libpam-cracklib
```
</details>

* [pam(8)](https://manpages.org/pam/8)

<details>
<summary>How to use <b>Pluggable Authentication Modules (PAM)</b> to implement password policies and enforce users to follow strict rules for setting their passwords?</summary>

> Configure **PAM** by editing following configuration file:

```sh
sudoedit /etc/pam.d/passwd
```

Uncomment the line having following content:

```conf
password required pam_cracklib.so difok=2 minlen=8 dcredit=2 ocredit=2 retry=3
```

* `difok`: check the number of characters used in the current password compared to previous one.
* `minlen`: minimum length every password should have.
* `dcredit`: the least number of numerals every password should have.
* `ocredit`: the least number of special characters(?) every password should have.
* `retry`: the number of times users can enter an incorrect password before getting locked.
</details>

* [pam.d(5)](https://manpages.org/pamd/5)
* [pam.conf(5)](https://manpages.org/pamconf/5)

<details>
<summary>How to restrict SSH access to only users in <i>sshusers</i> group on a remote server?</summary>

> Create a new group called `sshusers`:

```sh
sudo groupadd sshusers
```

> Add appropriate users to this group:

```sh
sudo usermod -a -G sshusers <username>
```

> Allow users of this group to login in `/etc/ssh/sshd_config` configuration file:

```sh
AllowGroups sshusers
```

Restart `sshd.service`:

```sh
sudo systemctl restart sshd.service
```

> Using this configuration, a user who does not belong to this specific group will be prevented to access to the server over SSH; their passwords may be entered correctly, but they will not be given access. This reduces the chance of people hacking the server through brute force attacks.
</details>

* [ssh(1)](https://manpages.org/ssh/1)
* [sshd(8)](https://manpages.org/sshd/8)
* [sshd\_config(5)](https://manpages.org/sshd_config/5)

## Chapter 3/12

<details>
<summary>What is the name of firewall mechanism used in the Linux kernel and what is the common firewall interface used to interact with it?</summary>

> `netfilter` is the Linux firewall implemented in kernel.

> `iptables` is a simple firewall interface to `netfilter`.  
> `firewalld` is also a commonly used firewall interface to `netfilter`.

*archlinux*
```sh
sudo pacman -S iptables firewalld
```

> Enable only one of interfaces:

```sh
sudo systemctl enable --now firewalld
```
</details>

<details>
<summary>How to get all the zones from firewalld?</summary>

```sh
firewall-cmd --get-zones
```
</details>

<details>
<summary>How to list all the allowed services in a specific zone from firewalld?</summary>

```sh
sudo firewall-cmd --zone public --list-services
```
</details>

<details>
<summary>How to list all the allowed ports in a specific zone from firewalld?</summary>

```sh
sudo firewall-cmd --zone public --list-ports
```
</details>

<details>
<summary>How to list all the information of the default zone from firewalld?</summary>

```sh
sudo firewall-cmd --list-all
```
</details>

<details>
<summary>How to list all the information of all the zones from firewalld?</summary>

```sh
sudo firewall-cmd --list-all-zones
```
</details>

<details>
<summary>How to make changes permanently on firewalld?</summary>

> Use `--permanent` optional argument to make changes take effect even after reboot.
</details>

<details>
<summary>How to create a new zone on firewalld?</summary>

```sh
sudo firewall-cmd --new-zone corp --permanent
```
</details>

<details>
<summary>How to reload firewalld so that new configuration is applied?</summary>

```sh
sudo firewall-cmd --reload
```
</details>

<details>
<summary>How to add a service to the newly created zone in firewalld?</summary>

```sh
sudo firewall-cmd --zone corp --add-service ssh --permanent
sudo firewall-cmd --reload
```
</details>

<details>
<summary>How to identify the default zone used in firewalld?</summary>

```sh
sudo firewall-cmd --get-default
```
</details>

<details>
<summary>How to set a custom firewalld zone as default?</summary>

> You should already allow `ssh` service in new zone to prevent losing access to the server once new zone was set to the interface.

> The firewalld will access the default zone for every command is used unless any other zone is specified.

```sh
sudo firewall-cmd --change-interface <interface> --zone corp --permanent
sudo firewall-cmd --set-default corp
```
</details>

<details>
<summary>How to list zones and the interfaces associated with them in firewalld?</summary>

```sh
sudo firewall-cmd --get-active-zones
```
</details>

<details>
<summary>How to retrieve all the services available on the network to specify in firewalld?</summary>

```sh
sudo firewall-cmd --get-services
```
</details>

<details>
<summary>How to allow a service in the default zone of firewalld?</summary>

```sh
sudo systemctl enable --now <service>
sudo firewall-cmd --add-service <service> --permanent
sudo firewall-cmd --reload
```
</details>

<details>
<summary>How to remove a service from default zone in firewalld?</summary>

```sh
sudo firewall-cmd --remove-service <service> --permanent
sudo firewall-cmd --reload
sudo systemctl disable --now <service>
```
</details>

<details>
<summary>How to allow a new port in the default zone of firewalld?</summary>

```sh
sudo firewall-cmd --add-port 1622/tcp --permanent
sudo firewall-cmd --reload
```
</details>

<details>
<summary>How to remove a port in the default zone of firewalld?</summary>

```sh
sudo firewall-cmd --remove-port 1622/tcp --permanent
sudo fierwall-cmd --reload
```
</details>

## Chapter 4/12
## Chapter 5/12
## Chapter 6/12
## Chapter 7/12
## Chapter 8/12
## Chapter 9/12
## Chapter 10/12
## Chapter 11/12
## Chapter 12/12
