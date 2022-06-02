*** Settings ***
Documentation                   List of all the keywords used from the functions object
Resource                        ../common_keywords.robot
Resource                        ../webelements/functions_Webelement.robot
Resource                        ../webelements/deployments_webelements.robot
Resource                        ../../resources/objects/developer_org.robot

*** Variables ***
${EMPTY_STRING}

*** Keywords ***
Get ContextId From Deployment 
    [Documentation]             To get the context id from the deployments page to execute the functions
    ...                         Author: Dhanesh
    ClickElement                ${DEPLOYMENTPAGE_EYEICON_WEBELEMENT}
    SetConfig                   PartialMatch                False
    VerifyAll                   Step Name, Deployment
    ClickText                   Related
    VerifyText                  ${DEPLOYMENT_JOB_WEBELEMENT}
    ${DEPLOYMENT_JOB_NAME}=     GetText                     ${DEPLOYMENT_JOB_WEBELEMENT}
    ClickElement                ${DEPLOYMENT_JOB_WEBELEMENT}
    VerifyText                  ${DEPLOYMENT_JOB_NAME}      anchor=Deployment Job Name
    ${CONTEXTID}=               Get ContextId
    SetConfig                   PartialMatch                True
    [Return]                    ${CONTEXTID}

Verify Functions Details And Configuration
    [Documentation]             To verify the functions details and configurations field values according to the labels(List type) passed
    ...                         Author: Dhanesh
    [Arguments]                 ${EXPECTED_LABELS_LIST}     ${EXPECTED_VALUES}          #Arguments are of List type
    ${LENGTH}=                  Get Length                  ${EXPECTED_LABELS_LIST}
    FOR                         ${I}                        IN RANGE                    0                           ${LENGTH}
        ${LABEL}=               Get From List               ${EXPECTED_LABELS_LIST}     ${I}
        ${LABEL_ELEMENT}=       Replace String              ${LABEL_VALUE_WEBELEMENT}                               LABEL           ${LABEL}
        ${ACTUAL_VALUE}=        GetText                     ${LABEL_ELEMENT}
        ${EXPECTED_VALUE}=      Get From List               ${EXPECTED_VALUES}          ${I}
        Should Be Equal         ${ACTUAL_VALUE}             ${EXPECTED_VALUE}           msg=Value for the label ${LABEL} is not ${EXPECTED_VALUE}
    END

Add File To Functions
    [Documentation]             To add file to the functions file page
    ...                         Author: Dhanesh
    [Arguments]                 ${FILE_NAME}                ${LEFT_MENU_OPTION}
    VerifyText                  Add Files
    ClickText                   Add Files
    VerifyText                  Select Files
    ClickText                   ${LEFT_MENU_OPTION}
    VerifyNoText                Loading
    VerifyElement               ${UPLOAD_BUTTON_INADDFILE_WEBELEMENT}
    TypeText                    Search Files...             ${FILE_NAME}
    VerifyNoText                Loading
    VerifyText                  ${FILE_NAME}
    ${FILE_CHECKBOX_ELEMENT}=                               Replace String              ${FILE_CHECKBOX_WEBELEMENT}                 FILENAME    ${FILE_NAME}
    ClickElement                ${FILE_CHECKBOX_ELEMENT}
    VerifyText                  Add                         anchor=Cancel
    ClickText                   Add                         anchor=Cancel
    VerifyNoText                Loading
    VerifyText                  Add Files
    VerifyText                  ${FILE_NAME}

Upload Files To Functions
    [Documentation]             To upload files to functions from file page
    ...                         Author: Dhanesh
    [Arguments]                 ${FILE_PATH}                ${FILE_NAME}
    VerifyText                  Upload Files
    UploadFile                  Upload Files                ${FILE_PATH}
    VerifyText                  ${FILE_NAME}                timeout=120s

Create Function
    [Documentation]             Creating a new function
    ...                         Author : Ram Naidu
    [Arguments]                 ${FUNCTION_NAME}            ${IMAGE_NAME}               ${TIMEOUT}
    ClickText                   New
    VerifyAll                   New Function, Function Name
    Enter Input Field           Function Name               ${FUNCTION_NAME}
    Enter Input Field           API Name                    ${FUNCTION_NAME}
    Enter Input Field           Image Name                  ${IMAGE_NAME}
    Enter Input Field           Timeout                     ${TIMEOUT}
    SetConfig                   PartialMatch                False
    ClickText                   Save
    VerifyAll                   ${FUNCTION_NAME}, Details, Script, Configuration, Parameters, Execution History, Files
    SetConfig                   PartialMatch                True

