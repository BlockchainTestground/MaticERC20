var erc_contract
var accounts
var web3

const updateUi = async () => {
  console.log("Polling state...")
  balance = await erc_contract.methods.balanceOf(accounts[0]).call()
  symbol = await erc_contract.methods.symbol().call()
  console.log("==========")
  console.log(balance)
  ui_msg.text = "You have " + balance/1000000000000000000 + " " + symbol
};

const roll = async () => {
  ui_msg.text = "Minting..."
  await erc_contract.methods
    .mint("1000" + "000000000000000000")
    .send({ from: accounts[0], gas: 400000 },
    function(err, res){
    })
  updateUi()
}

async function maticDiceGameApp() {
  var awaitWeb3 = async function() {
    web3 = await getWeb3();
    var awaitERCContract = async function() {
      erc_contract = await getMyERC777Contract(web3)
      var awaitAccounts = async function() {
        accounts = await web3.eth.getAccounts()
        updateUi()
      }
      awaitAccounts()
    }
    awaitERCContract()
  }
  awaitWeb3()
}
maticDiceGameApp()