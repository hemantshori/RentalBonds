Feature: Wip

  Scenario Outline: ARB-333: As an aagent admin, property manager, lessor, I want to pay a single Bond.
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page
    Then I click on text "Lodge Bond"
    Then I check I am on "Bond Lodgement Premise" page
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields           | Value                               |
      | OneLineAddress   | 10 FLORA AVE, BADGER CREEK VIC 3777 |
      | StreetNumber     |                                  13 |
      | StreetName       | Shori                               |
      | Suburb           | Murrumbeena                         |
      | Postcode         |                                1111 |
      | NumberOfBedrooms |                                  13 |
    Then I select "Separated House" from "DwellingType"
    And I select "Residential" from "OccupancyType"
    And I enter the details as
      | Fields             | Value |
      | TotalBondAmount    |   400 |
      | WeeklyRentalAmount |   400 |
    And I select "Residential" from "OccupancyType"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Parties" page
    And I enter the details as
      | Fields          | Value                |
      | TenantFirstName | TenantFirstName      |
      | TenantLastName  | TenantLastName       |
      | TenantEmail     | TenantEmail@TEST.com |
      | TenantPhone     |           1234567890 |
      | LessorFirstName | <LessorFirstName>    |
      | LessorLastName  | <LessorLastName>     |
      | LessorEmail     | <LessorEmail>        |
      | LessorPhone     | <LessorPhone>        |
      | PostalAddress   | <PostalAddress>      |
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Summary" page
    Then I click on button with value "Next"
    And I wait for "1000" milliseconds
    Then I see text "Please confirm your bond details are correct." displayed
    Then I click on button "ConfirmCheck"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Confirmation" page
    #Scenario 1
    Then I click on button with value "View Payment Info"
    And I wait for "2000" milliseconds
    Then I check I am on "Bond Payment View" page
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value          |
      | item1  | BACK TO BONDS  |
      | item2  | Reference Code |
      | item4  | BSB            |
      | item5  | Account Number |
    #Scenario 2
    Then I click on button with value "Cancel"
    Then I check I am on "Bond Lodgement Confirmation" page
    Then I click on button with value "Submit"
    And I wait for "2000" milliseconds
    Then I see text "The status of your Bond/s has been changed to 'Raised-Pending Payment'." displayed

    Examples: 
      | PortalName | email                | Password   | Message                                  | Name            | LessorFirstName | LessorLastName | LessorEmail          | LessorPhone | PostalAddress                       |
      | ARB        | agentadmin2@test.com | Support123 | Invalid login details. Please try again. | Agent Admin Two | LessorFirstName | LessorLastName | LessorEmail@TeST.com |  0987654321 | 10 FLORA AVE, BADGER CREEK VIC 3777 |

  @wip
  Scenario Outline: ARB-333/2 using Lessor: As an aagent admin, property manager, lessor, I want to pay a single Bond.
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page
    Then I click on text "Lodge Bond"
    Then I check I am on "Bond Lodgement Premise" page
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields           | Value                              |
      | OneLineAddress   | 7 FLORA AVE, BADGER CREEK VIC 3777 |
      | StreetNumber     |                                 13 |
      | StreetName       | Shori                              |
      | Suburb           | Murrumbeena                        |
      | Postcode         |                               1111 |
      | NumberOfBedrooms |                                 13 |
    Then I select "Separated House" from "DwellingType"
    And I select "Residential" from "OccupancyType"
    And I enter the details as
      | Fields             | Value |
      | TotalBondAmount    |   400 |
      | WeeklyRentalAmount |   400 |
    And I select "Residential" from "OccupancyType"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Parties" page
    And I enter the details as
      | Fields          | Value                |
      | TenantFirstName | TenantFirstName      |
      | TenantLastName  | TenantLastName       |
      | TenantEmail     | TenantEmail@TEST.com |
      | TenantPhone     |           1234567890 |
    Then I click on button with value "Next"
    And I wait for "2000" milliseconds
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Summary" page
    Then I click on button with value "Next"
    And I wait for "1000" milliseconds
    Then I see text "Please confirm your bond details are correct." displayed
    Then I click on button "ConfirmCheck"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Confirmation" page
    #Scenario 1
    Then I click on button with value "View Payment Info"
    And I wait for "2000" milliseconds
    Then I check I am on "Bond Payment View" page
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value          |
      | item1  | BACK TO BONDS  |
      | item2  | Reference Code |
      | item4  | BSB            |
      | item5  | Account Number |
    #Scenario 2
    Then I click on button with value "Cancel"
    Then I check I am on "Bond Lodgement Confirmation" page
    Then I click on button with value "Submit"
    And I wait for "2000" milliseconds
    Then I see text "The status of your Bond/s has been changed to 'Raised-Pending Payment'." displayed

    Examples: 
      | PortalName | email            | Password   | Message                                  | Name |
      | ARB        | lessor2@test.com | Support123 | Invalid login details. Please try again. | Agen |
