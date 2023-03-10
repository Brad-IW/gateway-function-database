# Users API

## Prerequisites

Make sure to set the DBPasswordSecret in the secrets section.

## Installation Guide with DevOps

  To use the CI/CD provided as a part of this repo you will need to create your own repo from which Azure DevOps can pull from.

1. Fork this repo or clone it into your own personal repo.
2. Open Azure DevOps and click create a new project. 
3. Give the project a name and press create.

  To use this repo we need to have a connection to Azure Resource Manager which we will now create.
  
4. Click project settings on the bottom of the left panel.
5. Find and press the service connections button.
6. Click create service connection.
7. Choose Azure Resource Manager and press next.
8. Keep the default option (service principal (automatic)) and click next.
9. Sign into the Azure account you want to upload the API to.
10. Give the service a name, keep this name in mind as we will be using it later.
  Make sure to leave the resource group option blank.
  Also ensure that the Grant access permission to all pipelines option has been set.
11. Click save.

  Now that the ARM has been set up we can move on to setting up a worker agent. This is an optional step depending on how your Azure DevOps is set up. If you already have an agent you can safely ignore this step, otherwise follow along to install an agent onto one of your devices.

12. Open project settings and go to agent pools.
13. Click on the Default pool.
14. Press the new agent button in the top right.
15. Download the agent for your respective platform and extract the files to a folder.
    
  From here you can follow the [configuration](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/v2-windows?view=azure-devops) guide created by the Azure DevOps team to configure and run the agent. Once this is done the agent should show up within the default agent pool. Once these steps have been completed or skipped we can add and run the build pipeline.

16. From the pipelines menu on the left panel click the pipelines button.
17. Press the Create Pipeline button.
18. Choose the GitHub option.
19. Find and select the repo you created which holds the forked or cloned project.

    GitHub may request approval to install Azure Pipelines to GitHub, if they do make sure you press the aprove and install button.

20. After selecting the repo Azure DevOps should take you to the review page. 
21. Before setting the other parameters we need to set a database password. To do this click the variables button at the top right of the review page. 
22. Click the (+) button to create a new variable.
23. Set the name to `DBPasswordSecret` and the value to something with more than 12 characters, lowercase letters, uppercase letters, and numbers.
24. Select the keep this value secret option
25. Click OK.
26. Now you can configure the parameters for the pipeline by replacing the values in the default property of each parameter.
  - azureServiceConnection: This should be set to the name you gave to the Azure service you set in step 10.
  - resourceGroupName: This is the name of the resource group that the pipeline will create. This can be left as the default value but make sure you don't already have a resource group with the same name as it will be deleted.
  - location: This is the physical location that the Azure resources will be created in. 
  
    Below these parameters are more options for changing settings for the database, function, and gateway.

27. Click save and run, then save and run again to commit these changes to your repo and to start the pipeline.

  The pipeline may give a resource authorization error. If this happens click the Authorize Resources button and click Run New. 
