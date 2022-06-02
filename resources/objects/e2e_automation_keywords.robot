*** Settings ***
Documentation    List of all the keywords used for E2E Automation
Resource         ../../resources/webelements/e2eautomation_webelement.robot
Resource         ../../resources/objects/developer_org.robot
Resource          ../../CommonUtilities/github_keywords.robot
Resource         ../../resources/common_keywords.robot
Library          QWeb
Library          String
Library          ImapLibrary2
Library          QForce


*** Variables ***
${BROWSER}=               chrome
${JobTitle}=              SDET
${Email}=                 e2emcdxautomation11@gmail.com
${Organization}=          Copado
${NumberOfEmployees}=     250+ employees  
${Country}=               India
${EmailId}=               @copa.do.sandbox
${FirstName}=
${LastName}=
${PhoneNumber}=
${UserName}=
${EE_UserName}=           
${Sandboxes}=
${CustomDomainURL_Prefix}=    https://




*** Keywords ***
Setup Browser
    [Documentation]      Opens the Chrome Browser
    ...                  Author: Prashant Arakeri
    ...                  Date: 23RD NOV 2021  
    Open Browser          about:blank                 ${BROWSER}
    SetConfig             LineBreak                   ${EMPTY}               #\ue000
    SetConfig             DefaultTimeout              20s                    #sometimes salesforce is slow
    Evaluate              random.seed()                        random 

Create Enterprise Edition Org
    [Documentation]       Creates an Enterprise Edition org
    ...                   Author: Prashant Arakeri
    ...                   Date: 23RD NOV 2021
    [Arguments]           ${FirstName}                ${LastName}            ${JobTitle}    ${Email}    ${PhoneNumber}    ${Organization}    ${NumberOfEmployees}    ${Country}    ${UserName}
    GoTo                  https://www.salesforce.org/trial/nonprofit-ee/
    Click on Accept Cookies
    VerifyText            Sign up for your Trial
    ${FirstName}=         Generate Random String      length=10              chars=[LETTERS]
    TypeText              First Name                  ${FirstName}
    ${LastName}=         Generate Random String      length=10              chars=[LETTERS]
    TypeText              Last Name                   ${LastName}
    TypeText              Job Title                   ${JobTitle}
    TypeText              Email                       ${Email}
    ${PhoneNumber}=       Generate Random String      length=10             chars=[NUMBERS]
    TypeText              Phone Number                ${PhoneNumber}
    TypeText              Organization                ${Organization}
    Dropdown              Number of Employees         ${NumberOfEmployees}
    Dropdown              Country                     ${Country}
    ${User_Name}=         Set Variable                ${FirstName}
    ${Email_Id}=          Set Variable                ${EmailId}
    ${UserName_MailId}=   Set Variable                ${FirstName}${Email_Id}
    TypeText              Username                    ${UserName_MailId}
    Log To Console        ${UserName_MailId}                            
    ClickElement          ${E2E_MASTERSUBSCRIPTION_CHECKBOX_WEBELEMENT}
    ClickText             Submit                      timeout=25
    VerifyText            Congratulations! Your Trial Awaits!
    [Return]              ${UserName_MailId}

Click on Accept Cookies
    [Documentation]       Click on Accept Cookies button
    ...                   Author: Prashant Arakeri
    ...                   Modified Date: 13TH JAN 2022
    ${ACCEPT_COOKIES}=    IsText     Accept All Cookies    5s    
    Run Keyword If        ${ACCEPT_COOKIES}
    ...                   ClickText    Accept All Cookies       

Open Setup for Enterprise Edition Org
    [Documentation]       Click on Set up For Enterprise Edition Org
    ...                   Author: Prashant Arakeri
    ...                   Date: 24TH NOV 2021
    VerifyText            Home                        anchor=Chatter
    ClickElement          ${SETTINGS_ICON_WEBELEMENT}
    VerifyText            Setup for current app
    ClickText             Setup for current app
    VerifyNoText                Loading                    anchor=Hide message

    
Enable Dev Hub and Source Tracking
    [Documentation]             Enable Dev Hub & Source Tracking for Enterprise Edition Org
    ...                        Author: Prashant Arakeri
    ...                        Date: 24TH NOV 2021
    SwitchWindow               2
    Open component on Setup Home tab                       Dev Hub
    VerifyText                        Enable Dev Hub to:
    Sleep                        2s
    ClickElement                      ${ENABLE_DEVHUB_WEBELEMENT}          timeout=5s
    VerifyText                        Enable Source Tracking in Sandboxes to:
    ClickElement                      ${ENABLE_SOURCETRACKING_WEBELEMENT}                   timeout=5s
    
