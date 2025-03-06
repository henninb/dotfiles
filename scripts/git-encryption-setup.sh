#!/bin/sh

# Sets up transparent encryption of files in /config/private as per
# https://gist.github.com/873637. You will need to edit the password
# in ~/.gitencrypt/password to match everyone else's if you want to
# share this repo.

# Note: due to me being in a hurry, only files in /config/private/ and
# its subdirectories DOWN TO FOUR LEVELS are encrypted.

global_setup() {

    mkdir -p ~/.gitencrypt
    current_dir=$(pwd)
    cd ~/.gitencrypt || exit

    touch clean_filter_openssl smudge_filter_openssl diff_filter_openssl
    chmod 755 "*"

    GENERATED_SALT=$(uuidgen | sed s/-//g | cut -c -16)
    GENERATED_PASS=$(uuidgen | sed s/-//g)

    echo "GITENCRYPT_PASSWORD=$GENERATED_PASS" > password
    echo "GITENCRYPT_SALT=$GENERATED_SALT" >> password

    echo "Set random password. Change it if that's not what you want! It's in ~/.gitencrypt/password"

    echo "Generating ~/.gitencrypt/clean_filter_openssl"

    cat > clean_filter_openssl <<EOF
#!/bin/bash
source ~/.gitencrypt/password
openssl enc -base64 -aes-256-ecb -S \$GITENCRYPT_SALT -k \$GITENCRYPT_PASSWORD
EOF

    echo "Generating ~/.gitencrypt/smudge_filter_openssl"

cat > smudge_filter_openssl <<EOF
#!/bin/bash
# No salt is needed for decryption.
source ~/.gitencrypt/password
# If decryption fails, use cat instead.
# Error messages are redirected to /dev/null.
openssl enc -d -base64 -aes-256-ecb -k \$GITENCRYPT_PASSWORD 2> /dev/null || cat
EOF

    echo "Generating ~/.gitencrypt/diff_filter_openssl"

    cat > diff_filter_openssl <<EOF
#!/bin/bash
# No salt is needed for decryption.
source ~/.gitencrypt/password
# Error messages are redirect to /dev/null.
openssl enc -d -base64 -aes-256-ecb -k \$GITENCRYPT_PASSWORD -in "\$1" 2> /dev/null || cat "\$1"
EOF

    cd "$current_dir" || exit
}

repo_setup() {
    touch .gitattributes

    cat >> .gitattributes <<'EOF'
/config/private/* filter=openssl diff=openssl
/config/private/*/* filter=openssl diff=openssl
/config/private/*/*/* filter=openssl diff=openssl
/config/private/*/*/*/* filter=openssl diff=openssl
/config/private/*/*/*/*/* filter=openssl diff=openssl
[merge]
    renormalize=true
EOF

cat >> .git/config <<'EOF'
[filter "openssl"]
    smudge = ~/.gitencrypt/smudge_filter_openssl
    clean = ~/.gitencrypt/clean_filter_openssl
[diff "openssl"]
    textconv = ~/.gitencrypt/diff_filter_openssl
EOF

    echo .gitattributes >> .gitignore
}

if [ -e ~/.gitencrypt ]; then
    echo "$HOME/.gitencrypt already exists. Refusing to clobber existing global setup."
else
    global_setup
fi

# TODO: Make this idempotent
echo "Setting up this repository for transparent encryption."
repo_setup

# vim: set ft=sh:
