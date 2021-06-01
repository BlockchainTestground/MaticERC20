// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./dependencies/ERC777.sol";

contract MyERC777 is ERC777, IERC777Recipient {

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

  // Staking Attributes
  address[] public stakers;
  mapping(address => uint) public stakingBalance;
  mapping(address => bool) public hasStaked;
  mapping(address => bool) public isStaking;

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
    stakeTokensInternal(_amount, _from);
  }

  // Staking Functions
  function stakeTokens(uint _amount) public {
    stakeTokensInternal(_amount, msg.sender);
  }

  // Staking Functions
  function stakeTokensInternal(uint _amount, address staker) public {
    // Require amount greater than 0
    require(_amount > 0, "amount cannot be 0");

    // Trasnfer Mock Dai tokens to this contract for staking
    //send(address(this), _amount, "");
    //_send(msg.sender, address(this), _amount, "", "", true);

    // Update staking balance
    stakingBalance[staker] = stakingBalance[staker] + _amount;

    // Add user to stakers array *only* if they haven't staked already
    if(!hasStaked[staker]) {
      stakers.push(staker);
    }

    // Update staking status
    isStaking[staker] = true;
    hasStaked[staker] = true;
  }

  function _beforeTokenTransfer(
    address operator,
    address from,
    address to,
    uint256 amount) override internal virtual
  {
  }
}