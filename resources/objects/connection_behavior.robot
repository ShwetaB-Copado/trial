*** Settings ***
Documentation                   Methods for creating Connection Behavior
Resource                        ../../resources/common_keywords.robot
Resource                        ../../resources/webelements/connection_behavior_webelement.robot

*** Keywords ***
Create Default Connection Behavior
    [Documentation]             Create Connection Behavior and verify the record
    ...                         Author: Shivangi Agarwal
    ...                         Date:30th Nov 2021
    ${CONNECTION_BEHAVIOR_NAME}=                            Generate random name
    TypeText                    ${CONNECTION_BEHAVIOR_NAME_WEBELEMENT}                  ${CONNECTION_BEHAVIOR_NAME}
    ${CONNECTION_BEHAVIOR_DESCRIPTION}=                     Generate random name
    TypeText                    Description                 ${CONNECTION_BEHAVIOR_DESCRIPTION}
    ClickText                   Save                        anchor=2
    VerifyText                  Details
    VerifyText                  ${CONNECTION_BEHAVIOR_NAME}
    [Return]                    ${CONNECTION_BEHAVIOR_NAME}

Promotion Execution for Automated Option
    [Documentation]             Selecting values from promotion Execution
    ...                         Author: Shivangi Agarwal
    ...                         Date:30th Nov 2021
    [Arguments]                 ${USER_STORY_STATUS_AFT_PROMOTION}                      ${PARALLEL_PROMOTION_EXECUTION}
    ClickElement                ${PROMOTION_EXECUTION_WEBELEMENT}
    ClickText                   Automated                   anchor=--None--
    ClickElement                ${USER_STORY_STATUS_AFTER_PROMOTION_WEBELEMENT}
    VerifyAll                   Ready for testing, Ready for UAT, Completed
    ClickText                   ${USER_STORY_STATUS_AFT_PROMOTION}
    ClickCheckbox               Execute promotions in parallel                          ${PARALLEL_PROMOTION_EXECUTION}

Selecting Back Promotion Details
    [Documentation]             Selecting Back Promotion
    ...                         Author: Shivangi Agarwal
    ...                         Date:30th Nov 2021
    [Arguments]                 ${BACK_PROMOTION_EXECUTION_OPTION}                      ${PARALLEL_BACK_PROMOTION_EXECUTION}
    ScrollTo                    Back-Promotion Execution
    ClickElement                ${BACK_PROMOTION_EXECUTION_WEBELEMENT}
    VerifyAll                   Automated, Scheduled, Manual, Disabled
    ClickText                   ${BACK_PROMOTION_EXECUTION_OPTION}
    ClickCheckbox               Execute back-promotions in parallel                     ${PARALLEL_BACK_PROMOTION_EXECUTION}

Promotion Execution For Scheduled Option
    [Documentation]             Selecting Scheduled option and providing the US size in Promotion Execution section
    ...                         Author: Shivangi Agarwal
    ...                         Date:30th Nov 2021
    [Arguments]                 ${USER_STORY_STATUS_AFT_PROMOTION}                      ${PARALLEL_PROMOTION_EXECUTION}                         ${US_GROUP_SIZE}
    VerifyText                  Information                 anchor=2
    ClickElement                ${PROMOTION_EXECUTION_WEBELEMENT}
    ${CLICK_SCHEDULED_PROMOTION_EXECUTION}=                 Replace String              ${CLICK_SCHEDULED_OPTION_WEBELEMENT}                    EXECUTIONOPTION    Promotion Execution
    ClickElement                ${CLICK_SCHEDULED_PROMOTION_EXECUTION}
    ClickElement                ${USER_STORY_STATUS_AFTER_PROMOTION_WEBELEMENT}
    VerifyAll                   Ready for testing, Ready for UAT, Completed
    ClickText                   ${USER_STORY_STATUS_AFT_PROMOTION}
    ClickCheckbox               Execute promotions in parallel                          ${PARALLEL_PROMOTION_EXECUTION}
    VerifyText                  Scheduled Promotion US Group Size
    TypeText                    Scheduled Promotion US Group Size                       ${US_GROUP_SIZE}

Scheduled Promotion Execution
    [Documentation]             Selecting Scheduled Promotions option when Promotion Execution is set to Scheduled
    ...                         Author: Shivangi Agarwal
    ...                         Date:30th Nov 2021
    [Arguments]                 ${DEPLOY_OPTION}
    ClickElement                ${SCHEDULED_PROMOTION_WEBELEMENT}
    ClickText                   ${DEPLOY_OPTION}
    VerifyAll                   Schedule Deployment, How often do you want to deploy, Hourly, Daily, Weekly, Cron Expression

Every Hour Deployment
    [Documentation]             Scheduling the deployment for Every Hour from Hourly page
    ...                         Author: Shivangi Agarwal
    ...                         Date:30th Nov 2021
    [Arguments]                 ${EVERY_HOUR_TIME}
    ClickElement                ${CLICK_EVERY_HOUR_OPTION_WEBELEMENT}
    DropDown                    Every                       ${EVERY_HOUR_TIME}
    ClickText                   Save                        anchor=Cancel

