#!/bin/bash

cargo install agsol-glue wasm-pack

git submodule add $1 rust
git submodule init
git submodule update

agsol-glue --wasm ./rust/client --schema ./rust/contract -o src/contract-logic
