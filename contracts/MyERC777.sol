// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "./dependencies/ERC777.sol";

contract MyERC777 is ERC777 {

  constructor () public
    ERC777("testground2", "TG2", new address[](0))
  {
    uint256 initialSupply = 1001 ether;
    _mint(msg.sender, initialSupply, "", "");
  }

  function burn(uint256 amount) public {
    _burn(msg.sender, amount, "", "");
  }

  function mint(uint256 amount) public {
    _mint(msg.sender, amount, "", "");
  }
}