Feature: Log in and check the past surveys in the patient panel
  
  As a patient
  So that I can sign in to the system
  I want to see all the previous records of my past surveys
  
Background: user accounts and surveys have been added to database
  
  Given the following users exist:
    |   role   |          email          | password |   full_name   |
    | admin    | admin@admin.com         | test123  | admin         |
    | provider | test@provider.com       | test123  | test provider |
    | patient  | test@patient.com        | test123  | test_patient  |
  
  Given the following questions exist:
    |   name       |    mrn     | age | question2 | question3 | question4 | question51 | question52 | question53 | question54 | question55 | question56 | question6 | user_id | patient_id |
    | test_patient | MRNtest123 |  32 |         2 |         2 | t         |          2 |          2 |          1 |          1 |          3 |          3 |         3 | 2       |            |          
    | test_patient | MRNtest321 |  67 |         2 |         2 | t         |          2 |          2 |          3 |          1 |          2 |          1 |         1 | 2       |            |
  
#   When I am on the take survey page
# #   Then I fill in "question_user_id" with "2"
#   Then I fill in "question_mrn" with "MRNtest123"
#   Then I fill in "question_age" with "32"
#   Then I fill in "question[question2]" with "1"
#   Then I fill in "question_question3_1" with "1"
#   Then I fill in "question_question4_true" with "true"
#   Then I fill in "question_question51_1" with "1"
#   Then I fill in "question_question52_1" with "1"
#   Then I fill in "question_question53_1" with "1"
#   Then I fill in "question_question54_1" with "1"
#   Then I fill in "question_question55_1" with "1"
#   Then I fill in "question_question56_1" with "1"
#   Then I fill in "question_question6_1" with "1"
#   Then I press "Submit Response"
  
  
 Scenario: Log in and go to the patient panel page
   When I am on the login page
   And I fill in "inputEmail" with "test@patient.com"
   And I fill in "inputPassword" with "test123"
   Then I press "Log in"
   Then I am on the patient panel page
   Then I should see "Patient Panel"
   And I should see "MRNtest123"
   And I should see "32"
   And I should see "MRNtest321"
   And I should see "67"
  