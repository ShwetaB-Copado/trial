*** Settings ***
Documentation                   Methods for creating Complicance Rules and Compliance Scope
Resource                        ../../resources/common_keywords.robot
Resource                        ../../resources/webelements/compliance_webelement.robot

*** Keywords ***
Create CCH Rule
    [Documentation]             Creating Compliance Rule
    [Arguments]                 ${SEVERITY}                 ${ACTION}
    Open Object                 Compliance Rules
    ClickText                   New
    ClickText                   Copado
    ClickText                   Next
    ${CCH_RULE}=                Generate random name
    VerifyText                  New Compliance Rule: Copado
    TypeText                    Compliance Rule Name        ${CCH_RULE}                 anchor=Rule Detail
    ClickElement                ${SEVERITY_WEBELEMENT}
    ${SEVERITY_OPTION}=         Replace String              ${SELECT_SEVERITY_OPTION}                               SEVERITYVALUE              ${SEVERITY}
    ClickElement                ${SEVERITY_OPTION}
    ClickElement                ${ACTION_WEBELEMENT}
    ${ACTION_OPTION}=           Replace String              ${SELECT_ACTION_OPTION}     ACTIONVALUE                 ${ACTION}
    ClickElement                ${ACTION_OPTION}
    ClickText                   Save                        anchor=2
    VerifyText                  ${CCH_RULE}
    VerifyAll                   Severity, ${SEVERITY}, Action, ${ACTION}, Risk Details, Error Message
    [Return]                    ${CCH_RULE}

Create Compliance Scope
    [Documentation]             Creating Compliance Scope with Criteria as Profile having ViewAllData or ModifyAllData permission
    [Arguments]                 ${CCH_RULE}
    VerifyAll                   ${CCH_RULE}, Related, Delete
    VerifyText                  Edit                        anchor=Delete
    VerifyText                  Criteria Logic
    VerifyAll                   Compliance Scope, Select Metadata Type, Node, Field, Operator, Value
    ScrollTo                    Compliance Scope
    Sleep                       2s                          #waits for LWC component to load
    ClickElement                ${SELECT_METADATA_TYPE_WEBELEMENT}                      #Table does not have name hence chose xpath
    PressKey                    ${SELECT_METADATA_OPTION_WEBELEMENT}                    Profile
    ClickText                   Profile
    Select Value For Node       1                           userPermissions
    Select Value For Field      1                           name
    Select Value For Operator                               1                           equals
    TypeText                    ${LOGIC_INPUT_VALUE_ROW_ONE_WEBELEMENT}                 ViewAllData                 #Table does not have name hence chose xpath
    ClickText                   Add Row
    Select Value For Node       2                           userPermissions
    Select Value For Field      2                           name
    Select Value For Operator                               2                           equals
    TypeText                    ${LOGIC_INPUT_VALUE_ROW_TWO_WEBELEMENT}                 ModifyAllData               #Table does not have name hence chose xpath
    ClickText                   Add Row
    Select Value For Node       3                           userPermissions
    Select Value For Field      3                           enabled
    Select Value For Operator                               3                           equals
    ClickElement                ${LOGIC_ENABLE_CHECKBOX_WEBELEMENT}                     #If we don't use xpath then checkbox will automatically uncheck after Saving
    TypeText                    Criteria Logic              (1 OR 2) AND 3
    ClickText                   Save
    VerifyText                  ViewAllData
    VerifyText                  ModifyAllData
    ScrollTo                    Rule Detail
    VerifyText                  Related

Create Compliance Rule items
    [Documentation]             Creating Compliance Rule items by adding Compliance Group
    [Arguments]                 ${CCH_GROUP_NAME}
    ClickText                   Compliance Rule Group Items                             anchor=1
    ClickText                   New
    Select record from lookup field                         Search Compliance Rule Groups...                        ${CCH_GROUP_NAME}
    ClickText                   Save                        anchor=2
    VerifyText                  was created

Create Compliance Rule Group
    [Documentation]             Creating Compliance Rule Group
    Open Object                 Compliance Rule Groups
    ClickText                   New
    ${CCH_GROUP_NAME}=          Generate random name
    VerifyText                  New Compliance Rule Group
    TypeText                    Compliance Rule Group Name                              ${CCH_GROUP_NAME}           anchor=New Compliance Rule Group
    ClickText                   Save                        anchor=2
    VerifyText                  ${CCH_GROUP_NAME}           anchor=1
    [Return]                    ${CCH_GROUP_NAME}

Adding CCH Group to Environment
    [Documentation]             Adding CCH Group to Staging Environment
    [Arguments]                 ${CCH_GROUP_NAME}
    Open Object                 Environments
    Open record from object main page                       ${DEV1_ORG}
    VerifyText                  Quality Gates
    ClickText                   Edit                        anchor=Delete
    ScrollText                  Static Code Analysis        anchor=2
    ${CRG_ISBLANK}=             RunKeywordAndReturnStatus                               VerifyText                  Clear Selection            timeout=5s                  #CRG stands for Compliance Rule Group
    RunKeywordIf                ${CRG_ISBLANK}              ClickText                   Clear Selection
    Select record from lookup field                         Search Compliance Rule Groups...                        ${CCH_GROUP_NAME}          #Searches for the record in the lookup
    ClickText                   Save                        anchor=2
    ClickText                   Quality Gates
    VerifyText                  ${CCH_GROUP_NAME}           anchor=Compliance Rule Group

