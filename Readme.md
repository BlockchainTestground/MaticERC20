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
truffle migrate --network mumbai
truffle migrate --network matic
```

# Current version

Currently deployed at `0xd6d897b8FBF9b82c493dc256A2924bE41efda34f`. ABI is located at `current_version/MyERC20.json`.