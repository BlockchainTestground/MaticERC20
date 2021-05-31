var erc_contract
var accounts
var web3

const updateUi = async () => {
  console.log("Polling state...")
  balance = await erc_contract.methods.balanceOf(accounts[0]).call()
  symbol = await erc_contract.methods.symbol().call()
  console.log("==========")
  console.log(balance)
  ui_msg.text = "Balance: " + balance/1000000000000000000 + " " + symbol

  staking_balance = await erc_contract.methods.stakingBalance(accounts[0]).call()
  txt_staking_balance.text = "Stake: " + staking_balance/1000000000000000000 + " " + symbol
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
        //getRevertReason("0xd44a3b67078e98ce1b45e4d2383c61960d4fd099697043788b43441fdaa507f3")
      }
      awaitAccounts()
    }
    awaitERCContract()
  }
  awaitWeb3()
}
maticDiceGameApp()