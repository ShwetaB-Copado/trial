*** Settings ***
Documentation               Web Elements for Pipeline Object

*** Variables ***
${NEW_ENV_CONNECTION_WEBELEMENT}                        xpath\=//input[@title\="Create new Environment Connection"]
${CONFIG_PIPELINE_OPTION_WEBELEMENT}                    xpath\=//input[@value\='Return to Pipeline']/following-sibling::div
${RETURN_PIPELINE_WEBELEMENT}                           xpath\=//input[@value\='Return to Pipeline']
${PIPELINE_DOWN_ARROW_WEBELEMENT}                       xpath\=//img[@class\="down-arrow"]
${SWITCH_PIPELINE_VIEW_WEBELEMENT}                      xpath\=//select[@class\="slds-select filterDropdown"]
${CUSTOM_MULTIPICKLIST__WEBELEMENT}                     xpath\=(//button[@class\="slds-button slds-button_icon slds-button_icon-container"])[1]
${USERSTORYFILTER_DELETE_WEBELEMENT}                    xpath\=//option[@selected and text()\='VALUE']/ancestor::li//img[contains(@onclick,'removeFilterConditionEntry')]
${USERSTORYFILTER_DROPDOWN_WEBELEMENT}                  xpath\=//select[contains(@onchange,'updateSelectedFieldType(NUMBER)')]
${USERSTORYFILTER_CONDITIONDROPDOWN_WEBELEMENT}         xpath\=//select[contains(@onchange,'updateSelectedFieldType(NUMBER)')]//ancestor::li/div/div[2]//select
${USERSTORYFILTER_VALUE_WEBELEMENT}                     xpath\=//select[contains(@onchange,'updateSelectedFieldType(NUMBER)')]//ancestor::li/div/div[3]
${USERSTORY_AHEAD_COUNT_WEBELEMENT}                     xpath\=//span[text()\='ENVIRONMENT']/ancestor::div[contains(@class,'box-container')]//div[@class\='commits show']//button[contains(@class,'AheadBtn')]
${USERSTORY_BEHIND_COUNT_WEBELEMENT}                    xpath\=//span[text()\='ENVIRONMENT']/ancestor::div[contains(@class,'box-container')]//div[@class\='commits show']//button[contains(@class,'BehindBtn')]
${PIPELINE_LIST_DROPDOWN_WEBELEMENT}                    xpath\=//select[contains(@id,'pipelinePicklist')]
${PIPELINE_SHIELD_WEBELEMENT}                           xpath\=//span[@title='ENVIRONMENT']/following::div[contains(@title,'connection behavior')][1]/div[@class='icon'][2]
${PROMOTION_EXECUTION_WEBELEMENT}                       xpath\=//label[text()='Promotion Execution']/following::button[contains(@id,'combobox')][1]
${PROMOTION_EXECUTION_DROPDOWN_WEBELEMENT}              xpath\=//div[@id='dropdown-element-ID']//span[text()='DROPDOWN_VALUES']
${USER_STORY_STATUS_AFTER_PROMOTION_WEBELEMENT}         xpath\=//label[text()='User Story Status After Promotion']/following::button[contains(@id,'combobox')][1]
${BACK_PROMOTION_EXECUTION_WEBELEMENT}                  xpath\=//label[text()='Back-Promotion Execution']/following::button[contains(@id,'combobox')][1]
${PIPELINE_DEPLOYMENT_ACTIVITY_WEBELEMENT}              xpath\=(//span[@title='ENVIRONMENT']/preceding::img[contains(@id,'deploymentStatus')]/ancestor::a)[last()]
${DEPLOYMENT_ACTIVITY_WEBELEMENT}                       xpath\=//table[contains(@aria-describedby,'Deployment_info')]//h2[contains(text(),'COLUMN_NAME')]
${SELECT_US_CHECKBOX_WEBELEMENT}                        xpath\=//a[contains(text(),'USERSTORY')]/ancestor::tr//input[@type\='checkbox']
${SRC_ENV_WEBELEMENT}                                   xpath\=//span[text()\='Source Environment']/ancestor::record_flexipage-record-field//a//span
${DEST_ENV_WEBELEMENT}                                  xpath\=//span[text()\='Destination Environment']/ancestor::record_flexipage-record-field//a//span
${DEPLOYMENTACTIVITY_SEARCH_WEBELEMENT}                 xpath\=//label[text()='Search:']/input[@type='search']
${DEPLOYMENT_USERSTORY_WEBELEMENT}                      xpath\=//a[contains(text(),'ID')]
${CLICK_VIEW_RESULT_WEBELEMENT}                         xpath\=(//i[@class\="jobIconText"])[1]