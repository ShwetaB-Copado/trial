*** Settings ***
Documentation               List of webelements used for Job Templates

*** Variables ***
${FUNCTION_CONFIGURATION_WEBELEMENT}    xpath\=//Strong[text()='NAME']/ancestor::li
${JOB_TYPE_WEBELEMENT}                  xpath\=//label[text()\='Type']/parent::lightning-combobox//span[text()\='Select an Option']
${FUNCTION_INPUT_WEBELEMENT}            xpath\=//label[text()\='Function']/parent::div//input
${JOB_EXECUTION_WEBELEMENT}             xpath\=//a[@data-label\='Job Executions']
${CREATED_JOB_EXECUTION_WEBELEMENT}     xpath\=(//a[contains(text(),'JE-') and not(contains(@title,'JE-'))])[1]
${JOB_EXECUTION_STATUS_WEBELEMENT}      xpath\=//td[@data-label\='Status']//lightning-base-formatted-text
${JOB_SHOWMOREACTIONS_WEBELEMENT}       xpath\=(//a[text()\='{JOB STEP NAME}'])[1]/ancestor::tr//td[last()]//span[contains(text(),'Show')]/parent::button
${JOB_STEP_DELETE_WEBELEMENT}           xpath\=//span[text()\='Delete']
${SHOW_ACTIONS_INDEX_WEBELEMENT}        xpath\=(//span[text()='Show actions'])[iter]
${JOB_EXECUTION_TITLE_WEBELEMENT}       xpath\=//span[@slot='title']
${EXECUTION_SEQUENCE_WEBELEMENT}        xpath\=//label[text()\='Execution Sequence']/parent::lightning-combobox//span[text()\='Select an Option']