*** Settings ***
Documentation                   Contains common keywords required for team object
Resource                        ../common_keywords.robot
Resource                        ../common_elements.robot
Resource                        user_story.robot

*** Keywords ***
Create New Team
    [Documentation]             Create new team and return team name
    #Open New Team window and wait for loading
    ClickText                   New
    VerifyText                  New Team
    #Ennter details
    ${TEAM_NAME}=               Generate random name
    Enter Input Field           Team Name                   ${TEAM_NAME}
    ClickCheckbox               Active                      on
    ClickText                   Department
    ClickText                   IT
    #Save and verify new team record created succesfully
    ClickText                   Save                        2
    VerifyTexts                 ${TEAM_NAME}, IT
    VerifyCheckboxValue         Active                      on
    [Return]                    ${TEAM_NAME}

Create User Story for Dependencies
    [Documentation]             Create User Story for dependencies (Team)
    Open Object                 User Stories
    ${US_ID}=                   Create User Story           User Story                  ${PROJECT}     ${DEV1_ORG}
    [Return]                    ${US_ID}

Create User Story Dependencies
    [Documentation]             Create User Story dependencies Dependent/Provider Team as per argument
    [Arguments]                 ${POSITION}                 ${PARENT_US}                ${CHILD_US}
    #Create new User Story Dependency
    ClickText                   Related
    Sleep                       2s                          #To handle the loading issue
    ${NEW_BUTTON_XPATH}=        Replace String              ${RELATED_TAB_NEW_BUTTON_WEBELEMENT}       POSITION       ${POSITION}
    ClickElement                ${NEW_BUTTON_XPATH}
    Select record from lookup field                         Search User Stories...      ${PARENT_US}
    Sleep                       3s                          #handle the loading issue of child US selection
    Select record from lookup field                         Search User Stories...      ${CHILD_US}
    ClickText                   Save                        2
    ClickText                   UD-
    #Verify
    VerifyTexts                 User Story Dependency, ${PARENT_US}, ${CHILD_US}
    #Delete
    Delete record from object details page