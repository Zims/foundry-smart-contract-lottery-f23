// This is a style guide for writing smart contracts:
    // Layout of Contract:
    // version
    // imports
    // errors
    // interfaces, libraries, contracts
    // Type declarations
    // State variables
    // Events
    // Modifiers
    // Functions

    // Layout of Functions:
    // constructor
    // receive function (if exists)
    // fallback function (if exists)
    // external
    // public
    // internal
    // private
    // view & pure functions
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

/**
 * @title A sample raffle contract
 * @author Zims
 * @notice This contract is for creating a sample raffle
 * @dev This contract uses Chainlink VRFv2 for random number generation
 */

contract Raffle {
    error Raffle__NotEnoughEthSent();

    uint256 private immutable i_entranceFee;

    // to store all the participants we need to store their addresses in an array
    // mapping won't work because we need to iterate over the participants. https://youtu.be/sas02qSFZ74?t=12193
    address payable[] private s_players;

    /* Events */
    event enteredRaffle(address indexed player);

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }

    function enterRaffle() external payable {
        // Using require() is not gas efficient
        // require(msg.value >= i_entranceFee, "Not enough ETH sent");

        // better use if() but define the error as a custom error at the top of the contract
        // use this naming scheme: <contractName>__<errorName>()
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnoughEthSent();
        }

        // add the player to the players array. We need to convert the address to a payable address
        s_players.push(payable(msg.sender));

        // emit the event
        emit enteredRaffle(msg.sender);
    }

    function pickWinner() public {}

    // Getters

    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}