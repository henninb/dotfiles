#!/bin/sh

cat > "$HOME/tmp/ddwrt-cert-mount.sh" << 'EOF'
#!/bin/sh
# enable jffs support
# scp this script to /jffs/startup

if [ `nvram get https_enable` -gt 0 ] ; then
    # get the absolute directory of the executable
    SELF_PATH=$(cd -P "$(dirname "$0")" && pwd -P)
    echo SELF_PATH: ${SELF_PATH}

    # extract the mount path
    MOUNT_PATH=`echo ${SELF_PATH//startup/}`
    echo MOUNT_PATH: ${MOUNT_PATH}

    # do binds
    for BIND_PATH in ${MOUNT_PATH} ; do
         echo Binding ${BIND_PATH}
         if [ "${MOUNT_PATH}" != "${BIND_PATH}" ]; then
                    grep -q -e "${BIND_PATH}" /proc/mounts || mount -o bind ${MOUNT_PATH}${BIND_PATH} ${BIND_PATH}
         fi
    done

    HTTPS_RESET=0

    if [ `pidof httpd` -gt 0 ]; then
        echo Stopping httpd
        stopservice httpd
        HTTPS_RESET=1
    fi

    echo Binding HTTPS certificate
    grep -q -e "/etc/cert.pem" /proc/mounts || mount -o bind ${MOUNT_PATH}/etc/cert.pem /etc/cert.pem
    grep -q -e "/etc/key.pem" /proc/mounts || mount -o bind ${MOUNT_PATH}/etc/key.pem /etc/key.pem

    if [ "$HTTPS_RESET" = "1" ]; then
        echo Starting httpd
        startservice httpd
        unset HTTPS_RESET
    fi
fi
EOF
# if [ $# -ne 1 ]; then
#   echo "Usage: $0 <server_name>"
#   exit 1
# fi

server_name="ddwrt"
server_subject="/C=US/ST=Texas/L=Denton/O=Brian LLC/OU=None/CN=${server_name}"
rootca_subject="/C=US/ST=Texas/L=Denton/O=Brian LLC/OU=None/CN=Brian LLC rootCA"

mkdir -p "$HOME/ssl"
mkdir -p "$HOME/tmp"

# stty -echo
# printf "Cert Password: "
# read -r password
# stty echo

if [ ! -f "$HOME/ssl/rootCA.pem" ]; then
  echo "generate rootCA key"
  exit 1
fi

cat << EOF > "$HOME/tmp/$servername.ext"
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${server_name}
DNS.2 = localhost
IP.1 = 192.168.10.2
EOF

echo Generate an rsa key
openssl genrsa -out "./$server_name.key" 4096

echo Generate a certificate signing request
openssl req -new -sha256 -key "./$server_name.key" -subj "$server_subject" -out ${server_name}.csr

echo Generate the certificate using the intermediate.key
openssl x509 -req -sha256 -days 365 -in ${server_name}.csr -CA "$HOME/ssl/rootCA.pem" -CAkey "$HOME/ssl/rootCA.key" -CAcreateserial -out "./${server_name}.crt" -extfile "$HOME/tmp/$servername.ext"

echo Verify the certificate
openssl verify -CAfile "$HOME/ssl/rootCA.pem" -verbose "./${server_name}.crt"
cat "${server_name}.crt" | openssl x509 -noout -enddate

# scp ddwrt.crt root@192.168.10.2:/tmp/root/cert.pem
# scp ddwrt.key root@192.168.10.2:/tmp/root/key.pem

ssh root@192.168.10.2 mkdir -p /jffs/etc
ssh root@192.168.10.2 mkdir -p /jffs/startup
scp ddwrt.crt root@192.168.10.2:/jffs/etc/cert.pem
scp ddwrt.key root@192.168.10.2:/jffs/etc/key.pem
scp "$HOME/tmp/ddwrt-cert-mount.sh" root@192.168.10.2:/jffs/startup/ddwrt-cert-mount.sh
ssh root@192.168.10.2 chmod 755 /jffs/startup/ddwrt-cert-mount.sh

rm -rf *.csr
rm ddwrt.crt ddwrt.key

exit 0

# vim: set ft=sh:
