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
    | patient  | test2@patient.com       | test123  | test_patient_2|
  
  Given the following questions exist:
    |   name       |    mrn     | age | question2 | question3 | question4 | question51 | question52 | question53 | question54 | question55 | question56 | question6 | provider_name | patient_id |
    | test_patient | MRNtest123 |  32 |         2 |         2 | t         |          2 |          2 |          1 |          1 |          3 |          3 |         3 | test provider |            |          
    | test_patient | MRNtest321 |  67 |         2 |         2 | t         |          2 |          2 |          3 |          1 |          2 |          1 |         1 | test provider |            |
  
  
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
  
  Scenario: Failed to log in to the system
    When I am on the login page
    And I fill in "inputEmail" with "asdasd"
    And I fill in "inputPassword" with "test123"
    Then I press "Log in"
    Then I should not see "Patient Panel"
    
  Scenario: Log in as a patient who doesn't have any previous survey records
    When I am on the login page
    And I fill in "inputEmail" with "test2@patient.com"
    And I fill in "inputPassword" with "test123"
    Then I press "Log in"
    Then I am on the patient panel page
    Then I should see "Patient Panel"
    And I should not see "test_patient_2"
    And I should not see "Show Response"
    