Specific Time of the Hour Deployment
    [Documentation]             Scheduling the deployment for Specific time from Hourly page
    ...                         Author: Shivangi Agarwal
    ...                         Date:30th Nov 2021
    [Arguments]                 ${SPECIFIC_HOUR_TIME}       ${SPECIFIC_MINUTE_TIME}
    ClickElement                ${CLICK_SPICIFIC_HOUR_OPTION_WEBELEMENT}
    Select Hour And Minutes Time                            ${SPECIFIC_HOUR_TIME}       ${SPECIFIC_MINUTE_TIME}     hourly_starts_at_hourOptions    hourly_starts_at_minuteOptions
    ClickText                   Save                        anchor=Cancel

Daily Deployment
    [Documentation]             Scheduling the deployment for any day when Daily option is selected from Daily page
    ...                         Author: Shivangi Agarwal
    ...                         Date:30th Nov 2021
    [Arguments]                 ${DAY}                      ${SPECIFIC_HOUR_TIME}       ${SPECIFIC_MINUTE_TIME}
    TypeText                    day(s)                      ${DAY}
    Select Hour And Minutes Time                            ${SPECIFIC_HOUR_TIME}       ${SPECIFIC_MINUTE_TIME}     daily_starts_at_hourOptions    daily_starts_at_minuteOptions
    ClickText                   Save                        anchor=Cancel

Week Day Deployment
    [Documentation]             Scheduling the deployment for any day when Week Day option is selected from Daily page
    ...                         Author: Shivangi Agarwal
    ...                         Date:30th Nov 2021
    [Arguments]                 ${SPECIFIC_HOUR_TIME}       ${SPECIFIC_MINUTE_TIME}
    ClickText                   Every Week Day
    Select Hour And Minutes Time                            ${SPECIFIC_HOUR_TIME}       ${SPECIFIC_MINUTE_TIME}     daily_starts_at_hourOptions    daily_starts_at_minuteOptions
    ClickText                   Save                        anchor=Cancel

Select Hour And Minutes Time
    [Documentation]             Selecting the hour and minutes for the deployment
    ...                         Author: Shivangi Agarwal
    ...                         Date:02nd Dec 2021
    [Arguments]                 ${SPECIFIC_HOUR_TIME}       ${SPECIFIC_MINUTE_TIME}     ${HOUR_ELEMENT_VALUE}       ${MINUTE_ELEMENT_VALUE}
    ${DAILY_HOUR_TIME}=         Replace String              ${SPECIFIC_HOUR_MINUTES_TIME_WEBELEMENT}                TIMEVALUE                   ${HOUR_ELEMENT_VALUE}
    DropDown                    ${DAILY_HOUR_TIME}          ${SPECIFIC_HOUR_TIME}
    ${DAILY_MINUTES_TIME}=      Replace String              ${SPECIFIC_HOUR_MINUTES_TIME_WEBELEMENT}                TIMEVALUE                   ${MINUTE_ELEMENT_VALUE}
    DropDown                    ${DAILY_MINUTES_TIME}       ${SPECIFIC_MINUTE_TIME}

Set Weekly Deployment Time
    [Documentation]             Scheduling the deployment from Weekly page
    ...                         Author: Shivangi Agarwal
    ...                         Date:02nd Dec 2021
    [Arguments]                 ${SPECIFIC_HOUR_TIME}       ${SPECIFIC_MINUTE_TIME}
    Select Hour And Minutes Time                            ${SPECIFIC_HOUR_TIME}       ${SPECIFIC_MINUTE_TIME}     weekly_starts_at_hourOptions    weekly_starts_at_minuteOptions
    ClickText                   Save                        anchor=Cancel

Select Days Of The Week In Weekly Deployment
    [Documentation]             Selecting the days for the deployment
    ...                         Author: Shivangi Agarwal
    ...                         Date:02nd Dec 2021
    [Arguments]                 ${DAY_OF_THE_WEEK}
    ClickText                   ${DAY_OF_THE_WEEK}

Delete All Scheduled Jobs
    [Documentation]
    ClickText                   Setup
    VerifyAll                   Setup, Service Setup, Developer Console
    ClickElement                ${CLICK_SETUP_WEBELEMENT}
    SwitchWindow                2
    VerifyText                  Object Manager
    TypeText                    Quick Find                  Scheduled Jobs
    ClickText                   Scheduled Jobs              anchor=Didn't find what you're looking for
    VerifyAll                   Action, Job Name, Started, Type, Create New View
    ${LISTVIEW_STATUS}          Run Keyword And Return Status                           VerifyNoText                CCD View
    Log To Console              ${LISTVIEW_STATUS}
    Run Keyword If              ${LISTVIEW_STATUS}          DropDown                    View:                       CCD View
    VerifyAll                   Action, Job Name, Started, Type
    ${CCD_COUNT}                GetElementCount             ${CCD_WEBELEMENT}
    Log To Console              ${CCD_COUNT}
    FOR                         ${INDEX}                    IN RANGE                    0                           ${CCD_COUNT}
        VerifyAll               Action, Job Name, Started, Type
        ClickElement            ${CONFIRM_DELETE_WEBELEMENT}
        CloseAlert              Accept
    END
    CloseWindow