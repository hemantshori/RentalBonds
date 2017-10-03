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
      
      
      
      
      Scenario Outline: ARB-401  :	 As an RBU Team Leader/Officer, I want to enter the details of a 'Lodged' Bond from BMS so that BMS can be decommissioned in future
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I check I am on "ManageBonds" page
    And I click on text "Lodge Bond"
    #Scenario:1
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value         |
      | item1  | Lodgement     |
      | item2  | BMS Lodgement |
    And I click on text "BMS Lodgement"
    And I wait for "1000" milliseconds
    Then I check I am on "BMS Bond Lodgement Premise" page
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value                 |
      | item1  | Bond Status           |
      | item2  | Unclaimed             |
      | item2  | Bond Reference Number |
      | item2  | Date Raised           |
    #Scenario:2, Condition1, if Lodged is selected
    And I click on text "Lodged"
    And I wait for "1000" milliseconds
    Then I see text "Agent / Lessor" not displayed
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields              | Value       |
      | BondReferenceNumber | 12433434344 |
      | StreetNumber        |          13 |
      | StreetName          | Shori       |
      | Suburb              | Kaleen      |
      | Postcode            |        1111 |
      | Section             |           2 |
      | Block               |          13 |
      | NumberOfBedrooms    |           3 |
      | TotalBondAmount     |         400 |
      | WeeklyRentalAmount  |         400 |
    Then I select "Separated House" from "DwellingType"
    And I select "Residential" from "OccupancyType"
    Then I click on button with value "Next"
    #Scenario:2
    Then I see text "BSB Number" not displayed
    Then I see text "Account Number" not displayed
    Then I click on text "Back"
    Then I check I am on "BMS Bond Lodgement Premise" page
    Then I click on text "Unclaimed"
    Then I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Tenants" page
    #Scenario:2, Condition1, if Unclaimed is selected, bank details should be visible
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value               |
      | item1  | BSB Number          |
      | item2  | Account Number      |
      | item2  | Account Holder Name |
    #Scenario:3
    Then I click on button with value "Next"
    And I wait for "1000" milliseconds
    #defect 579, enable following step once fixed....fixed
     Then I see text "Required fields have not been completed." displayed
    #Scenario :4
    Then I select "DOG & CO PTY LTD" from "AgencyNameDrop"
    And I wait for "500" milliseconds
    Then I select "Agency Admin" from "AgentDrop"
    And I enter the details as
      | Fields          | Value                               |
      | LessorFirstName | LessorFirstName                     |
      | LessorLastName  | LessorLastName                      |
      | LessorEmail     | LessorEmail@TEST.com                |
      | LessorPhone     |                          1234567890 |
      | PostalAddress   | 10 FLORA AVE, BADGER CREEK VIC 3777 |
    #Scenario 4, Scenario 5
    Then I click on text "Paid"
    Then I see text "Transaction Reference" not displayed
    Then I see text "Unclaimed Amount" not displayed
    Then I see text "Date Refunded" not displayed
    And I wait for "500" milliseconds
    Then I click on text "Unclaimed"
    Then I click on button with value "Next"
    #ToDO...check future dates are not accepted, there is currently a task to be made by Katherine Santos
    #once defect is fixed, add tenant field details
    #Error message should be displayed
    And I wait for "1000" milliseconds
    Then I see text "Amount should be greater than 0, please try again." displayed
    And I enter the details as
      | Fields               | Value  |
      | TransactionReference | 123456 |
      | RefundAmount         |    250 |
    Then I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Summary" page

    Examples: 
      | PortalName | Password   | email                   |
      | ARB        | Support123 | rbuteamleader1@test.com |

  Scenario Outline: ARB-401/2   :	 Scenario 6 onwards
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I check I am on "ManageBonds" page
    And I click on text "Lodge Bond"
    #Scenario:1
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value         |
      | item1  | Lodgement     |
      | item2  | BMS Lodgement |
    And I click on text "BMS Lodgement"
    And I wait for "1000" milliseconds
    Then I check I am on "BMS Bond Lodgement Premise" page
    And I click on text "Lodged"
    And I wait for "1000" milliseconds
    Then I see text "Agent / Lessor" not displayed
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields              | Value                        |
      | BondReferenceNumber |                  12433434344 |
      | OneLineAddress      | 12 SABA ST, BURDELL QLD 4818 |
      | StreetNumber        |                           13 |
      | StreetName          | Shori                        |
      | Suburb              | Murrumbeena                  |
      | Postcode            |                         1111 |
      | Section             |                           12 |
      | Block               |                           10 |
      | NumberOfBedrooms    |                           13 |
      | TotalBondAmount     |                          400 |
      | WeeklyRentalAmount  |                          400 |
    Then I select "Separated House" from "DwellingType"
    And I select "Residential" from "OccupancyType"
    Then I click on button with value "Next"
    Then I click on text "Back"
    Then I check I am on "BMS Bond Lodgement Premise" page
    Then I click on text "Unclaimed"
    Then I click on button with value "Next"
    Then I check I am on "Historical Bond Tenants" page
    #Scenario:6, add multiple tenants and check correct fields are shown.
    And I enter the details as
      | Fields          | Value                |
      | TenantFirstName | TenantFirstName      |
      | TenantLastName  | TenantLastName       |
      | TenantEmail     | TenantEmail@TEST.com |
      | TenantPhone     |           1234567890 |
      | TRX_Ref         |               123123 |
    And I wait for "1000" milliseconds
    And I enter the details as
      | Fields              | Value     |
      | TenantRefundAmount  |    120.30 |
      | TenantAccountName   | Auto Test |
      | TenantBSB           |    456432 |
      | TenantAccountNumber | 123123123 |
    And I click on text "ADD TENANT"
    And I wait for "1000" milliseconds
    And I enter the details as
      | Fields          | Value                |
      | TenantFirstName | TenantFirstName      |
      | TenantLastName  | TenantLastName       |
      | TenantEmail     | TenantEmail@TEST.com |
      | TenantPhone     |           1234567890 |
      | TRX_Ref         |               123123 |
    And I click on text "REMOVE"
    And I see popup "MainContent" displayed
    Then I see "Are you sure you want to remove this tenant?" displayed on popup and I click "OK"

    Examples: 
      | PortalName | Password   | email                   |
      | ARB        | Support123 | rbuteamleader1@test.com |
      
