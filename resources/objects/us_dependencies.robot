*** Settings ***
Documentation                   Contains common keywords required for user story
Library                         Collections
Resource                        ../common_keywords.robot
Resource                        ../webelements/user_story_webelement.robot
Resource                        ../webelements/us_dependencies_webelement.robot

*** Keywords ***
Create New User Story Dependency
    [Documentation]             To create a new user story dependency
    ...                         Author: Shweta B
    ...                         Date: 15th Mar, 2022
    [Arguments]                 ${PARENT_US}                ${RELATIONSHIP_TYPE}        ${CHILD_US}
    Open Object                 User Story Dependencies
    Select The List View
    Sleep                       3s
    ClickText                   New
    VerifyText                  New User Story Dependency
    VerifyElement               ${CHILD_US_SECTION_WEBELEMENT}
    Select record from lookup field                         Search User Stories...      ${PARENT_US}
    ClickElement                ${RELATIONSHIP_TYPE_DROPDOWN_WEBELEMENT}
    ${REL_TYPE}=                Replace String              ${REL_TYPE_VALUE_WEBELEMENT}               RELVALUE                ${RELATIONSHIP_TYPE}
    ClickElement                ${REL_TYPE}
    Select record from lookup field                         Search User Stories...      ${CHILD_US}
    ClickText                   Save                        2
    ${USD_ID}=                  GetText                     ${US_DEPENDENCY_ID_WEBELEMENT}
    [Return]                    ${USD_ID}

Modify Relationship Type details
    [Documentation]             To modify relationship type details for user story dependencies
    ...                         Author: Shweta B
    ...                         Date: 15th Mar, 2022
    [Arguments]                 ${RELATIONSHIP_TYPE}        ${DEPSTATUS}                ${NOTES}
    ClickElement                ${EDIT_REL_TYPE_WEBELEMENT}
    ClickElement                ${RELATIONSHIP_TYPE_DROPDOWN_WEBELEMENT}
    ${REL_TYPE}=                Replace String              ${REL_TYPE_VALUE_WEBELEMENT}               RELVALUE                ${RELATIONSHIP_TYPE}
    ClickElement                ${REL_TYPE}
    ClickElement                ${DEPENECY_STATUS_DROPDOWN_WEBELEMENT}
    ${Status_Val}               Replace String              ${DEP_STATUS_VALUE_WEBELEMENT}             SVALUE                  ${DEPSTATUS}
    ClickElement                ${Status_Val}
    ClickText                   Notes
    TypeText                    ${NOTES_WEBELEMENT}         ${NOTES}
    ClickText                   Save                        anchor=Save & New