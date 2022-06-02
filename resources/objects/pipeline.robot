*** Settings ***
Documentation                   Contains common keywords required for user story
Library                         Collections
Resource                        ../../resources/common_keywords.robot
Resource                        ../../resources/webelements/pipeline_webelement.robot
Resource                        ../../resources/webelements/user_story_webelement.robot

*** Keywords ***
Create Pipeline through Pipeline object
    [Documentation]             Creating the Pipeline
    [Arguments]                 ${MAIN_BRANCH_NAME}         ${GIT_REPO_NAME}
    ClickText                   New
    ${PIPELINE_NAME}=           Generate random name
    TypeText                    *Pipeline Name              ${PIPELINE_NAME}
    ClickCheckbox               Active                      on    anchor=Owner
    Select record from lookup field                         Search Git Repositories...                              ${GIT_REPO_NAME}
    TypeText                    Main Branch                 ${MAIN_BRANCH_NAME}
    ClickText                   Save                        anchor=2
    VerifyAll                   ${PIPELINE_NAME}, Salesforce, main, ${GIT_REPO_NAME}, Pipeline Manager, User Story
    [Return]                    ${PIPELINE_NAME}

Create Pipeline Connection through Pipeline
    [Documentation]             Creating Pipeline Connections through Pipeline Object
    [Arguments]                 ${SOURCE_ORG}               ${DESTINATION_ORG}          ${BRANCH_NAME}
    ClickText                   Pipeline Connections
    ClickText                   New
    Select record from lookup field                         *Source Environment         ${SOURCE_ORG}
    Select record from lookup field                         *Destination Environment    ${DESTINATION_ORG}
    VerifyText                  Connection Behavior Override
    TypeText                    *Branch                     ${BRANCH_NAME}
    VerifyAll                   Fields Updated By Copado, Sync Merge State, Merge Auto Resolved Files, Sync Pull State, Pull Auto Resolved Files, Destination Branch
    ClickText                   Save                        anchor=2
    VerifyText                  View All

Pipeline Manager
    [Documentation]             Navigate to Pipeline Manager
    [Arguments]                 ${CREATED_ORGS}
    ClickText                   Pipeline Manager            anchor=Manage Releases
    VerifyText                  ${DEV1_ORG}
    VerifyText                  Mass Back-Promote
    VerifyAll                   Configure Pipeline, Refresh Pipeline, View:
    VerifyAll                   ${CREATED_ORGS}


Switch to different Pipeline
    [Documentation]             This method is used to change the pipeline and verify the existing and new ORGS
    [Arguments]                 ${SWITCH_PIPELINE_TXT}
    VerifyAll                   Configure Pipeline, Refresh Pipeline, View:
    DropDown                    ${PIPELINE_LIST_DROPDOWN_WEBELEMENT}                    ${SWITCH_PIPELINE_TXT}

Click and Validate Configure Pipeline
    [Documentation]             Verify data on Configure Pipeline
    [Arguments]                 ${ORGS_LIST}                ${BRANCH_LIST}
    ClickText                   Configure Pipeline
    VerifyElement               ${RETURN_PIPELINE_WEBELEMENT}
    VerifyAll                   ${ORGS_LIST}
    VerifyAll                   ${BRANCH_LIST}
    VerifyElement               ${NEW_ENV_CONNECTION_WEBELEMENT}
    ClickElement                ${CONFIG_PIPELINE_OPTION_WEBELEMENT}
    VerifyAll                   Variables, View Pipeline Details

Verify Edit Options on each org in Configure Pipline
    [Documentation]             Verifies Edit Options on each orgs in Configure Pipline
    [Arguments]                 ${ORG_LIST}
    ${LENGTH}=                  Get Length                  ${ORG_LIST}
    FOR                         ${I}                        IN RANGE                    0                           ${LENGTH}
        ${EXPECTED}=            Get From List               ${ORG_LIST}                 ${I}
        ClickElement            xpath\=//span[@title\='${EXPECTED}']/../../preceding-sibling::div//button
        VerifyText              Edit Environment
    END