Login with Enterprise Edition Org
    [Documentation]            Login with Enterprise Edition Org
    ...                        Author: Prashant Arakeri
    ...                        Date: 24TH NOV 2021
    [Arguments]                ${EE_UserName}              ${EE_Password}
    GoTo                       https://login.salesforce.com/
    VerifyText                 Salesforce
    TypeText                   Username                    ${EE_UserName}
    VerifyText                 Password
    TypeText                   Password                    ${EE_Password}
    ClickElement               ${EE_LOGINBUTTON_WEBELEMENT}                timeout=5
    
Create Sandboxes
    [Documentation]            Create Sandbox
    ...                        Author: Prashant Arakeri
    ...                        Date: 24Th NOV 2021
    [Arguments]                ${Sandbox_Name}
    Open component on Setup Home tab                        Sandboxes                        
    ${Sandbox_Name}=           Create List                        dev1                      dev2                        int                  stg                        
    FOR                        ${I}                        IN RANGE                        0                        4
        ${Sandboxes}=          Get From List              ${Sandbox_Name}                 ${I}
        VerifyText                        Available Sandbox Licenses
        ClickElement                      ${NEW_SANDBOXBUTTON_WEBELEMENT}
        VerifyText                        Create Sandbox
        TypeText                        Name              ${Sandboxes}
        VerifyText                      Sandbox License
        ClickElement                    ${DEVELOPERSANDBOX_NEXTBUTTON_WEBELEMENT}
        VerifyText                      Sandbox Options
        ClickText                       Create                    anchor=Back             timeout=10
        VerifyText                      Available Sandbox Licenses
    END
    
Verify SFDX Platform Exists
    [Documentation]             Verifies SFDX Platform Exists
    ...                        Author: Prashant Arakeri
    ...                        Date: 25TH NOV 2021
    Open Object on Developer ORG                        Environment
    Search field inside Object                        Platform
    ClickText                        Platform                 anchor=FIELD LABEL
    VerifyText                       Custom Field Definition Detail
    ScrollText                       Reorder                  timeout=5
    ${COUNT}                        GetTextCount              SFDX
    Log To Console                  ${COUNT}
    Run Keyword If                  '${COUNT}' == '0'         Create SFDX Platform            
    

Create SFDX Platform
    [Documentation]                 Creates New SFDX Platform
    ...                        Author: Prashant Arakeri
    ...                        Date: 25TH NOV 2021
    ClickElement              ${PLATFORM_NEWBUTTON_WEBELEMENT} 
    VerifyText                Platform
    TypeText                  ${PLATFORM_NAME_WEBELEMENT}     SFDX
    ClickText                   Save                        timeout=10

Login
    [Documentation]            Login to SF Org    #Test14 Env
    ...                        Author: Prashant Arakeri
    ...                        Date: 29TH NOV 2021
    GoTo                       https://login.salesforce.com/
    VerifyText                 Salesforce
    TypeText                   Username                    ${Credential_UserName}
    VerifyText                 Password
    TypeText                   Password                    ${Credential_Password}
    ClickElement               ${EE_LOGINBUTTON_WEBELEMENT}                timeout=5
    
