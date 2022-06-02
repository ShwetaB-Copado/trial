*** Settings ***
Documentation                   Contains keyword for Data Template
Resource                        ../common_keywords.robot
Resource                        ../../resources/webelements/recordmatchingformula_webelement.robot
Resource                        ../../resources/common_elements.robot
Resource                        ../../resources/objects/developer_org.robot
Resource                        ../../resources/objects/recordmatchingformula.robot
Resource                        ../../resources/webelements/datatemplate_webelement.robot

*** Keywords ***
Create Data Template
    [Documentation]             Create New Data Template
    ...                         Author: Naveen Ramesh
    ...                         Date: 26th Feb 2022
    VerifyText                  New
    ClickText                   New
    VerifyText                  New Data Template
    ${DATA_TEMPLATE_RANDOM_NAME}                            Generate random name
    ${DATA_TEMPLATE_NAME}=      Evaluate                    "DataTemplate_" + "${DATA_TEMPLATE_RANDOM_NAME}"
    TypeText                    ${DATA_TEMPLATE_NAME_WEBELEMENT}                        ${DATA_TEMPLATE_NAME}
    TypeText                    Description                 This is from Automation script
    ClickText                   Save                        anchor=2
    VerifyNoElement             ${DATA_SCHEMA_SPINNER_WEBELEMENT}
    VerifyCheckboxStatus        Active                      disabled
    VerifyAll                   Details, Object Fields, Parent Objects, Child Objects, Main Object Filter, Deployment Options, Relationship Diagram
    [Return]                    ${DATA_TEMPLATE_NAME}

Define Data Schema
    [Documentation]             Define Data Schema by specifing credentail and object name
    ...                         Author: Naveen Ramesh
    ...                         Date: 26th Feb 2022
    [Arguments]                 ${CREDENTIAL_NAME}          ${OBJECT_NAME}
    ClickText                   Define Data Schema
    Select Schema Credential from lookup field              Search Credentials...       ${CREDENTIAL_NAME}
    VerifyNoElement             ${DATA_SCHEMA_SPINNER_WEBELEMENT}
    PressKey                    ${MAIN_OBJECT_WEBELEMENT}                               ${OBJECT_NAME}
    ClickText                   ${OBJECT_NAME}
    ClickText                   Save
    VerifyNoElement             ${DATA_SCHEMA_SPINNER_WEBELEMENT}
    VerifyAll                   Main Object Fields, Field Label, Field API Name, Data Type, Use as External ID, Content Update

Click Refresh Schema
    [Documentation]             Click Refresh Schema
    ...                         Author: Naveen Ramesh
    ...                         Date: 26th Feb 2022
    ClickText                   Refresh Schema
    VerifyNoElement             ${DATA_SCHEMA_SPINNER_WEBELEMENT}
    ${STATUS}                   Run Keyword And Return Status                           VerifyText                  "Data Template Changes"
    Run Keyword If              ${STATUS}                   ClickText                   Close
    VerifyAll                   Details, Object Fields, Parent Objects, Child Objects

Update Field to Auto Generate Values For External Id
    [Documentation]             Update the External Id field to Auto Generate Values
    ...                         Author: Naveen Ramesh
    ...                         Date: 26th Feb 2022
    [Arguments]                 ${FIELD_API_NAME}
    ${CLICK_CONTENT_UPDATE}     Replace String              ${CLICK_CONTENT_UPDATE_WEBELEMENT}                      FIELDAPI_VALUE              ${FIELD_API_NAME}
    ClickElement                ${CLICK_CONTENT_UPDATE}
    ${ACTUAL_FIELD_API_NAME}    Replace String              ${SELECT_AUTO_GENERATE_OPTION_WEBELEMENT}               OPTIONVALUE                 ${FIELD_API_NAME}
    ClickElement                ${ACTUAL_FIELD_API_NAME}
    ClickText                   Configure Formula
    VerifyNoElement             ${DATA_SCHEMA_SPINNER_WEBELEMENT}
    VerifyAll                   Field 1, Field 2, Field 3, Hash External Id Value
    ${USE_EXTERNAL_ID_CHECKBOX}                             Replace String              ${SELECT_USE_EXTERNAL_ID_CHECKBOX_WEBELEMENT}           FIELDAPI_VALUE    ${FIELD_API_NAME}
    ClickElement                ${USE_EXTERNAL_ID_CHECKBOX}
    VerifyText                  ${USE_EXTERNAL_ID_CHECKBOX}

