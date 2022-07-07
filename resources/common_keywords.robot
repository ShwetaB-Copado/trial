*** Settings ***
Documentation                   Contains common keywords required for the automation
Library                         String
Library                         QWeb
Library                         QForce
Library                         Collections
Library                         DateTime
Library                         ../CommonUtilities/Commonutils.py
Library                         ../CommonUtilities/SFoauth.py
Library                         ../CommonUtilities/DeleteSFObject.py
Resource                        variables.robot
Resource                        common_elements.robot
Resource                        ../CommonUtilities/delete_objects.robot
Resource                        ../CommonUtilities/objects_list.robot
Resource                        ../CommonUtilities/github_keywords.robot
Resource                        ../CommonUtilities/packages_keywords.robot

*** Keywords ***
Switch To Lightning
    [Documentation]             Switch to lightning if classic view opened
    ${CLASSIC_VIEW}=            RunKeywordAndReturnStatus                               VerifyText                  Switch to Lightning Experience    timeout=2
    RunKeywordIf                ${CLASSIC_VIEW}             ClickText                   Switch to Lightning Experience

Start Suite
    [Documentation]             Setup browser and open Salesforce ORG
    #SearchMode- To get the blue box as visualization on the screen while element interaction
    #MultipleAnchors- Automation will not give an error if it finds multiple similar anchors, but tries to find/click the text as per anchor.
    #DefaultTimeout- Automation will try to perform an action until 25s, affecting all keywords
    #[Arguments]                 ${loginUrl}
    #Set libraries order
    Set Library Search Order    QWeb                        QForce

    SetConfig                   SearchMode                  draw
    SetConfig                   MultipleAnchors             True
    SetConfig                   DefaultTimeout              25
    Evaluate                    random.seed()               random

    #Steps for test suite setup
    #Open Browser                ${LOGIN_URL}                ${BROWSER}
    ${login_Url}=               Get Variable Value             '${loginUrl}'   NoValuePassed 
    IF                        '${login_Url}' != 'NoValuePassed'
        Open Browser                ${loginUrl}                ${BROWSER}
        #TypeText                    Username                    ${ORG_USERNAME}
        #TypeSecret                  Password                    ${ORG_PASSWORD}
    ELSE
        Open Browser                ${LOGIN_URL}                ${BROWSER}
        TypeText                    Username                    ${ORG_USERNAME}
        TypeSecret                  Password                    ${ORG_PASSWORD}
        ClickText                   Log In
    END
    

    #Switch to lightning if classic view opened and verify logged-in succesfully
    Switch To Lightning
    VerifyAny                   Home, User

Login for Permissions
    [Documentation]             Setup browser and open Salesforce ORG for Permissions
    [Arguments]                 ${USERNAME}

    #Set libraries order
    Set Library Search Order    QWeb                        QForce

    SetConfig                   SearchMode                  draw
    SetConfig                   MultipleAnchors             True
    SetConfig                   DefaultTimeout              25
    Evaluate                    random.seed()               random

    #Steps for test suite setup
    Open Browser                ${LOGIN_URL}                ${BROWSER}
    TypeText                    Username                    ${USERNAME}
    TypeSecret                  Password                    ${ORG_PASSWORD}
    ClickText                   Log In

    #Switch to lightning if classic view opened and verify logged-in succesfully
    Switch To Lightning
    VerifyAny                   Home, User

End Suite
    [Documentation]             Logout from Salesofrce ORG and Close browser
    #Steps related to test suite teardown- logout and close the browser after the test suite completion
    ${GET_CURRENT_URL}=         GetUrl
    ${LOGOUT_URL}=              Evaluate                    "https://" + '${GET_CURRENT_URL}'.split('/')[2] + "/secur/logout.jsp"
    GoTo                        ${LOGOUT_URL}               #Logout
    Close All Browsers

