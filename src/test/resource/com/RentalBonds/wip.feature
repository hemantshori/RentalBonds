Feature: Wip

  @wip
  

  Scenario Outline: Login page
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I capture "html"
    And I want to login to portal "<PortalName2>"
    And I click on text "Paste HTML Markup"
    And I click on button "checkpaste"
    And I paste "html"
    And I click on button "validate_paste"
    Then I wait for "5000" milliseconds
    And I capture "AC_num_of_errors"
    Then I write "Login" information to file

    Examples: 
      | PortalName | PortalName2 | email                | Password   | Message                                  |
      | ARB        | AC CHECKER  | agentadmin2@test.com | Support123 | Invalid login details. Please try again. |
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
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
    And I click on text "Unclaimed"
    And I wait for "1000" milliseconds
    Then I see text "Agent / Lessor" displayed
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
    Then I check I am on "Historical Bond Tenants" page
    #Scenario:2
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value     |
      | item1  | Paid      |
      | item2  | Unclaimed |
    Then I see text "BSB Number" not displayed
    Then I see text "Account Number" not displayed
    Then I click on text "Unclaimed"
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value               |
      | item1  | BSB Number          |
      | item2  | Account Number      |
      | item2  | Account Holder Name |
    #Scenario:3
    Then I click on button with value "Next"
    #defect, update when fixed
    And I wait for "1000" milliseconds
    Then I see text "Please review the information" displayed
    And I enter the details as
      | Fields              | Value                |
      | TenantFirstName     | TenantFirstName      |
      | TenantLastName      | TenantLastName       |
      | TenantEmail         | TenantEmail@TEST.com |
      | TenantPhone         |           1234567890 |
      | TRX_Ref             |           1234567890 |
      | TenantRefundAmount   |           250.50 |
      | TenantAccountName   |           Billu da Dhaba |
      | TenantBSB           |               123456 |
      | TenantAccountNumber |           456765 |
    Then I click on button with value "Next"

    Examples: 
      | PortalName | Password   | email                   |
      | ARB        | Support123 | rbuteamleader1@test.com |
