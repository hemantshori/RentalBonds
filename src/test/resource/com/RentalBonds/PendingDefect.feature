Feature: Wip

  @defect466
 Scenario Outline: ARB-387, As an RBU Team Lead/Officer, I want to view a list of Bond Refund Requests so that I can process them
    #Scenario 1
    Given I want to login to portal "<PortalName>"
    And I wait for "6000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I check I am on "ManageBonds" page
    Then I see text "Refunds & Payments" not displayed
    Then I click on text "Sign Out"
    #Scenario 2
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email_2>  |
      | Password | <Password> |
    And I hit Enter
    Then I check I am on "ManageBonds" page
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value              |
      | item1  | Refunds & Payments |
      | item2  | Reconciliation     |
      | item3  | Manage Bonds       |
      | item4  | Lodge Bond         |
      | item5  | Manage Users       |
      | item6  | Sign Out           |

    Examples: 
      | PortalName | email                | Password   | email_2                 |
      | ARB        | agentadmin2@test.com | Support123 | rbuteamleader1@test.com |