Open Object
    [Documentation]             Open Object
    [Arguments]                 ${OBJECT}
    #Open App launcher, type and click object
    ClickText                   App Launcher
    VerifyText                  ${APPS_WEBELEMENT}
    TypeText                    ${SEARCH_APPS_WEBELEMENT}                               ${OBJECT}
    ${OBJECT_XPATH}=            Replace String              ${OBJECT_WEBELEMENT}        OBJECT                      ${OBJECT}
    ClickElement                ${OBJECT_XPATH}
    #Refresh and verify object, except for "Work Manager" and "Pipeline Manager" as it works differently
    Run Keyword If              '${OBJECT}' != 'Work Manager' and '${OBJECT}' != 'Pipeline Manager'                 Check object      ${OBJECT}

Check object
    [Documentation]             Check the object/tab name
    [Arguments]                 ${OBJECT}
    RefreshPage
    VerifyPageHeader            ${OBJECT}

Open Show more actions on Details page
    [Documentation]             Click Show more action button if exists
    ${SHOW_MORE_ACTIONS}=       RunKeywordAndReturnStatus                               VerifyText                  Show more actions    timeout=2s
    RunKeywordIf                ${SHOW_MORE_ACTIONS}        ClickText                   Show more actions

Open Show Actions
    [Documentation]             Click Show Actions button as per position, e.g related tab
    [Arguments]                 ${POSITION}
    VerifyNoText                Loading
    ClickText                   Show Actions                ${POSITION}
    Sleep                       2                           #Handle loading issue

Delete and verify
    [Documentation]             Click Delete Button, Confirm and Verify
    VerifyText                  Delete
    ClickText                   Delete
    ClickText                   Delete
    VerifyText                  was deleted

Delete record from object details page
    [Documentation]             Delete the record by clicking delete button available on the object details page
    VerifyNoText                Loading
    #Click show more actions button
    ClickText                   Show more actions
    #Delete record
    Delete and verify

Delete record from object main page
    [Documentation]             Delete the record on the object main page
    [Arguments]                 ${RECORD}
    #Search record
    Search record on object main page                       ${RECORD}
    Open Show Actions           1
    #Delete record
    Delete and verify

Delete Record from related tab
    [Documentation]             Delete the record from related tab by clicking Show Actions button as per position
    [Arguments]                 ${POSITION}
    Open Show Actions           ${POSITION}
    Delete and verify

Delete record from Object
    [Documentation]             Delete the record from object
    [Arguments]                 ${OBJECT}                   ${RECORD}
    Open Object                 ${OBJECT}
    Delete record from object main page                     ${RECORD}

Update record
    [Documentation]             Update the data for record
    [Arguments]                 ${FIELD}
    ${FIELD_TO_UPDATE}=         Evaluate                    "Edit " + "${FIELD}"
    ClickText                   ${FIELD_TO_UPDATE}
    ${NEW_TEXT}=                Generate random name
    TypeText                    ${FIELD}                    ${NEW_TEXT}
    ClickText                   Save
    VerifyText                  ${NEW_TEXT}

Generate random name
    [Documentation]             Generate random name and return
    ${RANDOM_STRING1}=          Generate Random String
    ${RANDOM_STRING2}=          Generate Random String      6                           [NUMBERS]
    ${NAME}=                    Evaluate                    "Automation_" + "${RANDOM_STRING1}" + "${RANDOM_STRING2}"                 #Using random string twice to avoid duplicate name
    [Return]                    ${NAME}

Get Username
    [Documentation]             Return Username of the ORG
    ClickText                   View profile
    VerifyText                  Settings                    #To check drop-down opened
    ${USER}=                    GetText                     ${USER_WEBELEMENT}
    ClickText                   View profile
    [Return]                    ${USER}

Search record on object main page
    [Documentation]             Search record on object main page
    [Arguments]                 ${RECORD}
    Run Keyword And Ignore Error                            ClickText                   Select a List View
    ${ISPRESENT}=               Run Keyword And Return Status                           VerifyText                  All               timeout=5s
    Run Keyword If              ${ISPRESENT}                ClickText                   All
    Run Keyword And Ignore Error                            ClickText                   ALL Env                     timeout=2s
    VerifyNoText                Loading
    PressKey                    Search this list...         ${RECORD}
    VerifyNoText                Loading
    ClickElement                ${REFRESH_BUTTON_WEBELEMENT}
    VerifyNoText                Loading
    ${SEARCHED_RECORD}=         Replace String              ${SEARCHED_RECORD_WEBELEMENT}                           RECORD            ${RECORD}
    VerifyElement               ${SEARCHED_RECORD}
    VerifyNoText                No items to display

