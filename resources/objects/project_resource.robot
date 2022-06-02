*** Settings ***
Documentation                   Contains common keywords required for project object
Resource                        ../../resources/webelements/permission_set_webelements.robot
Resource                        ../../resources/webelements/mass_us_webelement.robot
Resource                        ../common_keywords.robot

*** Keywords ***
Create New Project
    [Documentation]             Create new project and return project name
    [Arguments]                 ${PIPELINE_NAME}

    #Open New Project window and wait for loading
    ClickText                   New
    VerifyText                  New Project

    #Enter details
    ${PROJECT_NAME}=            Generate random name
    Enter Input Field           Project Name                ${PROJECT_NAME}
    ClickText                   Select a date
    ClickText                   1                           anchor=Sun                  #Select the date with 1 which is near to sun of the month
    ClickText                   Select a date               2
    ClickText                   28                          anchor=Today                # Select 28 from the calender
    Select record from lookup field                         Search Pipelines...         ${PIPELINE_NAME}
    ${DESCRIPTION_NAME}=        Generate random name
    TypeText                    Description                 ${DESCRIPTION_NAME}

    #Save and verify new sprint record created succesfully
    ClickText                   Save                        2
    VerifyAll                   ${PROJECT_NAME}, ${PIPELINE_NAME}
    [Return]                    ${PROJECT_NAME}

Create New Project without Pipeline
    [Documentation]             Create new project and return project name
    ...                         Author:Preethi
    ...                         Date:11th Jan 2021
    #Open New Project window and wait for loading
    ClickText                   New
    VerifyText                  New Project

    #Enter details
    ${PROJECT_NAME}=            Generate random name
    Enter Input Field           Project Name                ${PROJECT_NAME}
    ClickText                   Select a date
    ClickText                   1                           anchor=Sun                  #Select the date with 1 which is near to sun of the month
    ClickText                   Select a date               2
    ClickText                   28                          anchor=Today                # Select 28 from the calender
    ${DESCRIPTION_NAME}=        Generate random name
    TypeText                    Description                 ${DESCRIPTION_NAME}

    #Save and verify new sprint record created succesfully
    ClickText                   Save                        2
    VerifyAll                   ${PROJECT_NAME}
    [Return]                    ${PROJECT_NAME}

Create Mass Add US
    [Documentation]             Create Mass Add User Story
    [Arguments]                 ${RECORD_ID}                ${TITLE}

    #Enter details and save
    DropDown                    ${RECORDTYPE_WEBELEMENT}    ${RECORD_ID}
    TypeText                    Title                       ${TITLE}
    ClickText                   Add Row
    ClickText                   Update/Save

Create Mass Add Record
    [Documentation]             Create Mass Add US Record

    ...                         Author:Ashok
    ...                         Date:30th NOV 2021

    [Arguments]                 ${RECORD_ID}                ${TITLE}                    ${val}
    ${DROPDOWN_ELEM}=           Replace String              ${MASS_RECORDTYPE_WEBELEMENT}                           ITER      ${val}
    DropDown                    ${DROPDOWN_ELEM}            ${RECORD_ID}
    ${TITLE_ELEM}=              Replace String              ${TITLE_WEBELEMENT}         ITR                         ${val}
    TypeText                    ${TITLE_ELEM}               ${TITLE}
    ClickText                   Add Row