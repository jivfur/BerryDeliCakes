Feature: User Creation
  Scenario: 
    As a user, i want to create my account
    
    Given I am on the home page
    Then I should see "Sign up"
    And I fill in "user[name]" with "Mickey"
    And I fill in "user[lastName]" with "Dolenz"
    And I fill in "user[email]" with "mickey@monkees.com"
    And I fill in "user[password]" with "password"
    And I fill in "user[passwordConfirm]" with "password"
    And I fill in "user[phone]" with "9794925979"
    And I fill in "user[address]" with "401 Anderson St"
    And I press "Register"
    Then I should be on the my orders page