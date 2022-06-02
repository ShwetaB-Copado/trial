*** Settings ***
Documentation                   Contains common keywords required for application object
Resource                        ../common_keywords.robot

*** Keywords ***
Create New Application
    [Documentation]             Create new application and return application name
    #Open New Application window and enter the details
    ${PRODUCT_MANAGER}=         Get Username
    ClickText                   New
    VerifyText                  New Application
    ${APPLICATION_NAME}=        Generate random name
    Enter Input Field           Name                        ${APPLICATION_NAME}
    Select record from lookup field                         Search People...            ${PRODUCT_MANAGER}
    ClickText                   Stability
    ClickText                   Stable                      anchor=--None--
    ClickText                   Release Status
    ClickText                   GA                          anchor=--None--
    ${APPLICATION_DESCRIPTION}=                             Generate random name
    ClickText                   Remove formatting
    TypeText                    Description                 ${APPLICATION_DESCRIPTION}                              anchor=Remove formatting
    #Save and verify new application record created succesfully
    ClickText                   Save                        2
    VerifyText                  Details
    VerifyText                  ${APPLICATION_NAME}         anchor=Information
    [Return]                    ${APPLICATION_NAME}