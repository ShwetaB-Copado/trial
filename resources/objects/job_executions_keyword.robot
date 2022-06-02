*** Settings ***
Documentation                   List of all the keywords used from the job executions
Resource                        ../common_keywords.robot
Resource                        ../../resources/webelements/job_execution_webelement.robot
Resource                        ../../resources/objects/Job_Templates_keywords.robot

*** Keywords ***
Verify Commit Job Execution
    [Documentation]             To verify the job execution is succesfully completed after committing any metadata
    ...                         Author: Dhanesh
    ...                         Date: 9th NOV 2021
    ...                         update: 7th JAN 2022
    Open Object                 Job Executions
    VerifyText                  Job Execution Name
    ${ISPRESENT}=               Run Keyword And Return Status                           VerifyElement               ${JOB_RECORD_WEBELEMENT}    timeout=2s
    IF                          '${ISPRESENT}' == 'False'
        Run Keyword And Ignore Error                        ClickText                   Select List View            timeout=2s
        ClickText               All
    END
    ClickElement                ${JOB_RECORD_WEBELEMENT}
    VerifyText                  SFDX Commit
    ${COMPLETED_STATUS}=        Replace String              ${JOB_COMPLETED_WEBELEMENT}                             {JOB}                       Commit
    VerifyElementText           ${COMPLETED_STATUS}         Completed                   timeout=600s                reason=To wait until the job executions to get completed

Verify Promote And Deploy Job Execution
    [Documentation]             To verify the job execution is succesfully completed after promote and deploy
    ...                         Author: Dhanesh
    ...                         Date: 10th NOV 2021
    ClickText                   Details
    VerifyText                  Promotion Name              anchor=Information
    VerifyText                  SFDX Promote
    ${JOB_NAMES}=               Create List                 Promote                     Encode file names           Deploy
    FOR                         ${I}                        IN RANGE                    0                           3
        ${JOB}=                 Get From List               ${JOB_NAMES}                ${I}
        ${COMPLETED_STATUS}=    Replace String              ${JOB_COMPLETED_WEBELEMENT}                             {JOB}                       ${JOB}
        VerifyElementText       ${COMPLETED_STATUS}         Completed                   timeout=600s                reason=To wait until the job executions to get completed
    END
    VerifyText                  SFDX Deploy
    VerifyText                  Step result:                anchor=Promote
    VerifyText                  Step result:                anchor=Encode file names
    VerifyText                  Step result:                anchor=Deploy

Verify Heroku Promote And Deploy Job Execution
    [Documentation]             To verify the job execution is succesfully completed after heroku promote and deploy
    ...                         Author: Ram Naidu
    ClickText                   Details
    VerifyText                  Promotion Name              anchor=Information
    VerifyText                  Heroku_Promote
    ${JOB_NAMES}=               Create List                 Promote    Heroku_Deploy
    FOR                         ${I}                        IN RANGE                    0                           2
        ${JOB}=                 Get From List               ${JOB_NAMES}                ${I}
        ${COMPLETED_STATUS}=    Replace String              ${JOB_COMPLETED_WEBELEMENT}                             {JOB}                       ${JOB}
        VerifyElementText       ${COMPLETED_STATUS}         Completed                   timeout=600s                reason=To wait until the job executions to get completed
    END
    VerifyText                  Heroku_Deploy
    VerifyText                  Step result:                anchor=Promote
    VerifyText                  Step result:                anchor=Deploy

Verify Job Execution
    [Documentation]             To verify the job execution status and navigate to the Results
    ...                         Author: Dhanesh
    [Arguments]                 ${JOB_TEMPLATE_NAME}
    ${JOB_EXECUTION_NAME}=      Navigate To Job Execution Result                        ${JOB_TEMPLATE_NAME}
    VerifyText                  Completed                   timeout=600s                reason=To wait until job template execution completion
    FOR                         ${I}                        IN RANGE                    0                           ${25}
        ${STATUS}=              GetText                     ${JOB_EXECUTION_STATUS_WEBELEMENT}
        Exit For Loop IF        '${STATUS}' == 'Success'
        Refresh page browser
    END
    Should Be Equal             ${STATUS}                   Success
    VerifyAll                   Success, Completed, Step result:
    ClickText                   R                           anchor=Step result:
    SetConfig                   PartialMatch                False
    VerifyText                  Result Name
    VerifyText                  Success                     anchor=Status
    SetConfig                   PartialMatch                True
    [Return]                    ${JOB_EXECUTION_NAME}

