*** Settings ***
Documentation               Web Elements for User Stories including Promotion

*** Variables ***
${EDIT_STATUS_US_WEBELEMENT}            xpath\=//button[@name\='copado__Status__c']
${STATUS_VALUES_WEBELEMENT}             xpath\=//label[text()\='Status']//following-sibling::div//div[@role\='listbox']//child::lightning-base-combobox-item[@data-value\='STATUS']
${SPRINTWALL_US_CHECKBOX_WEBELEMENT}    xpath\=//a[contains(text(), 'USERSTORY')]//ancestor::th//preceding-sibling::td//lightning-primitive-cell-checkbox
${SPRINTWALL_FILTERICON_WEBELEMENT}     xpath\=//button[@title\='filterList']
${FILTER_FIELD_WEBELEMENT}              xpath\=//span[text()\=‘Select Field’]//parent::button[@aria-label\=‘Field, Select Field’]
${FILTER_FIELD_STATUS_WEBELEMENT}       xpath\=//lightning-base-combobox-item[@role\='option']//child::span[text()\='Status']
${FILTER_STATUS_WEBELEMENT}             xpath\=//input[@role\='textbox']//ancestor::div[@role\='combobox']
${FILTER_STATUS_VALUES_WEBELEMENT}      xpath\=//label[text()\='Status']//following-sibling::div//div[@role\='listbox']//child::li[@data-value\='STATUS']
${SEARCH_US_WEBELEMENT}                 xpath\=(//input[@type\='search'])[3]
${US_ROW_STATUS_WEBELEMENT}             xpath\=//a[contains(text(), 'USNUM')]//ancestor::th//following-sibling::td[@data-label\='Status']//lightning-base-formatted-text
${US_REFRESH_BUTTON_WEBELEMENT}         xpath\=//span[@slot\='tableActions']//button[@title\='Refresh']