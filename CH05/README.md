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