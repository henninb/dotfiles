#!/bin/sh

doas emerge --update --newuse dev-libs/protobuf net-libs/grpc dev-libs/openssl

cd "$HOME/projects" || exit
git clone https://github.com/envoyproxy/envoy.git
cd envoy
git submodule update --init --recursive
bazel build //source/exe:envoy-static

exit 0

# vim: set ft=sh:
