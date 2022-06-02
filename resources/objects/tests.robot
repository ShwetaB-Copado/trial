*** Settings ***
Documentation                   Contains common keywords related to "Tests" Object
Resource                        ../common_keywords.robot
Resource                        ../webelements/tests_webelement.robot

*** Variables ***
${INFO_MESSAGE_READY_TO_RUN}    This test cannot be run yet.

*** Keywords ***
Base method for Tests creation
    [Arguments]                 ${TOOL_CONFIGURATION}
    [Documentation]             Base method to create "Tests" record as per parameter-Tool Configuration (Extension Configuration), we can use it in multiple places. E.g User Stories, Application, Feature, Tests
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 01st March, 2022
    VerifyText                  New Test
    ${TESTS_NAME}=              Generate random name
    TypeText                    Name                        ${TESTS_NAME}            anchor=Test Information
    Select record from lookup field                         Search Extension Configurations...                   ${TOOL_CONFIGURATION}
    ClickText                   Save                        2
    [Return]                    ${TESTS_NAME}

Create Tests
    [Arguments]                 ${TOOL_CONFIGURATION}
    [Documentation]             Create "Tests" record through "Tests" object as per parameter-Tool Configuration (Extension Configuration)
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 01st March, 2022
    ClickText                   New
    ${TESTS_NAME}=              Base method for Tests creation                       ${TOOL_CONFIGURATION}
    VerifyText                  Test Definition
    VerifyText                  ${TESTS_NAME}               anchor=Name
    VerifyText                  ${TOOL_CONFIGURATION}
    [Return]                    ${TESTS_NAME}

Enable or Disable Test Ready to Run checkbox
    [Arguments]                 ${STATUS}
    [Documentation]             Method to enable/disable "Ready to Run" checkbox of Test record as per argument- On/Off
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 28th April, 2022
    ClickText                   Edit Ready to Run
    Sleep                       2s
    ClickCheckbox               Ready to Run                ${STATUS}
    ClickText                   Save                        anchor=Cancel
    Run Keyword If              '${STATUS}' == 'On'         VerifyNoText             ${INFO_MESSAGE_READY_TO_RUN}
    ...                         ELSE                        VerifyText               ${INFO_MESSAGE_READY_TO_RUN}
    Run Keyword If              '${STATUS}' == 'On'         VerifyElement            ${RUN_BUTTON_WEBELEMENT}
    ...                         ELSE                        VerifyNoElement          ${RUN_BUTTON_WEBELEMENT}

Create Tests from Extension Configuration
    [Documentation]             Create "Tests" record from the Related tab of Extension Configuration
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 27th April, 2022
    ClickText                   Related                     anchor=Settings
    ClickText                   New
    VerifyText                  New Test
    ${TESTS_NAME}=              Generate random name
    TypeText                    Name                        ${TESTS_NAME}            anchor=Test Information
    ClickText                   Save                        2
    [Return]                    ${TESTS_NAME}