Create and Authenticate Credentials
    [Documentation]            Creates and Authenticates Credential and Changes the platform to SFDX
    ...                        Author: Prashant Arakeri
    ...                        Date: 16TH DEC 2021
    ${CredentialsPrefix}=         Generate Random String      length=4              chars=[LETTERS]
    ${Credential_Names}=       Create List                        ${CredentialsPrefix}E2EDev1                    ${CredentialsPrefix}E2EDev2                      ${CredentialsPrefix}E2EInt                      ${CredentialsPrefix}E2EStg
    Set Suite Variable         ${Credential_Names}
    FOR                        ${I}                       IN RANGE                        0                        4
        RefreshPage
        Open Object                Credentials
        VerifyText                 New                    anchor=Import
        ClickText                  New                        anchor=Import
        VerifyText                 New Credential
        ${NEW_CREDENTIAL}=     Get From List              ${Credential_Names}             ${I}
        TypeText                   ${CREDENTIAL_NAME_WEBELEMENT}            ${NEW_CREDENTIAL}
        ClickElement               ${ORGTYPE_DROPDOWN_WEBELEMENT}           timeout=2s
        TypeText                   ${ORGTYPE_DROPDOWN_WEBELEMENT}           Custom Domain                   
        ClickText                  Custom Domain
        TypeText                   ${CUSTOMDOMAIN_URL_WEBELEMENT}              ${DOMAIN_URL_LIST}[${I}]
        ClickText                  Default Credential
        ClickElement               ${SAVE_CREDENTIAL_WEBELEMENT}
        VerifyText                 Details
        ClickText                  Authenticate                        anchor=Open Credential
        Sleep                      3s                        #Waiting for the login page
        TypeText                   ${USERNAME_WEBELEMENT}                    ${SANDBOX_NAME_LIST}[${I}]
        TypeText                   ${PASSWORD_WEBELEMENT}                    ${EEPassword}
        ClickElement               ${EE_LOGINBUTTON_WEBELEMENT}                timeout=5s
        VerifyText                 Allow Access?
        ClickElement               ${ALLOW_BUTTON_WEBELEMENT}
        Sleep                      5s                        #To wait until Page is loaded
        VerifyText                 Basic information
        ClickElement               ${SAVE_CREDENTIAL_WEBELEMENT}               timeout=10s
        VerifyText                 Credentials validated
        ClickText                  Details
        ${ENVIRONMENT_NAME}=       Replace String                        ${ENVIRONMENT_NAME_WEBELEMENT}            {ENVNAME}                        ${NEW_CREDENTIAL}
        ClickElement               ${ENVIRONMENT_NAME}
        VerifyText                 Details
        ClickElement               ${EDITPLATFORM_BUTTON_WEBELEMENT}
        ClickText                  Platform
        TypeText                   ${PLATFORM_WEBELEMENT}                      SFDX
        ClickText                  SFDX                        anchor=Heroku
        ClickElement               ${ENVIRONMENT_SAVEBUTTON_WEBELEMENT}
        VerifyText                 Pipelines
    END

    
Email Verification With Gmail
    [Documentation]            Email Verification with Gmail
    ...                        Author: Prashant Arakeri
    ...                        Date: 30TH NOV 2021
    Open Mailbox    host=imap.gmail.com    user=e2emcdxautomation11@gmail.com   password=andscqraghiecxkq
    ${LATEST}=      Wait For Email         sender=support@salesforce.com   timeout=360
    Log To Console                        index:  ${LATEST}
    ${body}=  Get Email Body   ${LATEST}
    Should Contain       ${body}                  Thanks for signing up with Salesforce!
    Close Mailbox
    
Multipart Email Verification
    [Documentation]       Multipart Email Verification
    ...                   Author: Prashant Arakeri
    ...                   Date: 30TH NOV 2021
    [Arguments]           ${UserId}
    Open Mailbox    host=imap.gmail.com    user=e2emcdxautomation11@gmail.com   password=andscqraghiecxkq
    ${LATEST}=      Wait For Email         sender=support@salesforce.com   text=${UserId}                  timeout=360
    ${parts}=       Walk Multipart Email                        ${LATEST}
    FOR            ${i}                        IN RANGE                   ${parts}
        Walk Multipart Email        ${LATEST}
        ${content-type}=            Get Multipart Content Type
        Continue For Loop If        '${content-type}' != 'text/html'
        ${payload}=                 Get Multipart Payload      decode=True
        ${body}=                    Get Email Body             ${LATEST}  
        ${ALL_LINKS}=               Get Links From Email    ${LATEST}
        GoTo                        ${ALL_LINKS}[0]
    END
    Close Mailbox
    
Change Password for EE Org
    [Documentation]                 Change Password for Enterprise Edition Org
    ...                        Author: Prashant Arakeri
    ...                        Date: 30TH NOV 2021
    VerifyText                 Change Your Password
    TypeText                   New Password                 ${EEPassword}
    VerifyText                 Good
    Sleep                      1s
    TypeText                   Confirm New Password         ${EEConfirmPassword}
    VerifyText                 Match
    Sleep                      1s
    ${BornCity}=         Generate Random String      length=10              chars=[LETTERS]
    TypeText             Answer                      ${BornCity}
    Sleep                1s
    ClickText            Change Password             timeout=10s
    Sleep                5s

