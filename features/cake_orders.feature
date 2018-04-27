Feature: Check Status
  Scenario: 
    As a user, I want to check what's the status of my order
    Background: Order in database
    Given the following user exist:
    |userName|password|name|lastName|phone|email|address|
    |jivfur|123456|Ivan|Fuentes|9794925979|jivfur@gmail.com|Home|
    
    Given the following flavor exist:
    |name|flavorImgURL|
    |Zanahoria|/flavorsUploads/carrot_cake.jpg"|
    
    Given the following cake exist:
    |decorationImgURL|comments|levels|gallery|
    |/36/bob.jpg|None|5|False|
    
    Given the following cake price exist:
    |size|price|
    |10|500|
    
    Given the following cake orders exist:
    |deliveryDate|deliveryAddress|deliveryPhone|status|comments|paidStatus|
    |2018-04-25 18:00:00 UTC |Home|9794925979|1|None|0|
    
    Given I am on the home page
    Then I should see "Order Status"
    And I fill in "cake_orders[id]" with "@order.id"
    And I press "btnOrderStatus"
    Then I should go to Show Cake Order Page for "@order.id" order
    And I should see "Your order looks delicious!!!"
    
    Scenario: 
      As a user, I want to check what's the status of and unexisted order
    
      Given I am on the home page
      Then I should see "Order Status"
      And I fill in "cake_orders[id]" with "16"
      And I press "btnOrderStatus"
      Then I should go to Show Cake Order Page for "16" order
      And I should see "Order was not Found"
  
  