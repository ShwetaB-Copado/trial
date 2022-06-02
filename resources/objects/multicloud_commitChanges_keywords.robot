*** Settings ***
Documentation               List of all the keywords used from the multicloud user story commit page
Resource                    ../common_keywords.robot
Resource                    ../../resources/webelements/multicloud_commitChanges_webelements.robot

*** Keywords ***
Pull Changes
    [Documentation]         To pull the metadatas based on the date and time provided
    ...                     Author: Dhanesh
    ...                     Date: 8th NOV 2021
    ...                     Modified: 30th NOV 2021
    [Arguments]             ${DATE}                     ${TIME}
    SetConfig               PartialMatch                False
    VerifyAll               Pull Changes by Date, Get Metadata List, Files             
    SetConfig               PartialMatch                True
    TypeText                Date                        ${DATE}
    ClickText               Time
    TypeText                Time                        ${TIME}
    VerifyText              Pull Changes
    ClickElement            ${PULL_CHANGES_WEBELEMENT}
    VerifyNoText            Loading

MC Select Metadata
    [Documentation]         To MC Select Metadata from the multicloud commit changes page
    ...                     Author: Dhanesh
    ...                     Date: 8th NOV 2021
    [Arguments]             ${METADATA}                 #Argument is of List type
    ${LENGTH}=              Get Length                  ${METADATA}
    FOR                     ${I}                        IN RANGE                    0                          ${LENGTH}
        ${EXPECTED}=        Get From List               ${METADATA}                 ${I}
        ${SELECT_METADATA}=                             Replace String              ${METADATA_CHECKBOX_WEBELEMENT}                {METADATA}    ${EXPECTED}
        SetConfig           PartialMatch                False
        TypeText            Search                      ${EXPECTED}
        PressKey            Search                      {ENTER}
        SetConfig           PartialMatch                True
        VerifyNoText        Loading
        VerifyText          ${EXPECTED}
        ClickElement        ${SELECT_METADATA}
    END
    VerifyNoText            Loading
    VerifyElement           ${COMMIT_CHANGES_BUTTON_WEBELEMENT}
    ClickElement            ${COMMIT_CHANGES_BUTTON_WEBELEMENT}
    VerifyNoText            Loading
    VerifyAll               Commit Message, Re-create Feature Branch, Change Base Branch

MC Commit Metadata
    [Documentation]         To commit the selected metadata in MC commit page
    ...                     Author : Dhanesh, 8th Nov, 2021
    SetConfig               PartialMatch                False
    VerifyText              Commit                      anchor=Cancel
    ClickText               Commit                      anchor=Cancel
    SetConfig               PartialMatch                True
    VerifyNoText            Loading
    VerifyText              User Story Commit

MC Commit Change Base Branch
    [Documentation]         To change base branch in multi-cloud commit changes page
    ...                     Author: Ram Naidu, 29th Nov, 2021
    [Arguments]             ${BASE_BRANCH}    ${RECREATE_FEATURE_BRANCH}
    VerifyAll               Change Base Branch, No
    ClickText               No                anchor=Change Base Branch
    VerifyAll               *Base Branch, Yes
    TypeText                *Base Branch      ${BASE_BRANCH}
    IF                     '${RECREATE_FEATURE_BRANCH}' == 'TRUE'
        ClickText           Re-create Feature Branch
    END

Modify Operation Against Name Of Field
    [Documentation]         To modify the operation against the name of metadata in the multicloud commit changes page
    ...                     Author: Shweta
    ...                     Date: 29th NOV, 2021
    [Arguments]             ${METADATA_DICTIONARY}      #Input data in key(metadata name) value(operation) pair Ex: ${Dictionary} = Create Dictionary Key1=Value1 key2=value2
    ${NUMBEROFITEMS}        Get Dictionary Items        ${METADATA_DICTIONARY}
    FOR                     ${KEY}                      ${VALUE}                    IN                         @{NUMBEROFITEMS}
        SetConfig           PartialMatch                False
        TypeText            Search                      ${KEY}
        PressKey            Search                      {ENTER}
        SetConfig           PartialMatch                True
        ${OPERATION}=       Replace String              ${ACTION_WEBELEMENT}        CUSOBJNAME                 ${KEY}
        ClickElement        ${OPERATION}
        ${MODIFY_PENCIL}=                               Replace String              ${MODIFY_PENCIL_WEBELEMENT}                    CUSOBJNAME    ${KEY}
        ClickElement        ${MODIFY_PENCIL}
        ${TO_PERFORM_OP}=                               Replace String              ${ACTION_DROPDOWN}         CUSOBJNAME          ${KEY}
        ClickElement        ${TO_PERFORM_OP}
        ClickElement        ${TO_PERFORM_OP}
        ${ACTION_DROPDOWN1}=                            Replace String              ${ACTION_DROPDOWN}         CUSOBJNAME          ${KEY}
        PressKey            ${ACTION_DROPDOWN1}         {ENTER}
        Sleep               2s                          reason=Wait is needed since the actions perform quick
        PressKey            ${ACTION_DROPDOWN1}         ${VALUE}
        PressKey            ${ACTION_DROPDOWN1}         {ENTER}
        Sleep               2s                          reason=Wait is needed since the actions perform quick
    END
    ClickText               Save                        anchor=Cancel

