Feature: Wip





 
  

  #ready to be included into regression once JL fixes selection issue
  @wip
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
