# Linux Administration

## YouTube

### DistroTube

#### Locating Tools

##### https://youtu.be/Tl6xOw6Au88

###### Locate the files of a command?

```sh
whereis <command>
```

###### Locate the manual pages of a command?

```sh
whereis -m <command>
```

###### Locate the binaries of a command?

```sh
whereis -b <command>
```

```sh
which <command>
```

###### Locate the binaries of a command with a specific pattern in their name?

```sh
whereis -b -g <glob>
```

##### https://youtu.be/rF3ymTBeZ_k

###### Locate all the binary instances of a command?

```sh
which -a <command>
```

###### Locate the binaries of a command used inside of an alias?

```sh
alias | which -i <command>
alias | which --read-alias <command>
```

###### Locate the binaries of a command used inside of a shell function?

```sh
declare -f | which --read-functions <command>
```

###### Locate the binaries of a command excluding directories starting with dot?

```sh
which --skip-dot <command>
```

###### Locate the binaries of a command excluding directories starting with tilde?

This option will also exclude the home directory.

```sh
which --skip-tilde <command>
```

#### System Monitoring

##### https://youtu.be/clqL--vqToE?feature=shared

###### What are the commonly used system monitoring commands?

```sh
top
htop
btop
```

#### Working Directory

##### https://youtu.be/nXJdxxXjkvA

###### Print the path to the working directory of your running shell?

```sh
pwd
```

###### Print the resolved path to the working directory of your running shell?

```sh
pwd -P
pwd --physical
```

#### User Management

##### https://youtu.be/TLH7tDk6OP4

###### Print the name of the user you are logged in with?

```sh
whoami
```

```sh
echo $USER
```

#### System Domain

##### https://youtu.be/XMPeAVx3Cls

###### Print the name of your system within a local domain?

```sh
hostname
```

###### Print the network addresses of your system?

```sh
hostname -i
```

```sh
ip address
```

###### Print the fully qualified domain name on your system?

```sh
hostname -f
```

###### Change the name of your system within a local domain?

```sh
sudo hostname <new name>
```

#### Kernel Management

##### https://youtu.be/TgoJ51OwSeA

###### Print the currently used kernel release?

```sh
uname -r
```

###### Print the machine architecture of the running system?

```sh
uname -m
```

#### Output Generators

##### https://youtu.be/d-3A3Y2C-Fc?feature=shared

###### Generate a sequence of numbers?

```sh
seq <numbers>
```

###### Generate a sequence of numbers with specific steps?

```sh
seq <begin> <step> <end>
```

#### Removing Files

##### https://youtu.be/1h9T3-X_1qQ

###### Remove a file?

```sh
rm <file>
```

###### Remove a file with suppressing errors?

```sh
rm -f <file>
```

###### Remove an empty directory?

```sh
rm -d <directory>
```

###### Remove a directly and its contents?

```sh
rm -r <directory>
```

###### Remove a file interactively?

The prompt can always appear:

```sh
rm -i <file>
```

Or it can only appear once when removing recursively:

```sh
rm -I <file>
```

###### Remove a file with receiving a confirmation of the removal?

```sh
rm -v <file>
```

##### https://youtu.be/07nVHYb_vV0

###### Remove an empty directory?

```sh
rmdir <directory>
```

###### Remove empty directories and ignore non-empty ones?

```sh
rmdir --ignore-fail-on-non-empty <directory>...
```

###### Remove nested empty directories?

```sh
rmdir -p <directory>/...
rmdir --parent <directory>/...
```

###### Remove empty directories with removal confirmations?

```sh
rmdir -v <directory>
```

#### Creating Directories

#### Moving Files


