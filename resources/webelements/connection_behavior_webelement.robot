*** Settings ***
Documentation               List of webelements used for Connection behavior

*** Variables ***
${PROMOTION_EXECUTION_WEBELEMENT}                       xpath\=//label[text()\='Promotion Execution']/following-sibling::div
${USER_STORY_STATUS_AFTER_PROMOTION_WEBELEMENT}         xpath\=//label[text()\='User Story Status After Promotion']/following-sibling::div
${BACK_PROMOTION_EXECUTION_WEBELEMENT}                  xpath\=//label[text()\='Back-Promotion Execution']/following-sibling::div
${DESCRIPTION_WEBELEMENT}                               xpath\=//label[text()='Description']//following-sibling::div
${CONNECTION_BEHAVIOR_NAME_WEBELEMENT}                  xpath\=//label[contains(text(),'Connection Behavior Name')]/..//following-sibling::div/input
${SPECIFIC_HOUR_MINUTES_TIME_WEBELEMENT}                xpath\=//select[@id\='TIMEVALUE']
${SCHEDULED_PROMOTION_WEBELEMENT}                       xpath\=//a[text()\='Schedule Promotions']
${CLICK_EVERY_HOUR_OPTION_WEBELEMENT}                   xpath\=(//span[contains(text(),'Every')])[1]//preceding::span[1]
${CLICK_SPICIFIC_HOUR_OPTION_WEBELEMENT}                xpath\=(//span[contains(text(),'Starts at')])[1]//preceding::span[1]
${CLICK_SCHEDULED_OPTION_WEBELEMENT}                    xpath\=//label[text()\='EXECUTIONOPTION']/following-sibling::div//span[@title\='Scheduled']
${EDIT_BUTTON_WEBELEMENT}                               xpath\=//button[@name\='Edit']
${CLICK_SETUP_WEBELEMENT}                               xpath\=//div[@class\="popupTargetContainer menu--nubbin-top uiPopupTarget uiMenuList uiMenuList--right uiMenuList--default visible positioned"]//ul[@class\="scrollable"]/li[1]
${CCD_WEBELEMENT}                                       xpath\=//th[contains(text(),'CCD')]
${CONFIRM_DELETE_WEBELEMENT}                            xpath\=(//a[@onclick\="return confirmDelete();"])[1]