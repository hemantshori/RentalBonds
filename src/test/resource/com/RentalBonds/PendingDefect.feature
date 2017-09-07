Feature: Wip

Scenario Outline: ARB-38, As an RBU Team Leader/Officer, I want to Approve a Refund Request so the Bond can be refunded to the nominated parties
    
    Given I want to login to portal "<PortalName>"
    And I wait for "3000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I check I am on "ManageBonds" page
    Then I see text "Refunds & Payments" not displayed
    Then I click on text "Sign Out"
  
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
      
    Then I "click" text "selectTheFirstRow" displayed in table "RefundsRaisedTable"
        #remove following once JL fixes the thing on row click
          And I wait for "10000" milliseconds 
    Then I click on button with value "EDIT & APPROVE"
    Then I check I am on "ApproveRefundRequest" page
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value             |
      | item1  | Total Bond Amount |
      | item2  | Lessor / Agent    |
      | item3  | Tenants           |
      | item4  | VIEW BOND         |
      | item5  | EDIT DETAILS      |
      #Scenario 1
      Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value           |
      | item1  | XXXXXXX |
      And I click on text "EDIT DETAILS"
      And I wait for "1000" milliseconds 
      And I see popup "MainContent" displayed
      #Scenario 2: Fields should be editable
      Then I enter the details as
      | Fields                       | Value       |
      | BSB            |      123123 |
      | Account_Number |   123123123 |
      | Account_Name   | OneTwoThree |
      
      
     


    Examples: 
      | PortalName | email                | Password   | email_2                 | BondId  |
      | ARB        | agentadmin2@test.com | Support123 | rbuteamleader1@test.com | 1000088 |



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