Fetch Verification Code From Email
    [Documentation]      Fetches the Verification Code from Email
    ...                  Author: Prashant Arakeri
    ...                  Date: 01ST DEC 2021
    [Arguments]           ${UserId}
    Open Mailbox    host=imap.gmail.com    user=e2emcdxautomation11@gmail.com   password=andscqraghiecxkq           text=${UserId}                  timeout=360
    ${LATEST}=      Wait For Email         sender=noreply@salesforce.com   timeout=60
    Log To Console                        index:  ${LATEST}
    ${body}=                        Get Email Body                        ${LATEST}
    Log To Console             ${body}
    Should Contain       ${body}                  You recently logged in to Salesforce from a browser or app that we don't recognize.
    ${Parser_Body}=                        Remove String Using Regexp       ${body}    (<.*?>)
    ${Parsed_Token}=                       Split String                     ${Parser_Body}
    ${Parsed_Token}=                       Get From List                    ${Parsed_Token}    43
    Log To Console       ${Parsed_Token}
    ${Token}=         Set Variable                ${Parsed_Token}
    Delete All Emails
    Close Mailbox
    [Return]             ${Token}

Verify Sandbox Created Successfully
    [Documentation]            Verify Sandbox Created Successfully
    ...                        Author: Prashant Arakeri
    ...                        Date: 24TH NOV 2021
    ${SANDBOX_NAMES}=          Create List                        dev1                        dev2                  int                        stg
    FOR                        ${I}                        IN RANGE                        0                        4
        ${STATUS}=             Get From List               ${SANDBOX_NAMES}                ${I}
        ${COMPLETED_STATUS}=                        Replace String                        ${SANDBOX_STATUS_WEBELEMENT}                        {SANDBOX_NAME}         ${STATUS}
        RefreshPage
        Sleep                        10s
        VerifyElementText                        ${COMPLETED_STATUS}                      Completed                        timeout=5400s                        reason=To Wait Until Sandbox created status is Completed
        Wait Until Keyword Succeeds              ${I}                        900s                        Verify Sandbox Created Successfully
        RefreshPage
        Sleep                        10s
        Exit For Loop If             '${COMPLETED_STATUS}' == 'Completed'
    END

Verify Sandbox Status As Completed
    [Documentation]                  Verification of Sandbox Status to be Completed
    ...                        Author:Prashant Arakeri
    ...                        Date: 03RD DEC 2021
    UseTable              dev1
    FOR                   ${i}                        IN RANGE                        1                        5
        ${sandbox_status}=    GetCellText           r${i}c4  # use r${i}c4 in for loop
        ${status}=            Evaluate              "${sandbox_status}" == "Completed"
        IF  "${status}" == "False"
          Fail  Not ready yet
        END
    END


Fetch Custom Domain Url
    [Documentation]           Fetches the Custom Domain URL for Sandboxes
    ...                       Author: Prashant Arakeri
    ...                       Date: 06TH DEC 2021
    [Arguments]               ${UserId}
    ${VerificationCode}=      IsText    Verify Your Identity
    Run Keyword If            ${VerificationCode}    Enter Verification Code    ${UserId}
    ${Register_MobileNumber}=                       IsText                        Register Your Mobile Phone
    Run Keyword If                        ${Register_MobileNumber}                Register Your Mobile Phone Number
    Open Setup for Enterprise Edition Org
    SwitchWindow                        2
    Open component on Setup Home tab      Sandboxes


Register Your Mobile Phone Number
    [Documentation]                       Not to Register Mobile Phone
    ...                        Author: Prashant Arakeri
    ...                        Date: 06TH DEC 2021
    VerifyText                 Register Your Mobile Phone
    ClickText                  I Don't Want to Register My Phone                  timeout=10s
    
