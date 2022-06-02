*** Settings ***
Documentation            Contains common keywords related to work manager
Library                  Collections
Resource                 ../common_keywords.robot
Resource                 ../../resources/webelements/work_manager_webelement.robot

*** Keywords ***
Create Or Modify Configuration
    [Documentation]      Create or Edit a new configuration in work manager
    ...                  Author : Dhanesh
    [Arguments]          ${ROW}                      ${OPTION}                   #Expected options: New or Edit
    ${NAME}=             Generate Random String      length=10                   chars=LETTERS
    Run Keyword If       '${OPTION}'=='New'          VerifyText                  New Configuration
    ...                  ELSE                        VerifyText                  Edit Configuration
    TypeText             xpath\=//label[text()\='Name:']/parent::div/input       ${NAME}
    TypeText             xpath\=//label[text()\='Rows Per Panel:']/parent::div/input                         ${ROW}
    ClickText            Save
    VerifyNoText         Loading
    DropDown             xpath\=//select[contains(@id,'configName')]             ${NAME}
    ${SELECTED_NAME}=    GetSelected                 xpath\=//select[contains(@id,'configName')]             ${NAME}                     #Verify the created/Edited config name
    Should Be Equal      ${SELECTED_NAME}            ${NAME}
    [Return]             ${NAME}

Remove Configuration
    [Documentation]      Remove and verify the work manager configuration
    ...                  Author : Dhanesh
    [Arguments]          ${CONFIG_NAME}
    VerifyOption         xpath\=//select[contains(@id,'configName')]             ${CONFIG_NAME}
    DropDown             xpath\=//select[contains(@id,'configName')]             ${CONFIG_NAME}
    ClickText            Remove
    ${REMOVE_ALERT}      GetAlertText                #To verify and accept the alert
    Run Keyword If       '${REMOVE_ALERT}'=='Are you sure you want to delete this configuration?'            CloseAlert                  Accept
    ...                  ELSE                        Fail                        Alert text message is wrong for Remove
    VerifyNoOption       xpath\=//select[contains(@id,'configName')]             ${CONFIG_NAME}              timeout=5s

Verify Panel Dropdown
    [Documentation]      To verify the panel dropdown values in work manager
    ...                  Author : Dhanesh
    [Arguments]          ${EXPECTED_OPTIONS}
    ${PANEL_OPTIONS}=    GetDropDownValues           ${PANEL_DROPDOWN_VALUES_WEBELEMENT}                         
    ${LENGTH}=           Get Length                  ${EXPECTED_OPTIONS}
    FOR                  ${I}                        IN RANGE                    0                           ${LENGTH}
        ${EXPECTED}=     Get From List               ${EXPECTED_OPTIONS}         ${I}
        Should Contain                               ${PANEL_OPTIONS}            ${EXPECTED}
    END

Add Panel
    [Documentation]      To add and verify panel
    ...                  Author : Dhanesh
    [Arguments]          ${OPTION}                   ${NAME}                     #OPTION: Sprint, Epic etc NAME: Sprint name, Epic name etc
    DropDown             ${PANEL_DROPDOWN_WEBELEMENT}                      ${OPTION}
    TypeText             ${PANEL_SEARCH_WEBELEMENT}                        ${NAME}                     click=True
    VerifyText           Add Panel
    ClickElement         ${PANEL_LOOKUP_WEBELEMENT}
    SwitchWindow         2                           #Switch to the new window
    VerifyText           Lookup
    ClickText            ${NAME}                     anchor=Name
    SwitchWindow         1                           #Switch to default content
    VerifyText           Add Panel
    ClickText            Add Panel
    VerifyNoText         Loading
    VerifyText           Refresh Panels     
    ClickText            Refresh Panels    
    VerifyNoText         Loading    
    SetConfig            PartialMatch                True    
    VerifyAll            ${OPTION}, ${NAME}
    VerifyElementText    ${ADDED_PANEL_HEADER_WEBELEMENT}                  ${OPTION} 
    VerifyElementText    ${ADDED_PANEL_HEADER_WEBELEMENT}                  ${NAME}                 

Remove Panel
    [Documentation]      To remove the work manager panel
    ...                  Author : Dhanesh
    [Arguments]          ${NAME}
    ${PANEL_ELEMENT}=    Set Variable                xpath\=//h2//a[contains(text(),'${NAME}')]/ancestor::div[@class\='slds-media']//button[@class\='close-button']
    ClickElement         ${PANEL_ELEMENT}            #To close the panel according to the panel name
    ${REMOVE_ALERT}      GetAlertText                timeout=3s                  #To verify and accept the alert
    Run Keyword If       '${REMOVE_ALERT}'=='Are you sure you want to delete this Panel?'                    CloseAlert                  Accept
    ...                  ELSE                        Fail                        Alert text message is wrong for Remove panel
    VerifyNoElement      ${PANEL_ELEMENT}            timeout=3s

Enable Or Disable WIP
    [Documentation]      To enable or disable the work in progress and verify
    ...                  Author : Dhanesh
    [Arguments]          ${OPTION}                   #Expected options: Enable/Disable.
    ${WIP_ARROW}=        Set Variable                xpath\=//button[@title\='Show/Hide Columns']
    ${MIN}=              Set Variable                xpath\=//input[@id\='min' and contains(@style,'visibility: visible')]
    ${MAX}=              Set Variable                xpath\=//input[@id\='max' and contains(@style,'visibility: visible')]
    ClickElement         ${WIP_ARROW}
    VerifyText           Enable WIP
    ClickText            Enable WIP
    ClickElement         ${WIP_ARROW}
    Run Keyword If       '${OPTION}'=='Enable'       Verify WIP enabled          ${MIN}                      ${MAX}
    ...                  ELSE                        Verify WIP disabled         ${MIN}                      ${MAX}

