*** Settings ***
Documentation               Web Elements for Project

*** Variables ***
${PROJECT_NAME_WEBELEMENT}=                             xpath\=//label[text()\='Project Name']/following::div/input
${CLICK_PROJECT_WEBELEMENT}=                            xpath\=//b[text()\='Projects']