Click on Sabdbox Login
    [Documentation]            Click on Login Link for the Sandboxes
    ...                        Author: Prashant Arakeri
    ...                        Date: 06TH DEC 2021
    VerifyText                 Available Sandbox Licenses
    ${DOMAIN_URL_LIST}         Create List
    Set Suite Variable         ${DOMAIN_URL_LIST}
    ${SANDBOX_NAME_LIST}       Create List
    Set Suite Variable         ${SANDBOX_NAME_LIST}
    ${SANDBOX_NAMES}=          Create List                        dev1                        dev2                  int                        stg
    FOR                        ${I}                        IN RANGE                        0                        4
        ${STATUS}=             Get From List               ${SANDBOX_NAMES}                ${I}
        ${Login_Link_Sandboxes}=                        Replace String                        ${SANDBOX_LOGIN_WEBELEMENT}                        {SANDBOX_NAME}         ${STATUS}
        ClickElement                        ${Login_Link_Sandboxes}                        
        SwitchWindow                     3
        VerifyText                       Password
        TypeText                        Password                        ${EEPassword}
        ClickElement               ${EE_LOGINBUTTON_WEBELEMENT}                timeout=5s
        ${Register_MobileNumber}=                       IsText                        Register Your Mobile Phone
        Run Keyword If                        ${Register_MobileNumber}                Register Your Mobile Phone Number
        ${Verify_Identity}=                   IsText                        Verify Your Identity
        Run Keyword If                        ${Verify_Identity}            Enter Verification Code                        ${UserId}           
        Open Setup for Enterprise Edition Org
        SwitchWindow                        4
        Open component on Setup Home tab                        My Domain
        ${MY_DOMAIN_URL}=                        Get Text                      ${CUSTOM_DOMAIN_URL}
        ${CustomDomainURL_https}                Evaluate                      '${CustomDomainURL_Prefix}'+'${MY_DOMAIN_URL}'
        Append To List                        ${DOMAIN_URL_LIST}               ${CustomDomainURL_https}
        VerifyText                  Object Manager
        ClickText                   Home
        TypeText                    ${QUICK_FIND_WEBELEMENT}                        Users
        ClickText                   Users                        anchor=User Management Settings
        Sleep                       5s                        #waiting to load the users page                        
        DropDown           View          Admin Users                        timeout=5s
        VerifyText         Admin Users
        ${Sandboxes_Name}=                    Get Text                        ${SANDBOX_USERNAME_WEBELEMENT}
        Append To List                        ${SANDBOX_NAME_LIST}            ${Sandboxes_Name}
        CloseWindow
        CloseWindow
    END
    Log To Console                        ${DOMAIN_URL_LIST}
    Log To Console                        ${SANDBOX_NAME_LIST}
    [Return]                        ${DOMAIN_URL_LIST}                        ${SANDBOX_NAME_LIST}
                                                      

Enter Verification Code
    [Documentation]                 Enters the Verification Code from Email
    ...                        Author: Prashant Arakeri
    ...                        Date: 06TH DEC 2021
    [Arguments]                ${UserId}
    ${VerificationToken}=               Fetch Verification Code From Email    ${UserId}
    TypeText                        Verification Code             ${VerificationToken}             
    ClickText                       Verify                        timeout=10s
    
Create Private GIT Repo and Get SSH URL
    [Documentation]    Creates Private GIT Repo and Gets the SSH URL
    ...                Author: Prashant Arakeri
    ...                Date: 22ND DEC 2021
    ${GIT_Repo_Name}=         Generate Random String      length=6              chars=[LETTERS]
    ${GITRepo}=               Create Private Github Repo In Org    ${GIT_Repo_Name}E2E_Automation
    ${SSH}=                   Get SSH Url                   ${GIT_Repo_Name}E2E_Automation
    Log To Console            ${SSH}
    [Return]              ${SSH}
    Set Suite Variable    ${SSH}
    ${GITREPOS}=    Catenate   ${GIT_Repo_Name}E2E_Automation
    Log To Console            ${GITREPOS}
    Set Suite Variable    ${GITREPOS}
    
