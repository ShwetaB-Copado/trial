*** Settings ***
Documentation                   List of all the keywords used from the Environments object
Resource                        ../common_keywords.robot
Resource                        ../../resources/webelements/e2eautomation_webelement.robot

*** Keywords ***
Create Environment
    [Documentation]             To create a new Environment in the Environments object
    ...                         Author: Dhanesh
    ...                         Modified Date: 18th Nov 2021
    [Arguments]                 ${PLATFORM}
    VerifyText                  New
    ClickText                   New
    VerifyText                  New Environment
    Enter Environment field values                          ${PLATFORM}
    SetConfig                   PartialMatch                False
    ClickText                   Save
    SetConfig                   PartialMatch                True

Enter Environment Field Values
    [Documentation]             To enter Environment field values when creating a new Environment
    ...                         Author: Dhanesh
    ...                         Modified Date: 18th Nov 2021
    [Arguments]                 ${PLATFORM}
    ${ENVIRONMENT_NAME}=        Generate random name
    TypeText                    Environment Name            ${ENVIRONMENT_NAME}    anchor=New Environment
    Select value from dropdown list                         Platform               ${PLATFORM}               New Environment

Get Environment ContextID
    [Documentation]             To get the context id from an environment
    ...                         Author: Dhanesh
    ...                         Modified Date: 18th Nov 2021
    [Arguments]                 ${ENVIRONMENT}
    Open Object                 Environments
    Open record from object main page                       ${ENVIRONMENT}
    VerifyText                  ${ENVIRONMENT}
    ${CONTEXTID}=               Get ContextId
    [Return]                    ${CONTEXTID}

Get Credential ContextID
    [Documentation]             To get the context id from a credential
    ...                         Author: Dhanesh
    ...                         Date: 18th Feb 2022
    [Arguments]                 ${CREDENTIAL}
    Open Object                 Credentials
    Run Keyword And Ignore Error                            ClickText                   Select List View
    ${ISPRESENT}=               Run Keyword And Return Status                           VerifyText                  All               timeout=5s
    Run Keyword If              ${ISPRESENT}                ClickText                   All
    Run Keyword And Ignore Error                            ClickText                   ALL Env                     timeout=2s
    VerifyNoText                Loading
    PressKey                    Search this list...         ${CREDENTIAL}
    VerifyNoText                Loading
    ClickElement                ${REFRESH_BUTTON_WEBELEMENT}
    VerifyNoText                Loading
    VerifyText                  ${CREDENTIAL}               anchor=Credential Name
    ClickText                   ${CREDENTIAL}               anchor=Credential Name
    VerifyNoText                Loading
    ${CONTEXTID}=               Get ContextId
    [Return]                    ${CONTEXTID}

Update Credential Type And User
    [Documentation]             To get the context id from a credential
    ...                         Author: Sachin
    ...                         Date: 11th May 2022
    [Arguments]                 ${CREDENTIAL}               ${USERNAME}                 ${PASSWORD}
    Open Object                 Credentials
    Run Keyword And Ignore Error                            ClickText                   Select List View
    ${ISPRESENT}=               Run Keyword And Return Status                           VerifyText                All           timeout=5s
    Run Keyword If              ${ISPRESENT}                ClickText                   All
    Run Keyword And Ignore Error                            ClickText                   ALL Env                   timeout=2s
    VerifyNoText                Loading
    PressKey                    Search this list...         ${CREDENTIAL}
    VerifyNoText                Loading
    ClickElement                ${REFRESH_BUTTON_WEBELEMENT}
    VerifyNoText                Loading
    VerifyText                  ${CREDENTIAL}               anchor=Credential Name
    ClickText                   ${CREDENTIAL}               anchor=Credential Name
    ClickText                   Hide message                anchor=Loading
    VerifyNoText                Loading
    ClickText                   Authenticate                anchor=Delete
    Sleep                       3s                          #Waiting for the login page
    CloseWindow
    SwitchWindow                NEW
    TypeText                    ${USERNAME_WEBELEMENT}      ${USERNAME}
    TypeText                    ${PASSWORD_WEBELEMENT}      ${PASSWORD}
    ClickElement                ${EE_LOGINBUTTON_WEBELEMENT}                            timeout=5s
    VerifyText                  Allow Access?
    ClickElement                ${ALLOW_BUTTON_WEBELEMENT}
    Sleep                       7s                          #To wait until Page is loaded
    RefreshPage
    Open Object                 Credentials