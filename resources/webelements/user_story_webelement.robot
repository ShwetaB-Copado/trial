*** Settings ***
Documentation               Web Elements for User Stories including Promotion

*** Variables ***
${PROMOTION_STATUS_WEBELEMENT}                          xpath\=//*[@id\='thePage:j_id257:4:j_id260:j_id261:j_id272']
${FIRST_PROMOTION_INSIDE_US_WEBELEMENT}                 xpath\=(//lightning-primitive-cell-factory[@data-label\="Promotion Name"]/span/div)[1]
${TYPE_NAME_IN_US_WEBLEMENT}                            xpath\=(//input[@type\= 'textarea'])[1]
${SEARCHED_RESULT_WEBELEMENT}                           xpath\=//a[normalize-space()\='ARGUMENT']
${GIT_BRANCH_OPTION_WEBELEMENT}                         xpath\=//span[contains(text(),'Git')]//..//div[@class\="jqx-checkbox jqx-checkbox-base chkbox"]
${PROMOTION_RECORD_WEBELEMENT}                          xpath\=//span[text()\='Last Validation Promotion']/ancestor::div[contains(@class,'test-id')]//a//span
${DEPLOYMENT_RECORD_WEBELEMENT}                         xpath\=//span[text()\='Last Validation Deployment']/ancestor::div[contains(@class,'test-id')]//a//span
${LAST_VALIDATION_STATUS_WEBELEMENT}                    xpath\=//span[text()\='Last Validation Status']/ancestor::flexipage-field//lightning-formatted-rich-text/span[text()]
${VALIDATION_GREENFLAG_WEBELEMENT}                      xpath\=//span[text()\='Last Validation Status']/ancestor::flexipage-field//lightning-formatted-rich-text//img[contains(@src,'flag_green.gif')]
${VALIDATION_REDFLAG_WEBELEMENT}                        xpath\=//span[text()\='Last Validation Status']/ancestor::flexipage-field//lightning-formatted-rich-text//img[contains(@src,'flag_red.gif')]
${PROMOTION_STATUS_MAIN_WEBELEMENT}                     xpath\=//td[text()\='Status']/parent::tr/td[4]
${PROMOTION_STATUS_HEADER_WEBELEMENT}                   xpath\=//span[text()\='Status']/parent::div//span[contains(@id,'thePage')]/span
${DEPLOYMENT_RECORDNAME_WEBELEMENT}                     xpath\=//input[@class\='deploymentNameInput' and @value\='VARIABLE']
${DEPLOYMENT_STATUS_WEBELEMENT}                         xpath\=//*[@id\='thePage:theForm:pbStatus:pbsPbStatus:ofStatus']
${DEPLOYMENT_STATUSHEADER_WEBELEMENT}                   xpath\=//label[contains(text(),'Status')]/parent::li//span
${VIEW_RESULTS_WEBELEMENT}                              xpath\=//i[contains(text(),'View results')]/parent::i
${READYTOPROMOTE_CHECKBOX_WEBELEMENT}                   xpath\=//input[@name\="copado__Promote_Change__c"]
${TITLE_INPUT_WEBELEMENT}                               xpath\=//span[contains(@class,'field-label') and text()\='Title']/ancestor::flexipage-field//lightning-formatted-text
${SEL_BASE_BRANCH_VALIDATION_LINK_WEBELEMENT}           xpath\=(//table[@class='detailList'])[1]//th/span[text()='FIELD_NAME']/following::td/span/a[text()='FIELD_VALUE']
${SEL_BASE_BRANCH_VALIDATION_SPAN_WEBELEMENT}           xpath\=(//table[@class='detailList'])[1]//th/span[text()='FIELD_NAME']/following::td/span[text()='FIELD_VALUE']
${SEL_BASE_BRANCH_REFRESH_BRANCH_INDEX_WEBELEMENT}      xpath\=//a[contains(text(),'Refresh Branch Index')]
${SEL_BASE_BRANCH_REFRESH_SUCCESS_WEBELEMENT}           xpath\=//div[@class='messageText' and text()='Branches retrieved successfully.']/span/h4[text()='Success:']
${METADATA_TABLE_COLUMNS_WEBELEMENT}                    xpath\=//div[contains(@id,'columntable')]/div[@role='columnheader']/descendant::span[text()='COLUMN_NAME']
${SELECT_BRANCH_TABLE_COLUMNS_WEBELEMENT}               xpath\=//div[@id='columntablebranchSelectorGrid']/div[@role='columnheader']/descendant::span[text()='COLUMN_NAME']
${CLEAR_SELECTED_BASE_BRANCH_WEBELEMENT}                xpath\=//button[contains(@onclick,'removeRecord')]
${SELECT_BASE_BRANCH_LINK_WEBELEMENT}                   xpath\=//div[contains(@class,'branchLookup')]/following::a[@role='option' and text()='BRANCH']
${SELECT_BASE_BRANCH_INLINE_WEBELEMENT}                 xpath\=//input[@name='copado__Base_Branch__c']
${FUNCTIONAL_SPECIFICATIONS_WEBELEMENT}                 xpath\=//span[contains(text(),'Functional Specifications')]/following::p[1]
${TECHNICAL_SPECIFICATIONS_WEBELEMENT}                  xpath\=//span[contains(text(),'Technical Specifications')]/following::p[1]
${METADATA_INPUT_WEBELEMENT}                            xpath\=//input[@type\= 'textarea' and @tabindex\= '7']
${SELECT_METADATA_WEBELEMENT}                           xpath\=(//div[contains(text(),'METADATA')]/parent::div/parent::div/div[1]/div/div[contains(@class,'checkbox')])[1]
${FIRST_COMMIT_WEBELEMENT}                              xpath\=(//*[@data-label\="Commit Name"]/span/div)[1]
${USID_WEBELEMENT}                                      xpath\=//lightning-formatted-text[@slot\='primaryField' and contains(text(),'US')]
${USDEPEND_WEBELEMENT}                                  xpath\=//slot[@name\='primaryField']//lightning-formatted-text[contains(text(),'UD')]
${USCHECKBOX_WEBELEMENT}                                xpath\=(//a[contains(text(),'USERSTORY')]/ancestor::tr//input[@type\='checkbox']/parent::span/child::label/child::span[@class='slds-checkbox_faux'])[1]
${CREDENTIAL_VALUE_WEBELEMENT}                          xpath\=//span[text()\='Credential']/ancestor::record_flexipage-record-field//a//span
${ENVIRONMENT_VALUE_WEBELEMENT}                         xpath\=//span[text()\='Environment']/ancestor::record_flexipage-record-field//a//span
${PROMOTION_ID_WEBELEMENT}                              xpath\=//span[text()\='Promotion Name']/ancestor::flexipage-field//lightning-formatted-text
${US_TITLE_TEXTBOX_WEBELEMENT}                          //*[@name\="copado__User_Story_Title__c"]
${ACTUAL_POINTS_VALUE_WEBELEMENT}                       xpath\=//span[text()\='Actual Points']/ancestor::flexipage-field//lightning-formatted-number
${US_TESTSCRIPT_NEWBUTTON_WEBELEMENT}                   xpath\=//span[contains(text(),'Test Scripts')]/ancestor::lst-related-list-single-container//button[text()\='New']
${USTITLE_WEBELEMENT}                                   xpath\=(//input[contains(@id,'UserStory_Title')])[2]
${STATUS_WEBELEMENT}                                    xpath\=//label[text()\='Status']//parent::lightning-combobox//div[@class\='slds-form-element__control']
${ID_WEBELEMENT}                                        xpath\=//input[@id='ID']
${US_TESTSCRIPT_NEWBUTTON_WEBELEMENT}                   xpath\=//span[contains(text(),'Test Scripts')]/ancestor::lst-related-list-single-container//button[text()\='New']
${DEPLOYMENT_STEPS_NEW_WEBELEMENT}                      xpath\=//span[contains(text(),'Deployment Steps')]/ancestor::div[@class\='slds-grid']//button[@title\='New']
${ROW_TEXT_BD_WEBELEMENT}                               xpath\=(//tr[@data-row-key-value='row-NUM']//child::lightning-base-formatted-text)[2]
${ROW_DRAGELEMENT_BD_WEBELEMENT}                        xpath\=(//tr[@data-row-key-value\='row-NUM']//child::lightning-primitive-icon)[1]
${ROW_TEXT_AD_WEBELEMENT}                               xpath\=(//tr[@data-row-key-value='row-NUM']//child::lightning-base-formatted-text)[5]
${ROW_DRAGELEMENT_AD_WEBELEMENT}                        xpath\=(//tr[@data-row-key-value\='row-NUM']//child::lightning-primitive-icon)[2]
${JOBSTEPNAME_WEBELEMENT}                               xpath\=(//lightning-base-formatted-text[text()\='VALUE']//preceding::lightning-base-formatted-text)[2]
${JOBSTEPTYPE_WEBELEMENT}                               xpath\=//lightning-base-formatted-text[text()\='KEY']//following::td[1]
${BEFORE_DEPLOYMENT_TEXT_WEBELEMENT}                    xpath\=//div[@class\='slds-text-heading_medium slds-var-m-top_medium'][1]
${AFTER_DEPLOYMENT_TEXT_WEBELEMENT}                     xpath\=//div[@class\='slds-text-heading_medium slds-var-m-top_medium'][2]
${DEPSTEP_NAME_ROW_WEBELEMENT}                          xpath\=//div[@class\='slds-scrollable_y']/table/tbody/tr[ROWNUM]/th//child::a
${DEPSTEP_TYPE_ROW_WEBELEMENT}                          xpath\=//div[@class\='slds-scrollable_y']/table/tbody/tr[ROWNUM]/td[2]//child::lightning-base-formatted-text
${DEPSTEP_SEQUENCE_ROW_WEBELEMENT}                      xpath\=//div[@class\='slds-scrollable_y']/table/tbody/tr[ROWNUM]/td[3]//child::lightning-base-formatted-text
${DEPSTEP_ACTIONCLICK_WEBELEMENT}                       xpath\=//div[@class\='slds-scrollable_y']/table/tbody/tr[ROWNUM]/td[4]//child::lightning-button-menu
${DEPSTEP_ACTION_WEBELEMENT}                            xpath\=//div[@class\='slds-scrollable_y']/table/tbody/tr[ROWNUM]/td[4]//child::span[text()\='ACTION']
${ADD_METADATA_SAVE_BUTTON_WEBELEMENT}                  xpath\=//*[@id\="thePage:theForm:pb:pbb_Save:btnSave"]
${GIT_BRANCH_WEBELEMENT}                                xpath\=//span[contains(@class,'field-label') and text()\='View in Git']/ancestor::flexipage-field//a
${SEARCH_ELEM_WEBELEMENT}                               xpath\=//input[@name\='column-search-text']
${USERSTORY_METADATA_SECTION_WEBELEMENT}                xpath\=(//span[@title\='User Story Metadata'])[1]
${USERSTORY_COMMITED_METADATA_WEBELEMENT}               xpath\=//span[@title\='METADATANAME']
${PROMOTION_NAME_VALUE_WEBELEMENT}                      xpath\=//table[@class='detailList']//tr[1]//td[2]
${HAS_APEX_CODE_WEBELEMENT}                             xpath\=//input[@name='copado__Has_Apex_Code__c']
${USERSTORYNUM_WEBELEMENT}                              xpath\=(//a[contains(text(),'US-')])[INDEX]