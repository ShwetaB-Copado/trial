*** Settings ***
Documentation               List of webelements used for Test Script and Test Run

*** Variables ***
${FIRST_NEW_WEBELEMENT}     xpath\=(//button[@name\='New'])[1]
${SECOND_NEW_WEBELEMENT}    xpath\=(//button[@name\='New'])[2]
${TEST_RUN_WEBELEMENT}      xpath\=//th[@data-label\='Test Run Name']//child::a
${TESTSCRIPT_NAME_WEBELEMENT}                           xpath\=//input[@placeholder\='TEST_SCRIPT_NAME']
${TEST_RUN_IMAGE_WEBELEMENT}                            xpath\=//img[@alt\='IMAGE']
${INPUT_TESTSCRIPTSTEP_WEBELEMENT}                      xpath\=//input[contains(@class,'input-value') and contains(@placeholder,'TS')]
${TESTER_NAME_WEBELEMENT}                               xpath\=//a[@title\='TESTER']
${TESTSCRIPTSTEP_NEWBUTTON_WEBELEMENT}                  xpath\=//span[contains(text(),'Test Script Steps')]/ancestor::lst-related-list-single-container//button[text()\='New']
${TESTRUNSTEP_NEWBUTTON_WEBELEMENT}                     xpath\=//span[contains(text(),'Test Runs')]/ancestor::lst-related-list-single-container//button[text()\='New']