*** Settings ***
Documentation                   Contains common keywords required for sprint object
Resource                        ../common_keywords.robot
Resource                        ../../resources/objects/user_story.robot
Resource                        ../webelements/user_story_webelement.robot
Resource                        ../webelements/sprint_webelement.robot

*** Variables ***
${SPRINT_GOAL}                  Sprint created by Automation for Testing

*** Keywords ***
Base method for Sprint creation
    [Documentation]             Base method for creating Sprint and return the Sprint name
    [Arguments]                 ${POSITION}                 ${RELEASE_NAME}
    ClickText                   New                         ${POSITION}
    VerifyText                  New Sprint
    #Ennter details
    ${SPRINT_NAME}=             Generate random name
    Enter Input Field           Sprint Name                 ${SPRINT_NAME}
    Select record from lookup field                         Search Projects...          ${PROJECT}
    ClickElement                //label[contains(text(),'Status')]
    ClickText                   Planned                     anchor=--None--
    TypeText                    Sprint Goal                 ${SPRINT_GOAL}
    #Save and verify new sprint record created succesfully
    ClickText                   Save                        2
    [Return]                    ${SPRINT_NAME}

Sprint creation using Team
    [Documentation]             Base method for creating Sprint and return the Sprint name
    ...                         Author:Preethi
    ...                         Date:28th Jan 2021
    [Arguments]                 ${POSITION}                 ${RELEASE_NAME}          ${TEAM} 
    ClickText                   New                         ${POSITION}
    VerifyText                  New Sprint
    #Ennter details
    ${SPRINT_NAME}=             Generate random name
    Enter Input Field           Sprint Name                 ${SPRINT_NAME}
    Select record from lookup field                         Search Teams...          ${TEAM}
    ClickElement                //label[contains(text(),'Status')]
    ClickText                   Planned                     anchor=--None--
    TypeText                    Sprint Goal                 ${SPRINT_GOAL}
    #Save and verify new sprint record created succesfully
    ClickText                   Save                        2
    [Return]                    ${SPRINT_NAME}

Create Sprint using Team
    [Documentation]             Create and verify the sprint, return the sprint name
    ...                         Author:Preethi
    ...                         Date:28th Jan 2021
    [Arguments]                 ${RELEASE_NAME}            ${TEAM}    
    ${SPRINT_NAME}=             Sprint creation using Team                         1                           ${RELEASE_NAME}                    ${TEAM}
    VerifyText                  ${SPRINT_NAME}
    [Return]                    ${SPRINT_NAME}
    
Create Sprint
    [Documentation]             Create and verify the sprint, return the sprint name
    [Arguments]                 ${RELEASE_NAME}
    ${SPRINT_NAME}=             Base method for Sprint creation                         1                           ${RELEASE_NAME}
    VerifyText                  ${SPRINT_NAME}
    [Return]                    ${SPRINT_NAME}

Create Sprint From Different Object
    [Documentation]             Create and verify the sprint from different object and return the sprint name, e.g Teams
    [Arguments]                 ${POSITION}                 ${RELEASE_NAME}
    ${SPRINT_NAME}=             Base method for Sprint creation                         ${POSITION}                 ${RELEASE_NAME}
    VerifyText                  ${SPRINT_NAME}
    [Return]                    ${SPRINT_NAME}

Update Sprint Status
    [Documentation]             Update the status of Sprint and verify
    [Arguments]                 ${SPRINT_NAME}              ${STATUS_TO_UPDATE}
    Open Show more actions on Details page
    VerifyText                  Clone
    ClickText                   Edit                        anchor=Clone
    VerifyText                  Edit ${SPRINT_NAME}
    Select value from dropdown list                         Status                      ${STATUS_TO_UPDATE}         Team
    ClickText                   Save                        2
    VerifyText                  ${STATUS_TO_UPDATE}

Create User Story From Sprint Object
    [Documentation]             Create User Story from Sprint Object (prerequisite: Click on the New button before using this method)
    [Arguments]                 ${RECORD_TYPE}              ${PROJECT}                  ${CREDENTIAL}
    Base method for User Story creation                     ${RECORD_TYPE}              ${PROJECT}                  ${CREDENTIAL}
    ${ID}=                      GetText                     ${USID_WEBELEMENT}          #To get the ID from toast message window
    [Return]                    ${ID}

Verify Fields On Edit Stories Modal
    [Documentation]             Verify all field on Edit Stories Modal eg. Title,Status,Developer
    ...                         Author : Rashmitha Shetty
    ...                         Date : 17th NOV 2021
    VerifyText                  Edit Stories
    VerifyText                  No changes are saved if no values are provided.
    VerifyText                  Status                      anchor=None
    VerifyText                  Developer                   anchor=None
    VerifyAll                   Title,Business Analyst,Test Script Owner,Actual Points,Save,Cancel

