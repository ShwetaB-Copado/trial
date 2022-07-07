*** Settings ***
Documentation               Contains all global variables required for the automation

*** Variables ***
${BROWSER}                  chrome
${LOGIN_URL}                https://login.salesforce.com/
${GIT_REPO}                 CopadoAutomationGIT
${PIPELINE}                 CopadoAutomationPipeline
${PROJECT}                  CopadoAutomationProject
${DEV1_ORG}                 automation.dev1@copado.com
${DEV2_ORG}                 automation.dev2@copado.com
${STAGING_ORG}              automation.staging@copado.com
${PROD_ORG}                 automation.prod@copado.com
${HOTFIX_ORG}               automation.hotfix@copado.com
${EXISTING_MAIN_BRANCH_NAME}                            main
${EXISTING_GIT_REPO_VAR}    ${GIT_REPO}
${EXISTING_DEV1_BRANCH_NAME}                            dev1
${EXISTING_DEV2_BRANCH_NAME}                            dev2
${EXISTING_STAGING_BRANCH_NAME}                         staging
${EXISTING_PIPELINE_NAME}                               ${PIPELINE}
${SALESFORCE_ENVIRONMENT}                               qa_automation_mcdx_dev1@copado.com
${OTHER_ENVIRONMENT}        qa_automation_mcdx_dev2@copado.com
${SFDX_ENVIRONMENT}         qa_automation_mcdx_dev3@copado.com
${USERNAME_PLAN}            qa-qentinel-automation@copado.com.qauser1
${USERNAME_ADMIN}           qa-qentinel-automation@copado.com.qauser2
${USERNAME_USER}            qa-qentinel-automation@copado.com.qauser3
${USERNAME_NOLICENSE}       qa-qentinel-automation@copado.com.qauser
${USERNAME_PLANADMIN}       qa-qentinel-automation@copado.com.qauser4
${USERNAME_PLANVIEWER}      qa-qentinel-automation@copado.com.qauser5
${USERNAME_NOPLANADMIN}     qa-qentinel-automation@copado.com.qauser6
${USERNAME_PORTFOLIO}       qa-qentinel-automation@copado.com.qauser7
${USERNAME_PROJECT}         qa-qentinel-automation@copado.com.qauser8
${USERNAME_USERSTORYD}      qa-qentinel-automation@copado.com.qauser9
${MCDX_PIPELINE}            MCDX_Automation_Platform_Pipeline
${MCDX_PROJECT}             MC-DX-Automation_Platform
${MCDX_DEV1_ORG}            mcdxautomationplatform_dev1
${MCDX_DEV2_ORG}            mcdxautomationplatform_dev2
${MCDX_INT_ORG}             mcdxautomationplatform_int
${MCDX_STAG_ORG}            mcdxautomationplatform_stg
${MCDX_PROD_ORG}            QKQrMCqDsM@copa.do.sandbox
${PREFIX_TEXT}              Automation_
${MCDX_GIT_REPO}            MCDXAutomation_Platform
${PACKAGE_GIT_REPO}         packaging
${PACKAGE_PIPELINE}         MCDX_Package_Platform_pipeline                     
${DEVHUB_ORG_USERNAME}      devhub_automation@copado.com
${DEVHUB_ORG}               DevHubOrg
${DEVHUB_PLATFORM}          DevHubOrg_Platform
${MCDX_DEV2_USERNAME}       qkqrmcqdsm@copa.do.sandbox.dev2
${DEVHUB_AUTH_URL}          force://PlatformCLI::5Aep861mdLLi91HqFcHZFTlvZKcYoXVHVWA816nz2ZJ43hx8RzRIV8IqR5qvtMMgKxf3qLfjNPWEpCSwjv6W1fu@copado-c-dev-ed.my.salesforce.com    
${AUTOORG_AUTH_URL}         force://PlatformCLI::5Aep861R85s7ZWXls06hv9Iir12HPyb9lZWjHcGck1HFR_Sv7XaSqgQDx88lAc_NngZBhHnvxvRecwJTWCxuwQd@copado-19e-dev-ed.my.salesforce.com
${PLATFORM_AUTH_URL}        force://PlatformCLI::5Aep861R85s7ZWXls06hv9Iir12HPyb9lZWjHcGc3uRV2Dt6_VHjCOAAYgC9KQquuErWxroD98AOog4LM5hfxhA@copado-19e-dev-ed.my.salesforce.com 
${TARGET_ORG_AUTH_URL}      force://PlatformCLI::5Aep861Py1mmUCbH67DxUxjb2W1qrfjbKnNdYL95Afm3IhREZSyS90rDWqF5imPeuLM9rdkgk8.60xF366oFqul@copado22--dev2.my.salesforce.com

#Variables for Copado Core (Platform User)
#Set the below variables in the CRT suite level-
#Example- PROJECT= PlatformAutomation-Pipeline
#Because in code, we are using ${PROJECT}.
#Git Repo created for the standard user automation: https://github.com/CopadoSolutions/Qentinel-test-standard
${GIT_REPO_STANDARD}        PlatformAutomation-GIT
${PIPELINE_STANDARD}        PlatformAutomation-Pipeline
${PROJECT_STANDARD}         PlatformAutomation-Project
${DEV1_ORG_STANDARD}        automation.dev1-standard@copado.com
${STAGING_ORG_STANDARD}     automation.staging-standard@copado.com
${PROD_ORG_STANDARD}        automation.prod-standard@copado.com

#Configuration for CRT tests
#Document-One time setup required for new ORG: https://docs.copado.com/article/jboviauby6-crt-copado-integration
${DEFAULT_EXTENSION_CONFIGURATION}                      Copado Robotic Testing [Copado Default]    #Default record created by Copado with defined Project ID (11503)/Suite ID (20033)
${CRT_TOOL_URL}             https://pace.qentinel.com/
${HEROKU_PROJECT}                  HerokuDeploymentProject
${HEROKU_DEV1_ORG}                 HerokuDev1
