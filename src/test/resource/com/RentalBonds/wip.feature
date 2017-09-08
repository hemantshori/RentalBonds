Feature: Wip



@wip

 Scenario Outline: ARB-122: As an Agent Administrator, I want to update a users details so that their information is up to dates
    Given I want to login to portal "<PortalName>"
    And I wait for "4000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Manage Users"
    Then I click on text "ron.coldebella@dbresults.com.au"
    Then I wait for "1000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I wait for "1000" milliseconds
    Then I click on button with value "Cancel"
    Then I click on text "ron.coldebella@dbresults.com.au"
    Then I wait for "4000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I select "Agent Administrator" from "Role"
    Then I click on button with value "Save"
    Then I wait for "2000" milliseconds
    Then I click on text "ron.coldebella@dbresults.com.au"
    Then I wait for "2000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I select "Property Manager" from "Role"
    Then I click on button with value "Save"
    Then I see text "Ron Coldebella's details have been successfully updated." displayed

    Examples: 
      | PortalName | email                | Password   | Message                                  | email_test                      |
      | ARB        | agentadmin2@test.com | Support123 | Invalid login details. Please try again. | ron.coldebella@dbresults.com.au |







































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
      | ARB        | agentadmin2@test.com | Support123 | rbuteamleader1@test.com | 1000260 |
  

  #ready to be included into regression once JL fixes selection issue
  Scenario Outline: ARB-192: As an RBU Team Leader/Officer I want the ability to cancel a raised bond
    # create a new bond so that i tmay be cancelled
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Lodge Bond"
    Then I check I am on "Bond Lodgement Premise" page
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields             | Value                               |
      | OneLineAddress     | 10 FLORA AVE, BADGER CREEK VIC 3777 |
      | StreetNumber       |                                  13 |
      | StreetName         | Shori                               |
      | Suburb             | Murrumbeena                         |
      | Postcode           |                                1111 |
      | Section            |                                  12 |
      | Block              |                                  10 |
      | NumberOfBedrooms   |                                  13 |
      | TotalBondAmount    |                                 400 |
      | WeeklyRentalAmount |                                 400 |
    Then I select "Separated House" from "DwellingType"
    And I select "Residential" from "OccupancyType"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Parties" page
    And I wait for "1000" milliseconds
    And I enter the details as
      | Fields          | Value                |
      | TenantFirstName | TenantFirstName      |
      | TenantLastName  | TenantLastName       |
      | TenantEmail     | TenantEmail@TEST.com |
      | TenantPhone     |           1234567890 |
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value               |
      | item1  | ADD TENANT          |
      | item1  | Tenant 1 First Name |
      | item1  | Tenant 1 Last Name  |
    Then I click on button with value "Next"
    And I wait for "2000" milliseconds
    # Then I see text "Required fields have not been completed." displayed
    #Scenario1
    # only for back office ..radio buttons are present
    And I click on "<Responsible_Party>" radio option
    Then I see text "<TextOnSelection>" displayed
    And I wait for "1000" milliseconds
    Then I select "<SelectValue1>" from "<Dropdown1>"
    And I wait for "1000" milliseconds
    Then I select "<SelectValue2>" from "<Dropdown2>"
    And I enter the details as
      | Fields          | Value                               |
      | LessorFirstName | LessorFirstName                     |
      | LessorLastName  | LessorLastName                      |
      | LessorEmail     | LessorEmail@TEST.com                |
      | LessorPhone     |                          1234567890 |
      | PostalAddress   | 10 FLORA AVE, BADGER CREEK VIC 3777 |
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Summary" page
    #Scenario 2,3
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value                |
      | item1  | <SelectValue1>       |
      | item2  | <SelectValue2>       |
      | item3  | LessorFirstName      |
      | item4  | LessorLastName       |
      | item5  | LessorEmail@TEST.com |
    Then I click on text "I confirm that these details are correct at the time of lodgement"
    And I click on button with value "Next"
    And I wait for "1000" milliseconds
    Then I see text "Lodgement Complete" displayed
    # capture bond ID to check bond status and then submit it
    And I capture "You have successfully lodged your Bond"
    Then I click on text "BACK TO BONDS"
    Then I check I am on "ManageBonds" page
    Then I click on button with value "Search"
    # ARB-335,ARB-79 search bond
    And I paste "BondID" value in "SearchInput"
    And I hit Enter
    Then I check I am on "ManageBonds" page
    Then I "check" text "Raised" displayed in table "wtBondsList"
    Then I "click" text "selectTheFirstRow" displayed in table "Bonds"
    #remove following once JL fixes the thing on row click
    And I wait for "20000" milliseconds
    #The RBU Team Leader/Officer successfully updates the status of a Bond from 'Raised' to 'Cancelled'
    # following is to go to "..." till and id is provided.
    Then I click on button "fa fa-fw fa-ellipsis-h fa-2x"
    And I wait for "2000" milliseconds
    Then I click on text "CANCEL BOND"
    And I wait for "2000" milliseconds
    Then I switch to frame "0"
    #Scenario :3
    Then I click on button with value "No"
    Then I click on button with value "Yes"
    And I wait for "2000" milliseconds
    Then I click on text "CANCEL BOND"
    And I wait for "2000" milliseconds
    Then I switch to frame "0"
    #Scenario :4
    Then I click on button with value "Yes"
    And I wait for "2000" milliseconds
    Then I see text "Cancelled" displayed
    And I click on text "HISTORY"
    Then I see text "Bond Cancelled" displayed

    Examples: 
      | PortalName | email                         | Password   | Message                                  | email_test             | Responsible_Party  | TextOnSelection        | SelectValue1       | Dropdown1      | SelectValue2 | Dropdown2 |
      | ARB        | backofficeteamleader@test.com | Support123 | Invalid login details. Please try again. | honesurevo@mystvpn.com | ManagingAgentRadio | Managing Agent Details | DB RESULTS PTY LTD | AgencyNameDrop | ujaad singh  | AgentDrop |
