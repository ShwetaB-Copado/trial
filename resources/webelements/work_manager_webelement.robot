*** Settings ***
Documentation               Web Elements for work manager object

*** Variables ***
${PANEL_DROPDOWN_WEBELEMENT}                            xpath\=//select[contains(@id,'relatedObjects')]
${PANEL_SEARCH_WEBELEMENT}                              xpath\=//input[contains(@class,'iField')]
${PANEL_LOOKUP_WEBELEMENT}                              xpath\=//img[@class\='lookupIcon']
${PANEL_DROPDOWN_VALUES_WEBELEMENT}                     xpath\=//select[contains(@id,'relatedObjects')]
${ADDED_PANEL_HEADER_WEBELEMENT}                        xpath\=(//div[contains(@class,'panel__section')]//h2/a)[last()]