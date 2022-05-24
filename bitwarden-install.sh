#!/bin/sh

# wget 'https://github-releases.githubusercontent.com/85226880/f16a9800-b298-11eb-96bb-dc50e1f7f20f?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20210604%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20210604T112116Z&X-Amz-Expires=300&X-Amz-Signature=796e4f14906ced867a579defbb829416ca0a16442a3d7a6db033f9dc7584577d&X-Amz-SignedHeaders=host&actor_id=6399053&key_id=0&repo_id=85226880&response-content-disposition=attachment%3B%20filename%3Dbw-linux-1.16.0.zip&response-content-type=application%2Foctet-stream'
npm install -g @bitwarden/cli
echo bw list --help
echo bw login

exit 0

# vim: set ft=sh:
