Feature: Wip

  @wip


  Scenario Outline: ARB-390: As an Agent Administrator/Property Manager/Lessor, I want to request a Bond refund so that it can be returned to the relevant parties
    # launch a bond first logging as lessor
    #Scenario 1: Dispute Full Amount
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Lodge Bond"
    And I wait for "1000" milliseconds
    Then I click on text "<DoIExist1>"
    Then I check I am on "Bond Lodgement Premise" page
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields             | Value  |
      | StreetNumber       |     13 |
      | StreetName         | Shori  |
      | Suburb             | Kaleen |
      | Postcode           |   1111 |
      | Section            |      2 |
      | Block              |     13 |
      | NumberOfBedrooms   |      3 |
      | TotalBondAmount    |    400 |
      | WeeklyRentalAmount |    400 |
    Then I select "Separated House" from "DwellingType"
    And I select "Residential" from "OccupancyType"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Parties" page
    And I wait for "1000" milliseconds
    And I enter the details as
      | Fields          | Value                |
      | TenantFirstName | TenantFirstName      |
      | TenantLastName  | TenantLastName       |
      | TenantPhone     |           1234567890 |
      | TenantEmail     | TenantEmail@TEST.com |
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value               |
      | item1  | ADD TENANT          |
      | item1  | Tenant 1 First Name |
      | item1  | Tenant 1 Last Name  |
    Then I click on button with value "Next"
    And I wait for "2000" milliseconds
    Then I click on text "I confirm that these details are correct at the time of lodgement"
    And I click on button with value "Submit"
    And I wait for "1000" milliseconds
    Then I see text "Lodgement Complete" displayed
    And I capture "You have successfully raised your Bond"
    # find some bond and start with test requirements 390
    Then I click on text "Manage Bonds"
    And I wait for "1000" milliseconds
    Then I click on text "LODGED"
    And I wait for "1000" milliseconds
    And I take a "click" of "3" element of row "2" from the table "BondsList"
    Then I check I am on "Bond Detail" page
    And I click on button "<DoIExist2>"
    And I wait for "1000" milliseconds
    And I click on text "REQUEST REFUND"
    Then I check I am on "Refund Disbursements" page
    And I click on button with value "Next"

    #todo add verification once defect 636 on internal error is fixed
    Examples: 
      | PortalName | email                | Password   | Message                                  | email_test             | DoIExist2                                            | Responsible_Party | TextOnSelection   | DoIExist1 |
      | ARB        | lessor2@test.com     | Support123 | Invalid login details. Please try again. | honesurevo@mystvpn.com | wtMainContent_CloneOfWebPatterns_wt378_block_wtLabel | LessorRadio       | Responsible Party |           |
      | ARB        | agentadmin2@test.com | Support123 | Invalid login details. Please try again. | honesurevo@mystvpn.com | wtMainContent_CloneOfWebPatterns_wt378_block_wtLabel | LessorRadio       | Responsible Party |           |
