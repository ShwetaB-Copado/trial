*** Settings ***
Documentation                 Metadata Group creation with Metadata Items
Resource                      ../../resources/common_keywords.robot
Resource                      ../../resources/objects/metadata_group.robot
Suite Setup                   Start Suite
Suite Teardown                End Suite

*** Variables ***
${METADAT_NAME_OPTION}        All
${METADAT_TYPE_OPTION}        Profile
${VALUE}

*** Test Cases ***
Creation of Metadata
    [Documentation]           Creating Metadata Group and Metadata Items
    ...                       Author: Naveen Ramesh
    [Tags]                    Metadata Group
    #Usecase:
    #Open Metadata Group
    #Create Metadata Group and verify
    #Create Metadata Items for the above Metadata Group and verify

    #Given
    Open Object               Metadata Groups   

    #When and Then          
    ${METADAT_GROUP_NAME}=    Create Metadata Group
    Create Metadata Items     ${METADAT_GROUP_NAME}       ${METADAT_NAME_OPTION}      ${METADAT_TYPE_OPTION}    ${VALUE}
    Sleep                     2s                          #wait is added to so that record is created before deletion
    
    #Clean up
    Delete and verify