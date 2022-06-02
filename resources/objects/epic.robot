*** Settings ***
Documentation                   Contains common keywords required for Epic object
Resource                        ../common_keywords.robot

*** Keywords ***
Create New Epic
    [Documentation]             Create new epic and return Epic ID
    [Arguments]                 ${RELEASE}
    #Open New Epic window and enter the details
    ClickText                   New         
    VerifyText                  New Epic
    ${EPIC_TITLE}=              Generate random name
    ${EPIC_DETAILS}=            Generate random name
    TypeText                    Epic Title                  ${EPIC_TITLE}      anchor=Application
    TypeText                    Epic Details                ${EPIC_DETAILS}    anchor=Release
    Select record from lookup field                         Search Releases...                       ${RELEASE}
    #Save and verify new epic record created succesfully
    ClickText                   Save                        2
    ${EPIC_ID}=                 Get ID from toast message window
    VerifyText                  ${EPIC_TITLE}
    VerifyAll                   Draft, ${RELEASE}
    [Return]                    ${EPIC_ID}

Create New Epic without Release
    [Documentation]             Create new epic and return Epic ID
    ...                         Author: Preethi
    ...                         Modified Date: 06th Jan 2022
    #Open New Epic window and enter the details
    ClickText                   New         
    VerifyText                  New Epic
    ${EPIC_TITLE}=              Generate random name
    ${EPIC_DETAILS}=            Generate random name
    TypeText                    Epic Title                  ${EPIC_TITLE}      anchor=Application
    #Save and verify new epic record created succesfully
    ClickText                   Save                        2
    ${EPIC_ID}=                 Get ID from toast message window
    VerifyText                  ${EPIC_TITLE}
    [Return]                    ${EPIC_ID}
