Feature: signup
  
    Scenario: signup
   
    Given I am in the signup page
    Then I should see "Sign up"
    When I press_html "register"
    And I fill in "user[name]" with "han"
    And I fill in "user[lastName]" with "han"
    And I fill in "user[phone]" with "9999999"
    And I fill in "user[userName]" with "hanhan"
    And I fill in "user[email]" with "han@idiot.com"
    And I fill in "user[address]" with "college station"
    And I fill in "user[password]" with "password"
    And I fill in "user[passwordConfirm]" with "password"
    And I press_html "Register"
    Then I should be on the users path
    
    
#   Scenario: login
  
#     As a user,I should be able to have my user account
  
    Given I am in the login page
    Then I should see "Sign in"
    When I press_html "signin"
    When I fill in "username" with "hanhan"
    And I fill in "password" with "password"
    And I press "Login"
    Then I should be on the users new order page
    
