*** Settings ***
Documentation                   Contains common keywords required for Deployments object
Resource                        ../common_keywords.robot
Resource                        ../webelements/deployments_webelements.robot

*** Keywords ***
Create Metadata Deployment
    [Documentation]             Create empty Metadata deployment
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 20th DEC, 2021
    Open Object                 Deployments
    ClickText                   New
    VerifyText                  New Deployment
    ClickText                   Metadata Deployment         anchor=Select the metadata
    ClickText                   Next
    VerifyText                  New Deployment: Metadata Deployment
    ${DEPLOYMENT_NAME}=         Generate random name
    TypeText                    Deployment Name             ${DEPLOYMENT_NAME}          anchor=Information
    ClickText                   Save                        2
    [Return]                    ${DEPLOYMENT_NAME}

Select data from Deployment table
    [Arguments]                 ${DATA}
    [Documentation]             Select the data from deployment table, e.g Source/Target ORG
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 20th DEC, 2021
    TypeText                    ${DEPLOYMENT_SEARCH_BOX_WEBELEMENT}                     ${DATA}
    Sleep                       2s                          #Waiting to get the searched result
    ${CLICK_SEARCHED_OPTION_XPATH}=                         Replace String              ${DEPLOYMENT_SEARCHED_OPTION_SELECT_WEBELEMENT}    DATA    ${DATA}
    ClickElement                ${CLICK_SEARCHED_OPTION_XPATH}

Create Advanced Multistep Deployment
    [Arguments]                 ${SOURCE_CREDENTIAL}
    [Documentation]             Create Advance multistep deployment with Source Credential
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 21th DEC, 2021
    Open Object                 Deployments
    ClickText                   New
    VerifyText                  New Deployment
    ClickText                   Advanced (multi-step)       anchor=Create multiple types of deployment steps
    ClickText                   Next
    ${DEPLOYMENT_NAME}=         Generate random name
    VerifyText                  New Deployment: Advanced (multi-step)
    VerifyText                  Information
    TypeText                    Deployment Name             ${DEPLOYMENT_NAME}          anchor=Information
    Select record from lookup field                         Search Credentials...       ${SOURCE_CREDENTIAL}
    ClickText                   Save                        2
    VerifyText                  Information                 180s                        #Checking the deployment page opened
    VerifyText                  Deployment Name             120s
    VerifyAll                   ${DEPLOYMENT_NAME}, Information, Status

Add Target Credential to Advanced Multistep Deployment
    [Arguments]                 ${TARGET_CREDENTIAL}
    [Documentation]             Add Target Credential- "To Credential" to Advance Multistep Deployment as per argument
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 21th DEC, 2021
    VerifyText                  Deployment
    ClickElement                ${TO_CREDENTIAL_SEARCHBOX_WEBELEMENT}
    Sleep                       3s    #Sometimes new window takes time to load 
    SwitchWindow                NEW
    VerifyText                  Lookup
    VerifyText                  Recently Viewed Credentials
    TypeText                    Search...                   ${TARGET_CREDENTIAL}
    ClickText                   Go!
    ClickText                   ${TARGET_CREDENTIAL}        anchor=Credential Name
    SwitchWindow                NEW
    VerifyText                  ${TARGET_CREDENTIAL}        anchor=To Credential
    VerifyText                  Success

Select Step in Advanced Multistep Deployment
    [Arguments]                 ${STEP_NAME}
    [Documentation]             Select the Step as per argument in the Advanced Multistep deployment
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 22th DEC, 2021
    VerifyText                  Steps
    ClickText                   Add Step
    DropDown                    --None--                    ${STEP_NAME}
    ScrollText                  Details

Add Git Metadata Step in Advanced Multistep Deployment
    [Arguments]                 ${US_ID}                    ${GIT_REPO}                 ${GIT_TYPE}
    [Documentation]             Add the Git Metadata Step as per arguments, e.g User Stories which having metadata commit and git commit type- created/updated
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 22th DEC, 2021
    #Select Step
    Select Step in Advanced Multistep Deployment            Git MetaData
    #Define Step
    ClickElement                ${STEP_GIT_COMMIT_SELECTION_WEBELEMENT}
    SwitchWindow                NEW
    VerifyText                  Repository
    DropDown                    -- Select --                ${GIT_REPO}
    ClickText                   Search
    VerifyText                  Commit Message
    TypeText                    ${STEP_GIT_METADATA_TABLE_MSG_TEXTBOX_WEBELEMENT}       ${US_ID}
    Sleep                       3s                          #Wait to get the searched result
    ClickText                   ${US_ID}
    SwitchWindow                1
    VerifyText                  Find and Replace
    ${METADATA_ELEMENT}=        Replace String              ${SELECT_METADATA_WEBELEMENT}                           METADATA       ${GIT_TYPE}
    ClickElement                ${METADATA_ELEMENT}
    ClickText                   Save                        anchor=Cancel
    VerifyText                  Success

