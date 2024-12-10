// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {VRFCoordinatorV2Interface} from "@chainlink/contracts/src/v0.8/vrf/interfaces/VRFCoordinatorV2Interface.sol";
import {VRFConsumerBaseV2} from "@chainlink/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol";
/**
 * @title A sample Raffle Contract
 * @author Clemence Ruhi
 * @notice This contract is for creating a sample raffle
 * @dev It implements Chainlink VRFv2.5 and Chainlink Automation
 */


contract Raffle {
    /*Errors*/
    error Raffle__SendMoreToEnterRaffle(); 

    /*state variables*/
    uint256 private immutable i_entranceFee;   
   
    //@devThedurationofthelotteryinseconds
    uint256 private immutable i_interval;
    //what data structure should we use? how to keep track of all players?
    uint256 private s_lastTimeStamp;
    address payable[] private s_players;

    /*Events*/
    event RaffleEntered(address indexed player);

    constructor(uint256 entranceFee, uint256 interval) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;

    }

    function enterRaffle() external payable {
        //require(msg.value >= i_entranceFee, "Not enough ETH sent");
        //require(msg.value >= i_entranceFee, SendMoreToEnterRaffle());
        //FOR MORE GAS EFFICIENT CUSTOM ERRORS
        if(msg.value < i_entranceFee) {
            revert Raffle__SendMoreToEnterRaffle();
        }
        s_players.push(payable(msg.sender));
        //1.makes migration easier
        //2.makes front end "indexing" easier
        emit RaffleEntered(msg.sender);
        
    }
     //1.get a random number
     //2.use random number to pick a player
     //3.be automatically called
    function pickWinner() external {
        //check if enough time has passsed
        if((block.timestamp - s_lastTimeStamp) > i_interval){
            revert();
        }
        //get our random numbers using Chainlink VRF
        //1.request RNG
        //2.get RNG


        

    }

    /** Getter Function */

    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }

}