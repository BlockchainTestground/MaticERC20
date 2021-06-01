# Dependencies

```bash
npm install
```

# Compile

```bash
truffle compile
```

# Deploy

Create a new migration on the `./migrations/` directory following the same sequence. Create a `.secret` file and paste your mnemonic. An then:

```bash
truffle migrate --network mumbai --reset
truffle migrate --network matic --reset
```

# Current version

Currently deployed at `0x6e63f7a5fB2AAF3de5754ab575ABb0778813be7f`.