Create new Pipeline View
    [Documentation]             Create new view and selecting Filter option Only me
    [Arguments]                 ${FILTER_VISIBLITY_OPTION}
    VerifyNoText                Loading
    VerifyText                  View:
    ClickElement                ${PIPELINE_DOWN_ARROW_WEBELEMENT}
    VerifyText                  New
    ClickText                   New
    ${CHECK_FILTER_VALUES}=     Create List                 Filter Name                 Who can see this filter?    Only me                     All users                   Environment Filters    Visible Environments    Hidden Environments    User Story Filters
    VerifyAll                   ${CHECK_FILTER_VALUES}
    ${FILTER_NAME}=             Generate random name
    TypeText                    Filter Name                 ${FILTER_NAME}
    ClickText                   ${FILTER_VISIBLITY_OPTION}
    [Return]                    ${FILTER_NAME}

Select values from custom Multipicklist
    [Documentation]             Select multiple values from the picklist
    [Arguments]                 ${OPTIONS}
    ${LENGTH}=                  Get Length                  ${OPTIONS}
    FOR                         ${I}                        IN RANGE                    0                           ${LENGTH}
        ${EXPECTED}=            Get From List               ${OPTIONS}                  ${I}
        ClickText               ${EXPECTED}
        ClickElement            ${CUSTOM_MULTIPICKLIST__WEBELEMENT}
    END

Create three Pipeline Connection
    [Documentation]             Creates a Pipeline with three Connection
    Open Object                 Pipelines
    ${NEW_PIPELINE_NAME}=       Create Pipeline through Pipeline object                 ${EXISTING_MAIN_BRANCH_NAME}                            ${EXISTING_GIT_REPO_VAR}
    Create Pipeline Connection through Pipeline             ${DEV1_ORG}                 ${STAGING_ORG}              ${EXISTING_DEV1_BRANCH_NAME}
    Create Pipeline Connection through Pipeline             ${DEV2_ORG}                 ${STAGING_ORG}              ${EXISTING_DEV2_BRANCH_NAME}
    Create Pipeline Connection through Pipeline             ${STAGING_ORG}              ${PROD_ORG}                 ${EXISTING_STAGING_BRANCH_NAME}
    ClickText                   Details
    ${NEW_CREATED_ORGS}=        Create List                 ${DEV1_ORG}                 ${DEV2_ORG}                 ${STAGING_ORG}              ${PROD_ORG}
    Pipeline Manager            ${NEW_CREATED_ORGS}
    [Return]                    ${NEW_PIPELINE_NAME}

Edit pipeline view
    [Documentation]             To edit the existing pipeline view
    [Arguments]                 ${PIPELINE_VIEW}
    VerifyText                  View:
    DropDown                    View:                       ${PIPELINE_VIEW}
    VerifyNoText                Loading
    VerifySelectedOption        View:                       ${PIPELINE_VIEW}
    ClickElement                ${PIPELINE_DOWN_ARROW_WEBELEMENT}
    ClickText                   Edit
    VerifyText                  Edit View: ${PIPELINE_VIEW}
    ${CHECK_FILTER_VALUES}=     Create List                 Filter Name                 Who can see this filter?    Only me                     All users                   Environment Filters    Visible Environments    Hidden Environments    User Story Filters
    VerifyAll                   ${CHECK_FILTER_VALUES}

Delete US filter from Pipeline
    [Documentation]             To delete the user story filter in pipeline view
    [Arguments]                 ${USER_STORY_FILTER}
    ScrollText                  Add Row
    ${DELETE_FILTER}=           Replace String              ${USERSTORYFILTER_DELETE_WEBELEMENT}                    VALUE                       ${USER_STORY_FILTER}
    ClickElement                ${DELETE_FILTER}
    VerifyNoText                Loading
    VerifyText                  User Story Filters
    VerifyNoElement             ${DELETE_FILTER}

