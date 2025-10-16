#!/bin/bash


export GOPATH=/opt/repositories/go
export RUSTUP_HOME=/opt/languages/rust
export CARGO_HOME=/opt/languages/rust


function error_handling() {
    ret=$?
    if [ $ret -ne 0 ]; then
        echo "[!] An error occurred when $1"
        exit 127
    else
        echo -e "[*] $2    OK"
    fi
}
