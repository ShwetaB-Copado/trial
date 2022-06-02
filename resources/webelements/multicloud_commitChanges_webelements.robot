*** Settings ***
Documentation               Web Elements for multicloud commit changes

*** Variables ***
${METADATA_CHECKBOX_WEBELEMENT}         xpath\=//lightning-base-formatted-text[contains(text(),'{METADATA}')]/ancestor::tr//input[@type\='checkbox']/parent::span/parent::lightning-primitive-cell-checkbox
${PULL_CHANGES_WEBELEMENT}              xpath\=//button[@title\='Pull Changes']
${COMMIT_CHANGES_BUTTON_WEBELEMENT}     xpath\=//lightning-button[@copado-userstorycommitheader_userstorycommitheader]/button[text()\='Commit Changes']
${ACTION_WEBELEMENT}                    xpath\=//lightning-base-formatted-text[text()\='CUSOBJNAME']//preceding::th[1]
${MODIFY_PENCIL_WEBELEMENT}             xpath\=//lightning-base-formatted-text[text()\='CUSOBJNAME']/preceding::th[1]//lightning-primitive-icon
${ACTION_DROPDOWN}                      xpath\=//lightning-base-formatted-text[text()\='CUSOBJNAME']//preceding::th[1]//button
${CHECKBOX_SELECTION}                   xpath\=//lightning-base-formatted-text[text()\='CUSOBJNAME']//preceding::label[@class\='slds-checkbox__label'][1]
${METADATAAPI_CHECKBOX_WEBELEMENT}      xpath\=//lightning-base-formatted-text[text()\='{METADATA}']/ancestor::tr//input[@type\='checkbox']/parent::span/parent::lightning-primitive-cell-checkbox
${DIRECTORY_PATH_PENCIL_WEBELEMENT}     xpath\=//lightning-base-formatted-text[text()\='METADATANAME']//following::td[@data-label\='Directory']//child::lightning-primitive-icon
${DIRECTORY_MODIFY_WEBELEMENT}          xpath\=//input[@name\='dt-inline-edit-text' and @class\='slds-input']