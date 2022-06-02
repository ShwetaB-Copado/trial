*** Settings ***
Documentation                   Contains common keywords required for releases object
Resource                        ../common_keywords.robot

*** Variables ***
${DESCRIPTION}                  Release created by Automation for Testing

*** Keywords ***
Create new Release
    [Documentation]             Create new release and return release name
    ClickText                   New
    VerifyText                  New Release
    #Ennter details
    ${RELEASE_NAME}=            Generate random name
    Enter Input Field           Release Name                ${RELEASE_NAME}
    ClickText                   Status
    ClickText                   Planned
    Select record from lookup field                         Search Projects...     ${PROJECT}
    ClickText                   Select a date               anchor=Planned Date
    ClickText                   Today
    TypeText                    Description                 ${DESCRIPTION}
    #Save and verify new release record created succesfully
    ClickText                   Save                        2
    VerifyText                  ${RELEASE_NAME}
    VerifyAll                   ${PROJECT},Planned, ${DESCRIPTION}
    [Return]                    ${RELEASE_NAME}