Creation of GIT Repo in Copado and Authenticate             
    [Documentation]    Creates the GIT Repo in Copado & Authenticates using SSH
    ...                Author: Prashant Arakeri
    ...                Date: 06Th JAN 2022
    RefreshPage
    VerifyText         Home    anchor=1
    ClickText          App Launcher
    VerifyText         ${APPS_WEBELEMENT1}
    TypeText           ${SEARCH_APPS_WEBELEMENT1}    Getting Started
    ClickText          Getting Started              anchor=2
    VerifyText         Getting Started              anchor=2
    ClickText          GIT                        timeout=45s
    VerifyText         Git Repositories
    ClickText          New Git Repository
    SwitchWindow       3
    VerifyText         Details
    TypeText           Git Repository Name        ${GITREPOS}
    DropDown           Source Format          DX
    TypeText           URI                    ${SSH}
    DropDown           Git Provider           Github
    ${Branch_Base_URL}=                       GetInputValue                      Branch Base URL                       
    Log To Console                        ${Branch_Base_URL}
    ${DICTIONARY}=                        Create Dictionary                      {Username}=CopadoSolutions    {RepositoryName}=${GITREPOS}
    ${BRANCHBASEURL}=                     Replace All                        ${Branch_Base_URL}                        ${DICTIONARY}
    TypeText                        Branch Base URL                        ${BRANCHBASEURL}
    ${Commnit_Base_URL}=                      GetInputValue                      Commit Base URL      
    Log To Console                        ${Commnit_Base_URL}
    ${COMMITBASEURL}=                     Replace All                        ${Commnit_Base_URL}                        ${DICTIONARY}
    TypeText                        Commit Base URL                        ${COMMITBASEURL}                  
    ${Pull_Request_Base_URL}=                 GetInputValue      Pull Request Base URL
    Log To Console                        ${Pull_Request_Base_URL}
    ${PULLREQUESTBASEURL}=                Replace All                        ${Pull_Request_Base_URL}                        ${DICTIONARY}
    TypeText                        Pull Request Base URL                    ${PULLREQUESTBASEURL}
    ${Tag_Base_URL}=                        GetInputValue        Tag Base URL
    Log To Console                        ${Tag_Base_URL}
    ${TAGBASEURL}=                        Replace All                        ${Tag_Base_URL}                        ${DICTIONARY}
    TypeText                        Tag Base URL                        ${TAGBASEURL}
    ClickText                       Save
    ClickText                       Create SSH Keys                     anchor=1                        timeout=10s
    RefreshPage
    RefreshPage
    VerifyText                      Current Keys
    ClickText                       View                        anchor=2
    VerifyText                      Key Content
    ${SSHKEY}=                        GetText                        ${SSH_KEY_WEBELEMENT}
    Log To Console                 ${SSHKEY}
    Set Suite Variable    ${SSHKEY}
    [Return]                       ${SSHKEY}
    ${GIT_Name}=         Generate Random String      length=6              chars=[LETTERS]
    Add Ssh Key            ${SSHKEY}
    Sleep                  5s                        #Waiting to Add SSH Key to Git Hub Repository
    RefreshPage
    RefreshPage
    VerifyText             Credentials validated
    CloseWindow
    
Create Prod Org and Authenticate
    [Documentation]    Creates the Prod Org & Authenticate
    ...                Author: Prashant Arakeri
    ...                Date: 06TH JAN 2022
    [Arguments]        ${UserId}
    Open Object                Credentials
    ClickText                  New                        anchor=Import
    VerifyText                 New Credential
    TypeText                   ${CREDENTIAL_NAME_WEBELEMENT}            ${UserId}
    ClickElement               ${ORGTYPE_DROPDOWN_WEBELEMENT}           timeout=2s
    TypeText                   ${ORGTYPE_DROPDOWN_WEBELEMENT}           Production/Developer
    ClickText                  Default Credential
    ClickElement               ${SAVE_CREDENTIAL_WEBELEMENT}
    VerifyText                 Details
    ClickText                  Authenticate                        anchor=Open Credential
    Sleep                      3s                        #Waiting for the login page
    TypeText                   ${USERNAME_WEBELEMENT}                    ${UserId}
    TypeText                   ${PASSWORD_WEBELEMENT}                    ${EEPassword}
    ClickElement               ${EE_LOGINBUTTON_WEBELEMENT}                timeout=5s
    ${VerificationCode}=      IsText    Verify Your Identity
    Run Keyword If            ${VerificationCode}    Enter Verification Code    ${UserId}
    ${Register_MobileNumber}=                       IsText                        Register Your Mobile Phone
    Run Keyword If                        ${Register_MobileNumber}                Register Your Mobile Phone Number
    VerifyText                 Allow Access?
    ClickElement               ${ALLOW_BUTTON_WEBELEMENT}
    Sleep                      5s                        #To wait until Page is loaded
    VerifyText                 Basic information
    ClickElement               ${SAVE_CREDENTIAL_WEBELEMENT}               timeout=10s
    VerifyText                 Credentials validated

