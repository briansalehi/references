# [Linux Security and Administration](#)
<img alt="linux-security-and-administration" src="covers/linux-security-and-administration.jpg" width="200"/>

> Not ranked yet.

## Chapter 1/12

Nothing to import.

## Chapter 2/12

<details>
<summary>What mechanism should be used to prevent users from logging into `root` account on a Linux system when high privileges are needed?</summary>

> Using `sudo` accounts.
</details>

<details>
<summary>How to reduce the damage caused by privileged accessibilities on a system while these privileges are required?</summary>

> Using a limited access account and by separating fine grained privileges into activities, causes damage to whole system reduced.
</details>

<details>
<summary>How to create a user when only root is available and access should immediately be transferred into regular users?</summary>

```sh
useradd -s /bin/bash -m <username>
```
</details>

* [useradd(8)](https://manpages.org/useradd/8)

<details>
<summary>How can we add a user to `sudo` group?</summary>

> On account creation:

```sh
useradd -s /bin/bash -m -G sudo <username>
```

> After account creation:

```sh
usermod -a -G sudo <username>
```
</details>

<details>
<summary>What file changes the default behavior of `useradd` command when creating accounts?</summary>

```sh
/etc/login.defs
```
</details>

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

<details>
<summary>What modules is used to enfore users from following strict password policies?</summary>

> **Pluggable Authentication Modules (PAM)**
</details>

<details>
<summary>How to setup **PAM** on system?</summary>

> Install PAM on system:

*archlinux*
```sh
sudo pacman -S pam
```

*debian*
```sh
sudo apt install libpam-cracklib
```

> **CentOS** and **Red Hat** distros already come with **PAM** enabled.
</details>

<details>
<summary>How to use **Pluggable Authentication Modules (PAM)** to implement password policies and enforce users to follow strict rules for setting their passwords?</summary>

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

<details>
<summary>How to restrict SSH access to only users in `sshusers` group on a remote server?</summary>

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

## Chapter 3/12
## Chapter 4/12
## Chapter 5/12
## Chapter 6/12
## Chapter 7/12
## Chapter 8/12
## Chapter 9/12
## Chapter 10/12
## Chapter 11/12
## Chapter 12/12