Add or edit user story Filters
    [Documentation]             To add user story filters in the pipeline view
    [Arguments]                 ${USER_STORY_FILTER}        ${CONDITION}                ${VALUE}                    ${INDEX}                    #Index starts from 0(first row) 1(second row) etc. From index 1, new row gets added by clicking on Add row only if the index is not present else edits the indexed row
    ${USERSTORYFILTER_DROPDOWN}=                            Replace String              ${USERSTORYFILTER_DROPDOWN_WEBELEMENT}                  NUMBER                      ${INDEX}
    ${ISPRESENT}=               Run Keyword And Return Status                           VerifyElement               ${USERSTORYFILTER_DROPDOWN}                             timeout=5s
    Run Keyword Unless          ${ISPRESENT}                ClickText                   Add Row
    VerifyNoText                Loading
    DropDown                    ${USERSTORYFILTER_DROPDOWN}                             ${USER_STORY_FILTER}
    VerifyNoText                Loading
    ${USERSTORYFILTER_CONDITION_DROPDOWN}=                  Replace String              ${USERSTORYFILTER_CONDITIONDROPDOWN_WEBELEMENT}         NUMBER                      ${INDEX}
    DropDown                    ${USERSTORYFILTER_CONDITION_DROPDOWN}                   ${CONDITION}
    VerifyNoText                Loading
    ${USERSTORYFILTER_VALUE_WEBELEMENT}=                    Replace String              ${USERSTORYFILTER_VALUE_WEBELEMENT}                     NUMBER                      ${INDEX}
    ${TEXTAREA_ELEMENT}=        Catenate                    ${USERSTORYFILTER_VALUE_WEBELEMENT} //textarea
    ${ISTTEXTAREAELEMENTPRESENT}=                           Run Keyword And Return Status                           VerifyElement               ${TEXTAREA_ELEMENT}         timeout=3s
    Run Keyword If              ${ISTTEXTAREAELEMENTPRESENT}                            TypeText                    ${TEXTAREA_ELEMENT}         ${VALUE}
    ${INPUT_ELEMENT}=           Catenate                    ${USERSTORYFILTER_VALUE_WEBELEMENT} //input
    ${ISINPUTELEMENTPRESENT}=                               Run Keyword And Return Status                           VerifyElement               ${INPUT_ELEMENT}            timeout=3s
    Run Keyword If              ${ISINPUTELEMENTPRESENT}    TypeText                    ${INPUT_ELEMENT}            ${VALUE}
    ${LOOKUP_ELEMENT}=          Catenate                    ${USERSTORYFILTER_VALUE_WEBELEMENT} //span/input
    ${ISLOOKUPELEMENTPRESENT}=                              Run Keyword And Return Status                           VerifyElement               ${LOOKUP_ELEMENT}           timeout=3s
    Run Keyword If              ${ISLOOKUPELEMENTPRESENT}                               TypeText                    ${LOOKUP_ELEMENT}           ${VALUE}

Get user story ahead count
    [Documentation]             To get the user story ahead count of an environment in the pipeline manager
    [Arguments]                 ${ENVIRONMENT}
    ${AHEAD_COUNT_ELEMENT}=     Replace String              ${USERSTORY_AHEAD_COUNT_WEBELEMENT}                     ENVIRONMENT                 ${ENVIRONMENT}
    ${AHEAD_COUNT}=             GetText                     ${AHEAD_COUNT_ELEMENT}
    [Return]                    ${AHEAD_COUNT}

Get user story behind count
    [Documentation]             To get the user story behind count of an environment in the pipeline manager
    [Arguments]                 ${ENVIRONMENT}
    ${BEHIND_COUNT_ELEMENT}=    Replace String              ${USERSTORY_BEHIND_COUNT_WEBELEMENT}                    ENVIRONMENT                 ${ENVIRONMENT}
    ${BEHIND_COUNT}=            GetText                     ${BEHIND_COUNT_ELEMENT}
    [Return]                    ${BEHIND_COUNT}

Verify user story ahead and behind
    [Documentation]             To verify the number of user stories ahead and behind of an envirionment in the pipeline manager
    [Arguments]                 ${ENVIRONMENT}              ${AHEAD}                    ${BEHIND}
    VerifyNoText                Loading
    VerifyText                  View:
    ${AHEAD_CNT}=               Get user story ahead count                              ${ENVIRONMENT}
    ${BEHIND_CNT}=              Get user story behind count                             ${ENVIRONMENT}
    Should Be Equal             ${AHEAD_CNT}                ${AHEAD}
    Should Be Equal             ${BEHIND_CNT}               ${BEHIND}

