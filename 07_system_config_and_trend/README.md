# CH07
## Home Network
### network topology
- Container -> Servers
- Linux bridge -> Switch
- Iptables -> Firewall
- Linux Kernal -> Router

## SDN(Software Defined Network)
that network distinct control and data planes.
- Openflow

### Use Cases
- Network Virtualization
- Traffic Engineering for WANs (google) 
- Software-Defined WANs
- ...etc

## Configuration
### Layer2
- ARP, Bridge
### Layer3
- IPv4, IPv6
### Layer4
- TCP, UDP
```
sysctl -a | grep xxxx
sysctl -ar 'xxxx'
```
### Location
/proc/sys/net

### bridge
/proc/sys/net/bridge

### netfilter
/proc/sys/net/netfilter
- Conntrack table

### ipv4
/proc/sys/net/ipv4

/proc/sys/net/ipv4/conf/xxxx/

eg./proc/sys/net/ipv4/conf/docker0/ 

- forwarding (forward packet)
- rp_filter (Reverse Path Filtering)
- arp_ignore
- arp_filter

### ipv4 tcp
/proc/sys/net/ipv4/

## Network Debugging
#### How to Debug Network?
1. Network Topology(clearly describe the problem)

2. Can we reproduce the issue? -> Narrow down

3. Collect Debug Information

4. Advanced Tools

5. Tools
- DNS: dig, nslookup
- Routing: traceroute, mtr, ip route
- Send packets: ping, arping, hping, iperf, nc...etc
- Monitor traffics: iftop, sar
- Socket: netstat, ss




