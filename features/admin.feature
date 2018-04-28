Feature: admin signup and signin
  
    Scenario: admin signup
   
    Given I am in the signup page
    Then I should see "Sign up"
    When I press_html "register"
    And I fill in "user[userName]" with "admin"
    And I fill in "user[email]" with "han@idiot.com"
    And I fill in "user[address]" with "college station"
    And I fill in "user[password]" with "adminPW"
    And I fill in "user[passwordConfirm]" with "adminPW"
    And I press_html "Register"
    Then I should be on the users path
    
    # admin signin
    Given I am in the login page
    Then I should see "Sign in"
    When I press_html "signin"
    When I fill in "username" with "admin"
    And I fill in "password" with "adminPW"
    And I press "Login"
    Then I should be on the user listing path
    
    #admin add 
    #Given I am in the flavor page