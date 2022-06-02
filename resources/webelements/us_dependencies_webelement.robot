*** Settings ***
Documentation               Web Elements for User Storiey Depenedencies

*** Variables ***
${CHILD_US_SECTION_WEBELEMENT}                          xpath\=//span[@title\='Child User Story']//parent::h3
${PARENT_US_SECTION_WEBELEMENT}                         xpath\=//span[@title\='Parent User Story']//parent::h3
${RELATIONSHIP_SECTION_WEBELEMENT}                      xpath\=//span[@title\='Relationship type']//parent::h3
${RELATIONSHIP_TYPE_DROPDOWN_WEBELEMENT}                xpath\=//button[@aria-label\='Relationship Type, relates to']
${REL_TYPE_VALUE_WEBELEMENT}                            xpath\=//lightning-base-combobox-item[@data-value\='RELVALUE']
${US_DEPENDENCY_ID_WEBELEMENT}                          xpath\=//lightning-formatted-text[@slot\='primaryField' and contains(text(),'UD')]
${EDIT_REL_TYPE_WEBELEMENT}                             xpath\=//button[@title\='Edit Relationship Type']
${DEPENECY_STATUS_DROPDOWN_WEBELEMENT}                  xpath\=//button[@aria-label\='Dependency Status, New']
${DEP_STATUS_VALUE_WEBELEMENT}                          xpath\=//flexipage-field[@data-field-id\='RecordDependency_Status_cField1']//child::lightning-base-combobox-item[@data-value\='SVALUE']
${NOTES_WEBELEMENT}                                     xpath\=//textarea[@class\="slds-textarea"]