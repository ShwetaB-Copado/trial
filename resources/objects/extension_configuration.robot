*** Settings ***
Documentation                   Contains common keywords related to "Extension Configuration" Object
Resource                        ../common_keywords.robot

*** Variables ***
${INACTIVE_INFO_MESSAGE}        The Extension Configuration is inactive. Select an Extension Tool. If you have not configured an extension tool yet, navigate to Setup to configure it. For some tools, you need to populate additional information in the Extension Configuration record.
${ACTIVATE_SUCCESS_MESSAGE}     The Extension Configuration is successfully activated
${DEACTIVATE_SUCCESS_MESSAGE}                               Extension Configuration deactivated
${DEACTIVATE_CONFIRM_MESSAGE}                               By deactivating the extension, all tests previously assigned to the tool will not be executable and the extension configuration will not be available to select as a tool in Test records.

*** Keywords ***
Change the Tool Type of existing Extension Configuration
    [Arguments]                 ${EXTENSION_CONFIGURATION}                              ${EXTENSION_TOOL}
    [Documentation]             Method to change the extension tool of exsiting Extension Configuration
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 02nd March, 2022
    Open Object                 Extension Configurations
    Open record from object main page                       ${EXTENSION_CONFIGURATION}
    VerifyText                  Details
    VerifyText                  ${EXTENSION_CONFIGURATION}                              anchor=Name
    ClickText                   Edit Extension Tool
    Sleep                       2s                          #To handle the random failure
    ClickText                   Extension Tool
    ClickText                   ${EXTENSION_TOOL}           partial_Match=False
    ClickText                   Save                        anchor=Cancel
    VerifyText                  ${EXTENSION_TOOL}           anchor=Edit Extension Tool

Create Extension Configuration
    [Arguments]                 ${EXTENSION_TOOL}
    [Documentation]             Method to create Extension Configuration
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 21st March, 2022
    ClickText                   New
    VerifyText                  New Extension Configuration
    ${EXTENSION_NAME}=          Generate random name
    Enter Input Field           Name                        ${EXTENSION_NAME}
    ClickText                   None                        anchor=Extension Tool
    Sleep                       2s                          #To handle the random issue.
    ClickText                   ${EXTENSION_TOOL}           anchor=None
    ClickText                   Save                        2
    VerifyText                  Details
    VerifyText                  Extension Configuration
    VerifyText                  ${EXTENSION_NAME}           anchor=Edit Name
    VerifyText                  ${EXTENSION_TOOL}           anchor=Extension Tool
    [Return]                    ${EXTENSION_NAME}

Activate Extension Configuration
    [Documentation]             Method to activate the existing Extension Configuration
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 30th March, 2022
    VerifyText                  Edit                        #To check page loaded properly
    #Click on activate button
    Open Show more actions on Details page
    VerifyText                  Activate
    ClickText                   Activate
    #Check the message and status after activation
    VerifyText                  ${ACTIVATE_SUCCESS_MESSAGE}
    Verify active status of Extension Configuration

Deactivate Extension Configuration
    [Documentation]             Method to deactivate the existing Extension Configuration
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 30th March, 2022
    VerifyText                  Edit
    #Click on deactivate button and confirm deactivation
    Open Show more actions on Details page
    VerifyText                  Deactivate
    ClickText                   Deactivate
    VerifyText                  Deactivate Extension Configuration
    ClickText                   Deactivate                  anchor=Cancel
    #Check the message and status after deactivation
    VerifyText                  ${DEACTIVATE_SUCCESS_MESSAGE}
    Verify Inactive status of Extension Configuration

Verify Active status of Extension Configuration
    [Documentation]             Method to verify the active status of the existing Extension Configuration
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 30th March, 2022
    VerifyCheckboxValue         Active                      on
    VerifyText                  Active                      anchor=Extension Configuration Status
    VerifyNoText                ${INACTIVE_INFO_MESSAGE}

Verify Inactive status of Extension Configuration
    [Documentation]             Method to verify the inactive status of the existing Extension Configuration
    ...                         Author: Manav Kumar Parasrampuria
    ...                         Date: 30th March, 2022
    VerifyCheckboxValue         Active                      off
    VerifyText                  Inactive                    anchor=Extension Configuration Status
    VerifyText                  ${INACTIVE_INFO_MESSAGE}