Click pipeline shield
    [Documentation]             It will click on the pipeline shield image
    [Arguments]                 ${ENVIRONMENT}
    ClickText                   Configure Pipeline
    ${SHIELD_WEBELEMENT}=       Replace String              ${PIPELINE_SHIELD_WEBELEMENT}                           ENVIRONMENT                 ${ENVIRONMENT}
    Log To Console              ${SHIELD_WEBELEMENT}
    ClickElement                ${SHIELD_WEBELEMENT}

Verify promotion execution dropdown values
    [Documentation]             It will help to check options available in the dropdown
    [Arguments]                 ${EXPECTED_OPTIONS}
    ClickText                   Edit Promotion Execution
    ClickElement                ${PROMOTION_EXECUTION_WEBELEMENT}
    ${PROMOTION_EXECUTION_ID}=                              GetAttribute                ${PROMOTION_EXECUTION_WEBELEMENT}                       id
    ${PROMOTION_EXECUTION_ID}=                              Get Substring               ${PROMOTION_EXECUTION_ID}                               -3
    ${LENGTH}=                  Get Length                  ${EXPECTED_OPTIONS}
    FOR                         ${DROPDOWN_ITEM}            IN RANGE                    0                           ${LENGTH}
        ${EXPECTED}=            Get From List               ${EXPECTED_OPTIONS}         ${DROPDOWN_ITEM}
        ${PROMOTION_EXECUTION_DROPDOWN_WEBELEMENT}=         Replace String              ${PROMOTION_EXECUTION_DROPDOWN_WEBELEMENT}              ID                          ${PROMOTION_EXECUTION_ID}
        ${PROMOTION_EXECUTION_DROPDOWN_WEBELEMENT}=         Replace String              ${PROMOTION_EXECUTION_DROPDOWN_WEBELEMENT}              DROPDOWN_VALUES             ${EXPECTED}
        VerifyElement           ${PROMOTION_EXECUTION_DROPDOWN_WEBELEMENT}
    END
    ClickText                   Cancel

Verify user story status after promotion drop down values
    [Documentation]             It will help to check options available in the drop down
    [Arguments]                 ${EXPECTED_OPTIONS}
    ClickText                   Edit User Story Status After Promotion
    ClickElement                ${USER_STORY_STATUS_AFTER_PROMOTION_WEBELEMENT}
    ${USER_STORY_PROMOTION_ID}=                             GetAttribute                ${USER_STORY_STATUS_AFTER_PROMOTION_WEBELEMENT}         id
    ${USER_STORY_PROMOTION_ID}=                             Get Substring               ${USER_STORY_PROMOTION_ID}                              -3
    ${LENGTH}=                  Get Length                  ${EXPECTED_OPTIONS}
    FOR                         ${DROPDOWN_ITEM}            IN RANGE                    0                           ${LENGTH}
        ${EXPECTED}=            Get From List               ${EXPECTED_OPTIONS}         ${DROPDOWN_ITEM}
        ${PROMOTION_EXECUTION_DROPDOWN_WEBELEMENT}=         Replace String              ${PROMOTION_EXECUTION_DROPDOWN_WEBELEMENT}              ID                          ${USER_STORY_PROMOTION_ID}
        ${PROMOTION_EXECUTION_DROPDOWN_WEBELEMENT}=         Replace String              ${PROMOTION_EXECUTION_DROPDOWN_WEBELEMENT}              DROPDOWN_VALUES             ${EXPECTED}
        VerifyElement           ${PROMOTION_EXECUTION_DROPDOWN_WEBELEMENT}
    END
    ClickText                   Cancel

