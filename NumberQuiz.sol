pragma solidity >=0.4.22 <0.7.0;

/**
 * @title Storage
 * @dev Store & retreive value in a variable
 */
contract NumberQuiz {
    
    mapping(uint32 => address payable) public votes;

    
    bytes32 public hashedAnswer;
    uint32 public finalizedAnswer;
    
    
    constructor(bytes32 _hashedAnswer) public {
        hashedAnswer = _hashedAnswer;
    }
    
    function vote(uint32 _answer) public returns (bool) {
        if ( votes[_answer] != address(0x0) ) return false;
        votes[_answer] = msg.sender;
        
        return true;
    }
    
    
    function finish(uint32 _answer, bytes32 _secret) public returns (bool) {
        
        if ( hashedAnswer != keccak256(abi.encodePacked(_answer, _secret)) ) return false;
        
        finalizedAnswer = _answer;
        address payable winner = votes[_answer];
        winner.transfer(address(this).balance);
        
        return true;
    }
    
    
    
}
