# CH05
## TCP/UDP
```
## Run two containers

docker run -d --name client netutils
docker run -d --name server netutils

## Open three windows respectively

docker exec -it server bash
nc -l -p 4000

## Window 2
docker exec -it client bash
nc 172.18.0.3 4000


## Window 3
tcpdump -vvvvln -i docker0 tcp

### Lab2

# Let iptables have a 50% chance of discarding TCP packets

sudo iptables -t filter -I FORWARD -p tcp -m tcp --dport 4000 -m statistic --mode random --probability 0.5 -j DROP

# Observe the client/server interaction, at this time the server will not receive the packet immediately, and at the same time, you can see various retransmissions through tcpdump or wireshark.

### Lab 3

sudo iptables -t filter -I FORWARD -p udp -m udp --dport 4000 -m statistic --mode random --probability 0.5 -j DROP

```

## ICMP
```
traceroute 8.8.8.8 

mtr 8.8.8.8

docker run -d --name client netutils

## Remove default route
sudo ip route delete default via 10.0.2.2 dev eth0

echo "0" | sudo tee /proc/sys/net/ipv4/icmp_ratelimit
```

## HTTP
### Connection Model
- Short-lived (establish 3 TCP connections)
- Persistent (establish 1 TCP connection)
- Pipeline 

## gRPC over HTTP/2
- layer 7 protocol

## DNS

## Load Balancing
- Proxy
- Transparency
- Client-side 

## DPI(Deep Packet Inspection)
https://github.com/ntop/nDPI/blob/dev/src/lib/protocols/telegram.c

https://github.com/ntop/nDPI/blob/dev/src/lib/protocols/spotify.c

https://github.com/ntop/nDPI
```
# Run at container
docker run -d --name client netutils

# Run at host
iperf3 -s -B 172.18.0.1

# Execute ndpi
sudo ./nDPI/example/ndpiReader -i docker0 -s 50

# Run in conater
ssh vagrant@172.17.8.220
ping 1.1.1.1
nslookup google.com
curl facebook.com
iperf3 -c 172.18.0.1
```