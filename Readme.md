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

Currently deployed at `0x5EB8616aA0B124B31fC160F71C4C0476Df382b74`.