Verify back promotion execution dropdown values
    [Documentation]             It will help to check options available in the drop down
    [Arguments]                 ${EXPECTED_OPTIONS}
    ClickText                   Edit Back-Promotion Execution
    ClickElement                ${BACK_PROMOTION_EXECUTION_WEBELEMENT}
    ${BACK_PROMOTION_ID}=       GetAttribute                ${BACK_PROMOTION_EXECUTION_WEBELEMENT}                  id
    ${BACK_PROMOTION_ID}=       Get Substring               ${BACK_PROMOTION_ID}        -3
    ${LENGTH}=                  Get Length                  ${EXPECTED_OPTIONS}
    FOR                         ${DROPDOWN_ITEM}            IN RANGE                    0                           ${LENGTH}
        ${EXPECTED}=            Get From List               ${EXPECTED_OPTIONS}         ${DROPDOWN_ITEM}
        ${PROMOTION_EXECUTION_DROPDOWN_WEBELEMENT}=         Replace String              ${PROMOTION_EXECUTION_DROPDOWN_WEBELEMENT}              ID                          ${BACK_PROMOTION_ID}
        ${PROMOTION_EXECUTION_DROPDOWN_WEBELEMENT}=         Replace String              ${PROMOTION_EXECUTION_DROPDOWN_WEBELEMENT}              DROPDOWN_VALUES             ${EXPECTED}
        VerifyElement           ${PROMOTION_EXECUTION_DROPDOWN_WEBELEMENT}
    END
    ClickText                   Cancel

Navigate to deployment activity via pipeline page
    [Documentation]             It will help to navigate to deployment activity page from pipeline page
    [Arguments]                 ${ENVIRONMENT}
    ${PIPELINE_DEPLOYMENT_ACTIVITY_WEBELEMENT}=             Replace String              ${PIPELINE_DEPLOYMENT_ACTIVITY_WEBELEMENT}              ENVIRONMENT                 ${ENVIRONMENT}
    ClickElement                ${PIPELINE_DEPLOYMENT_ACTIVITY_WEBELEMENT}
    VerifyText                  Deployment Activity

Verify deployment activity columns heading
    [Documentation]             It will help to verify the columns name
    [Arguments]                 ${EXPECTED_OPTIONS}
    ${LENGTH}=                  Get Length                  ${EXPECTED_OPTIONS}
    FOR                         ${DROPDOWN_ITEM}            IN RANGE                    0                           ${LENGTH}
        ${EXPECTED}=            Get From List               ${EXPECTED_OPTIONS}         ${DROPDOWN_ITEM}
        ${DEPLOYMENT_ACTIVITY_WEBELEMENT}=                  Replace String              ${DEPLOYMENT_ACTIVITY_WEBELEMENT}                       COLUMN_NAME                 ${EXPECTED}
        VerifyElement           ${DEPLOYMENT_ACTIVITY_WEBELEMENT}
    END

Select User Stories For Promotion
    [Documentation]             To select the user stories from the pipeline manager to create promotion record.
    ...                         Author: Dhanesh
    ...                         Date:                       15 NOV 2021
    [Arguments]                 ${USER_STORIES}             #Argument is of List type
    SetConfig                   PartialMatch                False
    VerifyAll                   User Story Reference, Title, Status, Project, Created Date, Release, Last Validation Status, Has Apex Code, Is Bundle
    ClickText                   Select All
    ClickCheckbox               Select All                  off
    VerifyNoText                Loading
    ${LENGTH}=                  Get Length                  ${USER_STORIES}
    FOR                         ${I}                        IN RANGE                    0                           ${LENGTH}
        ${US}=                  Get From List               ${USER_STORIES}             ${I}
        VerifyText              Search:
        TypeText                Search:                     ${US}
        VerifyText              ${US}                       anchor=User Story Reference
        ${CHECK_US_ELEMENT}=    Replace String              ${SELECT_US_CHECKBOX_WEBELEMENT}                        USERSTORY                   ${US}
        ClickCheckbox           ${CHECK_US_ELEMENT}         on
        VerifyNoText            Loading
        PressKey                Search:                     {CONTROL + A}
        PressKey                Search:                     {BACKSPACE}
    END
    Sleep                       1s
    SetConfig                   PartialMatch                True
    VerifyNoText                Loading

