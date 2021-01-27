// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "./VotingToken.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract APF is VotingToken, Ownable {

    mapping(address => bool) public issuerMap;

    constructor() ERC20("Apifny Token", "APF") public {
    }
    
    modifier onlyIssuer() {
        require(issuerMap[msg.sender], "The caller does not have issuer role privileges");
        _;
    }
    function setIssuer(address _issuer, bool _isIssuer) external onlyOwner {
        issuerMap[_issuer] = _isIssuer;
    }


    function mint(address _to, uint256 _amount) external onlyIssuer {
        _mint(_to, _amount);
        _moveDelegates(address(0), _delegates[_to], _amount);
    }
    function burn(uint256 _amount) external {
        _burn(_msgSender(), _amount);
        _moveDelegates(_delegates[_msgSender()], address(0), _amount);
    }
}
