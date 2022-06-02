*** Settings ***

Documentation               Web Elements for Automations record

*** Variables ***
${PICKLIST_FIELD_WEBELEMENT}                            xpath\=//label[text()\='PICKLISTNAME']/following::div[2]
${PICKLIST_VALUE_WEBELEMENT}                            xpath\=//span[@title\='PICKLISTVALUE']
${LOOKUPFIELD_WEBELEMENT}                               xpath\=//label[text()\='LOOKUPFIELD']/following::div[2]//input
${APEX_TEST_WEBELEMENT}                                 xpath\=//i[starts-with(@data-stepname,'STEPNAME')]
${GIT_PROMOTION_TYPE_WEBELEMENT}                        xpath\=//i[starts-with(@data-stepname,'Git Promotion')]
${CLICK_STEP_WEBELEMENT}                                xpath\=//i[starts-with(@data-stepname,'VALUE')]/ancestor::td/..//img[@id\='imgGo']
${INCOMING_CONNECTION_BEHAVIOR_IN_ENV_WEBELEMENT}       xpath\=(//span[contains(text(),'Clear Selection')])[1]
${CONNECTION_BEHAVIOR_NAME_WEBELEMENT}                  xpath\=//label[contains(text(),'Connection Behavior Name')]/..//following-sibling::div/input
${AUTOMATION_NAME_WEBELEMENT}                           xpath\=//label[text()\='Automation Name']/following::div[1]/input