Select The List View
    [Documentation]             Search record on object main page
    ClickText                   Select a List View
    ${ALLBUTTON}=               Run Keyword And Return Status                           VerifyText                  All               timeout=5s
    Run Keyword If              ${ALLBUTTON}                ClickText                   All
    ...                         ELSE                        ClickText                   ALL Env
    ClickElement                ${REFRESH_BUTTON_WEBELEMENT}
    VerifyNoText                Loading

Clone record
    [Documentation]             Clone the record by changing the field value
    [Arguments]                 ${FIELD}                    ${ANCHOR}
    ClickText                   Show more actions
    ${CLONE_BUTTON_STATUS}=     RunKeywordAndReturnStatus                               VerifyText                  Clone             timeout=2
    RunKeywordIf                ${CLONE_BUTTON_STATUS}      ScrollText                  Clone
    ClickText                   Clone
    ${NEW_TEXT}=                Generate random name
    VerifyText                  ${ANCHOR}                   timeout=60s
    Enter Input Field           ${FIELD}                    ${NEW_TEXT}
    ClickText                   Save                        2
    VerifyText                  ${NEW_TEXT}

Select record from lookup field
    [Documentation]             Search and select the record in the lookup field
    [Arguments]                 ${FIELD}                    ${RECORD}
    PressKey                    ${FIELD}                    ${RECORD}
    VerifyText                  Show All Results
    PressKey                    ${FIELD}                    {ENTER}
    VerifyText                  ${CANCEL_BUTTON_WEBELEMENT}                             #Checking modal openend
    ${RECORD_WEBELEMENT}=       Replace String              ${SELECT_RECORD_WEBELEMENT}                             RECORD            ${RECORD}
    ClickText                   ${RECORD_WEBELEMENT}


Open record from object main page    
    [Documentation]             To open the record like Environment/User from the object main page
    [Arguments]                 ${RECORD}
    Search record on object main page                       ${RECORD}
    ClickText                   ${RECORD}
    Sleep                       2s                          #To load new record page

Refresh page browser
    [Documentation]             Refresh the browser for every 6 seconds
    RefreshPage
    Sleep                       6s

Check record result until status change
    [Documentation]             Checks the Status and refresh the page until status is changed
    [Arguments]                 ${CURRENT_STATUS}
    FOR                         ${INDEX}                    IN RANGE                    0                           ${10}
        ${IS_STATUS}=           IsText                      ${CURRENT_STATUS}
        Run Keyword If          ${IS_STATUS}                Refresh page browser
        ...                     ELSE                        Exit For Loop
    END

Select value from dropdown list
    [Documentation]             Clicks the dropdown/combobox and selects the value
    [Arguments]                 ${FIELD_NAME}               ${FIELD_VALUE}              ${ANCHOR_TAG}
    ClickText                   ${FIELD_NAME}               anchor=${ANCHOR_TAG}
    ClickText                   ${FIELD_VALUE}              anchor=--None--

Check The Number Of Records
    [Documentation]             To check if any of the records are present when clicking on ALL
    ${RECORD_FOUND}=            GetElementCount             ${RECORDCOUNT_WEBELEMENT}                               timeout=2
    RunKeywordIf                ${RECORD_FOUND}<=0          VerifyText                  No items to display.

Verify File Content
    [Documentation]             To verify the content is present in the latest downloaded file
    ...                         Author: Dhanesh
    [Arguments]                 ${EXPECTED_CONTENTS}        #The argument works with strings, lists, and anything that supports Python's in operator.
    ${FILE_CONTENT}=            Get File Content
    ${LENGTH}=                  Get Length                  ${EXPECTED_CONTENTS}
    FOR                         ${I}                        IN RANGE                    0                           ${LENGTH}
        ${VALUE}=               Get From List               ${EXPECTED_CONTENTS}        ${I}
        Should Contain          ${FILE_CONTENT}             ${VALUE}                    msg=The file doesnt contain the expected content: ${VALUE}
    END

