Feature: Log in and check the surveys of the current provider's patients in the provider panel
  
  As a provider
  So that I can sign in to the system
  I want to see all the previous records of my patients
  
Background: user accounts and surveys have been added to database
  
  Given the following users exist:
    |   role   |          email          | password |   full_name    |
    | admin    | admin@admin.com         | test123  | admin          |
    | provider | test@provider.com       | test123  | test_provider  |
    | provider | test2@provider.com      | test123  | test_provider_2|
    | provider | test3@provider.com      | test123  | test_provider_3|
    | patient  | test@patient.com        | test123  | test_patient   |
    | patient  | test2@patient.com       | test123  | test_patient_2 |
  
  Given the following questions exist:
    |   name         |    mrn     | age | question2 | question3 | question4 | question51 | question52 | question53 | question54 | question55 | question56 | question6 | provider_name   | patient_id | feedback |
    | test_patient   | MRNtest1   |  32 |         2 |         2 | t         |          2 |          2 |          1 |          1 |          3 |          3 |         3 | test_provider   |            |          |
    | test_patient   | MRNtest2   |  67 |         2 |         2 | t         |          2 |          2 |          3 |          1 |          2 |          1 |         1 | test_provider   |            |          |
    | test_patient_2 | MRNtest3   |  32 |         2 |         2 | t         |          2 |          2 |          1 |          1 |          3 |          3 |         3 | test_provider_2 |            |          |
    | test_patient_2 | MRNtest4   |  67 |         2 |         2 | t         |          2 |          2 |          3 |          1 |          2 |          1 |         1 | test_provider_2 |            |          |
  
  
 Scenario: Log in and go to the provider panel page
   When I am on the login page
   And I fill in "inputEmail" with "test@provider.com"
   And I fill in "inputPassword" with "test123"
   Then I press "Log in"
   Then I am on the provider panel page
   Then I should see "Provider Panel"
   And I should see "MRNtest1"
   And I should see "MRNtest2"
   And I should see "32"
   And I should not see "MRNtest3"
   And I should not see "MRNtest4"
  
  Scenario: Failed to log in to the system
    When I am on the login page
    And I fill in "inputEmail" with "asdasd"
    And I fill in "inputPassword" with "test123"
    Then I press "Log in"
    Then I should not see "Patient Panel"
    
  Scenario: Log in as a provider who doesn't have any patients
    When I am on the login page
    And I fill in "inputEmail" with "test3@provider.com"
    And I fill in "inputPassword" with "test123"
    Then I press "Log in"
    Then I am on the provider panel page
    Then I should see "Provider Panel"
    And I should not see "test_patient"
    And I should not see "View Survey"
    And I should not see "Edit Feedback"
    