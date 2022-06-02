*** Settings ***
Documentation                   Contains common keywords required for developer ORG
Resource                        ../common_keywords.robot
Resource                        ../webelements/developer_org_webelement.robot

*** Keywords ***
Open Developer ORG
    [Documentation]             Open the developer ORG
    Open Show more actions on Details page
    VerifyText                  Open
    ClickText                   Open
    Sleep                       10s                         #Sometimes automation will fail due to a blank screen and sometimes it is very fast that we can't validate another text/element.
    VerifyNoText                Loading                     25s                         anchor=Hide message         #For the User Story page, we will get a loading widget in the same tab.
    SwitchWindow                2                           #Switch to developer ORG
    VerifyNoText                Loading                     25s                         anchor=Hide message         #For the Credential page, we will get a loading widget in the next tab.
    Switch To Lightning         #Switch to lightning if classic view opened
    VerifyText                  Object Manager

Open Object on Developer ORG
    [Documentation]             Open Object on developer ORG
    [Arguments]                 ${OBJECT}
    VerifyText                  Object Manager
    ClickText                   Object Manager
    VerifyText                  Schema Builder
    TypeText                    Quick Find                  ${OBJECT}                   anchor=Schema Builder
    Sleep                       2s                          #Added to wait for page load
    VerifyText                  ${OBJECT}                   2
    ClickText                   ${OBJECT}
    ClickText                   Fields & Relationships

Search field inside Object
    [Documentation]             Search field inside the object
    [Arguments]                 ${FIELD}
    FOR                         ${I}                        IN RANGE                    0                           2
        ClickElement            ${SEARCH_FIELD_WEBELEMENT}
        TypeText                ${SEARCH_FIELD_WEBELEMENT}                              ${FIELD}
        ${SEARCHED_RECORD}=     Replace String              ${SEARCHED_FIELD_WEBELEMENT}                            FIELD                       ${FIELD}
        ${ISPRESENT}=           IsText                      ${SEARCHED_RECORD}          timeout=60s
        Exit For Loop If        ${ISPRESENT}
    END
    VerifyText                  ${FIELD}

Add new field to object
    [Documentation]             Add the new field to the opened object on developer ORG and return the field name
    ClickText                   New
    ClickText                   Text
    ClickText                   Next
    VerifyText                  New Custom Field
    ${FIELD}=                   Generate random name
    TypeText                    MasterLabel                 ${FIELD}
    TypeText                    Length                      10
    ClickText                   Next
    ClickText                   Next
    ClickText                   Save
    Sleep                       2s
    #Verify field created
    Search field inside Object                              ${FIELD}
    [Return]                    ${FIELD}

Verify field and delete
    [Documentation]             Verify the field on developer ORG and delete it
    [Arguments]                 ${ORG}                      ${OBJECT}                   ${FIELD}

    #Open developer ORG through Credentials object
    Open Object                 Credentials
    Open record from object main page                       ${ORG}
    VerifyText                  Open Org
    VerifyText                  Credentials validated       60s
    Open Developer ORG

    #Open object, then Verify field and delete it
    Open Object on Developer ORG                            ${OBJECT}
    Search field inside Object                              ${FIELD}
    ClickText                   Show More
    ClickText                   Delete
    VerifyText                  Cancel                      #Checking Delete window appears
    ClickText                   Delete                      anchor=Cancel
    VerifyNoText                Loading
    CloseWindow

Open component on Setup Home tab
    [Documentation]             Open any component from Home tab of the Setup page      Ex: Open Profiles/User/Apex Class
    [Arguments]                 ${COMPONENT}
    VerifyText                  Object Manager
    ClickText                   Home
    TypeText                    ${QUICK_FIND_WEBELEMENT}    ${COMPONENT}
    VerifyTextCount             ${COMPONENT}                1
    ClickText                   ${COMPONENT}

Create Profile
    [Documentation]             Creating profile from existing profile and adding ModifyAllData permissions
    Open component on Setup Home tab                        Profiles
    VerifyText                  Didn't find what you're looking for? Try using Global Search.
    ${PROFILE_NAME}=            Generate random name
    VerifyAll                   Edit, Delete, Create New View
    ClickText                   New Profile                 anchor=All Profiles
    VerifyText                  Clone Profile
    DropDown                    p2                          option=Custom: Marketing Profile                        anchor=Existing Profile
    TypeText                    Profile Name                ${PROFILE_NAME}             #profile name is fetched from variables.robot file
    ClickText                   Save                        anchor=Cancel
    VerifyText                  ${PROFILE_NAME}
    VerifyText                  Standard Object Layouts
    VerifyText                  Home Page Layout
    ClickText                   ${PROFILE_EDIT_BUTTON_WEBELEMENT}
    ScrollText                  Modify All Data
    Sleep                       1s
    ClickCheckbox               Modify All Data             on
    ClickText                   Save                        anchor=1
    VerifyText                  ${PROFILE_NAME}
    [Return]                    ${PROFILE_NAME}

Delete Profile from Org
    [Documentation]             Deleting Profile from the Org
    [Arguments]                 ${PROFILE_NAME_TO_DELETE}
    VerifyText                  ${PROFILE_NAME_TO_DELETE}
    ClickText                   ${PROFILE_NAME_TO_DELETE}
    VerifyText                  Edit                        anchor=Profile Detail
    VerifyText                  Clone                       anchor=Profile Detail
    VerifyText                  Delete                      anchor=Profile Detail
    ClickText                   Delete                      anchor=Profile Detail
    ClickText                   Delete                      anchor=Profile Detail
    ${DELETE_ALERT}=            GetAlertText
    Run Keyword If              '${DELETE_ALERT}'=='Are you sure?'                      CloseAlert                  Accept
    VerifyNoText                ${PROFILE_NAME_TO_DELETE}

