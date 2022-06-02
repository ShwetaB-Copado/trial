*** Settings ***
Documentation                   List of all the keywords used from the packages object
Resource                        ../common_keywords.robot
Resource                        ../../resources/webelements/package_webelements.robot
Resource                        ../../resources/webelements/job_execution_webelement.robot

*** Keywords ***

Verify Package Import
    [Documentation]             To verify the package imported from the devhub org via CLI
    ...                         Author: Dhanesh
    ...                         Date: 22nd Feb 2022
    [Arguments]                 ${PACKAGE_NAME}             ${PACKAGE_ID}    ${PACKAGE_VERSION_NAME}
    LaunchApp                   Packages
    VerifyNoText                Loading
    Run Keyword And Ignore Error                            ClickText                   Select a List View
    ${ISPRESENT}=               Run Keyword And Return Status                           VerifyText                  All                         timeout=5s
    Run Keyword If              ${ISPRESENT}                ClickText                   All
    Run Keyword And Ignore Error                            ClickText                   ALL Env                     timeout=2s
    VerifyNoText                Loading
    VerifyText                  ${PACKAGE_NAME}             anchor=Package Name
    VerifyText                  ${PACKAGE_ID}               anchor=Package Id
    ClickText                   ${PACKAGE_NAME}
    VerifyText                  Package Information
    VerifyText                  Package Versions            anchor=1
    VerifyText                  ${PACKAGE_VERSION_NAME}     anchor=1
    ClickText                   ${PACKAGE_VERSION_NAME}     anchor=1
    VerifyText                  ${PACKAGE_VERSION_NAME}     anchor=Package Version Name                                           


Create package Version
    [Documentation]             To create a new package version
    ...                         Author: Dhanesh
    ...                         Date: 28th Feb 2022
    [Arguments]                 ${FIELDS}                   ${VALUES}                   ${BYPASS_INSTALLATION_KEY}                              ${SKIP_VALIDATION}    ${CODE_COVERAGE}
    #FIELDS: Pass the fields as list type which needs to be entered
    #VALUES: Pass the values for the corresponding fields
    #BYPASS_INSTALLATION_KEY: Pass on/off to check/uncheck the checkbox
    #SKIP_VALIDATION: Pass on/off to check/uncheck the checkbox
    ClickText                   Create Package Version
    VerifyText                  Create Package Version      anchor=2
    VerifyText                  Create Version              anchor=Cancel
    ${LENGTH}=                  Get Length                  ${FIELDS}
    FOR                         ${I}                        IN RANGE                    0                           ${LENGTH}
        ${FIELD}=               Get From List               ${FIELDS}                   ${I}
        ${VALUE}=               Get From List               ${VALUES}                   ${I}
        Enter Input Field       ${FIELD}                    ${VALUE}
        VerifyNoText            Loading
    END
    ClickCheckbox               Installation Key Bypass     ${BYPASS_INSTALLATION_KEY}
    VerifyNoText                Loading
    VerifyCheckboxValue         Installation Key Bypass     ${BYPASS_INSTALLATION_KEY}
    ClickCheckbox               Code Coverage               ${CODE_COVERAGE}
    VerifyNoText                Loading
    VerifyCheckboxValue         Code Coverage               ${CODE_COVERAGE}
    ClickCheckbox               Skip Validation             ${SKIP_VALIDATION}
    VerifyNoText                Loading
    VerifyCheckboxValue         Skip Validation             ${SKIP_VALIDATION}
    VerifyNoText                Loading
    ClickText                   Create Version              anchor=Cancel

Update Installation key
    [Documentation]             To create a new package version
    ...                         Author: Dhanesh
    ...                         Date: 9th Mar 2022
    [Arguments]                 ${INSTALLATION_KEY}
    #INSTALLATION_KEY - The installation key to update for package version
    ClickText                   Update Installation Key
    VerifyNoText                Loading
    VerifyText                  Update Installation Key     anchor=2
    ClickElement                ${UPDATE_KEY_EDIT_WEBELEMENT}
    VerifyNoText                Loading
    VerifyText                  *Installation Key           partial_match=false
    TypeText                    *Installation Key           ${INSTALLATION_KEY}         click=true
    ClickText                   Save                        anchor=Cancel
    VerifyNoText                Loading

