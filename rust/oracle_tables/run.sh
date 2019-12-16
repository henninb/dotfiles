#!/bin/sh

#export RUST_LOG="warn,test::foo=info,test::foo::bar=debug" ./test
export RUST_LOG="oracle_tables"
cargo run

exit 0
