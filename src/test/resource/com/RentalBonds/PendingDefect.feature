Feature: Wip


# has defect where decimal vause can not be entered and also for this story make sure u have enough data, nearly done.
  @wip,    @defect 
  Scenario Outline: ARB-394: RBU Team Leader/Officer, I want to Dispute a Refund Request so that it cannot be refunded until the dispute has been resolved
  
    #The RBU Team Leader/Officer successfully Disputes a Bond Refund Request Dispute full amount
    
    #Scenario 1: Dispute Full Amount
    Given I want to login to portal "<PortalName>"
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
   # And I click on text "<BondId>"
   # And I take a "capture" of row "2" from the table "RefundRaisedTable"
   Then I "click" text "selectTheFirstRow" displayed in table "RefundRaisedTable"
    And I click on button with value "EDIT & DISPUTE"
    And I click on text "Dispute Full Amount"
     Then I wait for "1000" milliseconds
    And I click on button with value "Raise Dispute"
    And I hit Enter
    Then I wait for "2000" milliseconds
    Then I switch to frame "0"
    And I see text "Are you sure you want to raise this Dispute? " displayed
    And I click on button with value "Yes"
    And I see text "Dispute Raised" displayed
    And I see text "The funds not disputed have been transferred to Refund Payments awaiting release." displayed
        
    Then I wait for "1000" milliseconds
    #Scenario 2: Dispute Partial Amount
    Then I click on text "BACK TO TASKS"
    And I click on text "Refunds Raised"
Then I "click" text "selectTheFirstRow" displayed in table "RefundRaisedTable"
    And I click on button with value "EDIT & DISPUTE"
    And I click on text "Dispute Partial Amount"
 
    And I enter the details as
      | Fields           | Value |
      | DisputedAmount   |   50 |
      | Txt_LessorAmount |   200 |
      | AmountAllocated  |   100 |
   
    Then I wait for "2000" milliseconds
    And I click on button with value "RAISE DISPUTE"
    Then I switch to frame "0"
    And I see text "Are you sure you want to raise this Dispute? " displayed
    And I click on button with value "Yes"
    And I see text "Dispute Raised" displayed

    Examples: 
      | PortalName | email                   | Password   | Message                                  | BondId  | BondId2 |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | 1000117 | 1000202 |

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
