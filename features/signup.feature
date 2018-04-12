Feature: signup
  
    Scenario: signup
   
    Given I am in the signup page
    Then I should see "Sign Up"
    And I fill in "userName" with "Mickey Dolenz"
    And I fill in "email" with "mickey@monkees.com"
    And I fill in "password" with "password"
    And I fill in "password confirmation" with "password"
    And I press "Sign up!"
    Then I should see "User was successfully created." 
    Then I should be on the registration thank you page 
