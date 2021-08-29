# Network Namespace

Basic command
```bash
//ip netns + ...

ip netns help 

ip netns add ns1

ip netns list

ip netns exec ns1 bash

ip netns delete ns1

```

/var/run/netns/...

Recommand debugging command:

system call trace
```
$ strace ...
```

```bash
docker run -d nginx

docker ps

docker inspect $name

docker run -d -net=host nginx
```
/var/run/docker/netns/...
