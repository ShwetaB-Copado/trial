*** Settings ***
Documentation               List of webelements used for developer orgs

*** Variables ***
${SEARCH_FIELD_WEBELEMENT}                              xpath\=//input[@id\='globalQuickfind']
${SEARCHED_FIELD_WEBELEMENT}                            xpath\=//a[normalize-space()\='FIELD']/span
${SHOWMORE_ICON_WEBELEMENT}                             xpath\=//span[text()\='Show More']/ancestor::a
${CREATE_CUSTOM_OBJECT_WEBELEMENT}                      xpath\=//a[@data-id\='createCustomObjectURL' and @title\='Custom Object']
${SINGULAR_LABEL_WEBELEMENT}                            xpath\=//span[text()\='Singular Label']//following::span[1]
${CUSTOMOBJ_API_WEBELEMENT}                             xpath\=//span[text()\='API Name']//following::span[1]
${PAGELAYOUT_NAME_WEBELEMENT}                           xpath\=//span[@class\='uiOutputText']//ancestor::td
${PROFILE_TRIALS_WEBELEMENT}                            xpath\=(//input[contains(@title,'Trials')])[iter]
${FLS_CHECKBOX_WEBELEMENT}                              xpath\=//th[text()\='ELEMENT']/parent::tr/child::td[2]
${DELETE_CUSTOM_OBJECT_WEBELEMENT}                      xpath\=(//span[@dir\='ltr' and text()\='Delete'])[2]
${PERMISSIONSET_OBJECT_WEBELEMENT}                      xpath\=//div[@title\='Permission Sets']//a
${PERMISSIONSET_NEWBUTTON_WEBELEMENT}                   xpath\=//input[@title\='New' and @type\='button']
${FIND_SETTINGS_SEARCH_WEBELEMENT}                      xpath\=//input[@value\='Find Settings...']
${OBJECT_SETTINGS_OBJNAME_WEBELEMENT}                   xpath\=//tr//a[text()='{OBJECT}']
${OBJECT_SETTINGS_EDIT_WEBELEMENT}                      xpath\=//a[text()\='Edit']
${FIELD_PERMISSIONS_CHECKBOX_WEBELEMENT}                xpath\=//td[text()='{FIELDNAME}']/parent::tr/td[ITR]/input
${OLS_CHECKBOX_WEBELEMENT}                              xpath\=(//h3[text()\='Custom Object Permissions']//following::th[text()\='FIELDNAME']//following-sibling::td//child::td/input[@type\='checkbox'])[ITR]
${LABEL_TRANSLATION_WEBELEMENT}                         xpath\=//div[text()\='{RECORD}']/parent::td/parent::tr//td[2]/div
${APPLY_FIRST_RADIOBUTTON_WEBELEMENT}                   xpath\=//label[text()\='Apply one layout to all profiles']
${OBJECT_PERMISSIONS_CHECKBOX_WEBELEMENT}               xpath\=//td[text()\="PERMISSION"]//following-sibling::td/input
${SELECT_PROFILE_WEBELEMENT}                            xpath\=//span[text()='PROFILENAME']/parent::a
${PROFILE_EDIT_BUTTON_WEBELEMENT}                       xpath\=(//input[@title\='Edit'])[1]
${DELETE_APEXCLASS_WEBELEMENT}                          xpath\=//a[text()\='CLASSNAME']/preceding::a[contains(@title,'Delete')][1]
${FIELD_API_NAME_WEBELEMENT}                            xpath\=//span[text()\='FIELDVALUE']/ancestor::tr/td[2]
${QUICK_FIND_WEBELEMENT}                                xpath\=(//input[contains(@placeholder,'Quick Find')])[1]
${CLICK_TABS_OPTION_WEBELEMENT}                         xpath\=//div[@title\='Tabs']//mark[text()\='Tabs']
${CUSTOM_OBJECT_RECORD_NAME_WEBELEMENT}                 xpath\=//label[text()\='OBJECTNAME Name']/following-sibling::div/input
${ACCOUNT_NAME_WEBELEMENT}                              xpath\=//label[text()\='ACCOUNTINPUTFIELDS']/following::div[1]/input
${SELECT_OBJECT_TAB_WEBELEMENT}                         xpath\=//td[@class\='dataCol col02']/div[@class\='requiredInput']/select
${TAB_STYLE_LOOKUP_WEBELEMENT}                          xpath\=//a[@class\='lookup']
