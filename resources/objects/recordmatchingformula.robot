*** Settings ***
Documentation                   Contains keyword for Record Matching Formula
Resource                        ../common_keywords.robot
Resource                        ../../resources/webelements/recordmatchingformula_webelement.robot
Resource                        ../../resources/common_elements.robot
Resource                        ../../resources/objects/developer_org.robot

*** Keywords ***
Create Record Matching Formula Through App Launcher
    [Documentation]             Create Record Matching Formula via App Launcher
    ...                         Author: Naveen Ramesh
    ...                         Date: 26th Feb 2022
    [Arguments]                 ${DEV_SOURCE_ORG}
    VerifyText                  New
    ClickText                   New
    VerifyAll                   New Record Matching Formula, *Record Matching Formula Name, *Configuration Schema Credential, Cancel, Save & New
    VerifyText                  Save                        anchor=2
    ${RANDOMNAME}               Generate random name
    ${RMF_NAME}=                Evaluate                    "RMF_" + "${RANDOMNAME}"
    TypeText                    ${RMF_NAME_WEBELEMENT}      ${RMF_NAME}
    Select record from lookup field                         ${SCHEMA_CREDENTIALS_WEBELEMENT}                        ${DEV_SOURCE_ORG}
    ClickText                   Save                        anchor=2
    VerifyNoElement             ${DATA_SCHEMA_SPINNER_WEBELEMENT}
    VerifyText                  ${RMF_NAME}
    VerifyAll                   You have not configured record matching formula., Configure Record Matching Formula

Click Configure Record Matching Formula And Add Object
    [Documentation]             Create Record Matching Formula via App Launcher
    ...                         Author: Naveen Ramesh
    ...                         Date: 26th Feb 2022
    [Arguments]                 ${OBJECT_NAME}
    ClickText                   Configure Record Matching Formula
    VerifyNoElement             ${DATA_SCHEMA_SPINNER_WEBELEMENT}
    PressKey                    ${SEARCH_OBJECT_WEBELEMENT}                          ${OBJECT_NAME}
    VerifyText                  ${OBJECT_NAME}
    ClickText                   ${OBJECT_NAME}
    VerifyNoElement             ${DATA_SCHEMA_SPINNER_WEBELEMENT}

Configure Field Values For Record Matching Formula
    [Documentation]             Selects one or more Field values for Record Matching Formula
    ...                         Author: Naveen Ramesh
    ...                         Date: 26th Feb 2022
    [Arguments]                 ${FIELD_LABEL}              ${FIELD_VALUE}              # ${FIELD_LABEL} - Name of the field for which option is selected, ${FIELD_VALUE} - picklistvalue to be selected
    ${SELECT_RMF_FIELD}=        Replace String              ${FIELD_OPTION_WEBELEMENT}                              RMF_FIELDLABEL       ${FIELD_LABEL}
    VerifyElement               ${SELECT_RMF_FIELD}
    ClickElement                ${SELECT_RMF_FIELD}
    ClickText                   ${FIELD_VALUE}
    VerifyNoElement             ${DATA_SCHEMA_SPINNER_WEBELEMENT}
