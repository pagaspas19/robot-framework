*** Settings ***
Documentation               Common - Purchase History Commands
Library                     SeleniumLibrary
Library                     FakerLibrary 
Library                     JSONLibrary
Library                     String
Resource                    common.robot
Resource                    1-add_item_to_cart.robot
Resource                    2-checkout.robot

*** Keywords ***
Checkout Complete
    Checkout Customer Information
    Check Checkout Overview
    Finish Checkout

Checkout Customer Information
    Log to console    Checkout Customer Information
    
    ${firstName}=        FakerLibrary.First Name Male
    Input Text    //*[@id="first-name"]    ${firstName}

    ${lastName}=         FakerLibrary.Last Name   
    Input Text    //*[@id="last-name"]    ${lastName}

    ${postcode}=    FakerLibrary.Random Number    4
    Input Text    id=postal-code    ${postcode}

    Click Element    id=continue
    Sleep    2
    Wait Until Page Contains    Checkout: Overview

Check Checkout Overview
    Log to console    Check Checkout Overview | Calculation
    
    Log to console    Random Number = ${product_num}
    
    # Load JSON
    ${json_obj}=    Load JSON From File     ${EXECDIR}/data/product_${product_num}.json
    Log To Console    \nOriginal JSON:\n${json_obj}
    Set Global Variable    ${json_obj}

    # get value from json 
    ${json_file1}=    Get Value From Json    ${json_obj}    $..product_price_round
    ${price}=    Convert To String    ${json_file1}
    ${price_str}=    Remove String        ${price}      [    '    ] 
    Log To Console    Product Title = ${price_str}

    # get value from json 
    ${json_file1}=    Get Value From Json    ${json_obj}    $..product_price
    ${price_org}=    Convert To String    ${json_file1}
    ${price_org_str}=    Remove String        ${price_org}      [    '    ]    $ 
    Log To Console    Product Title = ${price_org_str}

    # Calculation
    ${tax}=    Evaluate    ${price_str} * 0.08
    Log to console    ${tax}
    ${cal_tax}=    Catenate    Tax: $${tax}
    
    ${total}=    Evaluate    ${price_org_str} + ${tax}
    Log to console    ${total}
    ${cal_total}=    Catenate    Total: $${total}

    Element Should Contain    class=summary_tax_label    ${cal_tax}
    Element Should Contain    class=summary_total_label    ${cal_total}
    Log to Console    Calculation Validated

  

    
