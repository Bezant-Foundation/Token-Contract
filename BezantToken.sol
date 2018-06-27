pragma solidity >=0.4.17;

import "./Migrations.sol";
import "./BezantERC20Base.sol";

contract BezantToken is Migrations, BezantERC20Base {

    bool public isUseContractFreeze;

    address public managementContractAddress;

    mapping (address => bool) public frozenAccount;

    event FrozenFunds(address target, bool frozen);

    function BezantToken(string tokenName) BezantERC20Base(tokenName) onlyOwner public {}

    function _transfer(address _from, address _to, uint256 _value) internal {
        require(_to != 0x0);
        require(balanceOf[_from] >= _value);
        require(balanceOf[_to].add(_value) > balanceOf[_to]);
        require(!frozenAccount[_from]);
        require(!frozenAccount[_to]);
        balanceOf[_from] = balanceOf[_from].sub(_value);
        balanceOf[_to] = balanceOf[_to].add(_value);
        emit Transfer(_from, _to, _value);
    }

    function freezeAccountForOwner(address target, bool freeze) onlyOwner public {
        frozenAccount[target] = freeze;
        emit FrozenFunds(target, freeze);
    }

    function setManagementContractAddress(bool _isUse, address _from) onlyOwner public {
        isUseContractFreeze = _isUse;
        managementContractAddress = _from;
    }

    function freezeAccountForContract(address target, bool freeze) public {
        require(isUseContractFreeze);
        require(managementContractAddress == msg.sender);
        frozenAccount[target] = freeze;
        emit FrozenFunds(target, freeze);
    }
}
