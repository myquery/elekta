// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract ElektaProject {
  
    uint256 public projectedCreatedTime;

    address public projectAddress;

    string public projectName;

    string public projectDescriptions;

    uint256  public projectId;

    address payable createdBy;

    address[] public projectMembers;

    event ProjectFunded(FundInfo fundInfo, uint256 amount);

    enum FundInfo{Funded, Withdrawn, Suspended}

    //receive fund to this project
    receive() external payable{
        emit ProjectFunded(FundInfo.Funded, msg.value);
    }


    constructor (string memory _projectName, string memory _projectDescriptions) public {
        require(msg.sender != address(0));
        require(createdBy != msg.sender);
       
            //projected time
            projectedCreatedTime = block.timestamp;

            //unique address for project account
            projectAddress = address(this);

            //project name
            projectName = _projectName;

            //what is the project all for
            projectDescriptions = _projectDescriptions;

            //project counter
            projectId++;

            //created y caller
            createdBy = msg.sender;

           
    }

    function addProjectMembers(address member) public {
        projectMembers.push(member);
    }


   
}