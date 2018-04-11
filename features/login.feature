Scenario: login
  
  As a user,
  I should be able to have my user account

  Given I am on the login page
  When I fill in "email" with "test@test.com"
  And I fill in "userName" with "testid"
  And I fill in "password" with "testpass"
  And I press "Login"
  Then I should be on the users home page
  And I should see "Login successful" #?
