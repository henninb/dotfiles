systemctl --user status gcr-ssh-agent.socket
echo o
echo $SSH_AUTH_SOCK
export SSH_AUTH_SOCK=/run/user/1000/gcr
