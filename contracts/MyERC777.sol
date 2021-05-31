// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./dependencies/ERC777.sol";

contract MyERC777 is ERC777, IERC777Recipient {

  constructor ()
    ERC777("testground2", "TG2", new address[](0))
  {
    uint256 initialSupply = 1002 ether;
    _mint(msg.sender, initialSupply, "", "");
  }

  function burn(uint256 _amount) public {
    _burn(msg.sender, _amount, "", "");
  }

  function mint(uint256 _amount) public {
    _mint(msg.sender, _amount, "", "");
  }

  // Staking Attributes
  address[] public stakers;
  mapping(address => uint) public stakingBalance;
  mapping(address => bool) public hasStaked;
  mapping(address => bool) public isStaking;

  // Staking Functions
  function stakeTokens(uint _amount) public {
    // Require amount greater than 0
    require(_amount > 0, "amount cannot be 0");

    // Trasnfer Mock Dai tokens to this contract for staking
    //send(address(this), _amount, "");
    _send(msg.sender, address(this), _amount, "", "", false);

    // Update staking balance
    stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;

    // Add user to stakers array *only* if they haven't staked already
    if(!hasStaked[msg.sender]) {
      stakers.push(msg.sender);
    }

    // Update staking status
    isStaking[msg.sender] = true;
    hasStaked[msg.sender] = true;
  }



  // Unstaking Tokens (Withdraw)
  function unstakeTokens() public {
    // Fetch staking balance
    uint balance = stakingBalance[msg.sender];

    // Require amount greater than 0
    require(balance > 0, "staking balance cannot be 0");

    // Transfer Mock Dai tokens to this contract for staking
    this.send(msg.sender, balance,"");

    // Reset staking balance
    stakingBalance[msg.sender] = 0;

    // Update staking status
    isStaking[msg.sender] = false;
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
  }
}