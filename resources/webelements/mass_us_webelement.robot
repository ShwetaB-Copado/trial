*** Settings ***
Documentation               List of webelements used for mass user story

*** Variables ***
${US_REFERENCE_WEBELEMENT}                              xpath\=(//*[text()\='US_REFERENCE']//ancestor::tr//span//span)[1]
${TITLE_WEBELEMENT}                                     xpath\=(//input[contains(@id,'UserStory_Title')])[ITR]
${MASS_RECORDTYPE_WEBELEMENT}                           xpath\=(//tr[@class='dataRow']/td[1]/select)[ITER]