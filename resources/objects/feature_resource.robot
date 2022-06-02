*** Settings ***
Documentation            Contains common keywords required for feature object
Resource                 ../common_keywords.robot
Resource                 ../../resources/webelements/application_webelement.robot

*** Keywords ***
Create New Feature
    [Documentation]      Create new feature and return feature name

    #Open New Feature window and wait for loading
    ClickText            New
    VerifyText           New Feature

    #Enter details
    ${FEATURE_NAME}=     Generate random name
    Enter Input Field    Feature Name                ${FEATURE_NAME}
    ClickElement         ${STATUS_NEWFEATURE_WEBELEMENT}         
    ClickText            Requested
    ClickText            Priority                    anchor=Additional Details
    ClickText            1                           anchor=--None--

    #Save and verify new feature record created succesfully
    ClickText            Save                        2
    [Return]             ${FEATURE_NAME}

Update Feature Status
    [Documentation]             Update the status of Feature and verify
    [Arguments]                 ${STATUS}
    ClickText                   Edit Status
    Select value from dropdown list                         Status                      ${STATUS}             Value Type
    ClickText                   Save
    VerifyText                  ${STATUS}                   anchor=Value Type