*** Settings ***
Documentation               List of webelements used in Job Executions

*** Variables ***
${JOB_RECORD_WEBELEMENT}        xpath\=(//span[text()\='In Progress']/ancestor::tr//a[contains(text(),'JE')])[1]
${JOB_COMPLETED_WEBELEMENT}     xpath\=//strong[text()\='{JOB}']/ancestor::c-result-detail//div[@class\='info']/div[1]
${JOB_ORDER_WEBELEMENT}         xpath\=((//h2[text()\='SFDX Deploy'])[last()]/ancestor::flexipage-component2//c-result-detail/li)[ITR]//Strong[text()\='JOBNAME']
${JOB_DRAGDROP_WEBELEMENT}      xpath\=(//lightning-icon[@class\='slds-icon-utility-drag-and-drop slds-icon_container'])[index]
${JOBEXECUTION_WEBELEMENT}      xpath\=(//a[contains(text(),'JE')])[INDEX]
${JOBEXECRESULT_WEBELEMENT}     xpath\=//span[text()\='View result']//parent::div//child::lightning-button/button
${PACKAGE_JOBEXEC_WEBELEMENT}   xpath\=(//button[text()\='{JOB}']/ancestor::div[@class\='custom-box'])[last()]//span[text()\='Completed']
${JOB_RESULT_WEBELEMENT}        xpath\=//strong[text()='{JOB}']/ancestor::c-result-detail//div[@class\='info']/div[2]//button