Feature: Wip

  @wip
  Scenario Outline: ARB-139: As an RBU Team Leader, I want to reactivate a user within RBU or ACT Housing so that they can access the portal again
    Given I want to login to portal "<PortalName>"
    And I wait for "6000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Manage Users"
    Then I check that table "RealEstateAgentTable_Wrapper" with row containing "<email_test>" has the following
      | Fields | Value           |

      | item1  | <email_test>    |
    
    #Scenario 3: RBU Team Leader does not confirm reactivation
    Then I click on text "<email_test>"
    Then I wait for "6000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I wait for "6000" milliseconds
    Then I click on button with value "Active"
    Then I click on button with value "Save"
    Then I wait for "6000" milliseconds
    Then I see text "Are you sure you want to reactivate this user?" displayed
    Then I click on button with value "No"
    Then I wait for "6000" milliseconds
    Then I click on button with value "Cancel"
    Then I check that table "RealEstateAgentTable_Wrapper" with row containing "<email_test>" has the following
      | Fields | Value           |
      | item1  | Nitin           |
      | item1  | Paul            |
      | item1  | <email_test>    |
      | item1  | RBU Team Leader |
      | item1  | Inactive        |
    #Scenario 1: RBU Team Leader reactivates user account
    Then I click on text "<email_test>"
    Then I wait for "6000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I wait for "6000" milliseconds
    Then I click on button with value "Active"
    Then I click on button with value "Save"
    Then I wait for "6000" milliseconds
    #
    Then I see text "Are you sure you want to reactivate this user?" displayed
    Then I click on button with value "Yes"
    Then I wait for "6000" milliseconds
    Then I see text "Nitin Paul's details have been successfully updated." displayed
    Then I check that table "RealEstateAgentTable_Wrapper" with row containing "<email_test>" has the following
      | Fields | Value           |
      | item1  | Nitin           |
      | item1  | Paul            |
      | item1  | <email_test>    |
      | item1  | RBU Team Leader |
      | item1  | Active          |
    #Scenario 2: RBU Team Leader confirms reactivation
    Then I click on text "Sign Out"
    Given I want to login to portal "<PortalName>"
    And I wait for "6000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value        |
      | Email    | <email_test> |
      | Password | <Password>   |
    And I hit Enter
    Then I check I am on "ManageBonds" page
    Then I click on text "Sign Out"
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Manage Users"
    Then I click on text "<email_test>"
    Then I wait for "6000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I wait for "6000" milliseconds
    Then I click on button with value "Inactive"
    Then I click on button with value "Save"
    Then I wait for "6000" milliseconds
    # now reactive the user again
    Then I see text "Are you sure you want to deactivate this user?" displayed
    Then I click on button with value "Yes"
    Then I wait for "6000" milliseconds
    Then I check that table "RealEstateAgentTable_Wrapper" with row containing "<email_test>" has the following
      | Fields | Value           |
      | item1  | Nitin           |
      | item1  | Paul            |
      | item1  | <email_test>    |
      | item1  | RBU Team Leader |
      | item1  | Inactive        |

    Examples: 
      | PortalName | email                   | Password   | Message                                  | email_test       |
      | ARB        | agentadmin2@test.com | Support123 | Invalid login details. Please try again. | nitin@amail.club |
