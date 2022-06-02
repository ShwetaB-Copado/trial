*** Settings ***
Documentation                   Contains common keywords required for user story
Library                         Collections
Resource                        ../common_keywords.robot
Resource                        ../webelements/user_story_webelement.robot
Resource                        ../../resources/webelements/job_execution_webelement.robot
Resource                        ../webelements/job_templates_webelement.robot

*** Keywords ***
Base method for User Story creation
    [Documentation]             Create User Story and return the User Story Name
    [Arguments]                 ${RECORD_TYPE}              ${PROJECT}                  ${CREDENTIAL}
    #Open "New User Story" window, select record type as per argument and enter other details
    SetConfig                   PartialMatch                True
    VerifyText                  New User Story
    ClickText                   ${RECORD_TYPE}
    ClickText                   Next
    VerifyText                  New User Story              #Check window loaded properly
    ${US_NAME}=                 Generate random name
    TypeText                    ${US_TITLE_TEXTBOX_WEBELEMENT}                          ${US_NAME}
    Select record from lookup field                         Search Projects...          ${PROJECT}
    Sleep                       2s                          #Wait to hanldle timming issue
    Run Keyword If              '${RECORD_TYPE}'!='Investigation'                       Select record from lookup field                         Search Credentials...       ${CREDENTIAL}    #There is no Credential for Investigation type.
    #Save the US and return the user story name
    ClickText                   Save                        2
    [Return]                    ${US_NAME}

Base method for User Story creation without Project
    [Documentation]             Create User Story and return the User Story Name
    ...                         Author:Preethi
    ...                         Date:11th Jan 2021
    [Arguments]                 ${RECORD_TYPE}              ${CREDENTIAL}
    #Open "New User Story" window, select record type as per argument and enter other details
    VerifyText                  New User Story
    ClickText                   ${RECORD_TYPE}
    ClickText                   Next
    VerifyText                  New User Story              #Check window loaded properly
    ${US_NAME}=                 Generate random name
    TypeText                    ${US_TITLE_TEXTBOX_WEBELEMENT}                          ${US_NAME}
    Sleep                       2s                          #Wait to hanldle timing issue
    Run Keyword If              '${RECORD_TYPE}'!='Investigation'                       Select record from lookup field                         Search Credentials...       ${CREDENTIAL}    #There is no Credential for Investigation type.
    #Save the US and return the user story name
    ClickText                   Save                        2
    [Return]                    ${US_NAME}

Create User Story
    [Documentation]             Create User Story from User Story Object and return the ID/Reference
    [Arguments]                 ${RECORD_TYPE}              ${PROJECT}                  ${CREDENTIAL}
    ClickText                   New
    ${US_NAME}=                 Base method for User Story creation                     ${RECORD_TYPE}              ${PROJECT}                  ${CREDENTIAL}
    SetConfig                   PartialMatch                False
    VerifyText                  Plan
    VerifyText                  ${US_NAME}                  anchor=User Story Reference
    SetConfig                   PartialMatch                True
    ${US_ID}=                   GetText                     ${USID_WEBELEMENT}
    [Return]                    ${US_ID}

Create User Story without Project
    [Documentation]             Create User Story without project
    ...                         Author:Preethi
    ...                         Date:11th Jan 2021
    [Arguments]                 ${RECORD_TYPE}              ${CREDENTIAL}
    ClickText                   New
    ${US_NAME}=                 Base method for User Story creation without Project     ${RECORD_TYPE}              ${CREDENTIAL}
    SetConfig                   PartialMatch                False
    VerifyText                  Plan
    VerifyText                  ${US_NAME}                  anchor=User Story Reference
    SetConfig                   PartialMatch                True
    ${US_ID}=                   GetText                     ${USID_WEBELEMENT}
    [Return]                    ${US_ID}

Create User Story From Different Object
    [Documentation]             Create User Story from different object,eg. Theme and return the ID/Reference (prerequisite: Click on the New button before using this method)
    [Arguments]                 ${RECORD_TYPE}              ${PROJECT}                  ${CREDENTIAL}
    Base method for User Story creation                     ${RECORD_TYPE}              ${PROJECT}                  ${CREDENTIAL}
    ${US_ID}=                   Get ID from toast message window
    [Return]                    ${US_ID}

Enable Promote and Deploy
    [Documentation]             Enable "Promote and Deploy" for User Story
    ClickText                   Deliver
    ClickText                   Edit Promote and Deploy
    ClickText                   Promote and Deploy
    ClickText                   Save

Refresh MetaData
    [Documentation]             Refresh metadata
    ClickText                   Refresh All Metadata
    Sleep                       3s
    VerifyText                  Initializing                30s                         #To check Refresh Metadata is working
    VerifyNoText                Information                 320s                        #Wait until the refresh window disappears

Open Commit page
    [Arguments]                 ${REFRESH_FLAG}
    [Documentation]             Open the Commit page and refresh metadata as per argument
    ClickText                   Show more actions
    ClickText                   Commit Changes
    VerifyText                  User Story Commit
    Run Keyword If              '${REFRESH_FLAG}'=='TRUE'                               Refresh MetaData

Select Git operation
    [Arguments]                 ${OPERATION}
    [Documentation]             Select the GIT operation as per argument in the commit page
    DropDown                    Git Operation               ${OPERATION}
    VerifyText                  Select Metadata

Select metadata
    [Arguments]                 ${METADATA}
    [Documentation]             Select the metadata and verify selected or not
    ClickText                   All Metadata
    ClickElement                ${TYPE_NAME_IN_US_WEBLEMENT}
    TypeText                    ${TYPE_NAME_IN_US_WEBLEMENT}                            ${METADATA}
    Sleep                       4s
    VerifyText                  ${METADATA}
    ${METADATA_ELEMENT}=        Replace String              ${SELECT_METADATA_WEBELEMENT}                           METADATA                    ${METADATA}
    ClickElement                ${METADATA_ELEMENT}
    VerifyNoText                Loading
    Check metadata selected     ${METADATA}

Check metadata selected
    [Arguments]                 ${METADATA}
    [Documentation]             Open Selected metadata tab and verify the metadata
    VerifyText                  Selected Metadata
    ClickText                   Selected Metadata
    VerifyText                  ${METADATA}

Commit metadata
    [Documentation]             Commit the metadata after selection, for Git operation- Commit Files, Recommit Files, and Full Profiles and Permission Sets.
    ClickText                   Commit Changes
    VerifyText                  Go Back to the User Story
    VerifyText                  The commit process has started
    VerifyNoText                Go Back to the User Story                               180s

