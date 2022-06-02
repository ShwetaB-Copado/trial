*** Settings ***
Documentation                   Contains common keywords related to test script and test run
Resource                        ../common_keywords.robot
Resource                        ../webelements/test_script_run_webelement.robot

*** Variables ***
${STATUS}                       Draft

*** Keywords ***
Create Test Script
    [Documentation]             Create a test script, verify and return the test script name
    ...                         Author : Dhanesh
    [Arguments]                 ${US_ID}                    ${PEER_REVIEWER}            ${RISK}
    ${TEST_TITLE}=              Generate random name
    ${INTRODUCTION}=            Generate random name
    ${TEST_DESCRIPTION}=        Generate random name
    ${PREREQUISITES}=           Generate random name
    ${EXPECTED_RESULTS}=        Generate random name
    Set Suite Variable          ${TEST_TITLE}               #Set suite variables to use it in another keywords
    Set Suite Variable          ${INTRODUCTION}
    Set Suite Variable          ${TEST_DESCRIPTION}
    Set Suite Variable          ${PREREQUISITES}
    Set Suite Variable          ${EXPECTED_RESULTS}
    Set Suite Variable          ${US_ID}
    VerifyText                  New Test Script
    ${US_PRESENT}=              RunKeywordAndReturnStatus                               VerifyText                  ${US_ID}                   timeout=2s
    Run Keyword Unless          ${US_PRESENT}               Select record from lookup field                         Search User Stories...     ${US_ID}
    VerifyText                  Credential
    VerifyText                  Status                      anchor=Overall Outcome
    ClickText                   Risk
    ClickText                   ${RISK}
    VerifyText                  Status                      anchor=Overall Outcome
    Select record from lookup field                         Search People...            ${PEER_REVIEWER}
    TypeText                    Test Title                  ${TEST_TITLE}               anchor=Additional Information
    TypeText                    Introduction                ${INTRODUCTION}             anchor=Additional Information
    TypeText                    Test Description            ${TEST_DESCRIPTION}
    TypeText                    Prerequisites               ${PREREQUISITES}
    TypeText                    Expected Result             ${EXPECTED_RESULTS}
    ClickText                   Save                        anchor=2
    VerifyText                  was created
    ${TEST_SCRIPT}=             Get ID from toast message window
    ${TEXT_PRESENT}=            RunKeywordAndReturnStatus                               VerifyText                  Test Scripts (User Story)
    Run Keyword If              ${TEXT_PRESENT}             ClickText                   ${TEST_SCRIPT}              anchor=Test Script Name
    VerifyText                  ${TEST_SCRIPT}              anchor=Test Script Name
    VerifyText                  ${PEER_REVIEWER}            anchor=3
    VerifyAll                   ${US_ID}, ${STATUS}, ${RISK}, ${TEST_TITLE}, ${INTRODUCTION}, ${TEST_DESCRIPTION}, ${PREREQUISITES}, ${EXPECTED_RESULTS}
    [Return]                    ${TEST_SCRIPT}

Create Test Script Step
    [Documentation]             create a new test script step for a test script
    ...                         Author : Dhanesh
    [Arguments]                 ${ORDER}
    ${ACTION_DESCRIPTION}=      Generate random name
    ${GUIDANCE_NOTES}=          Generate random name
    ${EXPECTED_RESULT}=         Generate random name
    Set Suite Variable          ${ACTION_DESCRIPTION}       #Set suite variables to use it in another keywords
    Set Suite Variable          ${GUIDANCE_NOTES}
    Set Suite Variable          ${EXPECTED_RESULT}
    VerifyText                  New Test Script Step
    TypeText                    Order                       ${ORDER}                    anchor=2
    TypeText                    Action/Description          ${ACTION_DESCRIPTION}
    TypeText                    Expected Result             ${EXPECTED_RESULT}
    TypeText                    Guidance notes              ${GUIDANCE_NOTES}
    ClickText                   Save                        anchor=2
    VerifyText                  was created
    ${SCRIPT_STEP_NAME}=        Get ID from toast message window
    VerifyText                  ${ACTION_DESCRIPTION}       anchor=Action/Description
    VerifyText                  ${EXPECTED_RESULT}          anchor=Expected Result
    VerifyText                  ${GUIDANCE_NOTES}           anchor=Guidance notes
    [Return]                    ${SCRIPT_STEP_NAME}