Deploy and Verify Advance Multistep Deployment Step through DeployAll
    [Documentation]             Deploy the Advanced Multistep Deployment step by clicking "Deploy All" and wait until the deployment completion
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 22th DEC, 2021
    VerifyText                  Deployment
    ScrollText                  Information
    ClickText                   Deploy
    VerifyAll                   Deploy All, Deployments
    ClickText                   Deploy All
    VerifyText                  Information                 60s                         #Waiting for the page redirect to main Advanced Multistep deployment page
    Wait until deployment completion

Wait until deployment completion
    [Documentation]             Wait until the deployment status to "Completed Successfully/Completed with errors/Cancelled"
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 22th DEC, 2021
    FOR                         ${INDEX}                    IN RANGE                    0                           ${15}
        ${CURRENT_STATUS}=      Get status of deployment
        Exit For Loop IF        '${CURRENT_STATUS}' == 'Completed Successfully' or '${CURRENT_STATUS}' == 'Completed with Errors' or '${CURRENT_STATUS}' == 'Cancelled'
        Refresh Deployment Page
    END

Get status of deployment
    [Documentation]             Get the current status of the deployment page
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 22th DEC, 2021
    ${STATUS}=                  GetText                     ${DEPLOYMENT_STATUS_WEBELEMENT}
    [Return]                    ${STATUS}

Refresh Deployment Page
    [Documentation]             Refresh the Deployment page every 25s
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 22th DEC, 2021
    RefreshPage
    Sleep                       20s
    
Create Data Deployment
    [Documentation]             Create empty Data deployment
    ...                         Author: Naveen
    ...                         Date: 8th Mar, 2022
    [Arguments]                 ${SOURCE_CREDENTIAL}
    Open Object                 Deployments
    ClickText                   New
    VerifyText                  New Deployment
    ClickText                   Data Deployment             anchor=Select a Data Template
    ClickText                   Next
    VerifyText                  New Deployment: Data Deployment
    ${DATA_DEPLOYMENT_NAME}=    Generate random name
    TypeText                    Deployment Name             ${DATA_DEPLOYMENT_NAME}     anchor=Information
    Select record from lookup field                         Search Credentials...       ${SOURCE_CREDENTIAL}
    ClickText                   Save                        anchor=2
    [Return]                    ${DATA_DEPLOYMENT_NAME}

Add Source Credential To Data Deployment
    [Documentation]             Add source credential to data deployment record
    ...                         Author: Naveen
    ...                         Date: 8th Mar, 2022
    [Arguments]                 ${SOURCE_CREDENTIAL}
    VerifyAny                   Add Name & Source, New Data Deployment, Select a source
    TypeText                    ${SELECT_DD_SOURCE_ORG_WEBELEMENT}            ${SOURCE_CREDENTIAL}
    ${SRC_CRED_STATUS}=         Run Keyword And Return Status                           VerifyCheckboxValue         ${DD_CREDENTIAL_WEBELEMENT}    off
    Log To Console              ${SRC_CRED_STATUS}
    Run Keyword If              ${SRC_CRED_STATUS}          ClickElement                ${DD_CREDENTIAL_WEBELEMENT}
    VerifyAll                   Back, Save & Close, Confirm Source
    ClickText                   Confirm Source
    VerifyAll                   New Data Deployment, Add Target, Credential Name, Username, Environment

Add Target Credential To Data Deployment
    [Documentation]             Add target credential to data deployment record
    ...                         Author: Naveen
    ...                         Date: 8th Mar, 2022
    [Arguments]                 ${TARGET_CREDENTIAL}
    TypeText                    ${SELECT_DD_TARGET_ORG_WEBELEMENT}            ${TARGET_CREDENTIAL}
    ${TGT_CRED_STATUS}          Run Keyword And Return Status                           VerifyCheckboxValue         ${DD_CREDENTIAL_WEBELEMENT}    off
    Log To Console              ${TGT_CRED_STATUS}
    Run Keyword If              ${TGT_CRED_STATUS}          ClickElement                ${DD_CREDENTIAL_WEBELEMENT}
    VerifyAll                   Back, Save & Close, Confirm Target
    ClickText                   Confirm Target
    VerifyAll                   New Data Deployment, Select Data Template, ${TARGET_CREDENTIAL}, Data Template Name, Description

Add Data Template To Data Deployment
    [Documentation]             Add data template to data deployment record
    ...                         Author: Naveen
    ...                         Date: 8th Mar, 2022
    [Arguments]                 ${DATA_TEMPLATE}
    TypeText                    ${SELECT_DD_DATA_TEMPLATE_WEBELEMENT}            ${DATA_TEMPLATE}
    ${DATA_TEMPLATE_STATUS}     Run Keyword And Return Status                           VerifyCheckboxValue         ${DD_CREDENTIAL_WEBELEMENT}    off
    Run Keyword If              ${DATA_TEMPLATE_STATUS}     ClickElement                ${DD_CREDENTIAL_WEBELEMENT}
    ClickText                   Confirm Selection
    VerifyAll                   Deployment Overview, ${DATA_TEMPLATE}, Template Schema Credential:, Max. Record Limit:, Total Related Objects:, Filter Override:, Batch Size:, Back, Save & Close, Validate Deployment, Start Deployment
