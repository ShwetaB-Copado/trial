*** Settings ***
Documentation               Web Elements for User Stories including Permission Set Groups

*** Variables ***
${RELEASE_FIELD}            xpath\=//input[@id='thePage:theForm:pb:pbs:if_Release']
${LOOKUP}                   xpath\=//img[@class\='lookupIcon']
${CHECKBOX_WEBELEMENT}      xpath\=//a[text()\='USID']/ancestor::tr//label[contains(@Class,'checkbox')]/span[contains(@Class,'checkbox')]
${RECORDTYPE_WEBELEMENT}    xpath\=//tr[@class='dataRow']/td[1]/select
${SHOWACTION_WEBELEMENT}    xpath\=//button//span[text()='Show Actions']
${SPRINTNEW_WEBELEMENT}     xpath\=//button[@title='New']
${TEMP_WEBELEMENT}          xpath\=(//table[@class='detailList']//span[contains(@id,'UserStoryName') and contains(text(),'USID')]/preceding::input)[last()]
${STATUS_WEBELEMENT}        xpath\=//label[text()='Status']
${ID_WEBELEMENT}            xpath\=//input[@id='ID']
${BUG_WEBELEMENT}           xpath\=(//option[text()='Bug'])[2]

