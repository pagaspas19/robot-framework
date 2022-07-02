*** Settings ***
Documentation               Common - Add Items to Cart
Library                     SeleniumLibrary
Resource                    common.robot

*** Keywords ***
Add Items To Cart
    Product 1
    Go to Cart

Product 1
    Log to console    Get Product Elements

    ${product_elemnt}    Get Webelements    class=inventory_item
    ${el_count}    Get Element count    class=inventory_item
    ${addtocart}=    Evaluate    ${el_count} - 1

    Log to console    Web Elements - ${product_elemnt}
    Log to console    Element Count - ${el_count}

    Log to console    Random Products
    ${random_number}    Evaluate    random.randint(1,${addtocart})    random
   
    ${add_to_cart}    Get Webelements    class=btn_primary
    ${el_count_add}    Get Element Count    class=btn_primary
    Log to console    Element Count - ${el_count_add}
    
    Set Global Variable    ${random_number}

    Log to console    Add Item To Cart
    Click Element    ${add_to_cart}[${random_number}]
    
    ${remove_button}    Get Webelements    class=btn_secondary
    ${remove_button_cnt}    Get Element Count    class=btn_secondary
    ${rev_button_index}=    Evaluate    ${remove_button_cnt} - 1
    ${remove_text}=    Get Text    ${remove_button}[${rev_button_index}]

    #Element Should Contain    xpath    ${remove_text}
    Run Keyword If    "${remove_text}" == "REMOVE"    Log to console    Status | Item Added to Cart
    ...    ELSE    Log to console    Status | Item Not Added to Cart