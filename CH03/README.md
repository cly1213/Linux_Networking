# CH03

## Linux Bridge
Tools
- bridge
- iproute2
- iptables

STP(Spanning Tree Protocol)

forwarding table

FDB(Look up) forwarding database

### Bridge 
```
ip link add br0 type=bridge

brictl show
brictl help

bridge fdb
bridge link

ip link set master br0 dev veth0
```

### IPv4
https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing
```
$ ipcalc

ipcalc 192.168.5.23/19

ipcalc 192.65.24.12/24
```

### Routing
https://elixir.bootlin.com/linux/v4.15.18/source/net/ipv4/devinet.c#L2250
```
# To inspect routing tables

```