Delete Job Template
    [Documentation]             To delete the job template step
    ...                         Author: Dhanesh
    [Arguments]                 ${JOB_TEMPLATE_NAME}        ${JOB_STEP_NAME}
    Open Object                 Job Templates
    Open record from object main page                       ${JOB_TEMPLATE_NAME}
    SetConfig                   PartialMatch                False
    VerifyText                  Details
    ClickText                   Steps                       anchor=Details
    Delete Job Step             ${JOB_STEP_NAME}
    ClickText                   Delete                      anchor=Edit
    VerifyText                  Delete Job Template
    VerifyText                  Delete                      anchor=Cancel
    ClickText                   Delete                      anchor=Cancel
    VerifyText                  was deleted

Delete Job Executions
    [Documentation]             To delete the job executions
    ...                         Author: Dhanesh
    [Arguments]                 ${JOB_EXECUTION_NAME}       ${JOB_STEP_NAME}
    Open Object                 Job Executions
    Open record from object main page                       ${JOB_EXECUTION_NAME}
    Delete Job Step             ${JOB_STEP_NAME}
    ClickText                   Delete                      anchor=Edit
    VerifyText                  Delete Job Execution
    VerifyText                  Delete                      anchor=Cancel
    ClickText                   Delete                      anchor=Cancel
    VerifyText                  was deleted
    VerifyNoText                was deleted

Verify Job Execution Failure
    [Documentation]             To verify the job execution failure with error message
    ...                         Author: Dhanesh
    [Arguments]                 ${JOB_TEMPLATE_NAME}        ${ERROR_MESSAGE}
    ${JOB_EXECUTION_NAME}=      Navigate To Job Execution Result                        ${JOB_TEMPLATE_NAME}
    VerifyText                  Error                       timeout=600s                reason=To wait until job template execution completion
    FOR                         ${I}                        IN RANGE                    0                           ${25}
        ${STATUS}=              GetText                     ${JOB_EXECUTION_STATUS_WEBELEMENT}
        Exit For Loop IF        '${STATUS}' == 'Failed'
        Refresh page browser
    END
    Should Be Equal             ${STATUS}                   Failed
    VerifyAll                   Failed, Error, Step result:
    ClickText                   R                           anchor=Step result:
    SetConfig                   PartialMatch                False
    VerifyText                  Result Name
    VerifyText                  Failed                      anchor=Status
    VerifyText                  ${ERROR_MESSAGE}            anchor=Error Message
    SetConfig                   PartialMatch                True
    [Return]                    ${JOB_EXECUTION_NAME}

Verify Deployment Execution Order
    [Documentation]             To verify the job execution order in the deployments page
    ...                         Author: Dhanesh
    ...                         Date: 3 DEC 2021
    [Arguments]                 ${JOBS}
    #JOBS: List of jobs in the exact execution order.
    ${LENGTH}=                  Get Length                  ${JOBS}
    FOR                         ${I}                        IN RANGE                    0                           ${LENGTH}
        ${JOB}=                 Get From List               ${JOBS}                     ${I}
        ${ITRLENGTH}=           Evaluate                    str(int(${I} + 1))
        ${DICTIONARY}=          Create Dictionary           ITR=${ITRLENGTH}            JOBNAME=${JOB}
        ${JOB_SEQ}=             Replace All                 ${JOB_ORDER_WEBELEMENT}     ${DICTIONARY}
        VerifyElementText       ${JOB_SEQ}                  ${JOB}
    END

Open SFDX Package Import Job   
    [Documentation]             To open the package import job execution based on execution id provided by CLI execution
    ...                         Author: Dhanesh
    ...                         Date: 21 Feb 2022
    [Arguments]                 ${EXECUTION_ID}
    Open Object                 Job Executions
    ClickText                   JE-                         anchor=1                    partial_match=True
    VerifyText                  Details
    ${CURRENT_URL}=             Get Url
    ${CONTEXT_ID}=              Evaluate                    '${CURRENT_URL}'.split('/')[6]
    ${JOB_EXECUTION_URL}=       Replace String              ${CURRENT_URL}              ${CONTEXT_ID}               ${EXECUTION_ID}
    GoTo                        ${JOB_EXECUTION_URL}
    VerifyText                  SFDX Package Import

