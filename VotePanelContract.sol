// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "contracts/CandidateMaster.sol";


contract VotePanel
{

    enum candidateCode{AJIT,ASHISH,MAYANK,KUNAL,NOTA}

    mapping (uint => Candidate)  candidateList;

    Candidate candiate;
    Candidate public winner;
    address blockAdmin;
    uint totalCandidate;
   
    address[] votersList;


    constructor() {
        blockAdmin= msg.sender;

        //INIT
        candidateList[uint(candidateCode.AJIT)]=Candidate("Ajit Singh","Red Party",0);
        candidateList[uint(candidateCode.ASHISH)]=Candidate("Ashish Sinha","Green Party",0);
        candidateList[uint(candidateCode.MAYANK)]=Candidate("Mayank Jain","Blue Party",0);
        candidateList[uint(candidateCode.KUNAL)]=Candidate("Kunal Singhal","Yellow Party",0);
        candidateList[uint(candidateCode.NOTA)]=Candidate("NOTA","None",0);

        totalCandidate=uint(type(candidateCode).max) + 1;
        //totalCandidate=4;


    }

    modifier checkBlockAdmin()
    {
        require(blockAdmin == msg.sender,"Not Valid USER");
        _;
    }

    modifier checkVoterCasting()
    {
        address voteraddress;
        uint totalvoters=votersList.length;

        bool token=false;

        uint counter=0;
        while(counter < totalvoters)
        {
           voteraddress = votersList[counter];
            if(voteraddress==msg.sender)
            {
                token=true;
                break;
            }
            counter++;
        }

        require(token==false,"You have already casted Your Voter, Thank You!");
        _;


    }

    function viewBlockAdmin() view public checkBlockAdmin() returns (address)
    {
        return blockAdmin;
    }

    function Ajit_Singh__Red_Party() public checkVoterCasting()
    {

        //TEST

        votersList.push(msg.sender);

        candiate = candidateList[uint(candidateCode.AJIT)];
        // Vote + 1
        candiate.voteCount++;
        candidateList[uint(candidateCode.AJIT)]=candiate;



    }


    function Ashish_Sinha__Green_Party() public checkVoterCasting()
    {

         votersList.push(msg.sender);

        candiate = candidateList[uint(candidateCode.ASHISH)];
        // Vote + 1
        candiate.voteCount++;
        candidateList[uint(candidateCode.ASHISH)]=candiate;
    }
    
    function Mayank_Jain__Green_Party() public checkVoterCasting()
    {
         votersList.push(msg.sender);

        candiate = candidateList[uint(candidateCode.MAYANK)];
        // Vote + 1
        candiate.voteCount++;
        candidateList[uint(candidateCode.MAYANK)]=candiate;
    }

    function Kunal_Singhal__Yellow_Party() public checkVoterCasting()
    {
         votersList.push(msg.sender);

        candiate = candidateList[uint(candidateCode.KUNAL)];
        // Vote + 1
        candiate.voteCount++;
        candidateList[uint(candidateCode.KUNAL)]=candiate;

    }

    function NOTA() public checkVoterCasting()
    {
         votersList.push(msg.sender);

        candiate = candidateList[uint(candidateCode.NOTA)];
        // Vote + 1
        candiate.voteCount++;
        candidateList[uint(candidateCode.NOTA)]=candiate;

    }


    function voteCountAndResult()  public checkBlockAdmin()
    {
        uint maxCount=0;
        
        
        uint counter=0;
        while(counter < totalCandidate)
        {

            candiate = candidateList[counter];

            if(maxCount < candiate.voteCount)
                {
                    winner=candiate;
                    maxCount=candiate.voteCount;
                }


            counter++;
        }



    }
    
     function totalVotesCasted() view public checkBlockAdmin() returns (uint)
    {
        uint totalvoters=votersList.length;
        return totalvoters;
    }

}