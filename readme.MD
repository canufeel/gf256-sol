# GF256-Solidity

Tool for gf256 (Galois field) computation.

## Install

```
npm install --save gf256-sol
```

## Usage

```solidity
pragma solidity ^0.5.7;

import "gf256-sol/contracts/GF256.sol";


contract WithMul {
    using GF256 for uint8;
    
    function mul(uint8 a, uint8 b) public view returns (uint8) {
        return a.gf256Mul(b);
    }
}
```

## Exposed methods

Exposed methods are `gf256Mul`, `gf256Div`, `gf256Sub`, `gf256Add`