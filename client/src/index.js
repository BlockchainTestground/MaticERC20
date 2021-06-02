var erc_contract
var accounts
var web3

const updateUi = async () => {
  balance = await erc_contract.methods.balanceOf(accounts[0]).call()
  symbol = await erc_contract.methods.symbol().call()
  reward = await erc_contract.methods.getReward(accounts[0]).call()
  ui_msg.text = "Balance: " + convertWeiToCrypto(balance) + " " + symbol

  staking_balance = await erc_contract.methods.stakingBalance(accounts[0]).call()
  txt_staking_balance.text = "Stake: " + convertWeiToCrypto(staking_balance) + " " + symbol
  txt_reward.text = "Reward: " + convertWeiToCrypto(reward) + " " + symbol
};

const mint = async () => {
  ui_msg.text = "Minting..."
  await erc_contract.methods
    .mint("1000" + "000000000000000000")
    .send({ from: accounts[0], gas: 400000 },
    function(err, res){
    })
  updateUi()
}

const stake = async () => {
  ui_msg.text = "Staking..."
  await erc_contract.methods
    .stakeTokens("100" + "000000000000000000")
    .send({ from: accounts[0], gas: 400000 },
    function(err, res){
    })
  updateUi()
}

const unstake = async () => {
  ui_msg.text = "Unstaking..."
  await erc_contract.methods
    .unstakeTokens()
    .send({ from: accounts[0], gas: 400000 },
    function(err, res){
    })
  updateUi()
}

async function maticDiceGameApp() {
  var awaitWeb3 = async function() {
    web3 = await getWeb3();
    var awaitERCContract = async function() {
      erc_contract = await getContract(web3)
      var awaitAccounts = async function() {
        accounts = await web3.eth.getAccounts()
        updateUi()
        //getRevertReason("0x0a31a4fad7d59d2cf68e9620385557f2a62646cb9efbec24e37ccf5c13caaa78")
      }
      awaitAccounts()
    }
    awaitERCContract()
  }
  awaitWeb3()
}
maticDiceGameApp()