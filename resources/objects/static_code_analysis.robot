** Settings ***
Documentation          Methods for creating Static Code Analysis record
Resource               ../../resources/objects/metadata_group.robot
Resource               ../../resources/objects/automation.robot
Resource               ../../resources/objects/developer_org.robot
Resource               ../../resources/objects/user_story.robot
Resource               ../../resources/webelements/static_code_analysis_webelement.robot
Test Setup             Start Suite
Test Teardown          End Suite

*** Keywords ***
Create Static Code Analysis Of PMD Record Type
    [Documentation]    Creating Static Code Analysis of PMD Record Type
    ...                Author: Naveen
    ...                Date: 15th NOV 2021
    ClickText          New
    ClickElement       ${PMD_RECORD_TYPE_WEBELEMENT}
    ClickText          Next
    ${SCA_NAME}=       Generate random name
    TypeText           ${SCA_SETTING_NAME_WEBELEMENT}         ${SCA_NAME}
    ClickText          Save
    VerifyAll          ${SCA_NAME}, Record Type, PMD, Pipelines, Generate Default Rule Set
    ClickText          Show more actions
    ClickText          Generate Default Rule Set
    VerifyAll          Name, Message
    ClickText          Finish
    ClickText          Rules
    ClickText          View All
    VerifyAll          Static Code Analysis Rule Name, Rule Name, Priority, Message
    VerifyAll          WhileLoopsMustUseBraces,IfStmtsMustUseBraces, NcssTypeCount, IfElseStmtsMustUseBraces, MethodNamingConventions, StdCyclomaticComplexity, ApexSOQLInjection, ForLoopsMustUseBraces, FieldNamingConventions, UnusedLocalVariable, ApexSharingViolations, NcssConstructorCount, LocalVariableNamingConventions, TooManyFields, ExcessiveParameterList, MethodWithSameNameAsEnclosingClass, ApexUnitTestClassShouldHaveAsserts
    ScrollText         ExcessiveParameterList
    ScrollText         MethodWithSameNameAsEnclosingClass
    VerifyAll          ApexXSSFromEscapeFalse, AvoidGlobalModifier, CognitiveComplexity, AvoidNonExistentAnnotations, ApexOpenRedirect, ApexUnitTestShouldNotUseSeeAllDataTrue, ApexBadCrypto, ApexInsecureEndpoint, FormalParameterNamingConventions, ApexSuggestUsingNamedCred, EmptyTryOrFinallyBlock, EmptyIfStmt, CyclomaticComplexity, DebugsShouldUseLoggingLevel, AvoidHardcodingId, ExcessivePublicCount, ApexXSSFromURLParam, ApexUnitTestMethodShouldHaveIsTestAnnotation, AvoidLogicInTrigger, NcssMethodCount
    ScrollText         ApexXSSFromURLParam
    VerifyAll          ApexCSRF, OneDeclarationPerLine, VfCsrf, ApexCRUDViolation, VfUnescapeEl, AvoidDirectAccessTriggerMap, TestMethodsMustBeInTestClasses, FieldDeclarationsShouldBeAtStart, VfHtmlStyleTagXss
    ScrollText         ExcessiveClassLength
    VerifyAll          ExcessiveClassLength, EmptyCatchBlock, AvoidDeeplyNestedIfStmts, ApexDoc, OperationWithLimitsInLoop, ApexDangerousMethods, EmptyWhileStmt, PropertyNamingConventions, EmptyStatementBlock, ClassNamingConventions, ApexAssertionsShouldIncludeMessage, OverrideBothEqualsAndHashcode
    [Return]           ${SCA_NAME}

Create Static Code Analysis Of CodeScan Record Type
    [Documentation]          Creating Static Code Analysis of CodeScan Record Type
    ...                      Author: Naveen
    ...                      Date: 15th NOV 2021
    [Arguments]              ${CODESCAN_URL}         
    ClickText                New
    ClickElement             ${CODESCAN_RECORD_TYPE_WEBELEMENT}
    ClickText                Next
    ${SCA_CODESCAN_NAME}=    Generate random name
    TypeText                 ${SCA_SETTING_NAME_WEBELEMENT}                      ${SCA_CODESCAN_NAME}
    DropDown                 CodeScan Version            Cloud
    TypeSecret               CodeScan Token              ${CODESCAN_TOKEN}
    TypeText                 CodeScan URL                ${CODESCAN_URL}
    TypeSecret               Cloud Organization          ${CODESCAN_ORG_ID}
    ClickText                Save                        anchor=1
    [Return]                 ${SCA_CODESCAN_NAME} 