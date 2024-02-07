// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract CrossContract {
    /**
     * The function below is to call the price function of PriceOracle1 and PriceOracle2 contracts below and return the lower of the two prices
     */

    function getLowerPrice(
        address _priceOracle1,
        address _priceOracle2
    ) external returns (uint256) {
        (bool ok1, bytes memory price1) = _priceOracle1.call(abi.encodeWithSignature("price()"));
        require(ok1, "call failed");
        uint256 price1Decoded = abi.decode(price1, (uint256));

        (bool ok2, bytes memory price2) = _priceOracle2.call(abi.encodeWithSignature("price()"));
        require(ok2, "call failed");
        uint256 price2Decoded = abi.decode(price2, (uint256));

        if (price1Decoded < price2Decoded) {
            return price1Decoded;
        } else {
            return price2Decoded;
        }
    }
}

contract PriceOracle1 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}

contract PriceOracle2 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}
