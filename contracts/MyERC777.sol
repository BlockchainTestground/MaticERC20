// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./dependencies/ERC777.sol";

contract MyERC777 is ERC777, IERC777Recipient {

  uint256 burnable_tx_fee = 1 ether;
  uint256 unstake_fee = 5 ether;
  
  constructor ()
    ERC777("testground2", "TG2", new address[](0))
  {
    uint256 initialSupply = 1005 ether;
    _mint(msg.sender, initialSupply, "", "");

    IERC1820Registry(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24).
      setInterfaceImplementer(address(this),
        keccak256("ERC777TokensRecipient"),
        address(this)
      );
  }

  function burn(uint256 _amount) public {
    _burn(msg.sender, _amount, "", "");
  }

  function mint(uint256 _amount) public {
    _mint(msg.sender, _amount, "", "");
  }

  address[] public stakers;
  mapping(address => uint) public stakingBlock;
  mapping(address => uint) public stakingBalance;
  mapping(address => bool) public hasStaked;
  mapping(address => bool) public isStaking;

  function unstakeTokens() public {
    uint balance = stakingBalance[msg.sender];
    require(balance > 0, "staking balance cannot be 0");
    uint reward = getReward(msg.sender);
    _mint(msg.sender, balance + reward - unstake_fee, "", "");
    //this.send(msg.sender, balance + reward - unstake_fee,"");
    stakingBalance[msg.sender] = 0;
    isStaking[msg.sender] = false;
  }

  function getReward(address _address) public view returns(uint) {
    uint balance = stakingBalance[_address];
    uint blocks_staked = block.timestamp - stakingBlock[_address];
    return balance*blocks_staked/100;
  }

  function _beforeTokenTransfer(
    address operator,
    address from,
    address to,
    uint256 amount) override internal virtual
  {
    if(from != address(0) && to != address(0))
      _burn(from, burnable_tx_fee,"","");
  }

  function stakeTokens(uint _amount) public {
    send(address(this), _amount,"");
  }

  function tokensReceived(
      address _operator,
      address _from,
      address _to,
      uint256 _amount,
      bytes calldata _userData,
      bytes calldata _operatorData
    ) override public
  {
    require(_amount > 0, "amount cannot be 0");
    stakingBalance[_from] = stakingBalance[_from] + _amount;
    if(!hasStaked[_from]) {
      stakers.push(_from);
    }
    isStaking[_from] = true;
    hasStaked[_from] = true;
    stakingBlock[_from] = block.timestamp;
  }
}