Select Metadata with API Name And Commit
    [Documentation]         To select metadata with API Name and commit in the multicloud commit changes page
    ...                     Author: Sachin Talwaria
    ...                     Modified Date: 22nd FEB, 2022
    [Arguments]             ${METADATA}    ${RECREATE_FEATURE_BRANCH}                 #Input the exact field name as displayed in commit page[Along with the API Name] & Re-create variable will mark chekbox as yes (i.e. true) or no (i.e. false) 
    ${LENGTH}=              Get Length                  ${METADATA}
    FOR                     ${I}                        IN RANGE                    0                          ${LENGTH}
        ${EXPECTED}=        Get From List               ${METADATA}                 ${I}
        ${SELECT_METADATA}=                             Replace String              ${METADATAAPI_CHECKBOX_WEBELEMENT}             {METADATA}    ${EXPECTED}
        SetConfig           PartialMatch                False
        TypeText            Search                      ${EXPECTED}
        PressKey            Search                      {ENTER}
        SetConfig           PartialMatch                True
        VerifyNoText        Loading
        VerifyText          ${EXPECTED}
        ClickElement        ${SELECT_METADATA}
    END
    VerifyNoText            Loading
    VerifyElement           ${COMMIT_CHANGES_BUTTON_WEBELEMENT}
    ClickElement            ${COMMIT_CHANGES_BUTTON_WEBELEMENT}
    VerifyNoText            Loading
    VerifyAll               Commit Message, Re-create Feature Branch, Change Base Branch
    IF                     "${RECREATE_FEATURE_BRANCH}" == "TRUE"
        ClickCheckbox       Re-create Feature Branch    on
    END
    SetConfig               PartialMatch                False
    VerifyText              Commit                      anchor=Cancel
    ClickText               Commit                      anchor=Cancel
    SetConfig               PartialMatch                True
    VerifyNoText            Loading
    VerifyText              User Story Commit

Modify Directory Path Of Metadata
    [Documentation]         To modify directory path for a metadata while commiting
    ...                     Author: Shweta
    ...                     Date: 17th DEC, 2021
    [Arguments]             ${DIRECTORY_DICTIONARY}
    #${DEPJOBSTEP_DICTIONARY} - Provide key[Exact METADATANAME] and value[PATH]. Ex:${DEPJOBSTEP_DICTIONARY} Create Dictionary Mname=custompath Mname2=/default/new
    FOR                     ${KEY}                      IN                          @{DIRECTORY_DICTIONARY}
        ${VALUE}=           Get From Dictionary         ${DIRECTORY_DICTIONARY}     ${KEY}
        SetConfig           PartialMatch                False
        TypeText            Search                      ${KEY}
        PressKey            Search                      {ENTER}
        SetConfig           PartialMatch                True
        ${CLICKPATH}=       Replace String              ${DIRECTORY_PATH_PENCIL_WEBELEMENT}                    METADATANAME        ${KEY}
        ClickElement        ${CLICKPATH}
        VerifyElement       ${DIRECTORY_MODIFY_WEBELEMENT}
        TypeText            ${DIRECTORY_MODIFY_WEBELEMENT}                          ${VALUE}
        ClickText           Save                        anchor=Cancel
    END

Retrieve Metadata By Type
    [Documentation]         To retrieve the metadata in the multicloud commit page using metadata type
    ...                     Author: Dhanesh
    ...                     Date: 2nd Feb, 2022
    [Arguments]             ${TYPE}
    VerifyText              Retrieve Metadata by Type and Name
    TypeText                Select Type                 ${TYPE}                     click=True
    ClickText               Type                        partial_match=False
    ClickText               ${TYPE}                     partial_match=False
    VerifyText              Retrieve Metadata           partial_match=False
    ClickText               Retrieve Metadata           partial_match=False
    VerifyNoText            Loading