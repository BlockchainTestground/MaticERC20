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

Currently deployed at `0x79962814dF4aC56f403D06129D05CEb5Efa6f201`.