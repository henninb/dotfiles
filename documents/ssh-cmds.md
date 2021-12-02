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
