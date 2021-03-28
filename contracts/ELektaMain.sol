// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;


import "./ElektaProject.sol";

contract ElektaMain{
   address public owner;


   uint projectCount = 0;

   address[] private projectAddress;

   event ProjectCreated(string _projectName);

   event FundProject(address _projectAddress, FundAlert alert, uint256 amount);

   enum FundAlert{Funded, WithDrawned, Suspecded}

   struct ProjectDetail {
       address _projectAddress;
       string _projectName;
       string _projectDesc;
   }

   mapping(address => ProjectDetail ) public elektaProjects;

   mapping(address => mapping(address => uint256)) public fundProject;

   constructor() public {
       owner = msg.sender;
   }

   //create new project
   function createNewProject(string calldata projectName, string calldata projectDesc) public {

      ElektaProject newProject = new ElektaProject(projectName, projectDesc);

      elektaProjects[address(newProject)] = ProjectDetail(address(newProject), projectName, projectDesc);

      projectAddress.push(address(newProject));
  
      emit ProjectCreated(projectName);
     
      projectCount += 1;
      

   }

   // //get list of projects
   // function getProjectList() public view returns(ProjectDetail memory details ){
   //     ProjectDetail memory _projectName;
   //    for(uint i = 0; i < projectAddress.length; i++){
   //       _projectName = elektaProjects[projectAddress[i]];
   //    }
   //    return ProjectDetail(_projectName._projectAddress, _projectName._projectName, _projectName._projectDesc);
   // }

   //contribute to a group
   function fundAProject(address payable  _projectAddr, uint256 amount) public {
      require(address(msg.sender).balance <= amount, "No enough fund in the wallet");
      uint256 funder = address(msg.sender).balance;
      uint256 receiver = address(_projectAddr).balance;
      funder -= amount;
      receiver += amount;
      msg.sender.transfer(amount);
      emit FundProject(_projectAddr, FundAlert.Funded, amount);

   }
}