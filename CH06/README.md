# CH06
## Access Private Service
- Port-Forwarding(DNAT)
- Reverse-Proxy(HTTP) -> Proxy process(Nginx) 
- VPN(Tunnel)

## VPN Implementation
### Tun/Tap
- OpenVPN
<img src="https://github.com/cly1213/Linux_networking/blob/main/CH06/image/openvpn.png"/>

# VPN
## Client to site
```
啟動 Vagrant

vagrant up

連到不同的 vagrant 機器

vagrant ssh host1
vagrant ssh host2

於 host2 安裝 openvpn server

wget https://git.io/vpn -O openvpn-install.sh
sudo chmod a+x openvpn-install.sh
sudo bash openvpn-install.sh

Public IP 地區請繼續輸入 172.18.2.4

獲得 Client 設定檔案後，透過 scp 複製到 host1
舉例(password 是 vagrant)

sudo scp /root/hwchiu.ovpn vagrant@172.18.2.3:~/

於 host 1 安裝 openvpn client
sudo apt-get install openvpn

測試連線
sudo openvpn --client --config hwchiu.ovpn

正式使用
sudo cp hwchiu.ovpn /etc/openvpn/client.conf
sudo systemctl restart openvpn@client

關閉 openvpn
sudo systemctl stop openvpn@client


觀察使用的 tun0 的 process
lsof /dev/net/tun
```
## Network Tunneling
## Site To Site
### IP in IP Tunnel
<img src="https://github.com/cly1213/Linux_networking/blob/main/CH06/image/ipinip.png"/
```
於 Host1 上面創立 IP-IP Tunnel

sudo ip tunnel add tunnel0 mode ipip remote 172.18.2.4 local 172.18.2.3
sudo ip link set up tunnel0

於 Host2 上面創立 IP-IP Tunnel
sudo ip tunnel add tunnel0 mode ipip remote 172.18.2.3 local 172.18.2.4
sudo ip link set up tunnel0


告知 Host1 哪些封包要透過 IP-IP 處理
sudo ip route add 10.66.0.0/24 dev tunnel0


告知 Host2 哪些封包要透過 IP-IP 處理
sudo ip route add 10.55.0.0/24 dev tunnel0


這時候可以嘗試使用兩個 Container 去互相存取，會發現網路不通，原因是 iptables 沒有弄好
強迫打開，修改預設全線
sudo iptables -t filter -P FORWARD ACCEPT

這時候可以通過 icmp 加上 tcpdump 觀察封包，會發現封包還是不能通，原因是因為 src IP 被強迫 SNAT，導致回來的封包無法被 Route

修正 nat 規則 (Host1)
sudo iptables -t nat -D POSTROUTING -s 10.55.0.0/24 -d 10.66.0.0/24 -j RETURN

修正 nat 規則 (Host2)
sudo iptables -t nat -D POSTROUTING -s 10.66.0.0/24 -d 10.55.0.0/24 -j RETURN

這時候 Container 都可以互通了，但是 Host 不能ping Container，主要還是封包的 SNAT 問題。
可以嘗試給 tunnel0 一個 IP，讓系統幫他選擇一個 IP。兩個節點都要做，目的是有辦法 routing.

host1
ip addr add 192.168.1.1/24 dev tunnel0

host2
ip addr add 192.168.1.254/24 dev tunnel0
```
K8s也使用此方法