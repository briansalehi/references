# Linux Security and Administration
<img src="../../../covers/linux-security-and-administration.jpg" width="200"/>

## Chapter 1/12 <sup>(ignored)</sup>


## Chapter 2/12

<details>
<summary>What mechanism should be used to prevent users from logging into <b>root</b> account on a Linux system when high privileges are needed?</summary>

> Using `sudo` accounts.
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

* [sudo(8)](https://manpages.org/sudo/8)

<details>
<summary>How to reduce the damage caused by privileged accessibilities on a system while these privileges are required?</summary>

> Using a limited access account and by separating fine grained privileges into activities, causes damage to whole system reduced.
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

* [visudo(8)](https://manpages.org/visudo/8)

<details>
<summary>How can we add a user to <i>sudo</i> group?</summary>

> On account creation:
>
> ```sh
> useradd -s /bin/bash -m -G sudo <username>
> ``````
>
> > After account creation:
>
> ```sh
> usermod -a -G sudo <username>
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> - [useradd(8)](https://manpages.org/useradd/8)
> ---
</details>


<details>
<summary>What file changes the default behavior of <i>useradd</i> command when creating accounts?</summary>

> ```sh
> /etc/login.defs
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> - [login.defs(5)](https://manpages.org/logindefs/5)
---
</details>

<details>
<summary>How to disable remote root login to prevent full system access from users?</summary>

> **Description**
>
> Set following configuration variable to `no` in `sshd` configuration:
>
> ```sh
> sudoedit /etc/ssh/sshd_config
> ``````
>
> ```conf
> PermitRootLogin no
> ``````
>
> And restart `sshd.service` on `systemd`:
>
> ```sh
> sudo systemctl restart sshd.service
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> - [sshd\_config(5)](https://manpages.org/sshd_config/5)
> ---
</details>

<details>
<summary>How to change default SSH port on Linux system to prevent brute-force attacks on default port?</summary>

> ```sh
> sudoedit /etc/ssh/sshd_config
> ``````
>
> ```conf
> Port 9292
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to restrict SSH connections only to a certain address family?</summary>

> ```sh
> sudoedit /etc/ssh/sshd_config
> ``````
>
> ```conf
> AddressFamily inet
> ``````
>
> ```sh
> sudo systemctl reload ssh
> ``````
>
> ---
> **Resources**
> -
>
> ---
> **References**
> ---
</details>

<details>
<summary>What modules is used to enfore users from following strict password policies?</summary>

> **Pluggable Authentication Modules (PAM)**
>
> **CentOS** and **Red Hat** distros already come with **PAM** enabled.
>
> *archlinux*
> ```sh
> sudo pacman -S pam
> ``````
>
> *debian*
> ```sh
> sudo apt install libpam-cracklib
> ``````
>
> ---
> **Resources**
> -

> **References**
> - [pam(8)](https://manpages.org/pam/8)
> ---
</details>

<details>
<summary>How to use <b>Pluggable Authentication Modules (PAM)</b> to implement password policies and enforce users to follow strict rules for setting their passwords?</summary>

> Configure **PAM** by editing following configuration file:
>
> ```sh
> sudoedit /etc/pam.d/passwd
> ``````
>
> Uncomment the line having following content:
>
> ```conf
> password required pam_cracklib.so difok=2 minlen=8 dcredit=2 ocredit=2 retry=3
> ``````
>
> * `difok`: check the number of characters used in the current password compared to previous one.
> * `minlen`: minimum length every password should have.
> * `dcredit`: the least number of numerals every password should have.
> * `ocredit`: the least number of special characters(?) every password should have.
> * `retry`: the number of times users can enter an incorrect password before getting locked.
>
> ---
> **Resources**
> -
>
> ---
> **References**
> - [pam.d(5)](https://manpages.org/pamd/5)
> - [pam.conf(5)](https://manpages.org/pamconf/5)
> ---
</details>

<details>
<summary>How to restrict SSH access to only users in <i>sshusers</i> group on a remote server?</summary>

> **Description**
>
> Create a new group called `sshusers`:
>
> ```sh
> sudo groupadd sshusers
> ``````
>
> Add appropriate users to this group:
>
> ```sh
> sudo usermod -a -G sshusers <username>
> ``````
>
> Allow users of this group to login in `/etc/ssh/sshd_config` configuration file:
>
> ```sh
> AllowGroups sshusers
> ``````
>
> Restart `sshd.service`:
>
> ```sh
> sudo systemctl restart sshd.service
> ``````
>
> Using this configuration, a user who does not belong to this specific group
> will be prevented to access to the server over SSH; their passwords may be
> entered correctly, but they will not be given access. This reduces the chance
> of people hacking the server through brute force attacks.
>
> ---
> **Resources**
> -
>
> ---
> **References**
> - [ssh(1)](https://manpages.org/ssh/1)
> - [sshd(8)](https://manpages.org/sshd/8)
> - [sshd\_config(5)](https://manpages.org/sshd_config/5)
---
</details>

## Chapter 3/12

<details>
<summary>What is the name of firewall mechanism used in the Linux kernel and what is the common firewall interface used to interact with it?</summary>

> - `netfilter` is the Linux firewall implemented in kernel.
> - `iptables` is a simple firewall interface to `netfilter`.
> - `firewalld` is also a commonly used firewall interface to `netfilter`.
>
> *archlinux*
> ```sh
> sudo pacman -S iptables firewalld
> ``````
>
> Enable only one of interfaces:
>
> ```sh
> sudo systemctl enable --now firewalld
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to get all the zones from firewalld?</summary>

> **Description**
>
> ```sh
> firewall-cmd --get-zones
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to list all the allowed services in a specific zone from firewalld?</summary>

> **Description**
>
> ```sh
> sudo firewall-cmd --zone public --list-services
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to list all the allowed ports in a specific zone from firewalld?</summary>

> **Description**
>
> ```sh
> sudo firewall-cmd --zone public --list-ports
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to list all the information of the default zone from firewalld?</summary>

> **Description**
>
> ```sh
> sudo firewall-cmd --list-all
> ``````
>
> ---
> **Resources**
> -
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to list all the information of all the zones from firewalld?</summary>

> ```sh
> sudo firewall-cmd --list-all-zones
> ``````
>
> ---
> **Resources**
> -
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to make changes permanently on firewalld?</summary>

> Use `--permanent` optional argument to make changes take effect even after reboot.
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to create a new zone on firewalld?</summary>

> **Description**
>
> ```sh
> sudo firewall-cmd --new-zone corp --permanent
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to reload firewalld so that new configuration is applied?</summary>

> **Description**
>
> ```sh
> sudo firewall-cmd --reload
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to add a service to the newly created zone in firewalld?</summary>

> **Description**
>
> ```sh
> sudo firewall-cmd --zone corp --add-service ssh --permanent
> sudo firewall-cmd --reload
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to identify the default zone used in firewalld?</summary>

> ```sh
> sudo firewall-cmd --get-default
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to set a custom firewalld zone as default?</summary>

> You should already allow `ssh` service in new zone to prevent losing access to the server once new zone was set to the interface.
>
> The firewalld will access the default zone for every command is used unless any other zone is specified.
>
> ```sh
> sudo firewall-cmd --change-interface <interface> --zone corp --permanent
> sudo firewall-cmd --set-default corp
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to list zones and the interfaces associated with them in firewalld?</summary>

> **Description**
>
> ```sh
> sudo firewall-cmd --get-active-zones
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to retrieve all the services available on the network to specify in firewalld?</summary>

> **Description**
>
> ```sh
> sudo firewall-cmd --get-services
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to allow a service in the default zone of firewalld?</summary>

> **Description**
>
> ```sh
> sudo systemctl enable --now <service>
> sudo firewall-cmd --add-service <service> --permanent
> sudo firewall-cmd --reload
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to remove a service from default zone in firewalld?</summary>

> ```sh
> sudo firewall-cmd --remove-service <service> --permanent
> sudo firewall-cmd --reload
> sudo systemctl disable --now <service>
> ``````
>
> ---
> **Resources**
> -
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to allow a new port in the default zone of firewalld?</summary>

> ```sh
> sudo firewall-cmd --add-port 1622/tcp --permanent
> sudo firewall-cmd --reload
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to remove a port in the default zone of firewalld?</summary>

> **Description**
>
> ```sh
> sudo firewall-cmd --remove-port 1622/tcp --permanent
> sudo fierwall-cmd --reload
> ``````
>
> ---
> **Resources**
> -
>
> ---
> **References**
> ---
</details>

## Chapter 4/12

<details>
<summary>How to create a 4096-bits RSA encripted SSH key to securely connect to remote server with it?</summary>

> ```sh
> ssh-keygen -t rsa -b 4096 -C "user@domain.tld" -f ~/.ssh/user_rsa
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to securely transfer locally generated SSH key to remote server?</summary>

> ```sh
> ssh-copy-id -i ~/.ssh/user_rsa.pub -p <port> user@domain.tld
> ``````
>
> ---
> **Resources**
> -
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to identify open and active ports on system?</summary>

> *deprecated*
> ```sh
> netstat -tuwlpn
> ``````
>
> *common*
> ```sh
> ss -tuwlpn
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to enable two factor authentication on a server to add an additional security layer for user logins?</summary>

> *archlinux*
> ```sh
> sudo pacman -S libpam-google-authenticator
> ``````
>
> *debian*
> ```sh
> sudo apt install libpam-google-authenticator
> ``````
>
> Setup a key:
>
> ```sh
> google-authenticator
> ``````
>
> Edit `sshd` service configuration:
>
> ```sh
> sudoedit /etc/ssh/sshd_config
> ``````
>
> ```conf
> UsePAM yes
> ChallengeResponseAuthentication yes
> ``````
>
> ```sh
> sudo systemctl reload sshd
> ``````
>
> Edit `pam` configuration:
>
> ```sh
> sudoedit /etc/pam.d/sshd
> ``````
>
> Add the following line:
>
> ```conf
> auth    required    pam_google_authenticator.so
> ``````
>
> ---
> **Resources**
> -
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to disable IPv4 or IPv6 on a server?</summary>

> **Description**
>
> ```sh
> sudoedit /etc/sysconfig/network
> ``````
>
> ```conf
> NETWORKING_IPV6=no
> IPV6INIT=no
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>What <b>Mandatory Access Control</b> modules are available for Linux systems?</summary>

> ```sh
> sudo apt install selinux-basics selinux-policy-default auditd
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to restrict the use of old passwords on Linux using <b>Pluggable Authentication Module (PAM)</b>?</summary>

> Edit **PAM** configuration file:
>
> ```sh
> sudoedit /etc/pam.d/system-auth
> ``````
>
> Add following lines:
>
> ```conf
> auth    sufficient  pam_unix.so likeauth nullok
> password    sufficient  pam_unix.so nullok use_authtok sha256 shadow remember=5
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>What tool can be used to prevent brute-force authentication attempts by blocking their IP addresses?</summary>

> `fail2ban` tool blocks frequently attempted login attempts.
>
> *archlinux*
> ```sh
> sudo pacman -S fail2ban
> ``````
>
> Configure the service by copying sample config file:
>
> ```sh
> cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
> sudoedit /etc/fail2ban/jail.local
> ``````
>
> ```conf
> [sshd]
> enabled = true
> port = ssh
> protocol = tcp
> filter = sshd
> logpath = /var/log/secure
> maxretry = 5
> findtime = 600
> bantime = 600
> ``````
>
> ```sh
> sudo systemctl restart fail2ban
> ``````
>
> ---
> **Resources**
> -
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to list all the blocked addresses by fail2ban?</summary>

> ```sh
> sudo fail2ban-client status ssh
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

## Chapter 5/12 (ignored)


## Chapter 6/12

<details>
<summary>What encryption tools are available on Linux?</summary>

> * gpg
> * bcrypt
> * ccrypt
> * zip (4-zip)
> * 7za (7-zip)
> * openssl
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>What tool is used to sign files, verify integrity, and encrypt or decrypt files in Linux systems?</summary>

> **GNU Privacy Guard** or **GnuPG**
>
> *archlinux*
> ```sh
> sudo pacman -S gnupg
> ``````
>
> *debian*
> ```sh
> sudo apt install gnupg
> ``````
>
> ---
> **Resources**
> -
>
> ---
> **References**
> - [gnupg(7)](https://manpages.org/gnupg/7)
> - [gpgconf(1)](https://manpages.org/gnupg/1)
> - [gpg-agent(1)](https://manpages.org/gnupg/1)
> ---
</details>

<details>
<summary>How to encrypt and decrypt files using GnuPG?</summary>

> Encrypt:
>
> ```sh
> gpg -c <file>
> ``````
>
> Decrypt:
>
> ```sh
> gpg <file>
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>What tool should be used to encrypt files by Blowfish cipher?</summary>

> *archlinux*
> ```sh
> sudo pacman -S cryptsetup
> ``````
>
> *debian*
> ```sh
> sudo apt install bcrypt
> ``````
>
> ---
> **Resources**
> -
>
> ---
> **References**
> - [bcrypt(1)](https://manpages.org/bcrypt/1)
---
</details>

<details>
<summary>How to encrypt or decrypt files using bcrypt?</summary>

> **Description**
>
> Encrypt:
>
> ```sh
> bcrypt <file>.ext
> ``````
>
> Decrypt:
>
> ```sh
> bcrypt <file>.bfe
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to use ccrypt and cdecrypt to encrypt and decrypt files on Linux?</summary>

> Encrypt:
>
> ```sh
> ccrypt <file>
> ``````
>
> Decrypt:
>
> ```sh
> cdecrypt <file>.cpt
> ``````
>
> ---
> **Resources**
> -
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to encrypt and decrypt files with compression using zip on Linux?</summary>

> Encrypt:
>
> ```sh
> zip -p <pass> <output.zip> files...
> ``````
>
> Decrypt:
>
> ```sh
> unzip <output.zip>
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to encrypt and decrypt files using 7za tool on Linux?</summary>

> ```sh
> 7za a -t zip -p -mem=aes256 output.zip files...
> 7za output.zip
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to encrypt and decrypt files using openssl tool on Linux?</summary>

> ```sh
> openssl enc -aes-256-cbc -in file -out output.dat
> openssl enc -aes-256-cbc -d -in output.dat > file
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

## Chapter 7/12 (ignored)


## Chapter 8/12

<details>
<summary>What kernel module can be used to encrypt block devices and what is the userspace interface for it?</summary>

> **Description**
>
> dm-crypt
>
> *archlinux*
> ```sh
> sudo pacman -S cryptsetup
> ``````
>
> *debian*
> ```sh
> sudo apt install cryptset
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to check if filesystem encryption module is available on kernel?</summary>

> ```sh
> gunzip -c /proc/config.gz | grep CONFIG_DM_CRYPT
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to use cryptsetup to encrypt or decrypt a partition on Linux systems?</summary>

> ```sh
> cryptsetup --version
> cryptsetup open /dev/sda1 encrypted_partition
> cryptsetup close encrypted_partition
> ``````
>
> ---
> **Resources**
> -
>
> ---
> **References**
> ---
</details>

## Chapter 9/12

<details>
<summary>How ACL permissions of files on Linux systems?</summary>

> ```sh
> getfacl <file>
> setfacl -m u::r <file>
> setfacl -x m::rx <file>
> ``````
>
> ---
> **Resources**
> -
>
> ---
> **References**
> - [acl(5)](https://manpages.org/acl/5)
> - [getfacl(1)](https://manpages.org/getfacl/1)
> - [setfacl(1)](https://manpages.org/setfacl/1)
> - [chacl(1)](https://manpages.org/chacl/1)
> ---
</details>

## Chapter 10/12 (ignored)


## Chapter 11/12 (ignored)


## Chapter 12/12

<details>
<summary>What tools are used to scan a system on network?</summary>

> **Description**
>
> - ping
> - traceroute
> - nmap
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>