Select Schema Credential from lookup field
    [Documentation]             Search and select Schema Credential record in the lookup field
    ...                         Author: Naveen Ramesh
    ...                         Date: 26th Feb 2022
    [Arguments]                 ${FIELD}                    ${RECORD}
    PressKey                    ${FIELD}                    ${RECORD}
    VerifyText                  Show All Results
    PressKey                    ${FIELD}                    {ENTER}
    VerifyText                  ${SCHEMA_CREDENTIAL_CANCEL_BUTTON_WEBELEMENT}           #Checking modal openend
    ${RECORD_WEBELEMENT}=       Replace String              ${SELECT_RECORD_WEBELEMENT}                             RECORD                      ${RECORD}
    ClickText                   ${RECORD_WEBELEMENT}

Create Custom Object And Custom Field With External ID Checked
    [Documentation]             Create's Custom Object and select External Id option for the Custom Field that is created
    ...                         Author: Naveen Ramesh
    ...                         Date: 26th Feb 2022
    [Arguments]                 ${SOURCE_ORG}               ${FIELD_TYPE}               ${FIELD_LENGTH}
    Switch To Lightning         #Switch to lightning if classic view opened
    VerifyText                  Object Manager
    ${CUSTOM_OBJECT_NAME}       Generate random name
    ${CUSTOM_OBJECT_PLURAL_NAME}                            Evaluate                    "${CUSTOM_OBJECT_NAME}"
    Create Custom Object        ${CUSTOM_OBJECT_NAME}       ${CUSTOM_OBJECT_PLURAL_NAME}
    VerifyAll                   Fields & Relationships, Page Layouts, Field Sets
    ClickText                   Fields & Relationships
    VerifyAll                   New, Deleted Fields, Field Dependencies
    ClickText                   New
    ${RANDOM_FIELD_NAME}=       Generate random name
    ${FIELD_LIST}               Create New Text Field With External Id Checked          ${RANDOM_FIELD_NAME}        Text                        50
    ${FIELD_API_NAME}           Get From List               ${FIELD_LIST}               0
    ${FIELD_NAME}               Get From List               ${FIELD_LIST}               1
    ${OBJECT_DETAILS}           Create List                 ${CUSTOM_OBJECT_NAME}       ${FIELD_API_NAME}           ${FIELD_NAME}
    [Return]                    ${OBJECT_DETAILS}