Save Function Script
    [Documentation]             To give script to a function
    ...                         Author : Ram Naidu
    [Arguments]                 ${FUNCTION_SCRIPT}
    SetConfig                   PartialMatch                False
    ClickText                   Script
    ClickText                   Script
    sleep                       5s
    VerifyText                  Edit                        anchor=Files
    ClickText                   Edit                        anchor=Files
    TypeText                    ${FUNCTION_SCRIPT_WEBELEMENT}                           ${FUNCTION_SCRIPT}          click=True
    ClickText                   Save
    SetConfig                   PartialMatch                True

Execute Function
    [Documentation]             Execute a function
    ...                         Author : Ram Naidu
    [Arguments]                 ${CONTEXTID}
    ClickText                   Execute Function
    VerifyText                  Execute Function                        anchor=2
    SetConfig                   PartialMatch                True
    VerifyAll                   Context Id, Overwrite Parameters                
    TypeText                    Context Id                   ${CONTEXTID}
    SetConfig                   PartialMatch                False
    ClickText                   Execute
    VerifyText                  View Result Record          timeout=600s
    VerifyAll                   Previous, Finish
    SetConfig                   PartialMatch                True

Verify Function Execution
    [Documentation]             To verify whether function execution is succesful or not
    ...                         Author : Ram Naidu
    ClickText                   View Result Record
    VerifyNoText                Loading
    SwitchWindow                NEW
    Refresh page browser
    Refresh page browser
    VerifyText                  Completed                   timeout=600s
    VerifyText                  Success
    Refresh page browser
    VerifyText                  Completed

Add Parameters
    [Documentation]             To add the parameters to function
    ...                         Author: Dhanesh
    [Arguments]                 ${PARAMETERS}               ${DEFAULT_VALUE}            #Arguments are of List type
    SetConfig                   PartialMatch                False
    VerifyText                  Parameters
    ClickText                   Parameters
    SetConfig                   PartialMatch                True
    VerifyText                  Function Execution Parameters
    VerifyText                  Edit                        anchor=Files
    ClickText                   Edit                        anchor=Files
    ${COUNT}=                   Get Length                  ${PARAMETERS}
    FOR                         ${I}                        IN RANGE                    0                           ${COUNT}
        ${PARAMETER}=           Get From List               ${PARAMETERS}               ${I}
        ${VALUE}=               Get From List               ${DEFAULT_VALUE}            ${I}
        ClickText               Add new parameter
        VerifyAll               Name, Value, Required
        TypeText                ${PARAMETER_NAME_WEBELEMENT}                            ${PARAMETER}
        VerifyText              Name
        TypeText                ${DEFAULT_VALUE_WEBELEMENT}                             ${VALUE}
        VerifyText              Value
    END
    ClickText                   Save
    VerifyText                  Success

Verify And Download Log File
    [Documentation]             To verify the log file gets generated in the Results after function execution
    ...                         Author: Dhanesh
    ${CONTEXT_ID}=              Get ContextId
    ${FILE_NAME}=               Set Variable                Function Logs for ${CONTEXT_ID}.txt
    VerifyText                  ${FILE_NAME}
    ClickText                   ${FILE_NAME}
    VerifyNoText                Loading
    ClickText                   Download
    Sleep                       5s

Execute Invalid Function
    [Documentation]             To execute a function which should throw any error message
    ...                         Author: Dhanesh
    [Arguments]                 ${CONTEXTID}                ${ERROR_MESSAGE}
    ClickText                   Execute Function
    VerifyText                  Context Id
    VerifyText                  Overwrite Parameters
    TypeText                    Context Id                  ${CONTEXTID}
    SetConfig                   PartialMatch                False
    ClickText                   Execute
    SetConfig                   PartialMatch                True
    VerifyNoText                Loading
    VerifyAll                   Previous, Finish
    VerifyText                  ${ERROR_MESSAGE}

Verify No Log Generated
    [Documentation]             To verify no log generated after the execution results
    ...                         Author: Dhanesh
    ${CONTEXT_ID}=              Get ContextId
    ${FILE_NAME}=               Set Variable                Function Logs for ${CONTEXT_ID}.txt
    VerifyNoText                ${FILE_NAME}

Verify Function Nonexecution   
    [Documentation]             Verify that function execution is not succesful and displays a warning message
    ...                         Author: Dhanesh
    [Arguments]                 ${CONTEXT_ID}               ${WARNING_MESSAGE}
    ClickText                   Execute Function
    VerifyAll                   Execute Function, Context Id, Overwrite Parameters
    SetConfig                   PartialMatch                False
    ClickText                   Execute                     anchor=Copy to Clipboard
    VerifyText                  ${WARNING_MESSAGE}
    ClickText                   Finish
    SetConfig                   PartialMatch                True