Get ContextId
    [Documentation]             To get the context id from any Object
    ...                         Author: Dhanesh
    ${CURRENT_URL}=             Get Url
    ${CONTEXT_ID}=              Evaluate                    '${CURRENT_URL}'.split('/')[6]
    [Return]                    ${CONTEXT_ID}

Enter Input Field
    [Documentation]             To enter value to any input field using xpath
    ...                         Author: Dhanesh
    [Arguments]                 ${LABEL_NAME}               ${VALUE}
    ${ELEMENT}=                 Replace String              ${INPUT_FIELD_WEBELEMENT}                               LABEL             ${LABEL_NAME}
    VerifyElement               ${ELEMENT}                  timeout=60s
    TypeText                    ${ELEMENT}                  ${VALUE}

Delete All
    [Documentation]             To delete all the created datas in the specified object
    ...                         Author: Dhanesh
    ${COUNT}=                   GetElementCount             ${SHOW_ACTIONS_WEBELEMENT}
    ${LENGTH}=                  Evaluate                    ${COUNT} + 1
    FOR                         ${I}                        IN RANGE                    1                           ${LENGTH}
        VerifyElement           ${SHOW_ACTION_WEBELEMENT}
        ClickElement            ${SHOW_ACTION_WEBELEMENT}
        SetConfig               PartialMatch                False
        VerifyText              Delete
        ClickText               Delete
        VerifyText              Delete                      anchor=Cancel
        ClickText               Delete                      anchor=Cancel
        SetConfig               PartialMatch                True
        VerifyNoText            Loading
        VerifyNoText            was deleted
    END

