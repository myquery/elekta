// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


import "./ElektaProject.sol";

contract ElektaMain{
   address public owner;


   uint projectCount = 0;

   address[] private projectAddress;

   event ProjectCreated(string _projectName);

   struct ProjectDetail {
       address _projectAddress;
       string _projectName;
       string _projectDesc;
   }

   mapping(address => ProjectDetail ) public elektaProjects;

   constructor() public {
       owner = msg.sender;
   }

   //create new project
   function createNewProject(string memory projectName, string memory projectDesc) public {

      ElektaProject newProject = new ElektaProject(projectName, projectDesc);

      elektaProjects[address(newProject)] = ProjectDetail(address(newProject), projectName, projectDesc);

      projectAddress.push(address(newProject));
  
      emit ProjectCreated(projectName);
     
      projectCount += 1;
      

   }

   //get list of projects
   function getProjectList() public view returns(string memory ){
       ProjectDetail memory _projectName;
      for(uint i = 0; i < projectAddress.length; i++){
         _projectName = elektaProjects[projectAddress[i]];
      }
      return _projectName._projectName;
      
   }

   //
}