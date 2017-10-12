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
      | Suburb             | Kaleen                                |
      | Postcode           |                                       7777 |
      | Section            |                                         13 |
      | Block              |                                         2 |
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
    Then I wait for "1000" milliseconds
    And I take a "click" of "1" element of row "2" from the table "RefundRaisedTable"
    And I click on button with value "EDIT & DISPUTE"
    And I click on text "Dispute Full Amount"
    Then I wait for "1000" milliseconds
    And I click on button with value "Raise Dispute"
    And I hit Enter
    Then I wait for "2000" milliseconds
    Then I switch to frame "0"
    #And I see text "Are you sure you want to raise this Dispute?" displayed
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value                                        |
      | item1  | Are you sure you want to raise this Dispute? |
    And I click on button with value "Yes"
    #disabled because of coding issue, JL is looking into it
    #Then "<Item>" is displayed as "<ItemName>"
    # | Fields | Value                                                                             |
    # | item1  | Dispute Raised                                                                    |
    # | item2  | The funds not disputed have been transferred to Refund Payments awaiting release. |
    Then I wait for "1000" milliseconds
    #Scenario 2: Dispute Partial Amount
    Then I click on text "BACK TO TASKS"
    And I click on text "Refunds Raised"
    Then I "click" text "selectTheFirstRow" displayed in table "RefundRaisedTable"
    And I click on button with value "EDIT & DISPUTE"
    And I click on text "Dispute Partial Amount"
    And I enter the details as
      | Fields           | Value |
      | DisputedAmount   |    50 |
      | Txt_LessorAmount |   200 |
      | AmountAllocated  |   100 |
    Then I wait for "2000" milliseconds
    And I click on button with value "RAISE DISPUTE"
    Then I switch to frame "0"
    #disabled because of coding issue, JL is looking into it
    #Then "<Item>" is displayed as "<ItemName>"
    #| Fields | Value                                        |
    #| item1  | Are you sure you want to raise this Dispute? |
    And I click on button with value "Yes"
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value          |
      | item1  | Dispute Raised |

    Examples: 
      | PortalName | email                   | Password   | Message                                  | BondId  | BondId2 |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | 1000117 | 1000202 |

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
