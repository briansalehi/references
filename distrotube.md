# Linux Administration
# DistroTube

## channel
## YouTube

### video
### DistroTube

#### surface
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

##### https://youtu.be/Do4G_es2vm8

###### Create a directory?

```sh
mkdir <name>
```

###### Create nested directories?

```sh
mkdir -p <directory>/...
mkdir --parents <directory>/...
```

###### Create directories with specific permissions?

```sh
mkdir -m <role>=<permissions> <directory>...
```

###### Create directories with confirmations after creation?

```sh
mkdir -v <directory>...
```

#### Manual Pages

##### https://youtu.be/1V5ewUKIM1I

###### Open the manual page of a command?

```sh
man <command>
```

###### Where is the common path to manual page files?

```sh
/usr/share/man
```

###### List available manpage sections of a command?

```sh
man -f <command>
```

###### Select a specific manpage section of a command?

```sh
man <section> <command>
```

###### Open a manpage in your favorite browser?

```sh
man --html=firefox <command>
```

###### Locate the path to the manual page files of a command?

```sh
man -w <command>
```

###### Search for the manual page of a command?

```sh
man -k <command>
```

###### Open the manual page of a command in a specific locale?

```sh
man --locale <locale> <command>
```

###### Open the manual page of a command with a specific pager?

```sh
man -P <pager> <command>
man --pager <pager> <command>
```

#### Moving Files

##### https://youtu.be/R8CQjsNYdvY

###### Rename a file?

```sh
mv <file> <file>
```

###### Prevent file overwrites when moving?

```sh
mv -n <file> <file>
```

###### Overwrite files when moving without prompts?

```sh
man -f <file> <file>
```

###### Interactively move files?

```sh
man -i <file> <file>
```

##### https://youtu.be/KeAkWb4wgsc

###### Copy a file into another path?

```sh
cp <file> <file>
```

###### Recursively copy files inside a directory?

```sh
cp -r <file> <file>
```

###### Update files when there are differences between source and destination?

```sh
cp -u <file> <file>
```

#### Changing Directory

##### https://youtu.be/0p4l-rIGTfs

###### Change the working directory of the running shell?

```sh
cd <path>
```

###### Change the working directory of the running shell into home directory?

```sh
cd ~
```

###### Change the working directory of the running shell into root directory?

```sh
cd /
```

###### Change the working directory of the running shell to its parent directory?

```sh
cd ..
```

#### Listing Directory Entries

##### https://youtu.be/T-4Q7i6mNeM

###### List entries of the current working directory of the running shell?

```sh
ls
```

###### List the entries of a directory?

```sh
ls <directory>
```

###### List the entries of a directory with human readable file sizes?

```sh
ls -lh
```

###### List the entries of a directory sorted by modification time?

```sh
ls -lt
```

###### List the entries of a directory sorted by file sizes?

```sh
ls -lS
```

To sort the list by size in descending:

```sh
ls -lrS
```

###### List the entries of a directory with directories grouped first?

```sh
ls -l --group-directories-first
```

#### Stream Manipulators

##### https://youtu.be/ArquIrMD-0M

###### Randomly shuffle the lines of a file or input stream?

```sh
shuf <file>
```

```sh
<command> | shuf
```

###### Generate a sequence of shuffled numbers?

```sh
shuf -i <begin>-<end>
shuf --input-range <begin>-<end>
```

###### Generate a random percentage?

```sh
shuf -i 0-100 -n 1
```

###### Generate a stream of randomly shuffled numbers?

```sh
shuf -i <begin>-<end> -n <count> -r
shuf --input-range <begin>-<end> --head-count <count> --repeat
```

##### https://youtu.be/z55PFrvuBqk

###### Sort the lines of a file or input stream?

```sh
sort <file>
```

```sh
<command> | sort
```

###### Reversely sort the lines of a file or input stream?

```sh
sort -r <file>
```

```sh
<command> | sort -r
```

###### Sort numerically the lines of a file or input stream?

```sh
sort -n <file>
```

```sh
<command> | sort -n
```

###### Randomly sort the lines of a file or input stream?

```sh
sort -R <file>
```

```sh
<command> | sort -R
```

In this scenario, `shuf` is than `sort`.

###### Sort a column of a file or input stream?

```sh
sort -k <column> <file>
```

```sh
<command> | sort -k <column>
```

###### Unique sort the lines of a file or input stream?

In this case, `uniq` can also be used after `sort`.

```sh
sort -u <file>
```

```sh
<command> | sort -u
```

#### Grep

##### https://youtu.be/speTBP-NXJo

###### Search for a pattern in a file or input stream?

Grep uses basic regular expressions by default.

```sh
grep -G <pattern> <file>
grep <pattern> <file>
```

```sh
<command> | grep <pattern>
```

###### Use extended regular expressions for searching a pattern in a file or input stream?

```sh
grep -E <pattern> <file>
```

```sh
<command> | grep -E <pattern>
```

###### Search for a fixed string in a file or input stream?

```sh
grep -F <string> <file>
```

```sh
<command> | grep -F <string>
```

###### Invert the search results of a pattern in a file or input stream?

```sh
grep -v <pattern> <file>
```

```sh
<command> | grep -v <pattern>
```

###### Recursively search for a pattern in a directory?

```sh
grep -r <pattern> <directory>
```

###### Ignore binary files when searching for a pattern?

```sh
grep -rI <pattern> <directory>
```

###### Find the files containing a pattern rather than the lines?

```sh
grep -rl <pattern> <directory>
```

###### Ignore case sensitivity when searching for a pattern?

```sh
grep -i <pattern> <file>
```

###### Include line numbers in the search results of a pattern?

```sh
grep -rn <pattern> <directory>
```

###### Suppress error messages when searching for a pattern?

```sh
grep -s <pattern> <file>
```

###### Suppress all output and only return the exit status when searching for a pattern?

```sh
grep -q <pattern> <file>
```

###### Search for a whole word pattern in a file or input stream?

```sh
grep -w <pattern> <file>
```

###### Search for a pattern that matches the whole line in a file or input stream?

```sh
grep -x <pattern> <file>
```

###### Count the number of matching lines for a pattern in a file or input stream?

```sh
grep -c <pattern> <file>
```

###### Limit the number of matching lines for a pattern in a file or input stream?

```sh
grep -m <limit> <pattern> <file>
```










