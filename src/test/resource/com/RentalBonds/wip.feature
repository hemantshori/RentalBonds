Feature: Wip

  @wip
  Scenario Outline: ARB-434  :	As an RBU Team Leader/Officer, I want to view a list of Bonds that are in dispute so that I know which ones are awaiting resolution
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
      | item6  | Sign Out           |
    # because currently only RBU lead can acces Manage users
    Then I see text "Manage Users" not displayed
    Then I click on text "Refunds & Payments"
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value          |
      | item1  | Refunds Raised |
      | item3  | Disputes       |
      | item5  | Bond No.       |
      | item6  | Date Requested |
      | item5  | Manage Users   |
      | item6  | Requested By   |
      | item6  | Amount         |
    Then I click on text "Disputes"
    And I wait for "2000" milliseconds
    And I take a "capture" of row "1" from the table "DisputesTable"
    #Scenario 3
    Then I click on button with value "Search"
    And I paste "BondID" value in "SearchInput"
    And I hit Enter
    Then I see text "$" displayed
    And I hit Enter

    Examples: 
      | PortalName | Password   | email                |
      | ARB        | Support123 | rbuteamleader1@test.com |
