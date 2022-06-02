*** Settings ***
Documentation              Contains common keywords required for THEMES object
Resource                   ../common_keywords.robot
Resource                   user_story.robot

*** Keywords ***
Create New Theme
    [Documentation]        Create new theme and return theme name
    [Arguments]            ${THEME_STATUS}             ${THEME_ACTIVE}
    #Open New Theme window and wait for loading
    ClickText              New
    VerifyText             New Theme
    #Enter details
    ${THEME_NAME}=         Generate random name
    Enter Input Field      Theme Name                  ${THEME_NAME}
    ${THEME_DETAIL}=       Generate random name
    TypeText               Theme Details               ${THEME_DETAIL}
    ClickText              Status
    ClickText              ${THEME_STATUS}
    ClickCheckbox          Active                      ${THEME_ACTIVE}
    #Save and verify new team record created succesfully
    ClickText              Save                        2
    VerifyText             was created.
    VerifyCheckboxValue    Active                      ${THEME_ACTIVE}
    VerifyAll              ${THEME_NAME}, ${THEME_DETAIL}, ${THEME_STATUS}
    [Return]               ${THEME_NAME}