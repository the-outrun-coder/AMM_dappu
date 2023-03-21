// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./Token.sol";

struct AmmDeploymentAgs {
  Token _token1Address;
  Token _token2Address;
}

// [] Manage Pool
// [] Manage Deposits
// [] Facilitate Swaps (i.e. trades)
// [] Manage Withdraws

contract AMM {
  Token public dappuTokenContract;
  Token public musdcTokenContract;

  uint256 public dappuTokenBalance;
  uint256 public musdcTokenBalance;
  uint256 public K;

  constructor(AmmDeploymentAgs memory args) {
    dappuTokenContract = args._token1Address;
    musdcTokenContract = args._token2Address;
  }

  function addLiquidity(uint256 _token1Amount, uint256 _token2Amount) public {
    
    // Deposit Tokes
    require(
      dappuTokenContract.transferFrom(msg.sender, address(this), _token1Amount),
      'Failed to transfer DAPP token'
    );
    require(
      musdcTokenContract.transferFrom(msg.sender, address(this), _token2Amount),
      'Failed to transfer MUSDC token'
    );
    
    // Issue Shares

    // Manage Pool
    dappuTokenBalance += _token1Amount;
    musdcTokenBalance += _token2Amount;
    K = dappuTokenBalance * musdcTokenBalance;
  }
}