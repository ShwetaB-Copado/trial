*** Settings ***
Documentation                   List of all the keywords used from the Job Templates object
Resource                        ../common_keywords.robot
Resource                        ../webelements/job_templates_webelement.robot

*** Keywords ***
Create Job Template
    [Documentation]             To create a new job template
    ...                         Author: Dhanesh
    [Arguments]                 ${JOB_TEMPLATE_NAME}        ${VERSION}
    SetConfig                   PartialMatch                False
    ClickText                   New                         anchor=Change Owner
    VerifyText                  New Job Template
    VerifyAll                   Job Template Name, Version, Description, Type, Cancel, Save & New, Save
    Enter Input Field           Job Template Name           ${JOB_TEMPLATE_NAME}
    Enter Input Field           Version                     ${VERSION}
    ClickText                   Save
    VerifyNoText                Loading
    SetConfig                   PartialMatch                True
    VerifyText                  was created
    VerifyText                  Details
    ClickText                   Details
    VerifyText                  Job Template Name
    VerifyText                  ${JOB_TEMPLATE_NAME}        anchor=Job Template Name
    VerifyText                  ${VERSION}                  anchor=Version
    VerifyText                  Custom                      anchor=Type
    SetConfig                   PartialMatch                False
    ClickText                   Steps
    VerifyText                  New                         anchor=Change Owner
    SetConfig                   PartialMatch                True

Create Function Type Job Step
    [Documentation]             To create a new job step of Type as Functions from Job Template
    ...                         Author: Dhanesh
    [Arguments]                 ${JOB_STEP_NAME}            ${FUNCTION_NAME}            ${PARAMETERS}               ${VALUES}           #PARAMETER & VALUES}: List type
    SetConfig                   PartialMatch                False
    ClickText                   New                         anchor=Change Owner
    VerifyText                  Add New Step
    Enter Input Field           Name                        ${JOB_STEP_NAME}
    ClickElement                ${JOB_TYPE_WEBELEMENT}
    VerifyText                  Function
    ClickText                   Function
    VerifyText                  Function Configuration
    SetConfig                   PartialMatch                True
    ClickElement                ${FUNCTION_INPUT_WEBELEMENT}
    TypeText                    ${FUNCTION_INPUT_WEBELEMENT}                            ${FUNCTION_NAME}            click=True
    ClickElement                ${FUNCTION_INPUT_WEBELEMENT}
    ${CONFIGURATION}=           Replace String              ${FUNCTION_CONFIGURATION_WEBELEMENT}                    NAME                ${FUNCTION_NAME}
    ClickElement                ${CONFIGURATION}
    VerifyAll                   ${PARAMETERS}
    ${COUNT}=                   Get Length                  ${PARAMETERS}
    FOR                         ${I}                        IN RANGE                    0                           ${COUNT}
        ${PARAMETER}=           Get From List               ${PARAMETERS}               ${I}
        ${VALUE}=               Get From List               ${VALUES}                   ${I}
        VerifyText              ${PARAMETER}
        Enter Input Field       ${PARAMETER}                ${VALUE}
    END
    ClickText                   Save                        anchor=Cancel
    VerifyText                  ${JOB_STEP_NAME}            anchor=Name

Delete Job Step
    [Documentation]             To delete the job step
    ...                         Author: Dhanesh
    [Arguments]                 ${JOB_STEP_NAME}
    VerifyText                  Name
    ${SHOW_MORE_ACTIONS}=       Replace String              ${JOB_SHOWMOREACTIONS_WEBELEMENT}                       {JOB STEP NAME}     ${JOB_STEP_NAME}
    VerifyElement               ${SHOW_MORE_ACTIONS}
    ClickElement                ${SHOW_MORE_ACTIONS}
    SetConfig                   PartialMatch                True
    VerifyElement               ${JOB_STEP_DELETE_WEBELEMENT}
    ClickElement                ${JOB_STEP_DELETE_WEBELEMENT}
    VerifyText                  Delete Job Step
    VerifyText                  Delete                      anchor=Cancel
    ClickText                   Delete                      anchor=Cancel
    VerifyText                  Job Step Record deleted successfully.
    VerifyNoText                Job Step Record deleted successfully.

Navigate To Job Execution Result
    [Documentation]             To navigate to the job execution result
    ...                         Author: Dhanesh
    [Arguments]                 ${JOB_TEMPLATE_NAME}
    Open Object                 Job Templates
    Open record from object main page                       ${JOB_TEMPLATE_NAME}
    VerifyText                  Details
    VerifyElement               ${JOB_EXECUTION_WEBELEMENT}
    ClickElement                ${JOB_EXECUTION_WEBELEMENT}
    VerifyText                  Job Execution Name
    VerifyElement               ${CREATED_JOB_EXECUTION_WEBELEMENT}
    ${JOB_EXECUTION_NAME}=      GetText                     ${CREATED_JOB_EXECUTION_WEBELEMENT}
    ClickElement                ${CREATED_JOB_EXECUTION_WEBELEMENT}
    VerifyAll                   Name, Status
    [Return]                    ${JOB_EXECUTION_NAME}

Create Apex Type Job Step
    [Documentation]             To create a new job step of type Apex 
    ...                         Author : Ram Naidu, 3rd Feb, 2022
    [Arguments]                 ${JOB_STEP_NAME}
    SetConfig                   PartialMatch                False
    ClickText                   New                         anchor=Change Owner
    VerifyAll                   Add New Step, Cancel, Save
    Enter Input Field           Name                        ${JOB_STEP_NAME}
    ClickElement                ${JOB_TYPE_WEBELEMENT}
    VerifyText                  Apex
    ClickText                   Apex
    VerifyText                  Script
    ClickText                   Save                        anchor=Cancel
    VerifyAll                   Success, Step saved, ${JOB_STEP_NAME}

Create Manual Task Job Step
    [Documentation]             To create a manual task job step
    ...                         Author: Ram Naidu, 3rd Feb, 2022
    [Arguments]                 ${JOB_STEP_NAME}    ${TASK_DESCRIPTION}
    SetConfig                   PartialMatch                False
    ClickText                   New                         anchor=Change Owner
    VerifyAll                   Add New Step, Cancel, Save
    Enter Input Field           Name                        ${JOB_STEP_NAME}
    ClickElement                ${JOB_TYPE_WEBELEMENT}
    VerifyText                  Manual Task
    ClickText                   Manual Task
    VerifyAll                   Manual Task Configuration, *Task Description
    TypeText                    *Task Description           ${TASK_DESCRIPTION}
    ClickText                   Save                        anchor=Cancel
    VerifyAll                   Success, Step saved, ${JOB_STEP_NAME}

Create Flow Type Job Step
    [Documentation]            To create a flow type job step
    ...                        Author : Ram Naidu; 28th April, 2022
    [Arguments]                ${JOB_STEP_NAME}    ${FLOW_TYPE}
    SetConfig                   PartialMatch                False
    ClickText                   New  
    VerifyAll                   Add New Step, Cancel, Save
    Enter Input Field           Name                        ${JOB_STEP_NAME}
    ClickElement                ${JOB_TYPE_WEBELEMENT}
    VerifyText                  Salesforce Flow
    ClickText                   Salesforce Flow
    VerifyAll                   Flow Configuration, Flow Variables (0), Add new parameter
    ClickText                   Select a Salesforce Flow
    ClickText                   ${FLOW_TYPE}
    ClickText                   Save                        anchor=Cancel
    VerifyAll                   Success, Step saved, ${JOB_STEP_NAME}