Verify Function With Different Image
    [Documentation]             To verify same function execution using different docker image.
    ...                         Author: Ashok; 8th Feb, 2022
    [Arguments]                 ${IMAGE_NAME}

    ClickText                   Finish
    ClickText                   Configuration    anchor=Parameters    
    ClickText                   Edit Image Name    anchor=Image Name
    TypeText                    Image Name                        ${IMAGE_NAME}
    VerifyAll                   Cancel, Save
    ClickText                   Save                        anchor=Cancel
    Sleep                       5s
    Execute Function            ${EMPTY_STRING}
    Verify Function Execution
    Verify And Download Log File
    CloseWindow

Add Single Required Parameter To Function
    [Documentation]            To add a single required paramter to a function
    ...                         Author: Ram Naidu; 14th April, 2022
    [Arguments]                ${PARAMETER}    ${VALUE}
    ClickText                  Parameters
    VerifyText                 Function Execution Parameters (0)
    ClickText                  Edit    anchor=Files
    ClickText                  Add new parameter
    VerifyAll                  Name, Value, Required
    TypeText                   ${PARAMETER_NAME_WEBELEMENT}    ${PARAMETER}
    VerifyText                 Name
    TypeText                   ${DEFAULT_VALUE_WEBELEMENT}     ${VALUE}
    ClickCheckbox              Required                        on
    ClickText                  Save                        anchor=Cancel
    VerifyAll                  Function Execution Parameters (1), ${PARAMETER}, ${VALUE}

Add Callback To Function
    [Documentation]             To add callback to function
    ...                         Author: Ram Naidu;  21st April, 2022
    [Arguments]                 ${CALLBACK_TYPE}            ${CALLBACK_VAL}
    ClickText                   Configuration
    VerifyAll                   Callback, Callback Type
    ClickText                   Edit Callback Type
    IF                          '${CALLBACK_TYPE}' == 'ApexClass'
        ClickText               --None--
        ClickText               ApexClass
        VerifyText              ApexClass
        TypeText                ${COPADO_CALLBACK_APEX_WEBELEMENT}           ${CALLBACK_VAL}
    ELSE
        ClickText               ApexClass
        ClickText               Flow
        VerifyText              FlowHandler
        TypeText                ${COPADO_CALLBACK_FLOW_WEBELEMENT}           ${CALLBACK_VAL}
    END
    ClickText                   Save                        anchor=Cancel
    VerifyText                  ${CALLBACK_TYPE}

Get User APIkey
    [Documentation]             To add callback to function
    ...                         Author: Ram Naidu; 21st April, 2022
    [Arguments]                 ${USERNAME}
    ClickText                   Setup
    VerifyText                  Setup for current app
    ClickText                   Setup for current app
    SwitchWindow                NEW
    Open component on Setup Home tab                        Custom Settings
    VerifyAll                   Custom Settings, Personal Settings
    ClickText                   Manage                      anchor=Personal Settings
    VerifyAll                   Personal Settings, Default Organization Level Value
    ClickText                   View                        anchor=${USERNAME}
    ${APIKEY}=                  GetText                     ${APIKEY_VALUE_WEBELEMENT}                     
    [Return]                    ${APIKEY}

Remove User APIkey
    [Documentation]             To add callback to function
    ...                         Author: Ram Naidu; 21st April, 2022
    [Arguments]                 ${USERNAME}
    ClickText                   Edit                        anchor=${USERNAME}
    TypeText                    API Key                     ${EMPTY_STRING}
    ClickText                   Save                        anchor=Cancel
    VerifyAll                   Personal Settings Detail, ${USERNAME}


Update User APIkey      
    [Documentation]             To add callback to function
    ...                         Author: Ram Naidu;  21st April, 2022
    [Arguments]                 ${USERNAME}                 ${API_KEY}
    VerifyText                  Personal Settings
    ClickText                   Edit                        anchor=${USERNAME}
    TypeText                    API Key                     ${API_KEY}
    ClickText                   Save                        anchor=Cancel
    VerifyText                  Personal Settings Detail, ${USERNAME}, ${API_KEY}

Verify Function Failure
    [Documentation]            To Verify the function Failure
    ...                        Author : Ram Naidu; 21st April, 2022
    ClickText                   View Result Record
    VerifyNoText                Loading
    SwitchWindow                NEW
    VerifyText                  Failed
    Refresh page browser
    VerifyText                  Error