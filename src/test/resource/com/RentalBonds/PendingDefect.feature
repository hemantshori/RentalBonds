Feature: Wip

@wip @defect
  Scenario Outline: ARB-393:RBU Team Leader I want to view a list of Refunds awaiting disbursements
    #Scenario :1 RBU officer should not be able to access "Refunds Payments"
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I check I am on "ManageBonds" page
    And I click on text "Tasks"
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value              |
      | item1  | Refunds & Payments |
      | item2  | Reconciliation     |
      | item3  | Manage Bonds       |
      | item4  | Lodge Bond         |
      | item5  | Manage Users       |
      | item6  | Sign Out           |
    Then I click on text "Refunds & Payments"
    Then I check I am on "TaskList" page
    Then I see text "Refund Payments" not displayed

    Examples: 
      | PortalName | email               | Password   |
      | ARB        | backoffice@test.com | Support123 |

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
    Then I click on text "Refunds & Payments"
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value           |
      | item1  | Refunds Raised  |
      | item2  | Refund Payments |
      | item3  | Disputes        |
      | item4  | Claims          |
      | item5  | Bond No.        |
      | item6  | Date Requested  |
      | item6  | Requested By    |
      | item6  | Amount          |
    Then I click on button with value "Search"
    And I enter the details as
      | Fields      | Value    |
      | SearchInput | <BondId> |
    And I hit Enter
    Then I wait for "2000" milliseconds
    Then I check that table "RefundsRaisedTable" with row containing "<BondId>" has the following
      | Fields | Value      |
      | item1  | 28-08-2017 |
      | item2  | <BondId>   |
      | item3  | Lessor     |
      | item4  | $100.00    |
      

    Examples: 
      | PortalName | email                | Password   | email_2                 | BondId  |
      | ARB        | agentadmin2@test.com | Support123 | rbuteamleader1@test.com | 1000088 |
