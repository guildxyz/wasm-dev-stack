## Rust-Wasm development

This repo provides a development stack that facilitates webapp development
around Solana smart contracts written in Rust.

### Usage

You will need to organize your Rust code into a workspace with two separate
crates within: one `client` and one `contract`.

```
my-solana-contract
    |
    |___ client
    |       |
    |       |___ src
    |       |
    |       |___ Cargo.toml
    |
    |___ contract
    |       |
    |       |___ src
    |       |
    |       |___ Cargo.toml
    |
    |___ Cargo.toml
```

In `client/Cargo.toml` and `contract/Cargo.toml` you can set any name for your
packages but it's important that these packages are found in the `client` and
`contract` directories. Your `client` package should contain everything that
you'd like to compile to Wasm. The `contract` package should contain everything
related to your smart contract (entrypoint, processor, state, etc.). Furthermore,
every Rust data structure you'd like to serialize/deserialize in TypeScript
should have `BorshSchema` as a derived trait, see
[`agsol-borsh-schema`](https://crates.io/crates/agsol-borsh-schema).

Then, if you intend to keep your Rust repo separate from this repo, you can
simply run

```sh
./init.sh <link-to-your-rust-repo>
```

in the root of this repo. This will set up your Rust repo as a `git` submodule.
It also installs some tools via `cargo install`, so make sure you have `rustup`
installed (e.g. run `curl https://sh.rustup.rs -sSf | sh`). This script will
initialize an `src/contract-logic` TypeScript package which contains the
generated wasm bindings and the [BorshJS](https://github.com/near/borsh-js)
serialization schemas you need.

`contract-logic` can be executed standalone by running

```sh
ts-node index.ts
```

within the directory, however, make sure you have built your Wasm in
`wasm-factory` using the `--target nodejs` flag. Otherwise, the
[`wasm-pack-plugin`](https://github.com/wasm-tool/wasm-pack-plugin), which is
set up in `next.config.js`, will automatically build the Wasm bindings to a
`web` target whenever

```sh
npm run dev
```

is run to start our webapp.

## Contributions

For steps on local deployment, development, and code contribution, please see
[CONTRIBUTING](./CONTRIBUTING.md).

## Dependencies overview

- Next.js
- Chakra UI
- State management:
  - SWR for server and blockchain state (fetching and caching)
  - XState for complex flows
- Web3 stuff:
  - ethers.js
  - web3-react for connection management
