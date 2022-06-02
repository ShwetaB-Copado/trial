*** Settings ***
Documentation               Web Elements for Static Code Analysis

*** Variables ***
${PMD_RECORD_TYPE_WEBELEMENT}                           xpath\=//span[text()\='PMD']
${SCA_SETTING_NAME_WEBELEMENT}                          xpath\=//label[text()\='Static Code Analysis Settings Name']/../following::td[1]/input
${SCA_RESULT_WEBELEMENT}                                xpath\=//i[starts-with(@data-stepname,'Static Code Analysis')]
${SCA_CHECK_TYPE_WEBELEMENT}                            xpath\=//lightning-formatted-text[text()\='URL Callout']
${CODESCAN_RECORD_TYPE_WEBELEMENT}                      xpath\=//span[text()\='CodeScan']
${CLONED_CONNECTION_NAME_WEBELEMENT}                    xpath\=//flexipage-field[@data-field-id\='RecordNameField']//div[@class\='slds-form-element__control slds-grow']/input