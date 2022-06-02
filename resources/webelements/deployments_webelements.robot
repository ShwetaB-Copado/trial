*** Settings ***
Documentation               List of all the webelements used from the deployments object

*** Variables ***
${DEPLOYMENTPAGE_EYEICON_WEBELEMENT}                    xpath\=(//img[@id\='imgGo'])[last()]
${DEPLOYMENT_JOB_WEBELEMENT}                            xpath\=//div[contains(@class,'windowViewMode-normal')]//span[contains(text(),'DJ') and @force-lookup_lookup]
${DEPLOYMENT_SEARCH_BOX_WEBELEMENT}                     xpath\=//div[@class\="dataTables_filter"]//input[@type\="search"]
${DEPLOYMENT_SEARCHED_OPTION_SELECT_WEBELEMENT}         (//tr/td[contains(., 'DATA')])[1]/../td[@class\="sorting_1"]
${TO_CREDENTIAL_SEARCHBOX_WEBELEMENT}                   //a/img[@title\="To Credential Lookup (New Window)"]
${STEP_GIT_COMMIT_SELECTION_WEBELEMENT}                 //a[@class\="js-gitCommit-lookup lookupIcon iconAction"]
${STEP_GIT_METADATA_TABLE_MSG_TEXTBOX_WEBELEMENT}       //input[@type\= 'textarea' and @tabindex\= '10']
${DEPLOYMENT_STATUS_WEBELEMENT}                         //span[@id\="thePage:theForm:pbStatus:pbsPbStatus:ofStatus"]
${DD_CREDENTIAL_WEBELEMENT}                             xpath\=//table[@class\="stripe dataTable no-footer"]/tbody//tr[1]//input
${SELECT_DD_SOURCE_ORG_WEBELEMENT}                      xpath\=//label[text()\='Select a source']/..//input[@placeholder\='Search...']   
${SELECT_DD_TARGET_ORG_WEBELEMENT}                      xpath\=//p[text()\='Add Target']/ancestor::div[1]//input[@placeholder\='Search...']
${SELECT_DD_DATA_TEMPLATE_WEBELEMENT}                   xpath\=//p[text()\='Select Data Template']/..//input[@placeholder\='Search...']
