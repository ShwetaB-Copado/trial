*** Settings ***
Documentation                   Methods for creating various Metadata Group
Resource                        ../../resources/common_keywords.robot

*** Keywords ***
Create Metadata Group
    [Documentation]             Metadata Group creation
    ClickText                   New
    ${METADATA_GROUP_NAME}=     Generate random name
    VerifyText                  New Metadata Group
    TypeText                    Metadata Group Name         ${METADATA_GROUP_NAME}      anchor=2
    ${METADATA_GROUP_DESCRIPTION}=                          Generate random name
    TypeText                    Description                 ${METADATA_GROUP_DESCRIPTION}
    ClickText                   Save                        anchor=2
    VerifyText                  was created
    VerifyText                  Metadata Items
    [Return]                    ${METADATA_GROUP_NAME}

Create Metadata Items
    [Documentation]             Creating Metadata Items for the Group
    [Arguments]                 ${METADATA_GRP_NAME}        ${METADATA_NAME_OPTN}       ${METADATA_TYPE_OPTN}    ${VALUE}
    ClickText                   New
    Select value from dropdown list                         Metadata Name               ${METADATA_NAME_OPTN}    Metadata Item Name
    Select value from dropdown list                         Metadata Type               ${METADATA_TYPE_OPTN}    Value
    TypeText                    Value                       ${VALUE}
    ClickText                   Save                        anchor=2
    VerifyAll                   was created, ${METADATA_TYPE_OPTN}, ${METADATA_NAME_OPTN}, View All
   
Create MetaData Group with MetaData items
    [Documentation]             Create MetaData Group, MetaData Item and Returns MetaData Group Name
    [Arguments]                 ${METADATA_OPTN_LOCAL_VAR}                              ${METADATA_TYPE_OPTN_LOCAL_VAR}                   ${VALUE_LOCAL_VAR}
    ${METADATA_GRP_NAME_LOCAL_VAR}=                         Create Metadata Group
    Create Metadata Items       ${METADATA_GRP_NAME_LOCAL_VAR}                          ${METADATA_OPTN_LOCAL_VAR}                        ${METADATA_TYPE_OPTN_LOCAL_VAR}    ${VALUE_LOCAL_VAR}
    [Return]                    ${METADATA_GRP_NAME_LOCAL_VAR}