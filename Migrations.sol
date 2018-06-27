pragma solidity >=0.4.17;

contract Migrations {
    address public owner;

    event TransferOwnership(address oldaddr, address newaddr);

    modifier onlyOwner() { require(msg.sender == owner); _; }

    function Migrations() public {
        owner = msg.sender;
    }

    function transferOwnership(address _new) onlyOwner public {
        address oldaddr = owner;
        owner = _new;
        emit TransferOwnership(oldaddr, owner);
    }
}