*** Settings ***
Documentation               Common - SwagLabs
Resource                    ../actions/common.robot
Resource                    ../actions/1-add_item_to_cart.robot
Resource                    ../actions/2-checkout.robot
Resource                    ../actions/3-purchase_history.robot


*** Test Cases ***
Scenario 1: Checkout
    Given user login account
    And user will add items to cart
    And user will process checkout
    Then user purchase will proceed

*** Keywords ***
# Scenario 1: Checkout Feature
user login account 
    Normal User | Dashboard

user will add items to cart
    Add Items To Cart

user will process checkout
    Cart Checking

user purchase will proceed
    Checkout Complete