Create Data Template assign Record Matching Formula and Activate Template
    [Documentation]             Method will create Data Template, Record Matching Formula also assign it to Data Template and Activate the Template
    ...                         Author: Naveen
    ...                         Date: 22 Mar, 2022
    [Arguments]                 ${SOURCE_ORG}               ${OBJECT_NAME}              ${EXTERNAL_FIELD_API_NAME}    ${EXTERNAL_FIELD_NAME}                              ${FIELD_VALUE_1}
    Open Object                 Data Templates
    ${DATA_TEMPLATE_NAME}       Create Data Template
    Define Data Schema          ${SOURCE_ORG}               ${OBJECT_NAME}
    ClickText                   Edit                        anchor=Refresh Schema
    ScrollTo                    Account Rating
    ScrollTo                    Billing Country
    ScrollTo                    Clean Status
    ScrollTo                    Industry
    ScrollTo                    Shipping City
    ScrollTo                    SIC Code
    ScrollTo                    Ticker Symbol
    ScrollTo                    Website
    ClickElement                ${SELECT_ALL_FIELD_ON_DATA_TEMPLATE_WEBELEMENT}
    ScrollTo                    Account Name
    Select Specific Field On Data Template                  ${EXTERNAL_FIELD_NAME}
    Select Specific Field On Data Template                  Account Name
    Select Specific Field On Data Template                  Account Phone
    Update Field to Auto Generate Values For External Id    ${EXTERNAL_FIELD_API_NAME}
    Configure Field Values For Record Matching Formula      Field 1                     ${FIELD_VALUE_1}
    ClickText                   Save                        anchor=Cancel
    VerifyNoElement             ${DATA_SCHEMA_SPINNER_WEBELEMENT}
    ${EXT_ID_FIELD}             Replace String              ${EXT_ID_FIELD_WEBELEMENT}                              EXTFIELDNAME                ${EXTERNAL_FIELD_API_NAME}
    Log To Console              ${EXT_ID_FIELD}
    #ClickElement                ${EXT_ID_FIELD}
    #ScrollTo                    Account Rating
    #ScrollTo                    Billing Country
    #ScrollTo                    Industry
    #ScrollTo                    Shipping Country
    #ScrollTo                    SIC Code
    #ScrollTo                    Website
    #ClickElement                ${SELECT_ALL_FIELD_ON_DATA_TEMPLATE_WEBELEMENT}
    #ScrollTo                    Account Name
    #Select Specific Field On Data Template                  ${EXTERNAL_FIELD_NAME}
    #Select Specific Field On Data Template                  Account Name
    #Select Specific Field On Data Template                  Account Phone
    ClickText                   Save
    Activate Data Template
    [Return]                    ${DATA_TEMPLATE_NAME}

Activate Data Template
    [Documentation]             Activate the Template and verify whether checkbox is Activated
    ...                         Author: Naveen
    ...                         Date: 22 Mar, 2022
    ClickText                   Activate
    VerifyText                  Activate Data Template
    ClickText                   Activate                    anchor=Cancel
    VerifyCheckboxValue         Active                      on

Search Object And Create Text Field With External Id Checked
    [Documentation]             Create's Custom Object and select External Id option for the Custom Field that is created
    ...                         Author: Naveen Ramesh
    ...                         Date: 26th Feb 2022
    [Arguments]                 ${OBJECT_NAME}              ${RANDOM_FIELD_NAME}        ${TEXT_FIELD_LENGTH}
    Search Object in Object Manager                         ${OBJECT_NAME}
    ClickText                   Fields & Relationships
    VerifyAll                   New, Deleted Fields, Field Dependencies
    ${FIELD_LIST}               Create New Text Field With External Id Checked          ${RANDOM_FIELD_NAME}        Text                        ${TEXT_FIELD_LENGTH}
    ${FIELD_API_NAME}           Get From List               ${FIELD_LIST}               0
    ${FIELD_NAME}               Get From List               ${FIELD_LIST}               1
    ${OBJECT_DETAILS}           Create List                 ${OBJECT_NAME}              ${FIELD_API_NAME}           ${FIELD_NAME}
    [Return]                    ${OBJECT_DETAILS}

Select Specific Field On Data Template 
    [Documentation]             Select the checkbox of specific field on data template
    [Arguments]                 ${FIELDNAME}
    ${SELECT_FIELD}             Replace String              ${DATA_TEMPLATE_FIELD_CHECKBOX_WEBELEMENT}              DATATEMPLATE_FIELDNAME      ${FIELDNAME}
    ClickCheckbox               ${SELECT_FIELD}             on

Select Or Deselect All Fields On Data Template
    [Documentation]             Provide the last field name from the list to scroll to the bottom of the list
    [Arguments]                 ${LAST_FIELDNAME}
    ScrollTo                    ${LAST_FIELDNAME}
    ClickElement                ${SELECT_ALL_FIELD_ON_DATA_TEMPLATE_WEBELEMENT}