Verify WIP Enabled
    [Documentation]      To verify the min and max in WIP is enabled
    ...                  Author : Dhanesh
    [Arguments]          ${MIN}                      ${MAX}
    VerifyElement        ${MIN}
    VerifyElement        ${MAX}

Verify WIP Disabled
    [Documentation]      To verify the min and max in WIP is disabled
    ...                  Author : Dhanesh
    [Arguments]          ${MIN}                      ${MAX}
    VerifyNoElement      ${MIN}
    VerifyNoElement      ${MAX}

Verify WIP
    [Documentation]      To verify WIP accoring to the Min and Max values provided
    ...                  Author : Dhanesh
    [Arguments]          ${MIN_VALUE}                ${MAX_VALUE}                ${BACKGROUND_COLOUR}
    TypeText             xpath\=//input[@id\='max']                              ${MAX_VALUE}
    VerifyText           Refresh Panels
    ClickText            WORK MANAGER                anchor=New
    TypeText             xpath\=//input[@id\='min']                              ${MIN_VALUE}
    ClickText            WORK MANAGER                anchor=New
    ClickText            Refresh Panels
    VerifyNoText         Loading
    VerifyText           Refresh Panels
    VerifyElement        xpath\=//div[@class\='slds-media__body' and contains(@style,'${BACKGROUND_COLOUR}')]

Verify Wrong WIP
    [Documentation]      Verify alert is displayed when user enter min value greater than max value
    ...                  Author : Dhanesh
    [Arguments]          ${MIN_VALUE}                ${MAX_VALUE}
    TypeText             xpath\=//input[@id\='max']                              ${MAX_VALUE}
    VerifyText           Refresh Panels
    ClickText            WORK MANAGER                anchor=New
    TypeText             xpath\=//input[@id\='min']                              ${MIN_VALUE}
    ${WIP_ALERT}=        GetAlertText
    Run Keyword If       '${WIP_ALERT}'=='Minimum value can not be greater than maximum value'               CloseAlert                  Accept
    ...                  ELSE                        Fail                        Alert text message is wrong for WIP

Edit Work Manager US
    [Documentation]      To verify the edit user story from work manager panel
    ...                  Author : Dhanesh
    [Arguments]          ${US_ID}
    VerifyText           ${US_ID}
    ClickElement         xpath\=//a[text()\='${US_ID}']/parent::td/parent::tr//a[@title\='Edit']
    ${HEADER}=           Evaluate                    "Edit " + "${US_ID}"
    VerifyText           ${HEADER}
    ${EDIT_TITLE}=       Generate random name
    TypeText             Title                       ${EDIT_TITLE}               anchor=1
    ClickText            Save                        anchor=2
    VerifyText           was saved
    ClickText            Refresh Panels
    VerifyNoText         Loading
    VerifyText           Refresh Panels
    VerifyText           ${EDIT_TITLE}               anchor=TITLE
    [Return]             ${EDIT_TITLE}

Check And Remove Default Panels
    [Documentation]      To check and remove the existing panels available in a configuration
    ...                  Author : Dhanesh
    VerifyText           Refresh Panels
    ${COUNT}=            GetElementCount             xpath\=//button[@class\='close-button']
    FOR                  ${INDEX}                    IN RANGE                    0                           ${COUNT}
        ClickElement     xpath\=(//button[@class\='close-button'])[1]
        CloseAlert       Accept
        VerifyText       Refresh Panels
        ClickText        Refresh Panels
        VerifyNoText     Loading
    END

Edit Configuration With Filters
    [Documentation]      To add filters to the panels
    ...                  Author : Dhanesh
    [Arguments]          ${POSITION}                 ${OPTION}                   ${NAME}                     ${FILTER_LOGIC}             ${ROWS_PER_PANEL}
    ClickText            Edit
    VerifyText           Edit Configuration
    ClickElement         xpath\=//button[text()\='Add Line']
    VerifyNoText         Loading
    VerifyText           Filter Logic:               anchor=Remove
    DropDown             xpath\=(//select[contains(@id,'relatedObjects2')])[${POSITION}]                     ${OPTION}
    VerifyText           Filter Logic:               anchor=Remove
    TypeText             xpath\=(//input[contains(@class,'iField')])[${POSITION}]                            ${NAME}                     click=True
    VerifyText           Filter Logic:               anchor=Remove
    ClickElement         xpath\=(//img[@class\='lookupIcon'])[${POSITION}]
    SwitchWindow         2                           #Switch to the new window
    VerifyText           Lookup
    ClickText            ${NAME}                     anchor=Name
    SwitchWindow         1                           #Switch to default content
    VerifyText           Filter Logic:               anchor=Remove
    VerifyText           Rows Per Panel:
    TypeText             Filter Logic:               ${FILTER_LOGIC}
    TypeText             Rows Per Panel:             ${ROWS_PER_PANEL}
    ClickText            Save
    ${ISTRUE}=           IsAlert                     timeout=2s
    Run Keyword If       '${ISTRUE}'=='True'         CloseAlert                  Accept