Create Apex Class
    [Documentation]             Creating an apex class in developer org
    [Arguments]                 ${APEX_CLASS_CONTENT}
    Open component on Setup Home tab                        Apex Classes
    ClickText                   New                         anchor=Schedule Apex
    VerifyText                  Apex Class Edit
    TypeText                    xpath\=//textarea[@id\="textarea"]                      ${APEX_CLASS_CONTENT}
    ClickText                   Save
    VerifyText                  Apex Class Detail           #verifying that apex class is saved

Edit Apex Class and Save
    [Documentation]             Editing an apex class in developer org
    [Arguments]                 ${APEX_CLASS_NAME}          ${APEX_CLASS_CONTENT}
    Open component on Setup Home tab                        Apex Classes
    ClickText                   ${APEX_CLASS_NAME}
    VerifyText                  ${APEX_CLASS_NAME}
    ClickText                   Edit
    VerifyText                  Apex Class Edit
    TypeText                    xpath\=//textarea[@id\="textarea"]                      ${APEX_CLASS_CONTENT}
    ClickText                   Save
    VerifyText                  Apex Class Detail           #verifying that apex class is saved

Change org user name
    [Documentation]             To change the org first name and last name
    [Arguments]                 ${FIRST_NAME}               ${LAST_NAME}
    ClickText                   View profile
    ClickElement                xpath\=//a[contains(@href,'settings')]
    VerifyText                  First Name
    TypeText                    First Name                  ${FIRST_NAME}
    VerifyText                  Last Name
    TypeText                    Last Name                   ${LAST_NAME}
    ScrollText                  Save
    ClickText                   Save
    VerifyText                  Your settings have been successfully saved.

Add new field to object as per argument
    [Documentation]             Add the new field to the opened object on developer ORG as per argument.
    [Arguments]                 ${FIELD}
    ClickText                   New
    ClickText                   Text
    ClickText                   Next
    VerifyText                  New Custom Field
    TypeText                    MasterLabel                 ${FIELD}
    TypeText                    Length                      10
    ClickText                   Next
    ClickText                   Next
    ClickText                   Save
    Sleep                       2s
    #Verify field created
    Search field inside Object                              ${FIELD}

Open Trigger object in Developer Org
    [Documentation]             Open Trigger Object in the Developer org
    VerifyText                  Triggers
    ClickText                   Triggers

Create Apex Trigger
    [Documentation]             Creating an Apex Trigger in the Developer org
    [Arguments]                 ${APEX_TRIGGER_CONTENT}
    ClickText                   New
    VerifyText                  Apex Trigger Edit
    TypeText                    xpath\=//textarea[@id\="textarea"]                      ${APEX_TRIGGER_CONTENT}
    ClickText                   Save
    VerifyText                  Apex Trigger Detail         #To verify Apex Trigger is Saved