MC Create Promotion Record From Pipeline Manager
    [Documentation]             To verify creation of promotion record from pipeline manager and return promotion ID
    ...                         Name: Shweta
    ...                         Date: 15 November 2021
    [Arguments]                 ${SOURCE_ENVIRONMENT}       ${DESTINATION_ENVIRONMENT}                              #pass the environments that has to be verified in promotion record page
    VerifyText                  Create Promotion
    ClickText                   Create Promotion
    VerifyNoText                Loading
    VerifyAll                   Details, User Stories, Changes, History & Approvals, Notes & Attachments
    ClickText                   Details
    ${PROMOTION_ID}             GetText                     ${PROMOTION_ID_WEBELEMENT}
    VerifyText                  Source Environment
    ${SOURCE_ENV}               GetText                     ${SRC_ENV_WEBELEMENT}
    Should Be Equal             ${SOURCE_ENV}               ${SOURCE_ENVIRONMENT}
    VerifyText                  Destination Environment
    ${DESTINATION_ENV}          GetText                     ${DEST_ENV_WEBELEMENT}
    Should Be Equal             ${DESTINATION_ENV}          ${DESTINATION_ENVIRONMENT}
    [Return]                    ${PROMOTION_ID}

Add Connection Behavior to Existing Pipeline Connection
    [Documentation]             Add the connection behavior to the existing pipeline connection, pipeline should be opened and contain single pipeline connection.
    ...                         Name: Manav Kumar Parasrampuria
    ...                         Date: 26 November 2021
    [Arguments]                 ${CONNECTION_BEHAVIOR}
    ClickText                   Pipeline Connections
    ClickText                   View All
    ClickText                   Show Actions
    Sleep                       2s                          #To get the "Show Actions" options
    ClickText                   Edit                        anchor=Delete
    VerifyText                  Save                        #To check Edit pipeline connection window opened
    Select record from lookup field                         Connection Behavior Override                            ${CONNECTION_BEHAVIOR}
    ClickText                   Save                        2
    VerifyText                  was saved

Search User Story on Deployment Activity Page
    [Documentation]             On Pipeline > Env. > Deploymemnt activity > Search User Story deployment
    ...                         Name: Sachin Talwaria
    ...                         Date: 02 December 2021
    [Arguments]                 ${USER_STORY_ID}
    TypeText                    ${DEPLOYMENTACTIVITY_SEARCH_WEBELEMENT}                 ${USER_STORY_ID}
    ${DEPLOYMENT_USERSTORY_WEBELEMENT}=                     Replace String              ${DEPLOYMENT_USERSTORY_WEBELEMENT}                      ID                          ${USER_STORY_ID}
    ${SEARCH_COUNT}=            GetElementCount             ${DEPLOYMENT_USERSTORY_WEBELEMENT}
    Should Be True              ${SEARCH_COUNT} > 0

Navigate to Deployment from Deployment Activity Page
    [Documentation]             It will help to navigate on the deployment page from deployment activity page
    ...                         Name: Sachin Talwaria
    ...                         Date: 02 December 2021
    [Arguments]                 ${USER_STORY_ID}
    ${DEPLOYMENT_USERSTORY_WEBELEMENT}=                     Replace String              ${DEPLOYMENT_USERSTORY_WEBELEMENT}                      ID                          ${USER_STORY_ID}
    ${SEARCH_COUNT}=            GetElementCount             ${DEPLOYMENT_USERSTORY_WEBELEMENT}
    IF                          ${SEARCH_COUNT}>0
        ClickElement            ${DEPLOYMENT_USERSTORY_WEBELEMENT}
    END

Get Pipeline ContextID
    [Documentation]             To get the context id from a pipeline
    ...                         Author: Dhanesh
    ...                         Date: 18th Feb 2022
    [Arguments]                 ${PIPELINE_NAME}
    Open Object                 Pipelines
    Open record from object main page                       ${PIPELINE_NAME}
    VerifyText                  ${PIPELINE_NAME}
    ${CONTEXTID}=               Get ContextId
    [Return]                    ${CONTEXTID}