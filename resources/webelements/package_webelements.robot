*** Settings ***

Documentation    Web Elements for packages

*** Variables ***
${PACKAGE_VERSION_WEBELEMENT}    xpath\=//*[text()\='Latest Package Version']/ancestor::flexipage-field//span[@force-lookup_lookup]
${UPDATE_KEY_EDIT_WEBELEMENT}    xpath\=//header[text()\='Update Installation Key']/ancestor::div[@id\='wrapper-body']//button[text()\='Edit']
${SELECT_VERSION_WEBELEMENT}     xpath\=//a[text()\='VERSION NAME']/ancestor::tr//lightning-primitive-cell-checkbox
${JOB_ID_WEBELEMENT}             xpath\=//th[1]//lightning-formatted-url/a