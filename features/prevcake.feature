Feature: ex
  Scenario: prev
  
    As a user,...t
  
    Given I am in the root page
    Then I should see "Previous Designs"
    When I press_html "yummyfood-footer-nav"
    Then I should see "Our New Creation" 