Create Test Run
    [Documentation]             Create a new test run for a test script
    ...                         Author : Dhanesh
    [Arguments]                 ${ENVIORONMENT}             ${TESTER}                   ${TEST_PHASE}               ${TEST_SCRIPT_NAME}
    ${TEST_COMMENTS}=           Generate random name
    Set Suite Variable          ${TEST_COMMENTS}
    VerifyText                  New Test Run
    ClickText                   Status
    ClickText                   Ready for testing
    ${TEST_SCRIPT_PRESENT}=     RunKeywordAndReturnStatus                               VerifyText                  ${TEST_SCRIPT_NAME}        timeout=2s
    Run Keyword Unless          ${TEST_SCRIPT_PRESENT}      Select record from lookup field                         Search Test Scripts...     ${TEST_SCRIPT_NAME}
    ClickText                   Test Phase
    ClickText                   ${TEST_PHASE}               anchor=Test Phase
    ${TESTSCRIPT_NAME}=         Replace String              ${TESTSCRIPT_NAME_WEBELEMENT}                           TEST_SCRIPT_NAME           ${TEST_SCRIPT_NAME}
    VerifyElement               ${TESTSCRIPT_NAME}
    Select record from lookup field                         Search Environments...      ${ENVIORONMENT}
    VerifyText                  Tester
    TypeText                    Overall Test Comments       ${TEST_COMMENTS}
    Select record from lookup field                         Search People...            ${TESTER}
    TypeText                    Overall Test Comments       ${TEST_COMMENTS}
    ClickText                   Save                        anchor=2
    VerifyText                  was created
    ${TEST_RUN_NAME}=           Get ID from toast message window
    ${TESTER_XPATH}=            Replace String              ${TESTER_NAME_WEBELEMENT}                               TESTER                     ${TESTER}
    VerifyAny                   ${TESTER_XPATH}, ${TESTER}
    VerifyText                  ${TEST_PHASE}               anchor=1
    VerifyText                  Ready for testing           anchor=1
    [Return]                    ${TEST_RUN_NAME}

Execute Test Run
    [Documentation]             Execute a test run and verify the same
    ...                         Author : Dhanesh
    ClickText                   Show more actions
    ClickText                   Execute Test Run
    VerifyText                  Test Run Information
    ${VALUE}=                   GetSelected                 Status
    Should Be Equal             ${VALUE}                    Ready for testing
    VerifyAll                   ${TEST_TITLE}, ${INTRODUCTION}, ${TEST_DESCRIPTION}, ${PREREQUISITES}, ${TEST_TITLE}, ${US_ID}, ${TEST_COMMENTS}, ${ACTION_DESCRIPTION}, ${GUIDANCE_NOTES}, ${EXPECTED_RESULT}

Verify Test Run Status Based On Buttons
    [Documentation]             Verify the test run status based on the image provided
    ...                         Author : Dhanesh
    [Arguments]                 ${IMAGE}                    ${TEST_RUN_STATUS}
    ${TESTRUN_IMAGE}=           Replace String              ${TEST_RUN_IMAGE_WEBELEMENT}                            IMAGE                      ${IMAGE}
    ClickElement                ${TESTRUN_IMAGE}
    VerifyText                  ${TEST_RUN_STATUS}          anchor=BUTTONS
    ${SELECTED_VALUE}=          GetSelected                 Status
    Should Be Equal             ${SELECTED_VALUE}           ${TEST_RUN_STATUS}