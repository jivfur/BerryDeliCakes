Feature: flavors
  
  Scenario: flavors
  
    As a user I should see flavor options
  
    Given I am in the root page
    Then I should see "Flavors"
    When I press_html "yummyfood-footer-nav"
    Then I should see "Flavors" 