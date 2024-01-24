# Linux Administration

## RAID

<details>
<summary>What is a RAID used for?</summary>

> **Redundant Array of Independent Drives** is a mechanism in which multiple
> disks are combined for more reliablity and speed.

> Origins:
> - mdadm(1)

> References:
---
</details>

<details>
<summary>What are the RAID levels?</summary>

> **RAID 0**
> **RAID 1**
> **RAID 3**
>
> Similar to RAID 5 but with parities on only one drive.
>
> **RAID 4**
> **RAID 5**
> **RAID 6**
> **RAID 10**

> Origins:
> - mdadm(1)

> References:
---
</details>

## Running RAID

<details>
<summary>Create an array of drives with RAID level 5?</summary>

> ```sh
> mdadm --create --verbose /dev/md0 --level 5 --raid-devices 3 /dev/sda /dev/sdb /dev/sdc
> ``````

> Origins:
> - mdadm(1)

> References:
---
</details>

## RAID Status

<details>
<summary>Get the current status of RAID array?</summary>

> ```sh
> cat /proc/mdstat
> watch -n1 cat /proc/mdstat
> ``````

> Origins:
> - mdadm(1)

> References:
---
</details>

<details>
<summary>Retrieve RAID details?</summary>

> ```sh
> mdadm --detail --scan
> mdadm --detail /dev/md0
> ``````

> Origins:
> - mdadm(1)

> References:
---
</details>

## Making RAID Permanent

<details>
<summary>Make a RAID array permanent?</summary>

> ```sh
> mdadm --detail --scan >> /etc/mdadm.conf
> ``````

> Origins:
> - mdadm(1)

> References:
---
</details>

## Monitoring RAID

<details>
<summary>Start monitoring RAID and get notified about failures?</summary>

> Edit `mdadm(1)` configuration `/etc/mdadm.conf`, and specify `MAILADDR`,
> `MAILFROM` and `PROGRAM`.
>
> ```sh
> mdadm --monitor --scan --test
> ``````

> Origins:
> - mdadm(1)

> References:
---
</details>

<details>
<summary>Stop monitoring a RAID?</summary>

> ```sh
> mdadm --monitor --stop
> ``````

> Origins:
> - mdadm(1)

> References:
---
</details>

## Stopping RAID

<details>
<summary>Stop a RAID array temporarily?</summary>

> ```sh
> mdadm --stop /dev/md0
> ``````

> Origins:
> - mdadm(1)

> References:
---
</details>

<details>
<summary>Run an array of raided devices from the stopped state?</summary>

> ```sh
> mdadm --assemble /dev/md0 /dev/sda /dev/sdb /dev/sdc
> ``````

> Origins:
> - mdadm(1)

> References:
---
</details>

## Removing RAID

<details>
<summary>Remove an array component from a RAID?</summary>

> ```sh
> mdadm --manage /dev/md0 --fail /dev/sdX
> mdadm --manage /dev/md0 --remove /dev/sdX
> mdadm --zero-superblock /dev/sdX
> mdadm --detail --scan >> /etc/mdadm.conf
> ``````

> Origins:
> - mdadm(1)

> References:
---
</details>

## Extending RAID

<details>
<summary>Add an storage drive into the array?</summary>

> ```sh
> fdisk /dev/sdd
> mdadm --manage /dev/md0 --add /dev/sdd
> ``````

> Origins:
> - mdadm(1)

> References:
---
</details>
