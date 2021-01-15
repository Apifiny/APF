// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract APF is ERC20, Ownable {

    mapping(address => bool) public issuerMap;

    constructor() ERC20("Apifny Token", "APF") public  {
    }
    
    modifier onlyIssuer() {
        require(issuerMap[msg.sender], "The caller does not have issuer role privileges");
        _;
    }
    function setIssuer(address _issuer, bool _isIssuer) external onlyOwner {
        issuerMap[_issuer] = _isIssuer;
    }

    function mint(address _to, uint256 _amount) public onlyIssuer {
        _mint(_to, _amount);
    }

    function burn(uint256 amount) public {
        _burn(_msgSender(), amount);
    }

    function burnFrom(address account, uint256 amount) public virtual {
        uint256 decreasedAllowance = allowance(account, _msgSender()).sub(amount, "ERC20: burn amount exceeds allowance");

        _approve(account, _msgSender(), decreasedAllowance);
        _burn(account, amount);
    }
}
