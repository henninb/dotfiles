# sudo

## mint sudoers file
```
#sudo visudo
henninb ALL=(ALL) NOPASSWD: ALL
%wheel ALL=(ALL) NOPASSWD: ALL
```

## disable pwfeedback - ** while typing sudo passwords
```
$ sudo mv /etc/sudoers.d/0pwfeedback /etc/sudoers.d/0pwfeedback.disabled
```

```
Defaults env_editor,editor=/usr/bin/vi:/usr/bin/vim
