Feature: Wip

  @wip
  Scenario Outline: ARB-438 As an Agent Administrator/Property Manager/Lessor/RBU Team Leader/Officer, I want to capture the lodgement 'Type' so that it can be used for Land Tax reporting purposes
    Given I want to login to portal "<PortalName>"
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
      | Fields             | Value                                      |
      | OneLineAddress     | 217 Badger Creek Rd, Badger Creek VIC 3777 |
      | StreetNumber       |                                         14 |
      | StreetName         | Shorid                                     |
      | Suburb             | Murrumbeena                                |
      | Postcode           |                                       7777 |
      | Section            |                                         12 |
      | Block              |                                         10 |
      | NumberOfBedrooms   |                                         21 |
      | TotalBondAmount    |                                       1000 |
      | WeeklyRentalAmount |                                       2000 |
    Then I select "Townhouse/Semi-Detached" from "DwellingType"
    Then I select "<OccType>" from "OccupancyType"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Parties" page
    And I enter the details as
      | Fields          | Value                      |
      | TenantFirstName | someautomated              |
      | TenantLastName  | test                       |
      | TenantEmail     | someautomatedtest@test.com |
      | TenantPhone     |                 0422184033 |
    And I click on button "<LessorRadio>"
    And I enter the details as
      | Fields          | Value             |
      | LessorFirstName | <LessorFirstName> |
      | LessorLastName  | <LessorLastName>  |
    #And I hit Enter
    Then I click on button with value "Next"
    And I wait for "4000" milliseconds
    And I enter the details as
      | Fields        | Value           |
      | LessorEmail   | <LessorEmail>   |
      | LessorPhone   | <LessorPhone>   |
      | PostalAddress | <PostalAddress> |
    Then I click on button with value "Next"
    And I check I am on "Bond Lodgement Summary" page
    And I see text "<OccType>" displayed

    Examples: 
      | PortalName | email                         | Password   | LessorRadio | LessorFirstName | LessorLastName | LessorEmail     | LessorPhone | PostalAddress                              | Message                                  | AgencyName  | OccType     |
      | ARB        | rbuteamleader1@test.com       | Support123 | LessorRadio | sfdfs           | sddsf          | sdfdf@gmail.com |  0433456673 | 217 Badger Creek Rd, Badger Creek VIC 3777 | Invalid login details. Please try again. | FirstAgency | Residential |
      | ARB        | rbuteamleader1@test.com       | Support123 | LessorRadio | sfdfs           | sddsf          | sdfdf@gmail.com |  0433456673 | 217 Badger Creek Rd, Badger Creek VIC 3777 | Invalid login details. Please try again. | FirstAgency | Occupancy   |
      | ARB        | backofficeteamleader@test.com | Support123 | LessorRadio | sfdfs           | sddsf          | sdfdf@gmail.com |  0433456673 | 217 Badger Creek Rd, Badger Creek VIC 3777 | Invalid login details. Please try again. | FirstAgency | Residential |
      | ARB        | backofficeteamleader@test.com | Support123 | LessorRadio | sfdfs           | sddsf          | sdfdf@gmail.com |  0433456673 | 217 Badger Creek Rd, Badger Creek VIC 3777 | Invalid login details. Please try again. | FirstAgency | Occupancy   |
      | ARB        | lessor2@test.com              | Support123 |             |                 |                |                 |             |                                            | Invalid login details. Please try again. | FirstAgency | Residential |
      | ARB        | lessor2@test.com              | Support123 |             |                 |                |                 |             |                                            | Invalid login details. Please try again. | FirstAgency | Occupancy   |

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

  #ready to be included into regression once JL fixes selection issue
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
      | Fields | Value   |
      | item1  | XXXXXXX |
    And I click on text "EDIT DETAILS"
    And I wait for "1000" milliseconds
    And I see popup "MainContent" displayed
    #Scenario 2: Fields should be editable
    Then I enter the details as
      | Fields         | Value       |
      | BSB            |      123123 |
      | Account_Number |   123123123 |
      | Account_Name   | OneTwoThree |

    Examples: 
      | PortalName | email                | Password   | email_2                 | BondId  |
      | ARB        | agentadmin2@test.com | Support123 | rbuteamleader1@test.com | 1000088 |
