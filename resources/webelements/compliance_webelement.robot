*** Settings ***
Documentation               Web Elements for Compliance Hub

*** Variables ***
${SELECT_METADATA_TYPE_WEBELEMENT}                      xpath\=//*[contains(text(),"Select Metadata Type")]/..//button
${LOGIC_INPUT_VALUE_ROW_ONE_WEBELEMENT}                 xpath\=//table[@class\="slds-table"]/tr[1]/td[5]//input
${LOGIC_INPUT_VALUE_ROW_TWO_WEBELEMENT}                 xpath\=//table[@class\="slds-table"]/tr[2]/td[5]//input
${LOGIC_ENABLE_CHECKBOX_WEBELEMENT}                     xpath\=//table[@class\="slds-table"]//span[@class\="slds-checkbox_faux"]
${COMPLIANCE_SCAN_RECORD_COUNT_IN_US_WEBELEMENT}        xpath\=//*[contains(text(),"Compliance Scan Results")]/following-sibling::span
${SEVERITY_WEBELEMENT}                                  xpath\=//label[contains(text(),'Severity')]/following-sibling::div
${ACTION_WEBELEMENT}                                    xpath\=//label[contains(text(),'Action')]/following-sibling::div
${SELECT_SEVERITY_OPTION}                               xpath\=//label[text()\='Severity']/following-sibling::div//span[@title\='SEVERITYVALUE']
${SELECT_ACTION_OPTION}                                 xpath\=//label[text()\='Action']/following-sibling::div//span[@title\='ACTIONVALUE']
${COMPLIANCE_RESULT_WEBELEMENT}                         xpath\=//i[starts-with(@data-stepname,'Compliance Check')]
${COMPLIANCE_CHECK_TYPE}                                xpath\=//lightning-formatted-text[text()\='URL Callout']
${CRITERIA_NODE_WEBELEMENT}                             xpath\=//tr[@data-criteria-id\='CRITERIA_NODE_VALUE']/td[2]
${CRITERIA_FIELD_WEBELEMENT}                            xpath\=//tr[@data-criteria-id\='CRITERIA_FIELD_VALUE']/td[3]
${CRITERIA_OPERATOR_WEBELEMENT}                         xpath\=//tr[@data-criteria-id\='CRITERIA_OPERATOR_VALUE']/td[4]
${SELECT_METADATA_OPTION_WEBELEMENT}                    xpath\=//label[text()\='Select Metadata Type']/..//div/button[@class\="slds-combobox__input slds-input_faux"]
${CRITERIA_NODE_OPTION_WEBELEMENT}                      xpath\=//tr[@data-criteria-id\='CRITERIA_NODE_VALUE']/td[2]//span[@title\='NODETITLE']
${CRITERIA_FIELD_OPTION_WEBELEMENT}                     xpath\=//tr[@data-criteria-id\='CRITERIA_FIELD_VALUE']/td[3]//span[@title\='FIELDTITLE']
${CRITERIA_OPERATOR_OPTION_WEBELEMENT}                  xpath\=//tr[@data-criteria-id\='CRITERIA_OPERATOR_VALUE']/td[4]//span[@title\='OPERATORTITLE']