# ARP_MAC_ICMP

```bash
sudo ip netns add ns1

sudo ip netns add ns2

sudo ip link add veth0 type veth peer veth2

sudo ip link set netns ns1 dev veth0

### Enter ns1
sudo ip netns exec ns1 bash

ip link set up dev veth0

ip addr add 10.55.66.7/24 dev veth0

ip neigh

tcpdump -vvvnl -i veth0 -w arp

././go/bin/tcpterm -r arp

or using Wireshark to see arp packet
#####################################################

sudo ip link set netns ns2 dev veth2 name eth0

sudo ip netns exec ns2 bash

ip link set up dev eth0

ip addr add 10.55.66.8/24 dev eth0

ip neigh

ip neigh flush dev eth0

ping 10.55.66.7 -c1
```
