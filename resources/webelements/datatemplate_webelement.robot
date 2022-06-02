*** Settings ***
Documentation               Web Elements for Data Template

*** Variables ***
${DATA_TEMPLATE_BUTTON_DROPDOWN_LIST_WEBELEMENT}         xpath\=//ul[@class\="slds-button-group-list"]
${DATA_TEMPLATE_FIELD_CHECKBOX_WEBELEMENT}               xpath\=//*[text()\='DATATEMPLATE_FIELDNAME']/ancestor::tr/td[2]
${SELECT_ALL_FIELD_ON_DATA_TEMPLATE_WEBELEMENT}          xpath\=//span[text()\='Select All']/../span[1]
