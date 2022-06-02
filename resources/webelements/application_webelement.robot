*** Settings ***

Documentation               Web Elements for Application Record

*** Variables ***
${SUB_APPLICATION_NEWBUTTON_WEBELEMENT}                 xpath\=//span[@title='Sub-Applications']/ancestor::lst-common-list-internal//button
${STATUS_NEWFEATURE_WEBELEMENT}                         xpath\=//label[text()\='Status']
${FEATURES_SECTION_WEBELEMENT}                          xpath\=//span[@title\="Features"]