Create GIT Snapshot for Prod Org
    [Documentation]    Creates the GIT Snapshot for the Prod Org
    ...                Author: Prashant Arakeri
    ...                Date: 06TH JAN 2022
    [Arguments]        ${UserId}
    ClickText          App Launcher
    VerifyText         ${APPS_WEBELEMENT1}
    TypeText           ${SEARCH_APPS_WEBELEMENT1}    Getting Started
    ClickText          Getting Started              anchor=2
    VerifyText         Getting Started              anchor=2
    ClickText          GIT
    VerifyText         Git Repositories
    ClickElement       ${GIT_REPOSITORY_WEBELEMENT}
    TypeText           ${GIT_REPOSITORY_WEBELEMENT}    ${GITREPOS}
    ClickText          Select a Git Repository:
    ClickText          New Git Snapshot
    TypeText           Git Snapshot Name            ${UserId}
    TypeText           Branch                       main
    ClickElement       ${GIT_SNAPSHOTPERMISSIONS_WEBELEMENT}
    TypeText           ${GIT_SNAPSHOTPERMISSIONS_WEBELEMENT}    Allow Snapshots & commits
    ClickText          Git Snapshot Permissions      
    TypeText           ${GITSNAPSHOT_CREDENTIAL_WEBELEMENT}                        ${UserId}
    ClickText          Create
    
Take Snapshot
    [Documentation]    Navigates to Git Snapshots and Clicks on Take Snapshot
    ...                Author: Prashant Arakeri
    ...                Date: 06TH JAN 2022
    [Arguments]        ${UserId}
    ClickText          ${UserId}    anchor=1
    SwitchWindow       3
    VerifyText         Basic information
    ClickText          Take Snapshot Now
    ClickText          OK
    ${PROGRESS_WINDOW_GITSNAPSHOT}=                     RunKeywordAndReturnStatus                               VerifyText            Hide message                timeout=600s
    Run Keyword Unless          ${PROGRESS_WINDOW_GITSNAPSHOT}                      RefreshPage
    CloseWindow

GIT Snapshots For All Environments
    [Documentation]    Create GIT Snapshots for All the Environments Used in Pipeline
    ...                Author: Prashant Arakeri
    ...                Date: 11TH JAN 2022
    VerifyText         Git Repositories
    ${GITSNAPSHOT_NAMES}=          Create List                        E2EDev1                        E2EDev2                  E2EInt                        E2EStg
    FOR                        ${I}                        IN RANGE                        0                        4
        ${GITSNAPSHOTS}=             Get From List               ${GITSNAPSHOT_NAMES}                ${I}
        ClickText              New Git Snapshot
        VerifyText             Git Snapshots
        TypeText               Git Snapshot Name                 ${GITSNAPSHOTS}
        TypeText               Branch                        ${GITSNAPSHOTS}
        ClickElement       ${GIT_SNAPSHOTPERMISSIONS_WEBELEMENT}
        TypeText           ${GIT_SNAPSHOTPERMISSIONS_WEBELEMENT}    Allow Commits Only
        ClickText          Git Snapshot Permissions      
        TypeText           ${GITSNAPSHOT_CREDENTIAL_WEBELEMENT}                        ${Credential_Names}[${I}]
        ClickText          Create                        timeout=45s                        #waiting untill GIT Snapshot is created
        VerifyText         Refresh
    END

Create Pipeline
    [Documentation]    Creates Pipeline
    ...                Author: Prashant Arakeri
    ...                Date: 11TH JAN 2022
    ClickText          App Launcher
    VerifyText         ${APPS_WEBELEMENT1}
    TypeText           ${SEARCH_APPS_WEBELEMENT1}    Pipelines
    ClickText          Pipelines                     anchor=1
    VerifyAll          Pipeline Name, Active, Created Date, Last Modified Date
    ClickText          New                        anchor=Import
    VerifyText         New Pipeline
    ${PIPELINE_NAME}=         Generate Random String      length=6              chars=[LETTERS]
    TypeText           ${PIPELINE_NAME_WEBELEMENT}          ${PIPELINE_NAME}E2E_Automation
    ClickText          Platform                        anchor=1
    Sleep                        2s
    ClickText                  SFDX                        anchor=Heroku
    TypeText                   Git Repository                        ${GITREPOS}
    ClickText                  ${GITREPOS}                  anchor=2
    TypeText                   Main Branch                        main
    ClickElement               ${NEWPIPELINE_ACTIVE_WEBELEMENT}
    ClickText                  Save                        anchor=2
    VerifyAll                  Details, Pipeline Connections, Projects, Views, System Properties            
    ClickElement               ${PROMOTIONJOBTEMPLATE_EDITBUTTON_WEBELEMENT}
    TypeText                   Promotion Job Template             SFDX Promote    
    ClickText                  SFDX Promote                       anchor=2                       
    TypeText                   Deployment Job Template            SFDX Deploy     
    ClickText                  SFDX Deploy                        anchor=2
    TypeText                   Commit Job Template                SFDX Commit
    ClickText                  SFDX Commit                        anchor=2
    ClickText                  Save

