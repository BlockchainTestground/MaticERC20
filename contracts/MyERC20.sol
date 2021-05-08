// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "./dependencies/ERC20.sol";

contract MyERC20 is ERC20 {

  uint256 public numero = 10;

  constructor () public
    ERC20("testground1", "TG1")
  {
    _mint(msg.sender, 101 * 10 ** uint(decimals()));
  }

  function burn(uint256 amount) public {
      _burn(msg.sender, amount);
  }

  function mint(uint256 amount) public {
    _mint(msg.sender, amount);
  }
}