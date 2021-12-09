# ssh commands

## generate a public key from a private key
```shell
$ ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
```

## restrict sshd to ssh key
```
vi ~/.ssh/authorized_keys
options keytype base64-encoded-key comment
```

example
from="10.0.0.?,*.example.com",no-X11-forwarding ssh-rsa AB3Nz...EN8w== user@example.com


## disable password login
```
vi /etc/ssh/sshd_config
ChallengeResponseAuthentication no
PasswordAuthentication no
UsePAM no
```

## generate new ssh keys
```
ssh-keygen -t rsa -b 4096 -C "github.com" -f ~/.ssh/github-id_rsa
ssh-keygen -t rsa -b 4096 -C "gitlab.com" -f ~/.ssh/gitlab-id_rsa
ssh-keygen -t rsa -b 4096 -C "bastion" -f ~/.ssh/bastion-id_rsa
```

## start ssh agent
```
eval "$(ssh-agent -s)"

ssh-add ~/.ssh/github-id_rsa
```


## jump host config
```
~/.ssh/config
Host bastion
  HostName 192.168.10.33

Host pfsense
  HostName 192.168.10.1
  ProxyJump bastion
```
