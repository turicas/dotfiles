# Server post-install

IPv6-related configurations (IP forwarding, ndppd and docker config).


## IP Forwarding

Edit `/etc/sysctl.conf`:
```
net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1
net.ipv6.conf.enp1s0.proxy_ndp = 1
```


## ndppd

Execute:
```
apt install -y ndppd
```

Edit `/etc/ndppd.conf`:

```
proxy enp1s0 {
  timeout 500
  ttl 30000
  rule <ipv6-network>/80 {
    static
  }
}
```

Then, execute:

```
systemctl enable ndppd
```

## Docker daemon

Edit `/etc/docker/daemon.json`:
```
{
  "live-restore": true,
  "debug": false,
  "ipv6": true,
  "fixed-cidr-v6": "<ipv6-network>/80"
}
```

Then, execute:
```
service docker restart
```