Edit Stories From Sprint Wall
    [Documentation]             Edit User stories from Sprint Wall using Edit Stories button
    ...                         Author : Rashmitha Shetty
    ...                         Date : 17th NOV 2021
    [Arguments]                 ${TITLE}                    ${ACTUAL_POINTS}            ${PEOPLE}
    Enter Input Field           Title                       ${TITLE}
    Select value from dropdown list                         Status                      Draft                       Title
    Select People from lookup field                         Search People...            ${PEOPLE}
    VerifyText                  Business Analyst
    Select People from lookup field                         Search People...            ${PEOPLE}
    VerifyText                  Test Script Owner
    Select People from lookup field                         Search People...            ${PEOPLE}
    Enter Input Field           Actual Points               ${ACTUAL_POINTS}
    ClickText                   Save
    
Select People From Lookup Field
    [Documentation]             Search and select the Developer in the lookup field
    ...                         Author : Rashmitha Shetty
    ...                         Date : 17th NOV 2021
    [Arguments]                 ${FIELD}                    ${RECORD}
    PressKey                    ${FIELD}                    ${RECORD}
    VerifyText                  Show All Results
    PressKey                    ${FIELD}                    {ENTER}
    VerifyText                  ${CANCEL_BUTTON}                              #Checking modal openend
    ${RECORD_WEBELEMENT}=       Replace String              ${SELECT_RECORD_WEBELEMENT}                             RECORD           ${RECORD}
    ClickText                   ${RECORD_WEBELEMENT}
    
Create User Story From Sprint Wall    
    [Documentation]             Create User Story from Sprint Wall and return the ID/Reference
    ...                         Author : Rashmitha Shetty
    ...                         Date : 17th NOV 2021
    ...                         Modified :  2nd Dec 2021, Garima Pal
    [Arguments]                 ${RECORD_TYPE}              ${PROJECT}                  ${CREDENTIAL}
    ClickText                   ${NEW_BUTTON}
    Base method for User Story creation                     ${RECORD_TYPE}              ${PROJECT}            ${CREDENTIAL}
    VerifyText                  Plan
    ${US_ID}=                   GetText                     ${USID_WEBELEMENT}
    ${US_TITLE}=                Get user story title
    ${US_DETAILS}=              Create List                 ${US_ID}                        ${US_TITLE}
    [Return]                    ${US_DETAILS}

Edit US Status From Sprint Wall
    [Documentation]             Create User Story from Sprint Wall and return the ID/Reference
    ...                         Author : Shweta             15Feb'22
    [Arguments]                 ${US_LIST}                  ${STATUS_VALUE}                                  
    ${LENGTH}=                  Get Length                  ${US_LIST}
    FOR                         ${I}                        IN RANGE                    0                           ${LENGTH}
        ${US}=                  Get From List               ${US_LIST}                  ${I}
        TypeText                ${SEARCH_US_WEBELEMENT}                     ${US}
        PressKey                ${SEARCH_US_WEBELEMENT}                     {ENTER}                
        VerifyText              ${US}
        ${CHECK_US_ELEMENT}=    Replace String              ${SPRINTWALL_US_CHECKBOX_WEBELEMENT}                    USERSTORY          ${US}
        ClickCheckbox           ${CHECK_US_ELEMENT}         on
        VerifyNoText            Loading
        ClickText                   Edit Stories                anchor=New
        ClickElement                ${EDIT_STATUS_US_WEBELEMENT}
        ${STATUS}                   Replace String              ${STATUS_VALUES_WEBELEMENT}                             STATUS             ${STATUS_VALUE}
        ClickElement                ${STATUS}
        ClickText                   Save                        anchor=Cancel
    END

Set Status Filter In Sprint Wall
    [Documentation]             Create User Story from Sprint Wall and return the ID/Reference
    ...                         Author : Shweta             15Feb'22
    [Arguments]                 ${STATUS_VALUES}
    ClickElement                ${SPRINTWALL_FILTERICON_WEBELEMENT}
    ClickText                   Add Filter
    ClickText                   Field
    ClickElement                ${FILTER_FIELD_STATUS_WEBELEMENT}
    ClickElement                ${FILTER_STATUS_WEBELEMENT}
    ${LENGTH}=                  Get Length                  ${STATUS_VALUES}
    FOR                         ${I}                        IN RANGE                    0                           ${LENGTH}
        ${SVALUE}=              Get From List               ${STATUS_VALUES}            ${I}
        VerifyText              ${SVALUE}
        ${STATUS_ELEMENT}=      Replace String              ${FILTER_STATUS_VALUES_WEBELEMENT}                             STATUS          ${SVALUE}
        ClickElement           ${STATUS_ELEMENT}       
    END
    ClickElement               ${FILTER_STATUS_WEBELEMENT}               
    ClickText                   Done                        anchor=Close
    ScrollTo                    Save
    ClickText                   Save
    ClickElement                ${SPRINTWALL_FILTERICON_WEBELEMENT}