Select Package Version
    [Documentation]             To select the package version for distribution
    ...                         Author: Dhanesh
    ...                         Date: 22th Mar 2022
    [Arguments]                 ${EXPECTED_PACKAGE_VERSION}
    #EXPECTED_PACKAGE_VERSION: Package version in format: Automation_2sMBB4FN662125 - 0.0.0.2
    VerifyText                  Distribute Package          anchor=2
    VerifyText                  Select Package Version
    VerifyText                  ${EXPECTED_PACKAGE_VERSION}
    ${VERSION_RADIO_BUTTON}=    Replace String              ${SELECT_VERSION_WEBELEMENT}                            VERSION NAME                ${EXPECTED_PACKAGE_VERSION}
    ClickElement                ${VERSION_RADIO_BUTTON}
    ClickText                   Next

Select Distribution Type 
    [Documentation]             To select the distribution type
    ...                         Author: Dhanesh
    ...                         Date: 22th Mar 2022
    VerifyText                  Distribute Package          anchor=2
    VerifyText                  Select Distribution Type
    ClickText                   Next

Select Credentials
    [Documentation]             To select the credentials to distribute the package
    ...                         Author: Dhanesh
    ...                         Date: 22th Mar 2022
    [Arguments]                 ${CREDENTIAL}
    VerifyText                  Distribute Package          anchor=2
    VerifyText                  Select Credentials
    ScrollTo                    ${CREDENTIAL}               anchor=1
    VerifyText                  ${CREDENTIAL}               anchor=1
    ${CREDENTIAL_CHECKBOX}=     Replace String              ${SELECT_VERSION_WEBELEMENT}                            VERSION NAME                ${CREDENTIAL}
    ClickElement                ${CREDENTIAL_CHECKBOX}
    VerifyNoText                Loading
    VerifyCheckboxValue         ${CREDENTIAL}               on
    ClickText                   Next

Confirm credentials
    [Documentation]             To verify the confirm credentials 
    ...                         Author: Dhanesh
    ...                         Date: 23th Mar 2022
    [Arguments]                 ${CREDENTIAL}
    VerifyText                  Distribute Package          anchor=2
    VerifyText                  Confirm Credential Selections
    VerifyText                  ${CREDENTIAL}               anchor=1    partial_text=False
    VerifyText                  ${CREDENTIAL}               anchor=2    partial_text=False
    ClickText                   Next

Get Job Execution Id
    [Documentation]             To verify the List of installation procedures and get the job execution id
    ...                         Author: Dhanesh
    ...                         Date: 23th Mar 2022
    [Arguments]                 ${CREDENTIAL}
    VerifyText                  Distribute Package          anchor=2
    VerifyText                  List of installation procedures
    VerifyText                  ${CREDENTIAL}               anchor=Destination Environment
    ${JOB_ID}=                  GetText                     ${JOB_ID_WEBELEMENT} 
    [Return]                    ${JOB_ID}   

Verify Package Job Executions Error
    [Documentation]             To verify the job execution Error
    ...                         Author: Dhanesh
    ...                         Date: 9 MAR 2022
    [Arguments]                 ${JOB_DICTIONARY}           ${JOB_HEADER}    ${ERROR_MESSAGE}
    #JOB_DICTIONARY - List of functions $ flows that gets executed
    #JOB_HEADER - The text header eg: SFDX Package Import
    VerifyText                  ${JOB_HEADER}
    FOR                         ${KEY}                      IN                          @{JOB_DICTIONARY}
        IF                      '${KEY}' == 'Function'
            ${VALUE}=           Get From Dictionary         ${JOB_DICTIONARY}           ${KEY}
            ${ERROR_STATUS}=                                Replace String              ${JOB_COMPLETED_WEBELEMENT}                             {JOB}    ${VALUE}
            VerifyElementText                               ${COMPLETED_STATUS}         Error                       timeout=300s                reason=To wait until the job executions to get completed
            ${ERROR_STATUS}=                                Replace String              ${JOB_RESULT_WEBELEMENT}                                {JOB}    ${VALUE}
            ClickElement                                    ${ERROR_STATUS}
            VerifyText                                      Result                      partial_match=False
            VerifyText                                      ${ERROR_MESSAGE}            anchor=Error Message
        ELSE IF                 '${KEY}' == 'Flow'
            ${VALUE}=           Get From Dictionary         ${JOB_DICTIONARY}           ${KEY}
            ${SUCCESS_STATUS}=                              Replace String              ${JOB_COMPLETED_WEBELEMENT}                             {JOB}    ${VALUE}
            VerifyElementText                               ${SUCCESS_STATUS}           Success                     timeout=300s                reason=To wait until the job executions to get completed
        ELSE
            Fail                msg=Invalid option ${KEY}, Should be either Function or Flow
        END
    END
               