Delete Records Through API
    [Documentation]             To delete the object records through API calls
    ...                         Author: Dhanesh
    ...                         Date: 20 Dec 2021
    Run Keyword And Ignore Error                            Delete Source Org Object Records                        ${USER_STORIES_API}    ${USER_STORIES_FIELD}    ${PREFIX_TEXT}
    Log To Console              Deleted ${USER_STORIES_API}
    Run Keyword And Ignore Error                            Delete Source Org Object Records                        ${EPICS_API}      ${EPICS_FIELD}    ${PREFIX_TEXT}
    Log To Console              Deleted ${EPICS_API}
    Run Keyword And Ignore Error                            Delete Source Org Object Records                        ${PROJECT_API}    ${OBJECTS_NAME_FIELD}    ${PREFIX_TEXT}
    Log To Console              Deleted ${PROJECT_API}
    Run Keyword And Ignore Error                            Delete Source Org Object All Records                    ${PROMOTION_API}    ${OBJECTS_NAME_FIELD}
    Log To Console              Deleted ${PROMOTION_API}
    Run Keyword And Ignore Error                            Delete Source Org Object All Records                    ${DEPLOYMENT_API}    ${OBJECTS_NAME_FIELD}
    Log To Console              Deleted ${DEPLOYMENT_API}
    Run Keyword And Ignore Error                            Delete Source Org Object Records                        ${THEME_API}      ${OBJECTS_NAME_FIELD}    ${PREFIX_TEXT}
    Log To Console              Deleted ${THEME_API}
    Run Keyword And Ignore Error                            Delete Source Org Object Records                        ${TEAM_API}       ${OBJECTS_NAME_FIELD}    ${PREFIX_TEXT}
    Log To Console              Deleted ${TEAM_API}
    Run Keyword And Ignore Error                            Delete Source Org Object Records                        ${SPRINT_API}     ${OBJECTS_NAME_FIELD}    ${PREFIX_TEXT}
    Log To Console              Deleted ${SPRINT_API}
    Run Keyword And Ignore Error                            Delete Source Org Object All Records                    ${TESTSCRIPTS_API}    ${OBJECTS_NAME_FIELD}
    Log To Console              Deleted ${TESTSCRIPTS_API}
    Run Keyword And Ignore Error                            Delete Source Org Object All Records                    ${TESTRUN_API}    ${OBJECTS_NAME_FIELD}
    Log To Console              Deleted ${TESTRUN_API}
    Run Keyword And Ignore Error                            Delete Source Org Object Records                        ${CONNECTION_BEHAVIOUR_API}    ${OBJECTS_NAME_FIELD}    ${PREFIX_TEXT}
    Log To Console              Deleted ${CONNECTION_BEHAVIOUR_API}
    Run Keyword And Ignore Error                            Delete Source Org Object Records                        ${METADATA_GROUPS_API}    ${OBJECTS_NAME_FIELD}    ${PREFIX_TEXT}
    Log To Console              Deleted ${METADATA_GROUPS_API}
    Run Keyword And Ignore Error                            Delete Source Org Object Records                        ${PIPELINES_API}    ${OBJECTS_NAME_FIELD}    ${PREFIX_TEXT}
    Log To Console              Deleted ${PIPELINES_API}
    Run Keyword And Ignore Error                            Delete Source Org Object Records                        ${RELEASES_API}    ${OBJECTS_NAME_FIELD}    ${PREFIX_TEXT}
    Log To Console              Deleted ${RELEASES_API}
    Run Keyword And Ignore Error                            Delete Source Org Object Records                        ${FEATURES_API}    ${OBJECTS_NAME_FIELD}    ${PREFIX_TEXT}
    Log To Console              Deleted ${FEATURES_API}
    Run Keyword And Ignore Error                            Delete Source Org Object Records                        ${COMPLIANCE_RULES_API}    ${OBJECTS_NAME_FIELD}    ${PREFIX_TEXT}
    Log To Console              Deleted ${COMPLIANCE_RULES_API}
    Run Keyword And Ignore Error                            Delete Source Org Object Records                        ${COMPLIANCE_RULE_GROUP_API}    ${OBJECTS_NAME_FIELD}    ${PREFIX_TEXT}
    Log To Console              Deleted ${COMPLIANCE_RULE_GROUP_API}
    Run Keyword And Ignore Error                            Delete Source Org Object Records                        ${APPLICATIONS_API}    ${OBJECTS_NAME_FIELD}    ${PREFIX_TEXT}
    Log To Console              Deleted ${APPLICATIONS_API}
    Run Keyword And Ignore Error                            Delete Source Org Object Records                        ${FUNCTIONS_API}    ${OBJECTS_NAME_FIELD}    ${PREFIX_TEXT}
    Log To Console              Deleted ${FUNCTIONS_API}
    Run Keyword And Ignore Error                            Delete Source Org Object All Records                    ${PACKAGE_VERSION_API}    ${OBJECTS_NAME_FIELD}
    Log To Console              Deleted ${PACKAGE_VERSION_API}
    Run Keyword And Ignore Error                            Delete Source Org Object Records                        ${PACKAGES_API}    ${OBJECTS_NAME_FIELD}    ${PREFIX_TEXT}
    Log To Console              Deleted ${PACKAGES_API}
    Run Keyword And Ignore Error                            Delete Source Org Object Records                        ${TEST_API}       ${OBJECTS_NAME_FIELD}    ${PREFIX_TEXT}
    Log To Console              Deleted ${TEST_API}
    Run Keyword And Ignore Error                            Delete Source Org Object Records                        ${EXTENSION_CONFIGURATION_API}    ${OBJECTS_NAME_FIELD}    ${PREFIX_TEXT}
    Log To Console              Deleted ${EXTENSION_CONFIGURATION_API}

Clean Up And Start Suite
    [Documentation]             To clean up all the automation created object records and start the suite
    ...                         Author: Dhanesh
    ...                         Date: 20 Dec 2021
    Delete Records Through API
    Start Suite

Generate Automation Prefix String
    [Documentation]             To generate a random string with the prefix Automation
    ...                         Author: Dhanesh
    ...                         Date: 9 May 2022
    ${STRING}=                  Generate Random String      8                           UPPER
    ${RANDOM_STRING}=           Set Variable                Automation${STRING}
    [Return]                    ${RANDOM_STRING}                    

Get ID from toast message window
    [Documentation]             Returns the ID from toast message window, example: EPIC- Epic "E0000020" was created.
    ${ID}=                      GetText                     ${TOAST_MESSAGE_WEBELEMENT}                             #To get the ID from toast message window
    ${NEW_ID}=                  Evaluate                    '${ID}'.replace('\"', '')                               #To Replace the double quotation from ID String
    [Return]                    ${NEW_ID}