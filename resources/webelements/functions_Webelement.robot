*** Settings ***
Documentation               List of all the webelements used from the functions object

*** Variables ***
${LABEL_VALUE_WEBELEMENT}                               xpath\=//span[text()\='LABEL']/ancestor::flexipage-field//slot//lightning-formatted-text[@slot\='output']
${UPLOAD_BUTTON_INADDFILE_WEBELEMENT}                   xpath\=//button//span[text()\='Upload Files']
${FILE_CHECKBOX_WEBELEMENT}                             xpath\=//span[contains(text(),'FILENAME')]/ancestor::div[@class\='filerow']//label
${FUNCTION_SCRIPT_WEBELEMENT}                           xpath\=//div[@class\='CodeMirror cm-s-default CodeMirror-wrap']
${FUNCTION_EDITBUTTON_WEBELEMENT}                       xpath\=//flexipage-tab2[@id\='tab-17']//button[text()\='Edit']
${PARAMETER_NAME_WEBELEMENT}                            xpath\=(//input[@name\='name'])[last()]
${DEFAULT_VALUE_WEBELEMENT}                             xpath\=(//input[@name\='value'])[last()]
${APIKEY_VALUE_WEBELEMENT}                              xpath\=//span[@id\='CS_List:CS_Form:thePageBlock:thePageBlockSection:copado__API_Key__c']
${COPADO_CALLBACK_APEX_WEBELEMENT}                      xpath\=//input[@name\='copado__ApexClass__c']
${COPADO_CALLBACK_FLOW_WEBELEMENT}                      xpath\=//input[@name\='copado__FlowHandler__c']