Commit destructive changes
    [Documentation]             Commit the destructive changes after selection
    ClickText                   Commit Destructive Changes
    VerifyText                  Go Back to the User Story
    VerifyText                  The commit process has started
    VerifyNoText                Go Back to the User Story                               150s

Verify metadata
    [Arguments]                 ${METADATA}                 ${COMMIT_STATUS}
    [Documentation]             Verify the metadata in User Story after Commit as per metdata and status
    ClickText                   Build
    VerifyText                  ${METADATA}                 css=off
    ScrollText                  User Story Commits
    ClickElement                xpath\=(//*[@data-label\="Commit Name"]/span/div)[1]
    VerifyText                  Snapshot Commit
    VerifyText                  ${COMMIT_STATUS}            anchor=Status
    VerifyText                  ${METADATA}                 css=off
    #Navigate to US- Plan tab
    QWeb.Back
    ClickText                   Plan

Verify metadata in US build tab
    [Arguments]                 ${METADATA}                 ${METADATA_OPERATION_INDEX}
    [Documentation]             Verify the metadata in User Story-Build tab (User Story Selections)
    #Please use the below tab index value if you are using this method
    #0=MetaData
    #1=Git Upserts
    #2= Git Deletions
    #3= Test Only
    #4=Retrieve Only
    ClickText                   Build
    TypeText                    xpath\=//input[@type\='textarea' and @tabindex\='10']                               ${METADATA}
    Sleep                       3s                          #Wait to get the searched result
    ${VERIFY_METADATA_XPATH}=                               Set Variable                //div[contains(text(),"${METADATA}")]
    VerifyText                  ${VERIFY_METADATA_XPATH}
    ${METADATA_OPERATION}=      Set Variable                //div[@columnindex\='${METADATA_OPERATION_INDEX}']/div[@checked\='true']
    VerifyElement               ${METADATA_OPERATION}

Open Promotion through User Story
    [Documentation]             Open the Promotion available in user story and wait until the deployment creation
    VerifyNoText                Loading
    ClickText                   Plan
    VerifyNoText                Loading
    ClickText                   Deliver
    ScrollText                  User Story Promotions
    VerifyNoText                Loading
    VerifyElement               ${FIRST_PROMOTION_INSIDE_US_WEBELEMENT}
    ClickElement                ${FIRST_PROMOTION_INSIDE_US_WEBELEMENT}
    VerifyText                  Promotion                   #To check promotion page loaded
    ${PROGRESS_WINDOW}=         RunKeywordAndReturnStatus                               VerifyText                  Hide message                timeout=5s
    Run Keyword If              ${PROGRESS_WINDOW}          ClickText                   Hide Message

Wait until promotion completion
    [Documentation]             Wait until the promotion status to "Completed/Completed with errors/Cancelled"
    FOR                         ${INDEX}                    IN RANGE                    0                           ${15}
        ${CURRENT_STATUS}=      Get status of promotion page
        Exit For Loop IF        '${CURRENT_STATUS}' == 'Completed' or '${CURRENT_STATUS}' == 'Completed with Errors' or '${CURRENT_STATUS}' == 'Cancelled'
        Refresh Promotion Page
    END

Get status of promotion page
    [Documentation]             Get the current status of the promotion page
    ${STATUS}=                  GetText                     ${PROMOTION_STATUS_WEBELEMENT}
    [Return]                    ${STATUS}

Refresh Promotion Page
    [Documentation]             Refresh the Promotion page every 15s
    RefreshPage
    Sleep                       15s

Verify promotion status
    [Documentation]             Verify the promotion status to "Completed"
    ${CURRENT_STATUS}=          Get status of promotion page
    Should Be Equal             ${CURRENT_STATUS}           Completed

Open Deployment through Promotion
    [Documentation]             Open the deployment page through promotion
    ClickText                   CD: Deploy
    VerifyText                  Deployment Name

Check Deployment Status
    [Documentation]             Check the Deployment status
    VerifyAny                   100 %, 100.0 %              120s                        #Wait until 100% deployment completion
    ${STATUS}=                  GetText                     xpath\=//*[@id\='thePage:theForm:pbStatus:pbsPbStatus:ofStatus']
    Should Be Equal             ${STATUS}                   Completed Successfully      Deployment Failed

Unselect metadata
    [Arguments]                 ${METADATA}
    [Documentation]             Unselect the metadata
    TypeText                    ${METADATA_INPUT_WEBELEMENT}                            ${METADATA}
    Sleep                       2s                          #Added to handle the loading of search result
    ClickElement                xpath\=//*[@class\="jqx-grid-content jqx-grid-content-base jqx-widget-content jqx-widget-content-base"]/div[1]/div[1]/div[1]/div[1]/div[1]                   #need to refactor the xpath

Add Agile Content to User Story
    [Arguments]                 ${AS_A}                     ${WANT_To}                  ${SO_THAT}
    [Documentation]             Enter Agile Content Details
    ScrollTo                    So that...
    ClickText                   Edit As a...
    TypeText                    As a...                     ${AS_A}
    TypeText                    Want to...                  ${WANT_To}
    TypeText                    So that...                  ${SO_THAT}
    ClickText                   Save

Add Specifications to User Story
    [Arguments]                 ${FUNCTIONAL_SPECIFICATIONS}                            ${TECHNICAL_SPECIFICATIONS}
    [Documentation]             Enter specification details
    ClickText                   Edit Functional Specifications
    TypeText                    ${FUNCTIONAL_SPECIFICATIONS_WEBELEMENT}                 ${FUNCTIONAL_SPECIFICATIONS}                            click=True
    TypeText                    ${TECHNICAL_SPECIFICATIONS_WEBELEMENT}                  ${TECHNICAL_SPECIFICATIONS}                             click=True
    ClickText                   Save                        anchor=Cancel

Add Estimation to User Story
    [Arguments]                 ${PLANNED_POINTS}           ${ACTUAL_POINTS}            ${Priority}                 ${Order}
    [Documentation]             Enter estimation details
    ClickText                   Edit Planned Points
    TypeText                    Planned Points              ${PLANNED_POINTS}
    TypeText                    Actual Points               ${ACTUAL_POINTS}
    TypeText                    Priority                    ${Priority}
    TypeText                    Order                       ${Order}
    ClickText                   Save                        anchor=Cancel

Auto select changes
    [Documentation]             To select the option under auto select changes and verify the functionality
    [Arguments]                 ${OPTION}                   ${LAST_MODIFIED_DATE}       ${METADATA}
    ClickText                   Auto-Select Changes
    VerifyAll                   Done Today, Done Since Yesterday, Done Since Last Commit Date
    ClickText                   ${OPTION}
    VerifyNoText                ${OPTION}
    VerifyText                  All Metadata
    VerifyElement               xpath\=//div[text()\='Selected Metadata']/ancestor::li[contains(@class,'state-pressed')]
    TypeText                    //input[@type\= 'textarea' and @tabindex\= '7']         ${METADATA}                 click=True
    VerifyText                  ${METADATA}
    ${EXPECTED_DATE}=           GetText                     xpath\=//div[@columnindex\='5' and contains(@class,'item-base')]/div
    Should Be Equal             ${EXPECTED_DATE}            ${LAST_MODIFIED_DATE}
    VerifyElement               xpath\= //div[@columnindex\='0']/div[@checked\='true']

Select option under US show more actions
    [Documentation]             To select show more actions option in a user story
    [Arguments]                 ${OPTION}
    ClickText                   Show more actions
    ${OPTION_PRESENT}=          Run Keyword And Return Status                           VerifyText                  ${OPTION}
    Run Keyword Unless          ${OPTION_PRESENT}           ScrollText                  ${OPTION}
    ClickText                   ${OPTION}

Select Second metadata 
    [Arguments]                 ${METADATA}
    [Documentation]             Select the metadata and verify selected or not
    ClickText                   All Metadata
    TypeText                    //input[@type\= 'textarea' and @tabindex\= '7']         ${METADATA}
    Sleep                       2s
    VerifyText                  ${METADATA}
    ClickElement                xpath\=(//div[text()\="AccountOperations"]/../../child::div)[1]
    Check metadata selected     ${METADATA}

Click on AddTestClasses Button in US Metadata Grid
    [Documentation]             Click on Add Test Classes Button in US Metadata Grid
    ClickText                   Build
    HoverElement                xpath\=//input[contains(@id\,'btnAddTestClasses')]
    ClickElement                xpath\=//input[contains(@id\,'btnAddTestClasses')]

Select Test Apex Class
    [Arguments]                 ${APEXCLASS_NAME}
    [Documentation]             Selects any Test ApexClass and Click on Save Button
    ClickText                   All Metadata
    TypeText                    xpath\=//input[@type\= 'textarea' and @tabindex\= '6']                              ${APEXCLASS_NAME}
    sleep                       1s
    VerifyText                  ${APEXCLASS_NAME}
    ClickElement                xpath\=//div[text()\="${APEXCLASS_NAME}"]/parent::div/parent::div/div[1]/div/div[contains(@class,'jqx-checkbox-default jqx-checkbox-default-base jqx-fill-state-normal jqx-fill-state-normal-base jqx-rc-all jqx-rc-all-base')]
    ClickText                   Save

Run Manage Apex Tests
    [Documentation]             Run Manage Apex Tests
    ...                         Author: Prashant Arakeri
    ...                         Modified Date: 16th NOV 2021
    ScrollText                  Show more actions
    Select option under US show more actions                Manage Apex Tests
    VerifyAll                   Summary, Class coverage, Trigger coverage, Methods
    ClickText                   Run Apex Tests
    ${PROGRESS_WINDOW_MANAGEAPEXTESTS}=                     RunKeywordAndReturnStatus                               VerifyText                  Hide message                timeout=45s
    Run Keyword Unless          ${PROGRESS_WINDOW_MANAGEAPEXTESTS}                      RefreshPage
    VerifyText                  The apex test run has started.                          #To Verify Apex Run Has Started
    VerifyNoText                Go Back to the User Story                               180s
    VerifyText                  User Story Coverage
    ${TESTCOVERAGE}=            GetText                     xpath\=//div[contains(@class,"userStoryCoverage")]
    Should Be Equal             ${TESTCOVERAGE}             100%

Metadata Exist
    [Documentation]             It will help in searching metadata from the metadata table.
    [Arguments]                 ${METADATA}                 ${EXIST}
    ClickText                   All Metadata
    TypeText                    (//input[@type\='textarea'])[1]                         ${METADATA}
    Sleep                       2s
    Run Keyword If              '${EXIST}'=='TRUE'          ClickElement                xpath\=//*[@class\="jqx-grid-content jqx-grid-content-base jqx-widget-content jqx-widget-content-base"]/div[1]/div[1]/div[1]/div[1]/div[1]
    Run Keyword If              '${EXIST}'=='FALSE'         VerifyText                  No data to display

Verify metadata table columns
    [Documentation]             To verify the columns name of metadata table
    [Arguments]                 ${EXPECTED_OPTIONS}
    ${LENGTH}=                  Get Length                  ${EXPECTED_OPTIONS}
    FOR                         ${COL_NUM}                  IN RANGE                    0                           ${LENGTH}
        ${EXPECTED}=            Get From List               ${EXPECTED_OPTIONS}         ${COL_NUM}
        ${METADATA_TABLE_COLUMNS_WEBELEMENT}=               Replace String              ${METADATA_TABLE_COLUMNS_WEBELEMENT}                    COLUMN_NAME                 ${EXPECTED}
        VerifyElement           ${METADATA_TABLE_COLUMNS_WEBELEMENT}
    END

Edit Commit Message
    [Documentation]             It will help to edit the commit message
    ClickText                   Commit Message
    ${COMMIT_MSG}=              Generate random name
    TypeText                    //input[contains(@name,'GitCommitMain') and @type\='text']                          ${COMMIT_MSG}
    [Return]                    ${COMMIT_MSG}

Verify User Story Validation
    [Documentation]             To verify the user story validation
    ...                         Author: Dhanesh
    ...                         Modified Date: 16 NOV 2021
    [Arguments]                 ${RESULT}
    VerifyText                  The validation is in progress. You will be redirected to the User Story when the validation is completed.       timeout=120s
    VerifyText                  Promotion in progress ...                               timeout=120s
    VerifyText                  The promotion was created successfully. The deployment validation will start in a few seconds.                  timeout=120s
    VerifyText                  Starting deployment         timeout=120s
    Run Keyword If              '${RESULT}'=='Validation failed'                        Validation failed
    VerifyNoText                Go Back to the User Story                               150s
    VerifyAll                   Plan, Build, Test, Deliver, Related
    ClickText                   Deliver
    VerifyText                  Validation Deployment Results
    VerifyElement               ${PROMOTION_RECORD_WEBELEMENT}
    VerifyElement               ${DEPLOYMENT_RECORD_WEBELEMENT}
    ${STATUS}=                  GetText                     ${LAST_VALIDATION_STATUS_WEBELEMENT}
    ${STATUS}=                  Strip String                ${STATUS}
    Should Be Equal             ${STATUS}                   ${RESULT}
    Run Keyword If              '${STATUS}'=='Validated'    VerifyElement               ${VALIDATION_GREENFLAG_WEBELEMENT}
    ...                         ELSE                        VerifyElement               ${VALIDATION_REDFLAG_WEBELEMENT}

Validation failed
    [Documentation]             To verify the validation failed step
    VerifyText                  An unexpected error happened during the validation process. Please contact your system administrator.           timeout=120s
    ClickText                   Go Back to the User Story

Verify promption after validation
    [Documentation]             To verify promotion details through validation
    [Arguments]                 ${RESULT}
    ${PROMOTION_NAME}=          GetText                     ${PROMOTION_RECORD_WEBELEMENT}
    ClickElement                ${PROMOTION_RECORD_WEBELEMENT}
    VerifyNoText                Loading
    VerifyText                  Promotion Name
    ${EXP_PROMOTION_NAME}=      GetText                     ${PROMOTION_NAME_VALUE_WEBELEMENT}
    Should Be Equal             ${PROMOTION_NAME}           ${EXP_PROMOTION_NAME}
    ${STATUS1}=                 GetText                     ${PROMOTION_STATUS_MAIN_WEBELEMENT}
    Should Be Equal             ${STATUS1}                  ${RESULT}
    ${STATUS2}=                 GetText                     ${PROMOTION_STATUS_HEADER_WEBELEMENT}
    Should Be Equal             ${STATUS2}                  ${RESULT}

Verify deployment after validation
    [Documentation]             To verify deployment details through validation
    [Arguments]                 ${RESULT}
    VerifyAll                   Plan, Build, Test, Deliver, Related
    ClickText                   Deliver
    VerifyText                  Validation Deployment Results
    ${DEPLOYMENT_NAME}=         GetText                     ${DEPLOYMENT_RECORD_WEBELEMENT}
    ClickElement                ${DEPLOYMENT_RECORD_WEBELEMENT}
    ${TEXT_STATUS}=             Run Keyword And Return Status                           VerifyText                  Deployment Name
    Run Keyword If              '${TEXT_STATUS}'=='True'    RefreshPage
    Run Keyword If              '${TEXT_STATUS}'=='True'    VerifyText                  Deployment Name
    ${DEPLOYMENT_RECORDNAME_WEBELEMENT}=                    Replace String              ${DEPLOYMENT_RECORDNAME_WEBELEMENT}                     VARIABLE                    ${DEPLOYMENT_NAME}
    VerifyElement               ${DEPLOYMENT_RECORDNAME_WEBELEMENT}
    ${STATUS1}=                 GetText                     ${DEPLOYMENT_STATUS_WEBELEMENT}
    Should Be Equal             ${STATUS1}                  ${RESULT}
    ${STATUS2}=                 GetText                     ${DEPLOYMENT_STATUSHEADER_WEBELEMENT}
    Should Be Equal             ${STATUS2}                  ${RESULT}
    ClickElement                ${VIEW_RESULTS_WEBELEMENT}
    VerifyNoText                Loading
    Run Keyword If              '${RESULT}'=='Completed Successfully'                   VerifyText                  No step results found
    ...                         ELSE IF                     '${RESULT}'=='Completed with Errors'                    VerifyText                  ERROR

Select Base Branch
    [Documentation]             Select base branch for the User Story as per argument
    [Arguments]                 ${BRANCH}
    Select option under US show more actions                Select Base Branch
    VerifyText                  Select a Branch
    ClickText                   Select Filter
    ClickText                   Select All
    ClickElement                ${GIT_BRANCH_OPTION_WEBELEMENT}
    ClickText                   Type
    TypeText                    ${TYPE_NAME_IN_US_WEBLEMENT}                            ${BRANCH}
    ${SEARCHED_BRANCH}=         Replace String              ${SEARCHED_RESULT_WEBELEMENT}                           ARGUMENT                    ${BRANCH}
    Sleep                       2s                          #Wait to get the searched result
    ClickElement                ${SEARCHED_BRANCH}

Enable Ready to Promote
    [Documentation]             Enable "Ready to Promote" in the User Story
    ClickText                   Deliver
    ClickText                   Edit Ready to Promote
    ClickElement                ${READYTOPROMOTE_CHECKBOX_WEBELEMENT}
    ClickText                   Save

Get user story title
    [Documentation]             To get the user story title when the user story is opened
    VerifyAll                   Plan, Related
    ${TITLE}=                   GetText                     ${TITLE_INPUT_WEBELEMENT}
    Should Not Be Empty         ${TITLE}                    msg=The Title field should not be empty
    [Return]                    ${TITLE}

Verify Select Base Branch Link Fields
    [Documentation]             It helps to verify the link fields value
    [Arguments]                 ${FIELD_NAME}               ${FIELD_VALUE}
    ${SEL_BASE_BRANCH_VALIDATION_LINK_WEBELEMENT}=          Replace String              ${SEL_BASE_BRANCH_VALIDATION_LINK_WEBELEMENT}           FIELD_NAME                  ${FIELD_NAME}
    ${SEL_BASE_BRANCH_VALIDATION_LINK_WEBELEMENT}=          Replace String              ${SEL_BASE_BRANCH_VALIDATION_LINK_WEBELEMENT}           FIELD_VALUE                 ${FIELD_VALUE}
    VerifyElement               ${SEL_BASE_BRANCH_VALIDATION_LINK_WEBELEMENT}

Verify Select Base Branch Span Fields
    [Documentation]             It helps to verify the span fields value
    [Arguments]                 ${FIELD_NAME}               ${FIELD_VALUE}
    ${SEL_BASE_BRANCH_VALIDATION_SPAN_WEBELEMENT}=          Replace String              ${SEL_BASE_BRANCH_VALIDATION_SPAN_WEBELEMENT}           FIELD_NAME                  ${FIELD_NAME}
    ${SEL_BASE_BRANCH_VALIDATION_SPAN_WEBELEMENT}=          Replace String              ${SEL_BASE_BRANCH_VALIDATION_SPAN_WEBELEMENT}           FIELD_VALUE                 ${FIELD_VALUE}
    VerifyElement               ${SEL_BASE_BRANCH_VALIDATION_SPAN_WEBELEMENT}

Refresh Branch Index
    [Documentation]             It helps to refresh the branch index on select base branch page
    ClickElement                ${SEL_BASE_BRANCH_REFRESH_BRANCH_INDEX_WEBELEMENT}
    VerifyElement               ${SEL_BASE_BRANCH_REFRESH_BRANCH_INDEX_WEBELEMENT}

Verify select a branch table columns
    [Documentation]             To verify the columns name of select a branch table
    [Arguments]                 ${EXPECTED_OPTIONS}
    ${LENGTH}=                  Get Length                  ${EXPECTED_OPTIONS}
    FOR                         ${COL_NUM}                  IN RANGE                    0                           ${LENGTH}
        ${EXPECTED}=            Get From List               ${EXPECTED_OPTIONS}         ${COL_NUM}
        ${SELECT_BRANCH_TABLE_COLUMNS_WEBELEMENT}=          Replace String              ${METADATA_TABLE_COLUMNS_WEBELEMENT}                    COLUMN_NAME                 ${EXPECTED}
        VerifyElement           ${SELECT_BRANCH_TABLE_COLUMNS_WEBELEMENT}
    END

Update select base branch on commit page
    [Documentation]             It will help to update the base branch on commit page
    [Arguments]                 ${BRANCH}
    ${STATUS}=                  GetElementCount             ${CLEAR_SELECTED_BASE_BRANCH_WEBELEMENT}
    Run Keyword If              ${STATUS}>0                 ClickElement                ${CLEAR_SELECTED_BASE_BRANCH_WEBELEMENT}
    TypeText                    Select Base Branch          ${BRANCH}
    ${SELECT_BASE_BRANCH_LINK_WEBELEMENT}=                  Replace String              ${SELECT_BASE_BRANCH_LINK_WEBELEMENT}                   BRANCH                      ${BRANCH}
    ClickElement                ${SELECT_BASE_BRANCH_LINK_WEBELEMENT}
    VerifyText                  ${BRANCH}
    ClickText                   Apply

Update select base branch from inline edit
    [Documentation]             It will help to update the base branch using inline edit
    [Arguments]                 ${BRANCH}
    ClickText                   Edit Base Branch
    TypeText                    ${SELECT_BASE_BRANCH_INLINE_WEBELEMENT}                 ${BRANCH}
    ClickText                   Save                        anchor=Cancel

Create Promotion Record 
    [Documentation]             To create promotion record after the promote and deploy using SFDX pipeline
    ...                         Author: Ram Naidu Saragadam
    ...                         Date :                      9th November, 2021
    [Arguments]                 ${PROJECT_NAME}             ${IS_BACKPROMOTION}         ${ENVIRONMENT}
    Open Object                 Promotions
    VerifyAll                   Promotions, New
    ClickText                   New
    VerifyAll                   New Promotion, Draft, Release, Project, Source Environment
    VerifyAll                   Save, Cancel
    RunKeywordIf                '${IS_BACKPROMOTION}'=='TRUE'                           ClickText                   Is Back-Promotion
    sleep                       5s
    TypeText                    Project                     ${PROJECT_NAME}
    RunKeywordIf                '${IS_BACKPROMOTION}'=='TRUE'                           TypeText                    Destination Environment     ${ENVIRONMENT}
    ...                         ELSE                        TypeText                    Source Environment          ${ENVIRONMENT}
    ClickText                   Save
    VerifyAll                   Details, User Stories, Project, SFDX, ${PROJECT_NAME}, Merge Changes, Merge & Deploy
    ${PROMOTION_ID}             GetText                     ${PROMOTION_ID_WEBELEMENT}
    [Return]                    ${PROMOTION_ID}

Merge And Deploy Promoted MC User Stories
    [Documentation]             To add user stories in the promoted USs and perform merge & deploy
    ...                         Author : Ram Naidu Saragadam
    ...                         Date : 10th November, 2021
    [Arguments]                 ${USERSTORIES}
    Add User Stories to Promotion Record                    ${USERSTORIES}
    ClickText                   Merge & Deploy Changes
    VerifyText                  You are about to merge the changes included in this promotion and deploy them to the destination environment.
    VerifyText                  All the promotion and deployment execution steps will run. You can keep track of the progress in the Promotion record.
    VerifyAll                   Merge and Deploy, Cancel
    ClickText                   Merge and Deploy            anchor=Cancel
    VerifyNoText                Loading

Verify MC User Story Promotion
    [Documentation]             To verify the user story movement to next environment in user story Page
    ...                         Author: Shweta B
    ...                         Date: 9th November 2021
    [Arguments]                 ${DESTINATION_ENVIRONMENT}
    #To verify the source environment updated in the userstory page. UserStory must be loaded.
    RefreshPage
    VerifyAll                   Plan, Build, Test, Deliver, Related
    ClickText                   Build
    VerifyText                  Credential
    ${CREDENTIAL_VALUE}=        GetText                     ${CREDENTIAL_VALUE_WEBELEMENT}
    Should Be Equal             ${CREDENTIAL_VALUE}         ${DESTINATION_ENVIRONMENT}
    VerifyText                  Environment
    ${ENVIRONMENT_VALUE}=       GetText                     ${ENVIRONMENT_VALUE_WEBELEMENT}
    Should Be Equal             ${ENVIRONMENT_VALUE}        ${DESTINATION_ENVIRONMENT}

Verify MC User Story Back Promotion
    [Documentation]             To verify if the user story has been backpromoted
    ...                         Author: Shweta B
    ...                         Date: 10th November 2021
    [Arguments]                 ${US_ID}
    #To verify back promotion in the userstory page. UserStory must be loaded.
    RefreshPage
    VerifyAll                   Plan, Build, Test, Deliver, Related
    ClickText                   Deliver
    ScrollTo                    User Story Promotions
    VerifyText                  Back Promoted
    ClickText                   Back Promoted
    VerifyText                  Back Promoted User Story: ${US_ID}                      anchor=Promoted User Story Name

MC Merge Changes And Verify Promotion
    [Documentation]             To click on Merge changes and verify the promote job is successful
    ...                         Author: Dhanesh
    ...                         Date:                       15 NOV 2021
    VerifyText                  Merge Changes
    ClickText                   Merge Changes
    VerifyText                  You are about to merge the changes included in this promotion.                      anchor=Merge Changes
    SetConfig                   PartialMatch                False
    ClickText                   Merge                       anchor=Cancel
    SetConfig                   PartialMatch                True
    VerifyNoText                Loading
    VerifyNoText                You are about to merge the changes included in this promotion.                      anchor=Merge Changes
    RefreshPage
    VerifyText                  Merge Changes
    VerifyElementText           ${STATUS_FIELD_WEBELEMENT}                              In Progress
    Verify Promotion
    RefreshPage
    VerifyText                  Merge Changes

Verify Promotion
    [Documentation]             To verify the MC promotion function execution
    ...                         Author: Dhanesh
    ...                         Date:                       3 DEC 2021
    VerifyText                  SFDX Promote
    ${COMPLETED_STATUS}=        Replace String              ${JOB_COMPLETED_WEBELEMENT}                             {JOB}                       Promote
    VerifyElementText           ${COMPLETED_STATUS}         Completed                   timeout=600s                reason=To wait until the job executions to get completed
    VerifyText                  Step result:

MC Deploy Changes And Verify Deployment
    [Documentation]             To click on deploy changes and verify the Deployment job is successful
    ...                         Author: Dhanesh
    ...                         Date:                       15 NOV 2021
    VerifyText                  Deploy Changes
    ClickText                   Deploy Changes
    VerifyText                  You are about to deploy the changes included in this promotion to the destination environment.
    SetConfig                   PartialMatch                False
    ClickText                   Deploy                      anchor=Cancel
    SetConfig                   PartialMatch                True
    VerifyNoText                Loading
    VerifyNoText                You are about to deploy the changes included in this promotion to the destination environment.
    RefreshPage
    VerifyText                  Deploy Changes
    VerifyElementText           ${STATUS_FIELD_WEBELEMENT}                              In Progress
    VerifyText                  SFDX Deploy
    ${COMPLETED_STATUS1}=       Replace String              ${JOB_COMPLETED_WEBELEMENT}                             {JOB}                       Encode file names
    VerifyElementText           ${COMPLETED_STATUS1}        Completed                   timeout=600s                reason=To wait until the job executions to get completed
    VerifyText                  Step result:
    ${COMPLETED_STATUS2}=       Replace String              ${JOB_COMPLETED_WEBELEMENT}                             {JOB}                       Deploy
    VerifyElementText           ${COMPLETED_STATUS2}        Completed                   timeout=600s                reason=To wait until the job executions to get completed
    VerifyText                  Step result:
    RefreshPage
    VerifyText                  Deploy Changes
    RefreshPage
    VerifyText                  Deploy Changes
    VerifyElementText           ${STATUS_FIELD_WEBELEMENT}                              Completed

Add User Stories To Promotion Record
    [Documentation]             To add user stories in the promoted USs and perform merge & deploy
    ...                         Author : Ram Naidu Saragadam
    ...                         Date : 15th November, 2021
    [Arguments]                 ${USERSTORIES}
    ${NO_OF_USERSTORIES}=       Get Length                  ${USERSTORIES}
    ClickText                   User Stories                anchor=Details
    VerifyAll                   Promoted User Stories, Add User Stories
    ClickText                   Add User Stories
    VerifyAll                   User Story Reference, Title, Status, Cancel, Save
    FOR                         ${US_NUMBER}                IN RANGE                    0                           ${NO_OF_USERSTORIES}
        ${CURRENT_US_NUM}=      Get From List               ${USERSTORIES}              ${US_NUMBER}
        #TypeText               Search this list...         ${CURRENT_US_NUM}
        ${CHECK_US}=            Replace String              ${USCHECKBOX_WEBELEMENT}    USERSTORY                   ${CURRENT_US_NUM}
        ClickElement            ${CHECK_US}
    END
    ClickText                   Save
    VerifyText                  User stories added to this promotion successfully.

MC Merge And Deploy changes
    [Documentation]             To click and perform merge and deploy changes in MC Promotion page
    ...                         Author: Dhanesh
    ...                         Date. : 18 Nov 2021
    VerifyText                  Merge & Deploy Changes
    ClickText                   Merge & Deploy Changes
    VerifyText                  You are about to merge the changes included in this promotion and deploy them to the destination environment.
    VerifyText                  All the promotion and deployment execution steps will run. You can keep track of the progress in the Promotion record.
    VerifyAll                   Merge and Deploy, Cancel
    ClickText                   Merge and Deploy            anchor=Cancel
    VerifyNoText                Loading

Create Empty User Story
    [Documentation]             Create empty User Story (of User Story record type) and return the ID/Reference
    ...                         Author :Manav Parasrampuria
    ...                         Date : 18th November, 2021
    ClickText                   New
    VerifyText                  New User Story
    ClickText                   User Story
    ClickText                   Next
    VerifyText                  New User Story
    ${US_NAME}=                 Generate random name
    TypeText                    ${US_TITLE_TEXTBOX_WEBELEMENT}                          ${US_NAME}
    ClickText                   Save                        2
    VerifyText                  Plan
    VerifyText                  ${US_NAME}                  anchor=User Story Reference
    ${US_ID}=                   GetText                     ${USID_WEBELEMENT}
    [Return]                    ${US_ID}

Create Deployment Steps
    [Documentation]             To create new job step from the user story Deployment Steps
    ...                         Author: Dhanesh
    ...                         Date                        : 1st DEC 2021
    [Arguments]                 ${NAME}                     ${TYPE}                     ${EXECUTION_SEQUENCE}       ${FUNCTION_NAME}            ${ISPARAM}                  ${PARAMETERS}    ${VALUES}
    #Name: Name of the job step, TYPE: job step type, EXECUTION_SEQUENCE: before or after, FUNCTION_NAME: Name of the function else pass NIL/FALSE if the TYPE is not function
    #ISPARAM: Pass TRUE if the function contains Function Execution Parameters else pass FALSE
    #PARAMETERS: Function execution parameters - List type variable
    #VALUES: Function execution parameter values - List type variable
    ClickText                   Build
    VerifyText                  Deployment Steps
    ClickElement                ${DEPLOYMENT_STEPS_NEW_WEBELEMENT}
    VerifyText                  Add New Step
    Enter Input Field           Name                        ${NAME}
    ClickElement                ${JOB_TYPE_WEBELEMENT}
    VerifyText                  ${TYPE}
    ClickText                   ${TYPE}
    VerifyNoText                Loading
    ClickElement                ${EXECUTION_SEQUENCE_WEBELEMENT}
    VerifyText                  ${EXECUTION_SEQUENCE}
    ClickText                   ${EXECUTION_SEQUENCE}
    IF                          "${TYPE}" == "Manual Task"
        VerifyText              Manual Task Configuration
        ${TASK_DESCRIPTION}=    Generate random name
        TypeText                Task Description            ${TASK_DESCRIPTION}
        ClickText               Save                        anchor=Cancel
        VerifyText              Success
        Return From Keyword     ${TASK_DESCRIPTION}
    ELSE IF                     "${TYPE}" == "Function"
        VerifyText              Function Configuration
        ClickElement            ${FUNCTION_INPUT_WEBELEMENT}
        TypeText                ${FUNCTION_INPUT_WEBELEMENT}                            ${FUNCTION_NAME}            click=True
        ClickElement            ${FUNCTION_INPUT_WEBELEMENT}
        ${CONFIGURATION}=       Replace String              ${FUNCTION_CONFIGURATION_WEBELEMENT}                    NAME                        ${FUNCTION_NAME}
        ClickElement            ${CONFIGURATION}
        IF                      "${ISPARAM}" == "TRUE"
            VerifyAll           ${PARAMETERS}
            ${COUNT}=           Get Length                  ${PARAMETERS}
            FOR                 ${I}                        IN RANGE                    0                           ${COUNT}
                ${PARAMETER}=                               Get From List               ${PARAMETERS}               ${I}
                ${VALUE}=       Get From List               ${VALUES}                   ${I}
                VerifyText      ${PARAMETER}
                Enter Input Field                           ${PARAMETER}                ${VALUE}
            END
        END
    END
    ClickText                   Save                        anchor=Cancel
    VerifyText                  Success

Drag Job Steps And Verify Job Name in Order Page
    [Documentation]             To reorder the deployment job steps by dragging and verifying the same
    ...                         Author: Shweta
    ...                         Date: 2nd DEC, 2021
    [Arguments]                 ${SEQUENCE}                 ${FROM_STEP_NUMBER}         ${TO_STEP_NUMBER}           ${CURRENT_FROM}
    # SEQUENCE - Provide input as BD or AD for BeforeDeployment or After Deployment
    # FROM_STEP_NUMBER - Provide the step from where the value must be dragged, starting number with 0
    # TO_STEP_NUMBER - Provide the step to where the value must be dropped, starting number with 0
    # CURRENT_FROM - Provide the name of step which has to be dragged
    IF                          '${SEQUENCE}' == 'BD'
        ${TOSTEP}               Replace String              ${ROW_DRAGELEMENT_BD_WEBELEMENT}                        NUM                         ${TO_STEP_NUMBER}
        ${FROMSTEP}             Replace String              ${ROW_DRAGELEMENT_BD_WEBELEMENT}                        NUM                         ${FROM_STEP_NUMBER}
        DragDrop                ${FROMSTEP}                 ${TOSTEP}
        ${CURR_VALUE}           Replace String              ${ROW_TEXT_BD_WEBELEMENT}                               NUM                         ${TO_STEP_NUMBER}
        ${CURRVALUE}=           Get Text                    ${CURR_VALUE}
        Should Be Equal         ${CURRVALUE}                ${CURRENT_FROM}
    ELSE IF                     '${SEQUENCE}' == 'AD'
        ${TOSTEP}               Replace String              ${ROW_DRAGELEMENT_AD_WEBELEMENT}                        NUM                         ${TO_STEP_NUMBER}
        ${FROMSTEP}             Replace String              ${ROW_DRAGELEMENT_AD_WEBELEMENT}                        NUM                         ${FROM_STEP_NUMBER}
        DragDrop                ${FROMSTEP}                 ${TOSTEP}
        ${CURR_VALUE}           Replace String              ${ROW_TEXT_AD_WEBELEMENT}                               NUM                         ${TO_STEP_NUMBER}
        ${CURRVALUE}=           Get Text                    ${CURR_VALUE}
        Should Be Equal         ${CURRVALUE}                ${CURRENT_FROM}
    END
    ClickText                   Save
    VerifyText                  Steps saved successfully.

Verify Job Name And Types In Order Page
    [Documentation]             To verify the jobname with it type in Order Page
    ...                         Author: Shweta
    ...                         Date: 3rd DEC, 2021
    [Arguments]                 ${JOBSTEPS_DICTIONARY}
    # JOBSTEPS_DICTIONARY - Provide values in a key(job step name) , value(job step type) pair. Ex: ${JOBSTEPS_DICTIONARY}= Create Dictionary StepA=Manual StepB=Function
    FOR                         ${KEY}                      IN                          @{JOBSTEPS_DICTIONARY}
        ${VALUE1}=              Get From Dictionary         ${JOBSTEPS_DICTIONARY}      ${KEY}
        ${JOBNAME}              Replace String              ${JOBSTEPNAME_WEBELEMENT}                               VALUE                       ${VALUE1}
        ${KEY_NAME}             Get Text                    ${JOBNAME}
        ${VALTYPE}              Replace String              ${JOBSTEPTYPE_WEBELEMENT}                               KEY                         ${KEY}
        ${VALUE_NAME}           Get Text                    ${VALTYPE}
        VerifyElement           ${JOBNAME}
        VerifyElement           ${VALTYPE}
    END

Retrieve Job Step Details Against Job Order
    [Documentation]             To Verify Job Details Against Order of the step
    ...                         Author: Shweta
    ...                         Date: 7th DEC, 2021
    [Arguments]                 ${STEP_NUMBER}              @{JOB_DETAILS_LIST}
    #${STEP_NUMBER} - Provide the step number for which the details has to be verified. Ex: 1
    #@{JOB_DETAILS_LIST} - Create a list of Jobname, jobtype and jobsequence in the same order to be verified. Ex: @{JOB_DETAILS_LIST} Create List JOBA ManualTask before
    ${DEPSTEP_NAME_ROW_WEBELEMENT}                          Replace String              ${DEPSTEP_NAME_ROW_WEBELEMENT}                          ROWNUM                      ${STEP_NUMBER}
    ${JOBSTEP_NAME}             Get Text                    ${DEPSTEP_NAME_ROW_WEBELEMENT}
    ${DEPSTEP_TYPE_ROW_WEBELEMENT}                          Replace String              ${DEPSTEP_TYPE_ROW_WEBELEMENT}                          ROWNUM                      ${STEP_NUMBER}
    ${JOBSTEP_TYPE}             Get Text                    ${DEPSTEP_TYPE_ROW_WEBELEMENT}
    ${DEPSTEP_SEQUENCE_ROW_WEBELEMENT}                      Replace String              ${DEPSTEP_SEQUENCE_ROW_WEBELEMENT}                      ROWNUM                      ${STEP_NUMBER}
    ${JOBSTEP_SEQUENCE}         Get Text                    ${DEPSTEP_SEQUENCE_ROW_WEBELEMENT}
    Should Be Equal             ${JOBSTEP_NAME}             ${JOB_DETAILS_LIST[0]}
    Should Be Equal             ${JOBSTEP_TYPE}             ${JOB_DETAILS_LIST[1]}
    Should Be Equal             ${JOBSTEP_SEQUENCE}         ${JOB_DETAILS_LIST[2]}

Perform Actions On Deployment Job Steps
    [Documentation]             To Perform Actions On Deploymemnt Job Steps
    ...                         Author: Shweta
    ...                         Date: 8th DEC, 2021
    [Arguments]                 ${ACTION}                   ${DEPJOBSTEP_DICTIONARY}
    #${ACTION} - Provide the action. Ex: Edit
    #${DEPJOBSTEP_DICTIONARY} - Provide key[step order] and value[step name]. Ex:${DEPJOBSTEP_DICTIONARY} Create Dictionary 1=JobName1 2=jobname2
    FOR                         ${KEY}                      IN                          @{DEPJOBSTEP_DICTIONARY}
        ${VALUE}=               Get From Dictionary         ${DEPJOBSTEP_DICTIONARY}    ${KEY}
        ${DEPSTEP_NAME_ROW_WEBELEMENT}                      Replace String              ${DEPSTEP_NAME_ROW_WEBELEMENT}                          ROWNUM                      ${KEY}
        ${JOBSTEP_NAME}         Get Text                    ${DEPSTEP_NAME_ROW_WEBELEMENT}
        Should Be Equal         ${JOBSTEP_NAME}             ${VALUE}
        ${DEPSTEP_ACTIONCLICK_WEBELEMENT}                   Replace String              ${DEPSTEP_ACTIONCLICK_WEBELEMENT}                       ROWNUM                      ${KEY}
        ClickElement            ${DEPSTEP_ACTIONCLICK_WEBELEMENT}
        ${DEPSTEP_ACTION_WEBELEMENT}                        Replace String              ${DEPSTEP_ACTION_WEBELEMENT}                            ROWNUM                      ${KEY}
        ${ACTION_ELEMENT}       Replace String              ${DEPSTEP_ACTION_WEBELEMENT}                            ACTION                      ${ACTION}
        ClickElement            ${ACTION_ELEMENT}
    END

Add Metadata
    [Arguments]                 ${METADATA}
    [Documentation]             Open "Add Metadata" and select & save the metadata as per argument, metadata example- Custom label/object/Permission Set
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 15th DEC, 2021
    #Opening Add Metadata paFge
    Select option under US show more actions                Add Metadata
    VerifyText                  Metadata selector
    VerifyText                  Refresh Metadata Index
    #Refreshing Metadata
    ClickText                   Refresh Metadata Index
    Sleep                       3s
    VerifyNoText                Hide message                320s                        #Wait until the refresh window disappears
    #Selecting and Saving Metadata
    Select metadata             ${METADATA}
    ClickElement                ${ADD_METADATA_SAVE_BUTTON_WEBELEMENT}

Get Feature Branch Name
    [Documentation]             To get the feature branch name from the user story
    ...                         Author: Dhanesh
    ...                         Date: 13th Jan, 2022
    VerifyText                  Build
    ClickText                   Build
    VerifyText                  View in Git                 anchor=Information
    ${BRANCH_NAME}=             GetText                     ${GIT_BRANCH_WEBELEMENT}
    Should Not Be Empty         ${BRANCH_NAME}              msg=The Git branch field should not be empty
    [Return]                    ${BRANCH_NAME}

MC Metadata validation in UserStory
    [Documentation]             To Verify Metadata Validation in UserStoryBuild
    ...                         Author: Shweta
    ...                         Date: 7th feb, 2022
    [Arguments]                 ${METADATA_LIST}
    ClickText                   Build
    ScrollTo                    ${USERSTORY_METADATA_SECTION_WEBELEMENT}
    ClickElement                ${USERSTORY_METADATA_SECTION_WEBELEMENT}
    VerifyNoText                Loading
    VerifyText                  File Name
    ${LENGTH}=                  Get Length                  ${METADATA_LIST}
    FOR                         ${I}                        IN RANGE                    0                           ${LENGTH}
        ${METADATA_NAME}=       Get From List               ${METADATA_LIST}            ${I}
        ${METADATA_ELEMENT}=    Replace String              ${USERSTORY_COMMITED_METADATA_WEBELEMENT}               METADATANAME                ${METADATA_NAME}
        VerifyElement           ${METADATA_ELEMENT}
    END

Verify Has Apex Code Status
    [Documentation]            Selects any Test ApexClass and Click on Save Button
    ...                        Author: Sachin Talwaria
    ...                        Date: 22nd Feb, 2022
    [Arguments]                 ${EXPECTED_STATUS}
    ${ACTUAL_STATUS}=                              GetAttribute                ${HAS_APEX_CODE_WEBELEMENT}                       checked
    Should Be Equal                        ${ACTUAL_STATUS}                    ${EXPECTED_STATUS}                        msg=Assertion Failed: Has Apex status checbkox mismatched.

Modify User Story Status
    [Documentation]            To modify the status of user story
    ...                        Author: Shweta B
    ...                        Date: 15th Mar, 2022
    [Arguments]                 ${US_ID}    ${EXPECTED_STATUS}
    Open Object                 User Stories
    Open record from object main page                       ${US_ID}
    ClickText                   Edit                        anchor=Open Org
    SwitchWindow                NEW                 
    ClickElement                ${STATUS_WEBELEMENT}
    ClickText                   ${EXPECTED_STATUS}                 anchor=--None--
    ClickText                   Save                        2
    VerifyText                  ${EXPECTED_STATUS}                 anchor=Status

Create Function Deployment Task From User Story
    [Documentation]            create Deployment task of a given type from user story
    ...                        Author : Ram Naidu; 14th April, 2022
    [Arguments]                ${DEPLOYMENT_TASK_NAME}    ${FUNCTION_NAME}    
    ClickText                  Build
    ScrollTo                   User Story Selected Metadata
    ScrollTo                   Deployment Tasks
    VerifyAll                  User Story Selected Metadata, Deployment Tasks, User Story Commits
    ClickText                  New    anchor=Deployment Tasks
    VerifyAll                  * Deployment Tasks Name, * Type, * User Story, Perform Deployment Task, Save, Cancel
    TypeText                   * Deployment Tasks Name    ${DEPLOYMENT_TASK_NAME}   
    DropDown                    Manual Task                    Function
    VerifyText                 * Select Function
    TypeText                   jsFunction                      ${FUNCTION_NAME}                      
    ExecuteJavascript          document.getElementById('jsFunction_lkwgt').click()
    SwitchWindow               NEW
    ClickText                  Automation_
    SwitchWindow               1
    ClickText                  Save                        anchor=Cancel
    VerifyAll                  ${DEPLOYMENT_TASK_NAME}, ${FUNCTION_NAME}, Detail, Task Details