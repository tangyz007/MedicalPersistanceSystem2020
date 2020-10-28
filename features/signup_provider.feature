Feature: Sign up and submit an application to the System as a Provider

    As a Provider
    So that I can sign up to the System
    I want an Admin can see my application in the database

Background: Sign up requests in database
  Given the following requests exist:
# #   | email                   | provider_id | encrypted_password |
# #   | yz@email.com            | G           |                    |
# #   | jy@email.com            | R           |                    |
  | email                   | provider_id      | encrypted_password |
  | yz@email.com            | Yunzhi           |                    |
  | jy@email.com            | Junyu            |                    |
  
# Background:
  And I am on the sign up page

Scenario: submit sign up request correctly
 When I fill in "request_provider_id" with "Sam"
  When I fill in "inputEmail" with "Sam@email.com"
  When I fill in "request_password" with "Sam123"
  When I fill in "request_password_check" with "Sam123"
  And I press "Submit"
  Then I should be on the submit success page

Scenario: submit sign up request with password less than 6 characters (sad path)
  When I fill in "request_provider_id" with "Bob"
  When I fill in "inputEmail" with "Bob@email.com"
  When I fill in "request_password" with "B123"
  And I press "Submit"
  Then I should see "Password can't be blank or less than 6 digits, Please return to previous page to correct!"

Scenario: submit sign up request with invalid email format (sad path)
  When I fill in "request_provider_id" with "Linda"
  When I fill in "inputEmail" with "Linda.email.com"
  When I fill in "request_password" with "Linda123"
  And I press "Submit"
  Then I should see "Email is invalid! Please return to previous page to correct!"

# Scenario: submit sign up request with repeated email (sad path)
#   When I fill in "request_provider_id" with "Small Sam"
#   When I fill in "request_email" with "jy@email.com"
#   When I fill in "request_password" with "Ssam123"
#   And I press "Submit"
#   Then I should see "Email has already exist, please wait for approval or use another one."

  