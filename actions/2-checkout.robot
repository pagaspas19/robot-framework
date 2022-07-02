*** Settings ***
Documentation               Common - Checkout Commands
Library                     SeleniumLibrary
Library                     Collections 
Library                     JSONLibrary
Library                     String
Resource                    common.robot
Resource                    1-add_item_to_cart.robot

*** Keywords ***
Cart Checking
    Product Checking
    Continue Checkout

Product Checking
    Log to console    Product Checking
    
    ${cart_item_element}    Get Webelements    class=cart_item
    ${cart_item_count}    Get Element Count    class=cart_item

    Log to console    Cart WebEl - ${cart_item_element}
    Log to console    Cart Count - ${cart_item_count}
    Log to console    Random Number - ${random_number}
    
    ${product_num}=    Evaluate    ${random_number} + 1
    Set Global Variable    ${product_num}
    
    # Load JSON
    ${json_obj}=    Load JSON From File     ${EXECDIR}/data/product_${product_num}.json
    Log To Console    \nOriginal JSON:\n${json_obj}
    Set Global Variable    ${json_obj}

    # get value from json 
    ${json_file1}=    Get Value From Json    ${json_obj}    $..product_title
    ${prdct_title}=    Convert To String    ${json_file1}
    ${prdct_title_str}=    Remove String        ${prdct_title}      [    '    ] 
    Log To Console    Product Title = ${prdct_title_str}

    ${json_file1}=    Get Value From Json    ${json_obj}    $..product_price
    ${prdct_price}=    Convert To String    ${json_file1}
    ${prdct_price_str}=    Remove String        ${prdct_price}      [    '    ] 
    Log To Console    Product Price = ${prdct_price_str}

    Element Should Contain    class=inventory_item_name    ${prdct_title_str}
    Element Should Contain    class=inventory_item_price    ${prdct_price_str}
