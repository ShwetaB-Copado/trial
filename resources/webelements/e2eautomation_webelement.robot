*** Settings ***
Documentation    Web Elements for E2E Automation

*** Variables ***
${E2E_MASTERSUBSCRIPTION_CHECKBOX_WEBELEMENT}    xpath\=//input[@name\='msa']
${SETTINGS_ICON_WEBELEMENT}                      xpath\=//lightning-icon[@class\='slds-button__icon slds-global-header__icon forceIcon slds-icon-utility-setup slds-icon_container']
${ENABLE_DEVHUB_WEBELEMENT}                      xpath\=(//input[@class=' uiInput uiInputCheckbox uiInput--default uiInput--checkbox'])[1]
${ENABLE_SOURCETRACKING_WEBELEMENT}              xpath\=(//input[@class=' uiInput uiInputCheckbox uiInput--default uiInput--checkbox'])[2]
${EE_LOGINBUTTON_WEBELEMENT}                     xpath\=//input[@id\='Login']
${NEW_SANDBOXBUTTON_WEBELEMENT}                  xpath\=//input[@id\='listSandbox:theForm:sandboxSummaryBlock:j_id30:tabButtons:newSandbox']
${DEVELOPERSANDBOX_NEXTBUTTON_WEBELEMENT}        xpath\=(//input[contains(@id,'editSandbox:theForm:licenseBlock:')])[2]
${SANDBOX_STATUS_WEBELEMENT}                     xpath\=//a[contains(text(),'{SANDBOX_NAME}')]/ancestor::tr[contains(@class,'dataRow')]//td[4]/span[text()='Completed']
${SFDX_PLATFORM_WEBELEMENT}                      xpath\=//div[@class='pbBody']/child::table/tbody/tr/td[2][contains(text(),'{PLATFORM}')]
${PLATFORM_NEWBUTTON_WEBELEMENT}                 xpath\=//input[@title\='New Values']
${PLATFORM_NAME_WEBELEMENT}                      xpath\=//textarea[@title\='Platform']
${SANDBOX_LOGIN_WEBELEMENT}                      xpath\=//a[contains(text(),'{SANDBOX_NAME}')]/ancestor::tr[contains(@class,'dataRow')]/td[1]/child::span[2]/a
${CUSTOM_DOMAIN_URL}                             xpath\=(//span[contains(@id,'thePage:myDomainForm:myDomainPageBlock:displayDomainName:')])[1]
${SANDBOX_USERNAME_WEBELEMENT}                    xpath\=(//table[@class='list']/tbody/tr/td[3])[1]/child::a
${CREDENTIAL_NAME_WEBELEMENT}                     xpath\=//input[@id\='thePage:theForm:pb_createOrg:pbs1:if_name']
${ORGTYPE_DROPDOWN_WEBELEMENT}                    xpath\=//select[@id\='thePage:theForm:pb_createOrg:pbs1:if_orgType']
${CUSTOMDOMAIN_URL_WEBELEMENT}                    xpath\=//input[@id\='thePage:theForm:pb_createOrg:pbs1:if_custom']
${SAVE_CREDENTIAL_WEBELEMENT}                     xpath\=//input[@id=\'thePage:theForm:pb_createOrg:co_pbb:bottom:cb_save']
${ALLOW_BUTTON_WEBELEMENT}                        xpath\=//input[@id\='oaapprove'] 
${ENVIRONMENT_NAME_WEBELEMENT}                    xpath\=//p[@title\='Environment']/ancestor::force-highlights-details-item//span[text()\='{ENVNAME}']
${EDITPLATFORM_BUTTON_WEBELEMENT}                 xpath\=//button[@title\='Edit Platform']
${PLATFORM_WEBELEMENT}                            xpath\=(//input[@class\='slds-input slds-combobox__input'])[2]
${ENVIRONMENT_SAVEBUTTON_WEBELEMENT}              xpath\=//button[@name\='SaveEdit']
${USERNAME_WEBELEMENT}                            xpath\=//input[@id\='username']
${PASSWORD_WEBELEMENT}                            xpath\=//input[@id\='password']
${GIT_SNAPSHOT_COMMIT_WEBELEMENT}                 xpath\=(//table[@class\='list'])[1]/tbody/tr[2] 
${NEWPIPELINE_ACTIVE_WEBELEMENT}                  xpath\=//input[@name\='copado__Active__c']
${PROMOTIONJOBTEMPLATE_EDITBUTTON_WEBELEMENT}     xpath\=//button[@title\='Edit Promotion Job Template']
${APPS_WEBELEMENT1}                               xpath\=//h3[normalize-space()\='Apps']
${SEARCH_APPS_WEBELEMENT1}                        xpath\=//input[@placeholder\="Search apps and items..."]
${GITSNAPSHOT_CREDENTIAL_LOOKUP}                  xpath\=//img[@title\='Credential Lookup (New Window)']
${SSH_KEY_WEBELEMENT}                             xpath\=//textarea[@wrap\='hard']
${GIT_PROFILE_WEBELEMENT}                         xpath\=(//img[@class\='avatar avatar-small circle'])[1]
${SSH_WEBELEMENT}                                 xpath\=//textarea[@id\='public_key_key']
${GIT_SIGNIN_WEBELEMENT}                          xpath\=//a[@class\='HeaderMenu-link flex-shrink-0 no-underline']
${SSH_CPGKEYS_WEBELEMENT}                         xpath\=//a[@href\='/settings/keys']
${NEW_SSH_KEY_WEBELEMENT}                         xpath\=//a[@href\='/settings/ssh/new']
${GIT_REPOSITORY_WEBELEMENT}                      xpath\=(//div[@class\='slds-form-element__control']/child::select)[3]
${GIT_SNAPSHOTPERMISSIONS_WEBELEMENT}             xpath\=(//select[contains(@class,'slds.input')])[1]
${GITSNAPSHOT_CREDENTIAL_WEBELEMENT}              xpath\=(//input[contains(@class,'slds.input')])[3]
${PIPELINE_NAME_WEBELEMENT}                       xpath\=//input[@name\='Name']
${PIPELINECONNECTION_SOURCEENV_WEBELEMENT}        xpath\=(//input[@placeholder\='Search Environments...'])[1]
${PIPELINECONNECTION_DESTENV_WEBELEMENT}          xpath\=(//input[@placeholder\='Search Environments...'])[2]
${NEWPIPELINE_PLATFORM_WEBELEMENT}                xpath\=(//div[@class\='slds-input__icon-group slds-input__icon-group_right']/child::lightning-icon)[2] 
${QUICK_FIND_WEBELEMENT}                          xpath\=(//input[contains(@placeholder,'Quick Find')])[1]
${CUSTOM_OBJECT_WEBELEMENT}                       xpath\=(//div[contains(@class,'trigger--click')])[2]