*** Settings ***
Documentation                   Methods for creating Quality Gates
Resource                        ../../resources/objects/metadata_group.robot
Resource                        ../../resources/webelements/automation_webelement.robot
Resource                        ../../resources/objects/developer_org.robot
Resource                        ../../resources/objects/user_story.robot

*** Variables ***
${METADATA_NAME}                All
${METADATA_TYPE}                ApexClass
${VALUE}

*** Keywords ***
Select Value From Picklist Using Xpath
    [Documentation]
    [Arguments]                 ${PICKLIST_NAME}            ${PICKLIST_VALUE}
    ${PICKLIST_FIELD_WEBELEMENT}=                           Replace String              ${PICKLIST_FIELD_WEBELEMENT}                            PICKLISTNAME            ${PICKLIST_NAME}
    ClickElement                ${PICKLIST_FIELD_WEBELEMENT}
    ${PICKLIST_VALUE_WEBELEMENT}=                           Replace String              ${PICKLIST_VALUE_WEBELEMENT}                            PICKLISTVALUE           ${PICKLIST_VALUE}
    ClickElement                ${PICKLIST_VALUE_WEBELEMENT}

Create Automation Record For Apex Test
    [Documentation]             Creating Automation Records for Quality Gates of Type Apex Test
    [Arguments]                 ${AUTOMATION_TYPE}          ${TEST_LEVEL}               ${METADATA_GRP_NAME}        ${EXECUTION_SEQUENCE}
    ClickText                   Automations
    ClickText                   New
    ${AUTOMATION_NAME}=         Generate random name
    TypeText                    ${AUTOMATION_NAME_WEBELEMENT}                           ${AUTOMATION_NAME}
    Select Value From Picklist Using Xpath                  Type                        ${AUTOMATION_TYPE}
    Select Value From Picklist Using Xpath                  Apex Test Level             ${TEST_LEVEL}
    ${METADATA_GROUP_ELEMENT}=                              Replace String              ${LOOKUPFIELD_WEBELEMENT}                               LOOKUPFIELD             Metadata Group
    Select record from lookup field                         ${METADATA_GROUP_ELEMENT}                               ${METADATA_GRP_NAME}
    Select Value From Picklist Using Xpath                  Execution Sequence          ${EXECUTION_SEQUENCE}
    ClickText                   Save                        anchor=2
    VerifyAll                   ${AUTOMATION_NAME}, ${AUTOMATION_TYPE}, ${EXECUTION_SEQUENCE}

Add Connection Behavior To Environment
    [Documentation]             Add Incoming Connection Behavior to Environment
    [Arguments]                 ${ENVIRONMENT_NAME}         ${INCOMING_CONNECTION_BEHAVIOR_NAME}
    Open record from object main page                       ${ENVIRONMENT_NAME}
    VerifyText                  Salesforce                  anchor=Platform
    ClickText                   Edit Incoming Connection Behavior
    ${CONNECTION_BEHAVIOR_STATUS}=                          Run Keyword And Return Status                           VerifyElement               ${INCOMING_CONNECTION_BEHAVIOR_IN_ENV_WEBELEMENT}
    Run Keyword If              ${CONNECTION_BEHAVIOR_STATUS}                           ClickElement                ${INCOMING_CONNECTION_BEHAVIOR_IN_ENV_WEBELEMENT}
    Select record from lookup field                         Search Connection Behaviors...                          ${INCOMING_CONNECTION_BEHAVIOR_NAME}
    ClickText                   Save                        anchor=Cancel
    VerifyText                  ${INCOMING_CONNECTION_BEHAVIOR_NAME}

Create And Commit Apex Class And Test And Trigger
    [Documentation]             Create and Commit Apex Class, Apex Test and Apex Trigger. Pre-condition: User should be on Developer or any Org
    [Arguments]                 ${APEX_CLASS_ONE}           ${APEX_CLASS_TWO}           ${APEX_TRIGGER_ONE}
    Create Apex Class           ${APEX_CLASS_ONE}
    Create Apex Class           ${APEX_CLASS_TWO}
    Open Object on Developer ORG                            Account
    Open Trigger object in Developer Org
    Create Apex Trigger         ${APEX_TRIGGER_ONE}
    SwitchWindow                1                           #Switch to User Story Page from developer ORG
    Switch To Lightning         #Switch to lightning if classic view opened
    Open Commit page            TRUE
    Select Second metadata      AccountOperations
    Select metadata             AccountDefaultDescription
    Select metadata             AccountOperationsTest
    Commit metadata

Check Deployment Steps
    [Documentation]             Checks the Step Name and Type of the Deployment
    [Arguments]                 ${STEP_NAME}                ${TYPE}
    ScrollTo                    Steps
    VerifyText                  ${STEP_NAME}
    VerifyText                  ${TYPE}                     anchor=${STEP_NAME}

Create Automation Record
    [Documentation]             Create Automation Record for Type other than Apex Test
    [Arguments]                 ${AUTOMATION_TYPE}          ${DEPENDANT_FIELD_ELEMENT}                              ${DEPENDANT_RECORD_SEARCH}                          ${METADATA_GROUP_ELEMENT}    ${METADATA_GRP_NAME}    ${EXECUTION_SEQUENCE}
    ${AUTOMATION_NAME}=         Generate random name
    TypeText                    ${AUTOMATION_NAME_WEBELEMENT}                           ${AUTOMATION_NAME}
    Select record from lookup field                         ${METADATA_GROUP_ELEMENT}                               ${METADATA_GRP_NAME}
    Select Value From Picklist Using Xpath                  Type                        ${AUTOMATION_TYPE}
    Select record from lookup field                         ${DEPENDANT_FIELD_ELEMENT}                              ${DEPENDANT_RECORD_SEARCH}
    Select Value From Picklist Using Xpath                  Execution Sequence          ${EXECUTION_SEQUENCE}
    ${CHECK_AUTOMATION_TYPE_VALUE}=                         Run Keyword If              '${AUTOMATION_TYPE}' == 'Static Code Analysis'          TypeText                Static Analysis Score Threshold    1000
    ClickText                   Save                        anchor=2

Create Automation Record For Validation Type
    [Documentation]             Create Automation Record when Type is Validation
    ...                         Author: Naveen Ramesh
    [Arguments]                 ${AUTOMATION_TYPE}          ${METADATA_GROUP_ELEMENT}                               ${METADATA_GRP_NAME}        ${EXECUTION_SEQUENCE}
    ${AUTOMATION_NAME}=         Generate random name
    TypeText                    ${AUTOMATION_NAME_WEBELEMENT}                           ${AUTOMATION_NAME}
    Select record from lookup field                         ${METADATA_GROUP_ELEMENT}                               ${METADATA_GRP_NAME}
    Select Value From Picklist Using Xpath                  Type                        ${AUTOMATION_TYPE}
    ClickText                   Save                        anchor=2