Pipeline Connections
    [Documentation]    Creates Pipeline Connections
    ...                Author: Prashant Arakeri
    ...                Date: 11TH JAN 2022
    [Arguments]        ${UserId}
    ClickText          Pipeline Connections
    ClickText          New
    VerifyText         New Pipeline Connection
    TypeText           Source Environment    E2EDev1    anchor=2
    ClickText          E2EDev1               anchor=2
    TypeText           Destination Environment    E2EInt    anchor=2
    ClickText          E2EInt                     anchor=2
    TypeText           Branch                     E2EDev1
    ClickText          Save                       anchor=2
    Sleep              1s
    ClickText          New
    VerifyText         New Pipeline Connection
    TypeText           Source Environment    E2EDev2        anchor=2
    ClickText          E2EDev2               anchor=2
    TypeText           Destination Environment    E2EInt    anchor=2
    ClickText          E2EInt                     anchor=2
    TypeText           Branch                     E2EDev2    anchor=2
    ClickText          Save                       anchor=2
    Sleep              1s
    ClickText          New
    VerifyText         New Pipeline Connection
    TypeText           Source Environment    E2EInt         anchor=2
    ClickText          E2EInt                anchor=2
    TypeText           Destination Environment    E2EStg    anchor=2
    ClickText          E2EStg                     anchor=2
    TypeText           Branch                     E2EInt     anchor=2
    ClickText          Save                       anchor=2
    Sleep              1s
    ClickText          New
    VerifyText         New Pipeline Connection
    TypeText           Source Environment    E2EStg          anchor=2
    ClickText          E2EStg                anchor=2
    TypeText           Destination Environment    ${UserId}    anchor=2
    ClickText          ${UserId}    anchor=2
    TypeText           Branch                     E2EStg                        anchor=2
    ClickText          Save                       anchor=2
    Sleep              1s

Add SSH To GitHub Repo
    [Documentation]    Add the SSH Key to GitHub Repository
    ...                Author: Prashant Arakeri
    ...                Date: 27TH JAN 2022
    [Arguments]        ${SSH_KEY_VALUE}
    GoTo               https://github.com/
    VerifyElement        ${GIT_SIGNIN_WEBELEMENT}
    ClickElement         ${GIT_SIGNIN_WEBELEMENT}
    TypeText           Username or email address    Copadocrt
    TypeText           Password                     Copado@1234
    ClickText          Sign in                      anchor=Password
    VerifyAll          Pull requests, Issues, Marketplace, Explore
    ClickElement       ${GIT_PROFILE_WEBELEMENT}
    ClickText          Settings
    ClickElement          ${SSH_CPGKEYS_WEBELEMENT}
    VerifyElement        ${NEW_SSH_KEY_WEBELEMENT}
    ClickElement          ${NEW_SSH_KEY_WEBELEMENT}
    ${SSH_Title}=         Generate Random String      length=6              chars=[LETTERS]
    TypeText           Title          ${SSH_Title}'E2E_Automation'
    ClickElement       ${SSH_WEBELEMENT}
    TypeText           ${SSH_WEBELEMENT}              ${SSHKEY}
    ClickText          Add SSH Key     

Custom Objects Deletion
    FOR   ${I}   IN RANGE                       1                       10
        ClickElement                   ${CUSTOM_OBJECT_WEBELEMENT}
        ClickText                      Delete                       anchor=Edit
        VerifyText                     Deleting a custom field will:
        ClickText                      Delete                       anchor=Cancel
        VerifyNoText                   Loading
        VerifyText                     Sorted by Label
    END         