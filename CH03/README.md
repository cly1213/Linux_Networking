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
# Linux Routing Table(RT) 
# To inspect routing tables

ip route add 192.168.0.0/24 dev eth0
ip route del 192.168.0.0/24 dev eth0

ip router add $network/prefix via $gateway dev $interface
```
### Iptables
```
iptables
iptables-save

sudo iptables-save -t filter 

sysctl net.bridge.bridge-nf-call-iptables

sudo sysctl -w net.bridge.bridge-nf-call-iptables=0

or

cd /proc/sys/net/bridge

echo "0" | tee bridge-nf-call-iptables 

sudo iptables-save -t filter -P FORWARD ACCEPT

default(DROP)

sudo iptables-save -t filter -P FORWARD DROP

#iptables add rules

sudo iptables -t filter -I FORWARD 1 -j ACCEPT
sudo iptables -t filter -I FORWARD 1 -s 10.56.6.0/24 -j ACCEPT
sudo iptables -t filter -I FORWARD 1 -s 10.56.6.0/24 -d 10.56.6.0/24 -j ACCEPT

#Delete

sudo iptables -t filter -D FORWARD -j ACCEPT
sudo iptables -t filter -D FORWARD -s 10.56.6.0/24 -j ACCEPT
sudo iptables -t filter -D FORWARD -s 10.56.6.0/24 -d 10.56.6.0/24 -j ACCEPT
```
### Docker Environment
```
docker run -d --name n1 nginx
docker run -d --name n2 nginx

docker ps

ip l

bridge link 

brictl show

ip route

sudo ls /var/run/docker/netns

ps auxw | grep nginx | grep master

nsenter -n -t $PID

ping 8.8.8.8

sudo iptables -t filter -D FORWARD -i docker0 ! -o docker0 -j ACCEPT
```

Other Ref:

https://github.com/osinstom/containers-impl-c

