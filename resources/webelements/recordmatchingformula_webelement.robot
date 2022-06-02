*** Settings ***
Documentation               Web Elements for Record Matching Formula
*** Variables ***
${RMF_NAME_WEBELEMENT}                                  xpath\=//label[text()\='Record Matching Formula Name']/following-sibling::div/input
${SCHEMA_CREDENTIALS_WEBELEMENT}                        xpath\=//label[text()\='Configuration Schema Credential']/following-sibling::div//input
${FIELD_OPTION_WEBELEMENT}                              xpath\=//label[text()\='RMF_FIELDLABEL']/following::div[1]
${DATA_TEMPLATE_NAME_WEBELEMENT}                        xpath\=//label[text()\='Data Template Name']/following::div[1]/input
${MAIN_OBJECT_WEBELEMENT}                               xpath\=//input[@placeholder\='Main Object']
${SELECT_AUTO_GENERATE_OPTION_WEBELEMENT}               xpath\=//tr[@data-row-key-value\='OPTIONVALUE']/td[7]//span[@title\='Auto Generate For Empty Values']
${CLICK_CONTENT_UPDATE_WEBELEMENT}                      xpath\=//tr[@data-row-key-value\='FIELDAPI_VALUE']/td[7]//button[@aria-label\='No Update']
${SCHEMA_CREDENTIAL_CANCEL_BUTTON_WEBELEMENT}           xpath\=(//button[@title\='Cancel'])[2] 
${DATA_SCHEMA_SPINNER_WEBELEMENT}                       xpath\=//*[@class\='slds-spinner_container']/div[@role\='status']
${SELECT_USE_EXTERNAL_ID_CHECKBOX_WEBELEMENT}           xpath\=//tr[@data-row-key-value\='FIELDAPI_VALUE']/td[6]//span[@class\='slds-checkbox_faux']
${SEARCH_OBJECT_WEBELEMENT}                             xpath\=//*[@placeholder\='Search Object']
${EXT_ID_FIELD_WEBELEMENT}                              xpath\=//tr[@data-row-key-value\='EXTFIELDNAME']/td[6]//span[@class\='slds-checkbox_faux']
