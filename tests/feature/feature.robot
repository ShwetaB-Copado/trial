*** Settings ***
Documentation                   Test feature Object- Create, Edit, clone, Delete.
Resource                        ../../resources/objects/feature_resource.robot
Suite Setup                     Start Suite
Suite Teardown                  End Suite

*** Test Cases ***
Verify the required fields in New Feature window
    [Tags]                      Features
    [Documentation]             Author: Ashok K

    #Given
    Open Object                 Features

    #When
    ClickText                   New
    VerifyText                  New Feature
    ClickText                   Save                        2

    #Then
    VerifyText                  Complete this field.
    VerifyText                  Feature Name                anchor=Error

Update,Clone,Delete Feature by Creating new
    [Tags]                      Features
    [Documentation]             Author: Ashok K

    #Given
    Open Object                 Features

    #When
    ${FEATURE_NAME}=            Create New Feature

    #Then
    VerifyText                  ${FEATURE_NAME}             anchor=Details
    Update record               Feature Name
    Update Feature Status       Ready for Refinement
    Update Feature Status       Refinement in Progress
    Update Feature Status       Accepted
    Update Feature Status       Coming Soon
    Update Feature Status       Delivered
    Update Feature Status       Rejected

    #Clone the record
    Clone record                Feature Name                New Feature

    #Cleanup
    Delete record from object details page                  #Deleting new (cloned) Feature
    Delete record from object details page                  #Deleting existing Feature