Verify Package Job Executions
    [Documentation]             To verify the job execution success
    ...                         Author: Dhanesh
    ...                         Date: 9 MAR 2022
    ...                         Modified Date: 31 MAR 2022
    [Arguments]                 ${JOB_DICTIONARY}           ${JOB_HEADER}
    #JOB_DICTIONARY - List of functions $ flows that gets executed
    #JOB_HEADER - The text header eg: SFDX Package Import
    VerifyText                  ${JOB_HEADER}
    FOR                         ${KEY}                      IN                          @{JOB_DICTIONARY}
        IF                      '${KEY}' == 'Function'
            ${VALUE}=           Get From Dictionary         ${JOB_DICTIONARY}           ${KEY}
            ${COMPLETED_STATUS}=                            Replace String              ${JOB_COMPLETED_WEBELEMENT}                             {JOB}    ${VALUE}
            VerifyElementText                               ${COMPLETED_STATUS}         Completed                   timeout=300s                reason=To wait until the job executions to get completed
        ELSE IF                 '${KEY}' == 'Flow'
            ${VALUE}=           Get From Dictionary         ${JOB_DICTIONARY}           ${KEY}
            ${SUCCESS_STATUS}=                              Replace String              ${JOB_COMPLETED_WEBELEMENT}                             {JOB}    ${VALUE}
            VerifyElementText                               ${SUCCESS_STATUS}           Success                     timeout=300s                reason=To wait until the job executions to get completed
        ELSE
            Fail                msg=Invalid option ${KEY}, Should be either Function or Flow
        END
    END

Verify Package Version Create Job
    [Documentation]             To verify the job execution success after creating a package version
    ...                         Author: Dhanesh
    ...                         Date: 31 MAR 2022
    VerifyText                  SFDX Package Version Create
    ${JOBS}=                    Create Dictionary           Update Package Requisite=Success                        Create SFDX Package Version=Package version created successfully    Insert Package Version Information=Success
    FOR                         ${KEY}                      IN                          @{JOBS}
        ${VALUE}=               Get From Dictionary         ${JOBS}                     ${KEY}
        ${COMPLETED_STATUS}=    Replace String              ${JOB_COMPLETED_WEBELEMENT}                             {JOB}                       ${KEY}
        VerifyElementText       ${COMPLETED_STATUS}         ${VALUE}                    timeout=300s                reason=To wait until the job executions to get completed
    END

Delete Job Execution From Object Manager
    [Documentation]             To delete the job steps attached to job execution and delete the job execution finally
    ...                         Author:Ram Naidu - 23 Nov, 2021
    [Arguments]                 ${JOB_EXECUTION_ID}
    Open Object                 Job Executions
    Open record from object main page                       ${JOB_EXECUTION_ID}
    ExecuteJavascript           return document.evaluate("//span[text()='Show actions']", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotLength    $len
    ${JOB_STEP_COUNT}           GetText                     ${JOB_EXECUTION_TITLE_WEBELEMENT}
    ${COUNT}=                   Evaluate                    int('${JOB_STEP_COUNT}'['${JOB_STEP_COUNT}'.find("(")+1:'${JOB_STEP_COUNT}'.find(")")])
    ${JOBSTEPS_TO_REMOVE}=      Evaluate                    int(${len}-${COUNT}+1)
    FOR                         ${I}                        IN RANGE                    0                           ${COUNT}
        ${p}=                   Evaluate                    str(${JOBSTEPS_TO_REMOVE})
        ${ELEM}=                Replace String              ${SHOW_ACTIONS_INDEX_WEBELEMENT}                        iter                        ${p}
        ClickElement            ${ELEM}
        ClickText               Delete                      anchor=New
        VerifyAll               Delete Job Step, Are you sure you want to delete this job step?
        sleep                   5s
        ClickText               Delete                      anchor=Cancel
        VerifyText              Job Step Record deleted successfully.
    END
    ClickText                   Delete                      anchor=Edit
    VerifyAll                   Delete Job Execution, Are you sure you want to delete this Job Execution?
    ClickText                   Delete                      anchor=Cancel
    VerifyText                  Job Execution '${JOB_EXECUTION_ID}' was deleted.