*** Settings ***
Documentation               Common - Reusable Commands
Library                     SeleniumLibrary
Resource                    ../actions/common.robot
Resource                    ../actions/common_env.robot

*** Keywords ***
Normal User | Dashboard
    SwagLabs | Dashboard
    Login as normal user

#===========================
SwagLabs | Dashboard
    Log to console    Open Browser - SwagLabs
    Open Browser    ${site_url}    ${browser}
    Maximize Browser Window
    Sleep    5
    Element Should Be Visible    //*[@id="login-button"]

Login as normal user
    Log to console    Login as normal user
    
    Input Text    id=user-name    ${username}
    Input Text    id=password    ${password}
    
    Click button    id=login-button
    Sleep    3

    Wait Until Page Contains    Products

Go to Cart
    Log to console    Go to Cart
    Click Element    id=shopping_cart_container
    Sleep    2
    Page Should Contain    Your Cart

Continue Checkout
    Log to console    Continue Checkout
    Click Element    //*[@id="checkout"]
    Sleep    2
    Page Should Contain    Checkout: Your Information

Finish Checkout
    Log to console    Finish Checkout
    Click Element    id=finish
    Sleep    2
    Page Should Contain    THANK YOU FOR YOUR ORDER