Delete the Apex Classes
    [Documentation]             Delete the Apex Class
    SwitchWindow                2                           #Switching to Developer Org
    ClickElement                xpath\=(//a[contains(@class,'tabHeader slds-context-bar__label-action ')])[1]
    TypeText                    xpath\=//input[contains(@placeholder,'Quick Find')]     Apex Classes
    ClickText                   Apex Classes                anchor=Didn't find what you're looking for?
    ${APEXCLASSNAMES_COUNT}     GetElementCount             xpath\=//a[@onclick\="return confirmDelete();"]
    FOR                         ${INDEX}                    IN RANGE                    0                           ${APEXCLASSNAMES_COUNT}
        VerifyAll               Developer Console, Run All Tests, Schedule Apex
        ClickElement            xpath\=(//a[@onclick\="return confirmDelete();"])[1]
        CloseAlert              Accept
        VerifyText              Apex Code is an object
    END

Delete the Apex Triggers
    [Documentation]             Delete the Apex Trigger
    TypeText                    xpath\=//input[contains(@placeholder,'Quick Find')]     Apex Triggers
    ClickText                   Apex Triggers               anchor=Didn't find what you're looking for?
    ${APEXTRIGGERS_COUNT}       GetElementCount             xpath\=//a[@onclick\="return confirmDelete();"]
    FOR                         ${INDEX}                    IN RANGE                    0                           ${APEXTRIGGERS_COUNT}
        ClickElement            xpath\=(//a[@onclick\="return confirmDelete();"])[1]
        CloseAlert              Accept
        VerifyText              Compile all triggers
    END

Open Sandbox Developer ORG
    [Documentation]             To open the developer org through sandbox from any user story
    ...                         Author: Dhanesh
    ...                         Date: 11th NOV 2021
    ...                         Modified: 30th NOV 2021
    [Arguments]                 ${ORG}
    LaunchApp                   Credentials
    VerifyNoText                Loading
    Search record on object main page                       ${ORG}
    ClickText                   ${ORG}
    VerifyText                  Open Org
    ClickText                   Open Org
    Sleep                       10s                         reason=To handle the time taken to load to open the next tab
    VerifyNoText                Loading                     anchor=Hide message
    SwitchWindow                2
    VerifyNoText                Loading                     anchor=Hide message
    VerifyText                  Sandbox
    ClickText                   Setup
    VerifyText                  Setup for current app
    ClickText                   Setup for current app
    Sleep                       10s                         reason=To handle the time taken to load to open the next tab
    VerifyNoText                Loading                     anchor=Hide message
    SwitchWindow                3
    VerifyNoText                Loading                     anchor=Hide message
    VerifyText                  Object Manager

Verify Apex Class Exist Or Not
    [Documentation]             If Class does not exist then Class is created, if Class exist then delete the class and create it
    ...                         Author: Naveen
    ...                         Date: 15 NOV 2021
    [Arguments]                 ${ACTUAL_CLASS_NAME}        ${CLASS_NAME_VARIABLE}
    Open component on Setup Home tab                        Apex Classes
    VerifyAll                   Developer Console, Run All Tests, Schedule Apex
    ${STATUS}=                  Run Keyword And Return Status                           VerifyText                  ${ACTUAL_CLASS_NAME}
    Run Keyword If              ${STATUS} == True           Delete the Apex Classes
    Create Apex Class           ${CLASS_NAME_VARIABLE}

Verify Apex Trigger Exist Or Not
    [Documentation]             If Trigger does not exist then Trigger is created, if Trigger exist then delete the trigger and create it
    ...                         Author: Naveen
    ...                         Date: 15 NOV 2021
    [Arguments]                 ${ACTUAL_TRIGGER_NAME}      ${TRIGGER_NAME_VARIABLE}
    Open component on Setup Home tab                        Apex Trigger
    VerifyAll                   Developer Console, Api Version, Status
    ${STATUS}=                  Run Keyword And Return Status                           VerifyText                  ${ACTUAL_TRIGGER_NAME}
    Run Keyword If              ${STATUS} == True           Delete the Apex Triggers
    Create Apex Trigger         ${TRIGGER_NAME_VARIABLE}

Create Custom Object
    [Documentation]             To create a custom object and return the custom object's API name
    ...                         Author: Shweta
    ...                         Date: 24 November, 2021
    [Arguments]                 ${CUSOBJNAME}               ${CUSOBJ_PLURALNAME}        #Enter Singular and plural name of the custom object
    VerifyText                  Object Manager
    ClickText                   Object Manager
    VerifyText                  Create
    ClickText                   Create
    ClickElement                ${CREATE_CUSTOM_OBJECT_WEBELEMENT}
    VerifyText                  New Custom Object
    TypeText                    Label                       ${CUSOBJNAME}
    TypeText                    Plural Label                ${CUSOBJ_PLURALNAME}
    ClickText                   Save
    VerifyText                  ${CUSOBJNAME}
    ${CUSOBJ_SINGULARNAME}=     GetText                     ${SINGULAR_LABEL_WEBELEMENT}
    Should Be Equal             ${CUSOBJ_SINGULARNAME}      ${CUSOBJNAME}
    ${CUSOBJ_APINAME}=          GetText                     ${CUSTOMOBJ_API_WEBELEMENT}
    [Return]                    ${CUSOBJ_APINAME}

Create Profile From Existing Profile
    [Documentation]             To create a profile from existing profile and return the auto generated profile name
    ...                         Author: Shweta
    ...                         Date: 24 November, 2021
    [Arguments]                 ${EXISTING_PROFILE_NAME}    #Enter the name of any existing profile type available
    Open component on Setup Home tab                        Profiles
    VerifyText                  Didn't find what you're looking for? Try using Global Search.
    ${PROFILE_NAME}=            Generate random name
    VerifyAll                   Edit, Delete, Create New View
    ClickText                   New Profile                 anchor=All Profiles
    VerifyText                  Clone Profile
    DropDown                    Existing Profile            option=${EXISTING_PROFILE_NAME}
    TypeText                    Profile Name                ${PROFILE_NAME}
    ClickText                   Save                        anchor=Cancel
    VerifyText                  ${PROFILE_NAME}
    [Return]                    ${PROFILE_NAME}

Update OLS To Profile
    [Documentation]             To access profile and update field level security
    ...                         Author: Ram Naidu - 25th Nov, 2021
    [Arguments]                 ${PROFILE_NAME}             ${FIELD_NAME}
    VerifyAll                   ${PROFILE_NAME}, Delete
    ClickText                   ${PROFILE_NAME}
    ClickText                   Edit                        anchor=Clone                        
    VerifyAll                   Profile Edit, Save, Save & New, Cancel, Custom Object Permissions
    ${FIELD_ELEMENT}            Replace String              ${OLS_CHECKBOX_WEBELEMENT}                              FIELDNAME                   ${FIELD_NAME}
    FOR                         ${I}                        IN RANGE                    1                           ${5}
        ${ITER_STR}=            Evaluate                    str(${I})
        ${ELEM}=                Replace String              ${FIELD_ELEMENT}            ITR                         ${ITER_STR}
        ClickElement            ${ELEM}
    END
    ClickText                   Save

Update FLS To Custom Profile
    [Documentation]             To access profile and update object level security
    ...                         Author: Ram Naidu - 26th Nov, 2021
    [Arguments]                 ${OBJECT}                   ${FIELD}                    ${PROFILE_NAME}
    Open Object on Developer ORG                            ${OBJECT}
    Search field inside Object                              ${FIELD}
    ClickText                   ${FIELD}
    VerifyAll                   Field Information, Set Field-Level Security, View Field Accessibility
    ClickText                   Set Field-Level Security
    VerifyAll                   Save, Cancel
    ${ELEMENT}=                 Replace String              ${FLS_CHECKBOX_WEBELEMENT}                              ELEMENT                     ${PROFILE_NAME}
    ClickElement                ${ELEMENT}
    ClickText                   Save
    VerifyAll                   Set Field-Level Security, View Field Accessibility

Add Existing field to object
    [Documentation]             Add existing/already created field to the opened object on developer ORG
    ...                         Author : Ram Naidu - 29th Nov, 2021
    [Arguments]                 ${FIELD}
    ClickText                   New
    ClickText                   Text
    ClickText                   Next
    VerifyText                  New Custom Field
    TypeText                    MasterLabel                 ${FIELD}
    TypeText                    Length                      10
    ClickText                   Next
    ClickText                   Next
    ClickText                   Save
    Sleep                       2s
    Search field inside Object                              ${FIELD}

Delete Custom object
    [Documentation]             Deletes any custom object in dev org
    ...                         Author : Shweta - 30th November, 2021
    [Arguments]                 ${CUSTOM_OBJECT_NAME}       #input the name of custom object
    VerifyText                  Object Manager
    ClickText                   Object Manager
    VerifyText                  Schema Builder
    TypeText                    Quick Find                  ${CUSTOM_OBJECT_NAME}       anchor=Schema Builder
    Sleep                       2s                          reason=Added to wait for page load
    VerifyText                  ${CUSTOM_OBJECT_NAME}       2
    ClickText                   ${CUSTOM_OBJECT_NAME}
    ClickText                   Delete
    ClickElement                ${DELETE_CUSTOM_OBJECT_WEBELEMENT}

Navigate To permission set
    [Documentation]             To navigate to the permission set in the developer org
    ...                         Author: Dhanesh
    ...                         Date: 7th Dec 2021
    ClickText                   Home
    VerifyNoText                Loading
    TypeText                    Quick Find                  Permission Sets
    VerifyElement               ${PERMISSIONSET_OBJECT_WEBELEMENT}
    ClickElement                ${PERMISSIONSET_OBJECT_WEBELEMENT}
    VerifyElement               ${PERMISSIONSET_NEWBUTTON_WEBELEMENT}

Create Permission Set
    [Documentation]             To create a permission set in the developer org
    ...                         Author: Dhanesh
    ...                         Date: 6th Dec 2021
    [Arguments]                 ${PERMISSIONSET_NAME}       #Name of the permission set to be created
    Navigate To permission set
    ClickElement                ${PERMISSIONSET_NEWBUTTON_WEBELEMENT}
    VerifyText                  Enter permission set information
    TypeText                    Label                       ${PERMISSIONSET_NAME}
    TypeText                    API Name                    ${PERMISSIONSET_NAME}
    TypeText                    Description                 Creating permission set for automation testing
    ClickText                   Save                        anchor=Enter permission set information
    VerifyAll                   Permission Set Overview, ${PERMISSIONSET_NAME}
    ClickElement                ${PERMISSIONSET_OBJECT_WEBELEMENT}
    VerifyElement               ${PERMISSIONSET_NEWBUTTON_WEBELEMENT}
    VerifyText                  ${PERMISSIONSET_NAME}

Provide Object Settings Permission
    [Documentation]             To provide the read and write permissions to the object through permission set
    ...                         Author: Dhanesh
    ...                         Date: 7th Dec 2021
    [Arguments]                 ${PERMISSIONSET_NAME}       ${OBJECT}                   ${FIELD_NAME}               ${ACCESS}
    #PERMISSIONSET_NAME: Name of the created permission set to be selected
    #OBJECT: Object to which the permission needs to be provided
    #FIELD_NAME: The metadata field to which the permission needs to be assigned
    #ACCESS: The type of access to be assigned. Expected values: Read Access or Edit Access
    ClickText                   ${PERMISSIONSET_NAME}
    VerifyAll                   Permission Set Overview, ${PERMISSIONSET_NAME}
    ClickText                   Object Settings
    VerifyNoText                Loading
    VerifyText                  ${PERMISSIONSET_NAME}
    ScrollTo                    ${OBJECT}
    ClickText                   ${OBJECT}
    VerifyNoText                Loading
    VerifyAll                   Field Permissions, ${PERMISSIONSET_NAME}
    ClickElement                ${OBJECT_SETTINGS_EDIT_WEBELEMENT}
    VerifyNoText                Loading
    VerifyAll                   Save, Field Permissions, ${PERMISSIONSET_NAME}
    ${VALUE}=                   Set Variable If             '${ACCESS}' == 'Read Access'                            2
    ${VALUE}=                   Set Variable If             '${ACCESS}' == 'Edit Access'                            3
    ${DICTIONARY}=              Create Dictionary           ITR=${VALUE}                {FIELDNAME}=${FIELD_NAME}
    ${PERMISSION_FIELD}=        Replace All                 ${FIELD_PERMISSIONS_CHECKBOX_WEBELEMENT}                ${DICTIONARY}
    ClickCheckbox               ${PERMISSION_FIELD}         on
    VerifyCheckboxValue         ${PERMISSION_FIELD}         on
    ClickText                   Save                        anchor=Cancel
    VerifyNoText                Loading
    VerifyText                  ${PERMISSIONSET_NAME}

Create Custom Object Translation
    [Documentation]             To create a new custom object translation in the developer org
    ...                         Author: Dhanesh
    ...                         Date: 12th Jan 2022
    [Arguments]                 ${LANGUAGE}                 ${SETUP_COMPONENT}          ${OBJECT}                   ${ASPECT}                   ${RECORD}    ${TRANSLATION_NAME}
    Open component on Setup Home tab                        Translate
    VerifyText                  Select the filter criteria:
    DropDown                    Language                    ${LANGUAGE}
    DropDown                    Setup Component             ${SETUP_COMPONENT}
    DropDown                    Object                      ${OBJECT}
    DropDown                    Aspect                      ${ASPECT}
    VerifyText                  ${RECORD}
    ${LABEL_ELEMENT}=           Replace String              ${LABEL_TRANSLATION_WEBELEMENT}                         {RECORD}                    ${RECORD}
    ClickElement                ${LABEL_ELEMENT}            doubleclick=true
    TypeText                    Record Type Label Translation                           ${TRANSLATION_NAME}         doubleclick=true
    ClickText                   Save                        anchor=Cancel
    VerifyText                  Your changes have been saved

Create RecordType
    [Documentation]             Creates RecordType within the given custom object and returns the RecordType Name
    ...                         Author : Shweta - 12 January, 2022
    [Arguments]                 ${CUSTOM_OBJECT_NAME}       #Input the name of custom object to which a record type must be added
    VerifyText                  Object Manager
    ClickText                   Object Manager
    VerifyText                  Schema Builder
    TypeText                    Quick Find                  ${CUSTOM_OBJECT_NAME}       anchor=Schema Builder
    VerifyText                  ${CUSTOM_OBJECT_NAME}       2
    ClickText                   ${CUSTOM_OBJECT_NAME}
    ClickText                   Record Types
    VerifyAll                   New, Page Layout Assignment
    ClickText                   New
    ${RECORD_TYPE_NAME}=        Generate random name
    ${RECORD_TYPE_DESCRIPTION}=                             Generate random name
    TypeText                    Record Type Label           ${RECORD_TYPE_NAME}
    TypeText                    Record Type Name            ${RECORD_TYPE_NAME}
    TypeText                    Description                 ${RECORD_TYPE_DESCRIPTION}
    ScrollTo                    Next
    ClickText                   Next
    ClickElement                ${APPLY_FIRST_RADIOBUTTON_WEBELEMENT}
    ScrollTo                    Save
    ClickText                   Save                        anchor=Cancel
    VerifyNoText                Loading
    VerifyText                  Back to Custom Object:      partial_match=True
    [Return]                    ${RECORD_TYPE_NAME}

Modify Custom Object
    [Documentation]             Modify custom object details
    ...                         Author : Shweta - 13 January, 2022
    [Arguments]                 ${CUSTOM_OBJECT_NAME}       ${MODIFICATION_FIELDS_VALUES_DICTIONARY}
    #${CUSTOM_OBJECT_NAME} - Input the name of custom object to which a record type must be added
    #${MODIFICATION_FIELDS_VALUES} - Add the field and values as a key[label], value[updated value]. Ex:${MODIFICATION_FIELDS_VALUES}= Create Dictionary Label=new_name Plural Label=new_name1
    VerifyText                  Object Manager
    ClickText                   Object Manager
    VerifyText                  Schema Builder
    TypeText                    Quick Find                  ${CUSTOM_OBJECT_NAME}       anchor=Schema Builder
    Sleep                       2s                          reason=Object loading is taking time
    VerifyText                  ${CUSTOM_OBJECT_NAME}       2
    ClickText                   ${CUSTOM_OBJECT_NAME}
    ClickText                   Edit
    FOR                         ${KEY}                      IN                          @{MODIFICATION_FIELDS_VALUES_DICTIONARY}
        ${VALUE}=               Get From Dictionary         ${MODIFICATION_FIELDS_VALUES_DICTIONARY}                ${KEY}
        TypeText                ${KEY}                      ${VALUE}
    END
    ClickText                   Save                        anchor=Save & New

Get Custom Object Translation
    [Documentation]             To create a new custom object translation in the developer org
    ...                         Author: Dhanesh
    ...                         Date: 18th Jan 2022
    [Arguments]                 ${LANGUAGE}                 ${SETUP_COMPONENT}          ${OBJECT}                   ${ASPECT}                   ${RECORD}
    Open component on Setup Home tab                        Translate
    VerifyText                  Select the filter criteria:
    DropDown                    Language                    ${LANGUAGE}
    DropDown                    Setup Component             ${SETUP_COMPONENT}
    DropDown                    Object                      ${OBJECT}
    DropDown                    Aspect                      ${ASPECT}
    VerifyText                  ${RECORD}
    ${LABEL_ELEMENT}=           Replace String              ${LABEL_TRANSLATION_WEBELEMENT}                         {RECORD}                    ${RECORD}
    ${ACTUAL_TRANSLATION}=      GetText                     ${LABEL_ELEMENT}
    [Return]                    ${ACTUAL_TRANSLATION}

Create Custom Label
    [Documentation]             Creates Custom Labels and returns the custom label Name
    ...                         Author: Shweta
    ...                         Date: 17th January,2022
    [Arguments]                 ${CUSTOM_LABEL_VALUE}       ${CUSTOM_LABEL_CATEGORY}
    #${CUSTOM_LABEL_VALUE}- Enter a value for custom label
    #${CUSTOM_LABEL_CATEGORY}- Enter a category for the custom label
    Open component on Setup Home tab                        Custom Labels
    VerifyText                  Didn't find what you're looking for? Try using Global Search.
    ${CUSTOM_LABEL_NAME}=       Generate random name
    VerifyAll                   View, Create New View
    ClickText                   New Custom Label
    VerifyText                  New Custom Label
    TypeText                    Short Description           ${CUSTOM_LABEL_NAME}
    TypeText                    Name                        ${CUSTOM_LABEL_NAME}
    TypeText                    Categories                  ${CUSTOM_LABEL_CATEGORY}
    TypeText                    Value                       ${CUSTOM_LABEL_VALUE}
    ClickText                   Save                        anchor=Save & New
    VerifyText                  ${CUSTOM_LABEL_NAME}
    VerifyAll                   Edit, Delete
    [Return]                    ${CUSTOM_LABEL_NAME}

Modify Custom Label
    [Documentation]             Modify one or more custom Label values
    ...                         Author : Shweta - 17th January, 2022
    [Arguments]                 ${CUSTOMLABEL_NAME}         ${MODIFICATION_FIELDS_VALUES_DICTIONARY}
    #${CUSTOMLABEL_NAME} - Input the name of custom label twhich has to be modified
    #${MODIFICATION_FIELDS_VALUES} - Add the field and values as a key[label], value[updated value]. Ex:${MODIFICATION_FIELDS_VALUES}= Create Dictionary Value=new_name Plural Label=new_name1
    Open component on Setup Home tab                        Custom Labels
    VerifyText                  Didn't find what you're looking for? Try using Global Search.
    VerifyAll                   View, Create New View
    VerifyText                  ${CUSTOMLABEL_NAME}
    ClickText                   ${CUSTOMLABEL_NAME}
    ClickText                   Edit                        anchor=Delete
    VerifyText                  Custom Label Edit
    FOR                         ${KEY}                      IN                          @{MODIFICATION_FIELDS_VALUES_DICTIONARY}
        ${VALUE}=               Get From Dictionary         ${MODIFICATION_FIELDS_VALUES_DICTIONARY}                ${KEY}
        TypeText                ${KEY}                      ${VALUE}
    END
    ClickText                   Save                        anchor=Save & New

Create Custom Permissions
    [Documentation]             To create new custom permissions in the developer org
    ...                         Author: Dhanesh
    ...                         Date: 31th Jan 2022
    [Arguments]                 ${LABEL}
    #${LABEL}: The label and name of the custom permission
    Open component on Setup Home tab                        Custom Permissions
    VerifyNoText                Loading
    VerifyText                  Custom Permissions          anchor=Setup
    ClickText                   New                         partial_match=False
    Typetext                    Label                       ${LABEL}
    TypeText                    Name                        ${LABEL}
    ClickText                   Save                        anchor=1                    partial_match=False
    VerifyNoText                Loading
    VerifyText                  ${LABEL}                    anchor=Name

Provide Custom Permissions To Permission Set
    [Documentation]             To provide new custom permissions to the permission set created in the developer org
    ...                         Author: Dhanesh
    ...                         Date: 31th Jan 2022
    [Arguments]                 ${CUSTOM_PERMISSION}        ${PERMISSIONSET_NAME}       ${OPTION}
    #${CUSTOM_PERMISSION}: Name of the custom permission
    #${PERMISSIONSET_NAME}: The permission set name
    #${OPTION}: Either Add or Remove
    Navigate To permission set
    ClickText                   ${PERMISSIONSET_NAME}
    VerifyAll                   Permission Set Overview, ${PERMISSIONSET_NAME}
    ScrollTo                    Custom Permissions
    ClickText                   Custom Permissions
    VerifyNoText                Loading
    VerifyText                  Custom Permissions          anchor=Edit
    ClickText                   Edit                        partial_match=False
    VerifyNoText                Loading
    VerifyAll                   Available Custom Permissions, Enabled Custom Permissions
    IF                          '${OPTION}' == 'Add'
        ClickText               Available Custom Permissions
        ClickText               ${CUSTOM_PERMISSION}        anchor=Available Custom Permissions
        ClickItem               Add                         anchor=Available Custom Permissions                     tag=img
        VerifyNoText            Loading
        ClickText               Save                        anchor=Close
        VerifyNoText            Loading
        VerifyText              ${CUSTOM_PERMISSION}        anchor=Custom Permission Name
    ELSE IF                     '${OPTION}' == 'Remove'
        ClickText               Enabled Custom Permissions
        ClickText               ${CUSTOM_PERMISSION}        anchor=Enabled Custom Permissions
        ClickItem               Remove                      anchor=Enabled Custom Permissions                       tag=img
        VerifyNoText            Loading
        ClickText               Save                        anchor=Close
        VerifyNoText            Loading
        VerifyNoText            ${CUSTOM_PERMISSION}        anchor=Custom Permission Name
    ELSE
        Fail                    msg=Invalid option for multipicklist
    END

Set Object Permission
    [Documentation]             To provide permissions to the object through permission set
    ...                         Author: Shweta
    ...                         Date: 1st Feb 2022
    [Arguments]                 ${PERMISSIONSET_NAME}       ${OBJECT}                   ${PERMISSION_TYPE}
    #PERMISSIONSET_NAME: Name of the created permission set to be selected
    #OBJECT: Object to which the permission needs to be provided
    #PERMISSION_TYPE: The permission that has to be granted. Ex: Create (Type: List)
    VerifyText                  ${PERMISSIONSET_NAME}
    ClickText                   ${PERMISSIONSET_NAME}
    VerifyAll                   Permission Set Overview, ${PERMISSIONSET_NAME}
    ClickText                   Object Settings
    VerifyNoText                Loading
    VerifyText                  ${PERMISSIONSET_NAME}
    ScrollTo                    ${OBJECT}
    ClickText                   ${OBJECT}
    VerifyNoText                Loading
    VerifyAll                   Object Permissions, ${PERMISSIONSET_NAME}
    ClickElement                ${OBJECT_SETTINGS_EDIT_WEBELEMENT}
    VerifyNoText                Loading
    VerifyAll                   Save, Object Permissions, ${PERMISSIONSET_NAME}
    ${LENGTH}=                  Get Length                  ${PERMISSION_TYPE}
    FOR                         ${I}                        IN RANGE                    0                           ${LENGTH}
        ${TYPE}=                Get From List               ${PERMISSION_TYPE}          ${I}
        ${PERMISSION_FIELD}=    Replace String              ${OBJECT_PERMISSIONS_CHECKBOX_WEBELEMENT}               PERMISSION                  ${TYPE}
        ClickElement            ${PERMISSION_FIELD}
        VerifyNoText            Loading
    END
    ClickText                   Save                        anchor=Cancel
    VerifyNoText                Loading
    VerifyText                  ${PERMISSIONSET_NAME}

Update Specific OLS In Profile
    [Documentation]             To Update OLS for custom object in profile metadata
    ...                         Author: Sachin Talwaria - 28th Jan, 2022
    [Arguments]                 ${PROFILE_NAME}             ${FIELD_NAME}               ${START}                    ${END}
    ClickText                   ${PROFILE_NAME}
    VerifyAll                   ${PROFILE_NAME}, Delete
    ClickText                   Edit
    VerifyAll                   Profile Edit, Save, Save & New, Cancel, Custom Object Permissions
    ${FIELD_ELEMENT}            Replace String              ${OLS_CHECKBOX_WEBELEMENT}                              FIELDNAME                   ${FIELD_NAME}
    FOR                         ${I}                        IN RANGE                    ${START}                    ${END}
        ${ITER_STR}=            Evaluate                    str(${I})
        ${ELEM}=                Replace String              ${FIELD_ELEMENT}            ITR                         ${ITER_STR}
        ClickElement            ${ELEM}
    END
    ClickText                   Save

Open Existing Profile
    [Documentation]             To open existing profile.
    ...                         Author: Sachin Talwaria - 1st Feb, 2022
    [Arguments]                 ${PROFILE_NAME}
    ${SELECT_PROFILE_WEBELEMENT}                            Replace String              ${SELECT_PROFILE_WEBELEMENT}                            PROFILENAME                         ${PROFILE_NAME}
    VerifyElement               ${SELECT_PROFILE_WEBELEMENT}
    ClickElement                ${SELECT_PROFILE_WEBELEMENT}
    VerifyAll                   ${PROFILE_NAME}, Delete

Assign Apps To Permission Sets
    [Documentation]             To add or remove assigned apps to the permission set created
    ...                         Author: Dhanesh
    ...                         Date: 2nd Feb 2022
    [Arguments]                 ${APP_NAME}                 ${PERMISSIONSET_NAME}       ${OPTION}
    #${APP_NAME}: The App name which need to be Added/Removed
    #${OPTION}: Either Add or Remove
    #${PERMISSIONSET_NAME}: The permission set name
    ClickText                   ${PERMISSIONSET_NAME}
    VerifyAll                   Permission Set Overview, ${PERMISSIONSET_NAME}
    ScrollTo                    Assigned Apps
    ClickText                   Assigned Apps
    VerifyNoText                Loading
    VerifyText                  Assigned Apps               anchor=Edit
    ClickText                   Edit                        partial_match=False
    VerifyNoText                Loading
    VerifyAll                   Available Apps, Enabled Apps
    IF                          '${OPTION}' == 'Add'
        ClickText               Available Apps
        ClickText               ${APP_NAME}                 anchor=Available Apps
        ClickItem               Add                         anchor=Available Apps       tag=img
        VerifyNoText            Loading
        ClickText               Save                        anchor=Close
        VerifyNoText            Loading
        VerifyText              ${APP_NAME}                 anchor=App Name
    ELSE IF                     '${OPTION}' == 'Remove'
        ClickText               Enabled Apps
        ClickText               ${APP_NAME}                 anchor=Enabled Apps
        ClickItem               Remove                      anchor=Enabled Apps         tag=img
        VerifyNoText            Loading
        ClickText               Save                        anchor=Close
        VerifyNoText            Loading
        VerifyNoText            ${APP_NAME}                 anchor=App Name
    ELSE
        Fail                    msg=Invalid option for multipicklist
    END

Verify Assign Apps To Permission Sets
    [Documentation]             To verify the assigned apps in the permission set
    ...                         Author: Dhanesh
    ...                         Date: 2nd Feb 2022
    [Arguments]                 ${APP_NAME}                 ${PERMISSIONSET_NAME}
    #${APP_NAME}: The App name which need to be verified
    #${PERMISSIONSET_NAME}: The permission set name
    ClickText                   ${PERMISSIONSET_NAME}
    VerifyAll                   Permission Set Overview, ${PERMISSIONSET_NAME}
    ScrollTo                    Assigned Apps
    ClickText                   Assigned Apps
    VerifyNoText                Loading
    VerifyText                  Assigned Apps               anchor=Edit
    VerifyText                  ${APP_NAME}                 anchor=App Name

Delete Specific Apex Class
    [Documentation]             Delete the specific apex class
    ...                         Author: Sachin Talwaria
    ...                         Date: 22nd Feb 2022
    [Arguments]                 ${APEX_CLASS_NAME}
    ${DELETE_APEXCLASS_WEBELEMENT}=    Replace String    ${DELETE_APEXCLASS_WEBELEMENT}    CLASSNAME     ${APEX_CLASS_NAME}               
    VerifyElement                ${DELETE_APEXCLASS_WEBELEMENT}
    ClickElement                 ${DELETE_APEXCLASS_WEBELEMENT}
    ${DELETE_ALERT}=            GetAlertText
    Run Keyword If              '${DELETE_ALERT}'=='Are you sure?'                      CloseAlert                  Accept
    VerifyNoElement             ${DELETE_APEXCLASS_WEBELEMENT}                                    

Create New Text Field With External Id Checked
    [Documentation]             Create Text Field for an object on developer ORG with External ID field checked and return the field name
    ...                         Author: Naveen
    ...                         Date: 26th Feb 2022
    [Arguments]                 ${RANDOM_FIELD_NAME}    ${FIELD_TYPE}               ${FIELD_LENGTH}
    ClickText                   New
    VerifyAll                   Auto Number, Formula, Checkbox, Currency
    ScrollTo                    ${FIELD_TYPE}
    ClickText                   ${FIELD_TYPE}
    ClickText                   Next                        anchor=2
    VerifyAll                   Field Label, Length, Field Name, Help Text
    VerifyText                  New Custom Field
    TypeText                    MasterLabel                 ${RANDOM_FIELD_NAME}
    TypeText                    Length                      ${FIELD_LENGTH}
    ClickCheckbox               External ID                 on
    ClickText                   Next
    ClickCheckbox               Visible                     on
    ClickText                   Next
    ClickText                   Save
    Sleep                       2s
    Search field inside Object                              ${RANDOM_FIELD_NAME}
    ${FIELD_API_NAME_ELEMENT}=                              Replace String              ${FIELD_API_NAME_WEBELEMENT}                            FIELDVALUE                          ${RANDOM_FIELD_NAME}
    ${FIELD_API_NAME}=          GetText                     ${FIELD_API_NAME_ELEMENT}
    ${FIELD_LIST}               Create List                 ${FIELD_API_NAME}           ${RANDOM_FIELD_NAME}
    [Return]                    ${FIELD_LIST}

Create Tab For Custom Object
    [Documentation]             Creating a tab for Custom Object
    ...                         Author: Naveen
    ...                         Date: 2nd March 2022
    [Arguments]                 ${OBJECT_NAME}              ${TAB_STYLE}
    ClickText                   Home
    Open Tabs ComponentFrom Setup Home Page
    VerifyAll                   Custom Tabs, Custom Object Tabs
    ClickText                   New                         anchor=Custom Object Tabs
    DropDown                    ${SELECT_OBJECT_TAB_WEBELEMENT}                         ${OBJECT_NAME}
    ClickElement                ${TAB_STYLE_LOOKUP_WEBELEMENT
    SwitchWindow                3                           #additional new tab will open for selecting Tab image
    VerifyAll                   Tab Style Selector, Create your own style
    ClickText                   ${TAB_STYLE}                #selecting an image for custom object
    SwitchWindow                2
    ClickText                   Next
    ScrollText                  Next
    ClickText                   Next
    ScrollText                  Save
    ClickText                   Save
    VerifyAll                   ${OBJECT_NAME}, Custom Tabs, Custom Object Tabs, Action, Label
    RefreshPage

Open Tabs Component From Setup Home Page
    [Documentation]             Open Tabs component from Setup page
    ...                         Author: Naveen
    ...                         Date: 2nd March 2022
    VerifyText                  Object Manager
    ClickText                   Home
    TypeText                    ${QUICK_FIND_WEBELEMENT}    Tabs
    ClickElement                ${CLICK_TABS_OPTION_WEBELEMENT}

Create Record For Account Object
    [Documentation]             Create Records for Custom Object
    ...                         Author: Naveen
    ...                         Date: 2nd March 2022
    [Arguments]                 ${PHONE_NUMBER}
    ClickText                   New
    ${RANDOM_ACCOUNT_NAME}      Generate random name
    ${ACCOUNT_NAME}             Replace String              ${ACCOUNT_NAME_WEBELEMENT}                              ACCOUNTINPUTFIELDS          Account Name
    TypeText                    ${ACCOUNT_NAME}             ${RANDOM_ACCOUNT_NAME}
    ${ACCOUNT_PHONE}            Replace String              ${ACCOUNT_NAME_WEBELEMENT}                              ACCOUNTINPUTFIELDS          Phone
    TypeText                    ${ACCOUNT_PHONE}            ${PHONE_NUMBER}
    [Return]                    ${RANDOM_ACCOUNT_NAME}
    
Search Object In Object Manager   
    [Documentation]             Create's Custom Object and select External Id option for the Custom Field that is created
    ...                         Author: Naveen Ramesh
    ...                         Date: 26th Feb 2022
    [Arguments]                 ${OBJECT_NAME}
    ClickText                   Object Manager
    VerifyAny                   Schema Builder, Create
    TypeText                    Quick Find                  ${OBJECT_NAME}
    ClickText                   ${OBJECT_NAME}              anchor=LABEL
    VerifyAny                   ${OBJECT_NAME}, Details, Page Layouts, Lightning Record Pages