RunComplianceScan
    [Documentation]             Clicks on more actions button on the User Story
    Open Show more actions on Details page
    ClickText                   Run Compliance Scan
    Sleep                       2s                          #waiting for the page to load
    VerifyText                  Success:Compliance Scan Requested Successfully!
    ClickText                   Back

Navigate to Compliance Scan Results
    [Documentation]             Verifies the Status, Severity, Action for the result generate in Compliance Scan
    RefreshPage
    ClickText                   Related
    VerifyText                  User Story Commits
    ScrollTo                    Deployment Tasks
    ${CSR_COUNT}=               GetText                     ${COMPLIANCE_SCAN_RECORD_COUNT_IN_US_WEBELEMENT}        #unable to fetch Text without using xpath
    Run Keyword if              '${CSR_COUNT}'=='(0)'       Navigate to Compliance Scan Results
    VerifyText                  Scan Result
    ClickText                   Scan Result -               anchor=1
    ${CS_STATUS}=               Run Keyword And Return Status                           VerifyText                  In Progress                #CS= Compliance Scan
    Run Keyword If              ${CS_STATUS}                Check record result until status change                 In Progress

Validate Complicance Scan Result
    [Documentation]             Verifying Compliance Status, Severity and Action field
    [Arguments]                 ${COMPLIANCE_STATUS}        ${SEVERITY}                 ${ACTION}                   ${US_ID}
    RefreshPage
    VerifyText                  ${COMPLIANCE_STATUS}
    ${IS_ACTION}=               Run Keyword And Return Status                           VerifyNoText                ${ACTION}
    Run Keyword If              ${IS_ACTION}                RefreshPage
    VerifyText                  ${SEVERITY}                 anchor=Highest Severity
    VerifyText                  ${ACTION}
    VerifyAll                   Environment, Git Snapshot, ${DEV1_ORG}, Credential, ${US_ID}

Navigate to User Story
    [Documentation]             Navigate to the latest User Story
    [Arguments]                 ${US_ID}
    Open Object                 User Stories
    Open record from object main page                       ${US_ID}
    VerifyText                  ${US_ID}

Check Record Result Until Status Change In Test Tab
    [Documentation]             Checks the Status and refresh the page until status is changed in Test Tab
    ...                         Author: Naveen Ramesh
    [Arguments]                 ${CURRENT_STATUS}
    FOR                         ${INDEX}                    IN RANGE                    0                           ${20}
        ClickText               Test                        anchor=Deliver
        ${IS_STATUS}=           IsText                      ${CURRENT_STATUS}
        Run Keyword If          '${IS_STATUS}' == 'False'                               Refresh page browser
        ...                     ELSE                        Exit For Loop
    END

Select Value For Node
    [Documentation]             This method will select a value for Node picklist
    ...                         Author: Naveen Ramesh
    [Arguments]                 ${CRITERIA_ROW_NUMBER}      ${CRITERIA_NODE_OPTION}
    ${SELECT_ROW_NODE}=         Replace String              ${CRITERIA_NODE_WEBELEMENT}                             CRITERIA_NODE_VALUE         ${CRITERIA_ROW_NUMBER}
    ClickElement                ${SELECT_ROW_NODE}
    ${ROW_NODE}=                Replace String              ${CRITERIA_NODE_OPTION_WEBELEMENT}                      CRITERIA_NODE_VALUE         ${CRITERIA_ROW_NUMBER}
    ${ROW_NODE_VALUE}=          Replace String              ${ROW_NODE}                 NODETITLE                   ${CRITERIA_NODE_OPTION}
    ClickText                   ${ROW_NODE_VALUE}

Select Value For Field
    [Documentation]             This method will select a value for Field picklist
    ...                         Author: Naveen Ramesh
    [Arguments]                 ${CRITERIA_ROW_NUMBER}      ${CRITERIA_FIELD_OPTION}
    ${SELECT_ROW_FIELD}=        Replace String              ${CRITERIA_FIELD_WEBELEMENT}                            CRITERIA_FIELD_VALUE        ${CRITERIA_ROW_NUMBER}
    ClickElement                ${SELECT_ROW_FIELD}
    ${ROW_FIELD}=               Replace String              ${CRITERIA_FIELD_OPTION_WEBELEMENT}                     CRITERIA_FIELD_VALUE        ${CRITERIA_ROW_NUMBER}
    ${ROW_FIELD_VALUE}=         Replace String              ${ROW_FIELD}                FIELDTITLE                  ${CRITERIA_FIELD_OPTION}
    ClickText                   ${ROW_FIELD_VALUE}

Select Value For Operator
    [Documentation]             This method will select a value for Operator picklist
    ...                         Author: Naveen Ramesh
    [Arguments]                 ${CRITERIA_ROW_NUMBER}      ${CRITERIA_OPERATOR_OPTION}
    ${SELECT_ROW_OPERATOR}=     Replace String              ${CRITERIA_OPERATOR_WEBELEMENT}                         CRITERIA_OPERATOR_VALUE     ${CRITERIA_ROW_NUMBER}
    ClickElement                ${SELECT_ROW_OPERATOR}
    ${ROW_OPERATOR}=            Replace String              ${CRITERIA_OPERATOR_OPTION_WEBELEMENT}                  CRITERIA_OPERATOR_VALUE     ${CRITERIA_ROW_NUMBER}
    ${ROW_OPERATOR_VALUE}=      Replace String              ${ROW_OPERATOR}             OPERATORTITLE               ${CRITERIA_OPERATOR_OPTION}
    ClickText                   ${ROW_OPERATOR_VALUE}
