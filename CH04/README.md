# CH04
## NAT
### SNAT
source NAT

PreRouting
- DNAT

PostRouting
- SNAT

### SNAT/MASQUERADE
https://lxr.missinglinkelectronics.com/linux+v4.5/net/netfilter/xt_nat.c#L76

https://lxr.missinglinkelectronics.com/linux+v4.5/net/ipv4/netfilter/ipt_MASQUERADE.c#L58

<img src="https://github.com/cly1213/Linux_networking/blob/main/image/packet_flow.png"/>


### SNAT
basic
```
sudo docker run -d -name client netutils

nslookup google.com

sudo tcpdump -vvvvln -i eth0 udp and port 53

sudo iptables -t nat -D POSTROUTING -s 172.18.0.0/16 ! -o docker0 -j MASQUERADE

sudo iptables -t nat -I POSTROUTING -s 172.18.0.0/16 ! -o docker0 -p udp -j MASQUERADE --to-ports 5000-5010

sudo iptables -t nat -I POSTROUTING -s 172.18.0.0/16 ! -o docker0 -p udp -j MASQUERADE --random


#Not exist ip
sudo iptables -t nat -I POSTROUTING -s 172.18.0.0/16 ! -o docker0 -p udp -j SNAT --to-source 1.2.3.4


#Normal
sudo iptables -t nat -I POSTROUTING -s 172.18.0.0/16 ! -o docker0 -p udp -j SNAT --to-source 10.0.2.15

#Port Range
sudo iptables -t nat -I POSTROUTING -s 172.18.0.0/16 ! -o docker0 -p udp -j SNAT --to-source 10.0.2.15:1234:5555
```

### DNAT
Destination NAT

https://lxr.missinglinkelectronics.com/linux+v4.5/net/netfilter/xt_nat.c#L76

Port Forwarding/Virtual Function(home router)
```
sudo docker run -d --name www -p 12345:8000 netutils:python
sudo docker run -d --name client netutils:python

sudo tcpdump -vvvvln -i eth1 tcp

sudo iptables -t nat -I OUTPUT -p tcp -m tcp --dport 12345 -j DNAT --to-destination 172.18.0.2:8000

sudo iptables -t nat -I DOCKER 1  -p tcp -m tcp --dport 12345 -j DNAT --to-destination 172.18.0.2:8000

sudo bridge link set dev veth3947548 hairpin on
sudo bridge link set dev veth3947548 hairpin off

sudo ip link set dev docker0 promisc on
sudo ip link set dev docker0 promisc off
```

```
ps auxw | grep docker-proxy

sudo iptables-save -t nat -c

sudo tcpdump -vvvvln -i docker0
sudo tcpdump -vvvvln -i veth026bc26

#Inside container 
netstat -naltp
```

#### SNAT + DNAT
Ex: Kubernates Service


### Conntrack
```
curl google.com

sudo conntrack -L

docker run -d --name www -p 12345:8000 netutils:python

sudo iptables -t filter -D FORWARD -o docker0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

nc 172.17.8.222 12345 #Create connection
```




