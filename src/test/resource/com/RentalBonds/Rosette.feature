 @wip
 
 Feature: Some feature
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
    And I click on text "Refunds & Payments"
    And I click on text "<BondId>"
    And I click on button with value "EDIT & DISPUTE"
    And I click on text "Dispute Full Amount"
    And I click on button with value "RaiseDispute"
    And I hit Enter
    Then I wait for "2000" milliseconds
    Then I switch to frame "0"
    And I see text "Are you sure you want to raise this Dispute? " displayed
    And I click on button with value "Yes"
    And I see text "Dispute Raised" displayed

    #Scenario 2: Dispute Partial Amount
    Then I click on text "BACK TO TASKS"
    And I click on text "Refunds Raised"
    And I click on text "<BondId2>"
    And I click on button with value "EDIT & DISPUTE"
    And I click on text "Dispute Partial Amount"
    And I enter the details as
      | Fields           | Value |
      | DisputedAmount   |   800 |
      | Txt_LessorAmount |   500 |
      | AmountAllocated  |   500 |
    And I hit Enter
    Then I wait for "2000" milliseconds
    Then I switch to frame "0"
    And I see text "Are you sure you want to raise this Dispute? " displayed
    And I click on button with value "Yes"
    And I see text "Dispute Raised" displayed

    Examples: 
      | PortalName | email                   | Password   | Message                                  | BondId  | BondId2 |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | 1000117 | 1000202 |
      
      
       @wip
  Scenario Outline: ARB-299: As an RBU Team Leader/RBU Officer, I want to re-send a S33 notice
    #Scenario 1: Non RBU user views a Bond where Refund has been raised
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value         |
      | Email    | <NonRBUEmail> |
      | Password | <Password>    |
    And I hit Enter
    Then I click on button with value "Search"
    And I enter the details as
      | Fields      | Value          |
      | SearchInput | <RaisedBondId> |
    And I click on text "<RaisedBondId>"
    And I see text "Raised" displayed
    And I see text "RESEND S33" not displayed
    Then I click on text "Sign Out"

    #Scenario 2: RBU user views a Bond where Refund has been raised
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <RBUemail> |
      | Password | <Password> |
    And I hit Enter
    Then I click on button with value "Search"
    And I enter the details as
      | Fields      | Value                  |
      | SearchInput | <RefundInProgressBond> |
    And I click on text "<RefundInProgressBond>"
    And I see text "Refund In Progress" displayed
    #And I click on button "..." - not yet implemented in step
    #And I check "RESEND S33" exists
    
    #Scenario 3: RBU user resends S33
    And I click on text "BACK TO BONDS"
    Then I click on button with value "Search"
    And I enter the details as
      | Fields      | Value                  |
      | SearchInput | <RefundInProgressBond> |
    And I click on text "<RefundInProgressBond>"
    And I see text "Refund In Progress" displayed
    And I click on button with value "ResendS33"

    Examples: 
      | PortalName | RBUemail                | NonRBUEmail          | Password   | Message                                  | RaisedBondId | RefundInProgressBond |
      | ARB        | rbuteamleader1@test.com | agentadmin2@test.com | Support123 | Invalid login details. Please try again. |      1000257 |              1000241 |
      
      
      
    # ARB-401: As an RBU Team Leader/Officer, I want to enter the details of a 'Lodged' Bond from BMS so that BMS can be decommissioned in future

  Scenario Outline: RBU Team Leader/Officer accesses the Historical Bond Lodgement function
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Lodge Bond"
    And I click on text "BMS Lodgement"
    Then I check I am on "BMS Bond Lodgement Premise" page

    Examples: 
      | PortalName | email                   | Password   | Message                                  |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. |

  Scenario Outline: RBU Team Leader/Officer fills in all mandatory Premise details
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Lodge Bond"
    And I click on text "BMS Lodgement"
    Then I check I am on "BMS Bond Lodgement Premise" page
    And I click on button with value "UnclaimedRadioButton"
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields              | Value                                      |
      | OneLineAddress      | 217 Badger Creek Rd, Badger Creek VIC 3777 |
      | StreetNumber        |                                         14 |
      | StreetName          | Shorid                                     |
      | Suburb              | Murrumbeena                                |
      | Postcode            |                                       7777 |
      | NumberOfBedrooms    |                                         21 |
      | TotalBondAmount     |                                       1000 |
      | WeeklyRentalAmount  |                                       1000 |
      | BondReferenceNumber |                                   46385854 |
    And I select "01-09-1994" from "DateRaised"
    Then I select "Townhouse/Semi-Detached" from "DwellingType"
    Then I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Tenants" page
    And I see text "Refund Details" displayed
    And I see text "Bank Details" displayed

    Examples: 
      | PortalName | email                   | Password   | Message                                  |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. |

  Scenario Outline: RBU Team Leader/Officer does not fill in all mandatory Premise details
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Lodge Bond"
    And I click on text "BMS Lodgement"
    Then I check I am on "BMS Bond Lodgement Premise" page
    And I click on button with value "UnclaimedRadioButton"
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields              | Value                                      |
      | OneLineAddress      | 217 Badger Creek Rd, Badger Creek VIC 3777 |
      | StreetNumber        |                                         14 |
      | StreetName          | Shorid                                     |
      | Suburb              | Murrumbeena                                |
      | Postcode            |                                       7777 |
      | NumberOfBedrooms    |                                         21 |
      | TotalBondAmount     |                                       1000 |
      | WeeklyRentalAmount  |                                       1000 |
      | BondReferenceNumber |                                   46385854 |
    And I select "01-09-1994" from "DateRaised"
    Then I click on button with value "Next"
    And I see text "Required fields have not been completed." displayed

    Examples: 
      | PortalName | email                   | Password   | Message                                  |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. |

  Scenario Outline: Tenant’s Bond Amount has been refunded
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Lodge Bond"
    And I click on text "BMS Lodgement"
    Then I check I am on "BMS Bond Lodgement Premise" page
    And I click on button with value "UnclaimedRadioButton"
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields              | Value                                      |
      | OneLineAddress      | 217 Badger Creek Rd, Badger Creek VIC 3777 |
      | StreetNumber        |                                         14 |
      | StreetName          | Shorid                                     |
      | Suburb              | Murrumbeena                                |
      | Postcode            |                                       7777 |
      | NumberOfBedrooms    |                                         21 |
      | TotalBondAmount     |                                       1000 |
      | WeeklyRentalAmount  |                                       1000 |
      | BondReferenceNumber |                                   46385854 |
    And I select "01-09-1994" from "DateRaised"
    Then I select "Townhouse/Semi-Detached" from "DwellingType"
    Then I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Tenants" page
    And I click on button with value "PaidRadio"
    And I see text "Trasaction Reference" displayed
    And I see text "Date Refunded" displayed

    Examples: 
      | PortalName | email                   | Password   | Message                                  |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. |

  Scenario Outline: RBU Team Leader/Officer adds another Tenant
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Lodge Bond"
    And I click on text "BMS Lodgement"
    Then I check I am on "BMS Bond Lodgement Premise" page
    And I click on button with value "UnclaimedRadioButton"
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields              | Value                                      |
      | OneLineAddress      | 217 Badger Creek Rd, Badger Creek VIC 3777 |
      | StreetNumber        |                                         14 |
      | StreetName          | Shorid                                     |
      | Suburb              | Murrumbeena                                |
      | Postcode            |                                       7777 |
      | NumberOfBedrooms    |                                         21 |
      | TotalBondAmount     |                                       1000 |
      | WeeklyRentalAmount  |                                       1000 |
      | BondReferenceNumber |                                   46385854 |
    And I select "01-09-1994" from "DateRaised"
    Then I select "Townhouse/Semi-Detached" from "DwellingType"
    Then I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Tenants" page
    And I click on button with value "<BMSType>"
    And I enter the details as
      | Fields               | Value           |
      | TransactionReference |      1234567890 |
      | Amount               |             200 |
      #| Date Refunded       | 15/12/2017      |
      | AccountName          | Harley E. Quinn |
      | BSBNumber            |          012345 |
      | AccountNumber        |       123456789 |

    Then I click on text "ADD TENANT"
    And I see text "First Name" displayed
    And I see text "Last Name" displayed
    And I see text "Email Address" displayed
    And I see text "Phone Number" displayed
    And I see text "Refund Details" displayed
    #For Paid BMS type
    And I see text "Transaction Reference" displayed
    And I see text "Date Refunded" displayed

    #For Unclaimed BMS type
    #And I see text "Account Name" displayed
    #And I see text "BSB Number" displayed
    #And I see text "AccountNumber Number" displayed
    Examples: 
      | PortalName | email                   | Password   | Message                                  | BMSType   |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | PaidRadio |

  Scenario Outline: RBU Team Leader/Officer fills in all mandatory Tenant details
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Lodge Bond"
    And I click on text "BMS Lodgement"
    Then I check I am on "BMS Bond Lodgement Premise" page
    And I click on button with value "UnclaimedRadioButton"
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields              | Value                                      |
      | OneLineAddress      | 217 Badger Creek Rd, Badger Creek VIC 3777 |
      | StreetNumber        |                                         14 |
      | StreetName          | Shorid                                     |
      | Suburb              | Murrumbeena                                |
      | Postcode            |                                       7777 |
      | NumberOfBedrooms    |                                         21 |
      | TotalBondAmount     |                                       1000 |
      | WeeklyRentalAmount  |                                       1000 |
      | BondReferenceNumber |                                   46385854 |
    And I select "01-09-1994" from "DateRaised"
    Then I select "Townhouse/Semi-Detached" from "DwellingType"
    Then I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Tenants" page
    And I click on button with value "<BMSType>"
    And I enter the details as
      | Fields               | Value           |
      | TransactionReference |      1234567890 |
      | Amount               |             200 |
      #| Date Refunded       | 15/12/2017      |
      | AccountName          | Harley E. Quinn |
      | BSBNumber            |          012345 |
      | AccountNumber        |       123456789 |

    And I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Agent/Lessor" page
    And I see text "Refund Details" not displayed
    And I see text "Bank Details" not displayed

    Examples: 
      | PortalName | email                   | Password   | Message                                  | BMSType   |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | PaidRadio |

  Scenario Outline: RBU Team Leader/Officer does not fill in all mandatory Tenant details
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Lodge Bond"
    And I click on text "BMS Lodgement"
    Then I check I am on "BMS Bond Lodgement Premise" page
    And I click on button with value "UnclaimedRadioButton"
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields              | Value                                      |
      | OneLineAddress      | 217 Badger Creek Rd, Badger Creek VIC 3777 |
      | StreetNumber        |                                         14 |
      | StreetName          | Shorid                                     |
      | Suburb              | Murrumbeena                                |
      | Postcode            |                                       7777 |
      | NumberOfBedrooms    |                                         21 |
      | TotalBondAmount     |                                       1000 |
      | WeeklyRentalAmount  |                                       1000 |
      | BondReferenceNumber |                                   46385854 |
    And I select "01-09-1994" from "DateRaised"
    Then I select "Townhouse/Semi-Detached" from "DwellingType"
    Then I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Tenants" page
    And I click on button with value "<BMSType>"
    And I enter the details as
      | Fields               | Value           |
      | TransactionReference |      1234567890 |
      | Amount               |             200 |
      #| Date Refunded       | 15/12/2017      |
      | AccountName          | Harley E. Quinn |
      | BSBNumber            |          012345 |

    And I click on button with value "Next"
    And I see text "Required fields have not been completed" displayed

    Examples: 
      | PortalName | email                   | Password   | Message                                  | BMSType   |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | PaidRadio |

  Scenario Outline: No Refund to Agent/Lessor
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Lodge Bond"
    And I click on text "BMS Lodgement"
    Then I check I am on "BMS Bond Lodgement Premise" page
    And I click on button with value "UnclaimedRadioButton"
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields              | Value                                      |
      | OneLineAddress      | 217 Badger Creek Rd, Badger Creek VIC 3777 |
      | StreetNumber        |                                         14 |
      | StreetName          | Shorid                                     |
      | Suburb              | Murrumbeena                                |
      | Postcode            |                                       7777 |
      | NumberOfBedrooms    |                                         21 |
      | TotalBondAmount     |                                       1000 |
      | WeeklyRentalAmount  |                                       1000 |
      | BondReferenceNumber |                                   46385854 |
    And I select "01-09-1994" from "DateRaised"
    Then I select "Townhouse/Semi-Detached" from "DwellingType"
    Then I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Tenants" page
    And I click on button with value "<BMSType>"
    And I enter the details as
      | Fields               | Value           |
      | TransactionReference |      1234567890 |
      | Amount               |             200 |
      #| Date Refunded       | 15/12/2017      |
      | AccountName          | Harley E. Quinn |
      | BSBNumber            |          012345 |
      | AccountNumber        |       123456789 |

    And I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Agent/Lessor" page
    And I click on button with value "NoRefundRadio"
    And I click on button with value "Next"

    Examples: 
      | PortalName | email                   | Password   | Message                                  | BMSType   |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | PaidRadio |

  Scenario Outline: Agent/Lessor’s Bond Amount has been refunded
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Lodge Bond"
    And I click on text "BMS Lodgement"
    Then I check I am on "BMS Bond Lodgement Premise" page
    And I click on button with value "UnclaimedRadioButton"
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields              | Value                                      |
      | OneLineAddress      | 217 Badger Creek Rd, Badger Creek VIC 3777 |
      | StreetNumber        |                                         14 |
      | StreetName          | Shorid                                     |
      | Suburb              | Murrumbeena                                |
      | Postcode            |                                       7777 |
      | NumberOfBedrooms    |                                         21 |
      | TotalBondAmount     |                                       1000 |
      | WeeklyRentalAmount  |                                       1000 |
      | BondReferenceNumber |                                   46385854 |
    And I select "01-09-1994" from "DateRaised"
    Then I select "Townhouse/Semi-Detached" from "DwellingType"
    Then I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Tenants" page
    And I click on button with value "<BMSType>"
    And I enter the details as
      | Fields               | Value           |
      | TransactionReference |      1234567890 |
      | Amount               |             200 |
      #| Date Refunded       | 15/12/2017      |
      | AccountName          | Harley E. Quinn |
      | BSBNumber            |          012345 |
      | AccountNumber        |       123456789 |

    And I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Agent/Lessor" page
    And I click on button with value "RefundPaidRadio"
    And I see text "Transaction Reference" displayed
    And I see text "Date Refunded" displayed

    Examples: 
      | PortalName | email                   | Password   | Message                                  | BMSType   |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | PaidRadio |

  Scenario Outline: Agent /Lessor’s Bond Amount has not been refunded
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Lodge Bond"
    And I click on text "BMS Lodgement"
    Then I check I am on "BMS Bond Lodgement Premise" page
    And I click on button with value "UnclaimedRadioButton"
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields              | Value                                      |
      | OneLineAddress      | 217 Badger Creek Rd, Badger Creek VIC 3777 |
      | StreetNumber        |                                         14 |
      | StreetName          | Shorid                                     |
      | Suburb              | Murrumbeena                                |
      | Postcode            |                                       7777 |
      | NumberOfBedrooms    |                                         21 |
      | TotalBondAmount     |                                       1000 |
      | WeeklyRentalAmount  |                                       1000 |
      | BondReferenceNumber |                                   46385854 |
    And I select "01-09-1994" from "DateRaised"
    Then I select "Townhouse/Semi-Detached" from "DwellingType"
    Then I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Tenants" page
    And I click on button with value "<BMSType>"
    And I enter the details as
      | Fields               | Value           |
      | TransactionReference |      1234567890 |
      | Amount               |             200 |
      #| Date Refunded       | 15/12/2017      |
      | AccountName          | Harley E. Quinn |
      | BSBNumber            |          012345 |
      | AccountNumber        |       123456789 |

    And I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Agent/Lessor" page
    And I click on button with value "RefundUnclaimedRadio"
    And I see text "Account Name" displayed
    And I see text "BSB Number" displayed
    And I see text "Account Number" displayed

    Examples: 
      | PortalName | email                   | Password   | Message                                  | BMSType   |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | PaidRadio |

  Scenario Outline: RBU Team Leader/Officer fills in all mandatory Agent/Lessor details
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Lodge Bond"
    And I click on text "BMS Lodgement"
    Then I check I am on "BMS Bond Lodgement Premise" page
    And I click on button with value "UnclaimedRadioButton"
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields              | Value                                      |
      | OneLineAddress      | 217 Badger Creek Rd, Badger Creek VIC 3777 |
      | StreetNumber        |                                         14 |
      | StreetName          | Shorid                                     |
      | Suburb              | Murrumbeena                                |
      | Postcode            |                                       7777 |
      | NumberOfBedrooms    |                                         21 |
      | TotalBondAmount     |                                       1000 |
      | WeeklyRentalAmount  |                                       1000 |
      | BondReferenceNumber |                                   46385854 |
    And I select "01-09-1994" from "DateRaised"
    Then I select "Townhouse/Semi-Detached" from "DwellingType"
    Then I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Tenants" page
    And I click on button with value "<BMSType>"
    And I enter the details as
      | Fields               | Value           |
      | TransactionReference |      1234567890 |
      | Amount               |             200 |
      #| Date Refunded       | 15/12/2017      |
      | AccountName          | Harley E. Quinn |
      | BSBNumber            |          012345 |
      | AccountNumber        |       123456789 |

    And I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Agent/Lessor" page
    And I click on button with value "<RefundStatus>"
    And I click on button with value "Next"
    And I check I am on "BMS Bond Lodgement Summary" page
    And I see text "I confirm that these details are correct at time of lodgement" displayed

    Examples: 
      | PortalName | email                   | Password   | Message                                  | BMSType   | RefundStatus     |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | PaidRadio | BMSNoRefundRadio |

  Scenario Outline: RBU Team Leader/Officer does not fill in all mandatory Agent/Lessor details
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Lodge Bond"
    And I click on text "BMS Lodgement"
    Then I check I am on "BMS Bond Lodgement Premise" page
    And I click on button with value "UnclaimedRadioButton"
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields              | Value                                      |
      | OneLineAddress      | 217 Badger Creek Rd, Badger Creek VIC 3777 |
      | StreetNumber        |                                         14 |
      | StreetName          | Shorid                                     |
      | Suburb              | Murrumbeena                                |
      | Postcode            |                                       7777 |
      | NumberOfBedrooms    |                                         21 |
      | TotalBondAmount     |                                       1000 |
      | WeeklyRentalAmount  |                                       1000 |
      | BondReferenceNumber |                                   46385854 |
    And I select "01-09-1994" from "DateRaised"
    Then I select "Townhouse/Semi-Detached" from "DwellingType"
    Then I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Tenants" page
    And I click on button with value "<BMSType>"
    And I enter the details as
      | Fields               | Value           |
      | TransactionReference |      1234567890 |
      | Amount               |             200 |
      #| Date Refunded       | 15/12/2017      |
      | AccountName          | Harley E. Quinn |
      | BSBNumber            |          012345 |

    And I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Agent/Lessor" page
    And I click on button with value "Next"
    And I see text "Required fields have not been completed." displayed

    Examples: 
      | PortalName | email                   | Password   | Message                                  | BMSType   | RefundStatus     |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | PaidRadio | BMSNoRefundRadio |

  Scenario Outline: Unclaimed Bond has no Unclaimed refund record
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Lodge Bond"
    And I click on text "BMS Lodgement"
    Then I check I am on "BMS Bond Lodgement Premise" page
    And I click on button with value "UnclaimedRadioButton"
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields              | Value                                      |
      | OneLineAddress      | 217 Badger Creek Rd, Badger Creek VIC 3777 |
      | StreetNumber        |                                         14 |
      | StreetName          | Shorid                                     |
      | Suburb              | Murrumbeena                                |
      | Postcode            |                                       7777 |
      | NumberOfBedrooms    |                                         21 |
      | TotalBondAmount     |                                       1000 |
      | WeeklyRentalAmount  |                                       1000 |
      | BondReferenceNumber |                                   46385854 |
    And I select "01-09-1994" from "DateRaised"
    Then I select "Townhouse/Semi-Detached" from "DwellingType"
    Then I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Tenants" page
    And I click on button with value "<BMSType>"
    And I enter the details as
      | Fields               | Value           |
      | TransactionReference |      1234567890 |
      | Amount               |             200 |
      #| Date Refunded       | 15/12/2017      |
      | AccountName          | Harley E. Quinn |
      | BSBNumber            |          012345 |
      | AccountNumber        |       123456789 |

    And I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Agent/Lessor" page
    And I click on button with value "<RefundStatus>"
    And I click on button with value "Next"
    And I check I am on "BMS Bond Lodgement Summary" page
    And I see text "Refund status of ‘Unclaimed’ should be specified for either the Tenant or Agent/Lessor, please try again." displayed

    Examples: 
      | PortalName | email                   | Password   | Message                                  | BMSType   | RefundStatus     |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | PaidRadio | BMSNoRefundRadio |

  Scenario Outline: Unclaimed Bond has Unclaimed refund record
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Lodge Bond"
    And I click on text "BMS Lodgement"
    Then I check I am on "BMS Bond Lodgement Premise" page
    And I click on button with value "UnclaimedRadioButton"
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields              | Value                                      |
      | OneLineAddress      | 217 Badger Creek Rd, Badger Creek VIC 3777 |
      | StreetNumber        |                                         14 |
      | StreetName          | Shorid                                     |
      | Suburb              | Murrumbeena                                |
      | Postcode            |                                       7777 |
      | NumberOfBedrooms    |                                         21 |
      | TotalBondAmount     |                                       1000 |
      | WeeklyRentalAmount  |                                       1000 |
      | BondReferenceNumber |                                   46385854 |
    And I select "01-09-1994" from "DateRaised"
    Then I select "Townhouse/Semi-Detached" from "DwellingType"
    Then I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Tenants" page
    And I click on button with value "<BMSType>"
    And I enter the details as
      | Fields               | Value           |
      | TransactionReference |      1234567890 |
      | Amount               |             200 |
      #| Date Refunded       | 15/12/2017      |
      | AccountName          | Harley E. Quinn |
      | BSBNumber            |          012345 |
      | AccountNumber        |       123456789 |

    And I click on button with value "Next"
    Then I check I am on "BMS Bond Lodgement Agent/Lessor" page
    And I click on button with value "<RefundStatus>"
    And I click on button with value "Next"
    And I check I am on "BMS Bond Lodgement Summary" page
    And I click on button with value "confirmCheckbox"
    And I click on button with value "SUBMIT"
    And I click on button with value "BACT TO BONDS"
    And I check I am on "Manage Bonds" page

    Examples: 
      | PortalName | email                   | Password   | Message                                  | BMSType   | RefundStatus      |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | PaidRadio | BMSUnclaimedRadio |
      
      
  #    Feature: ARB-387: As an RBU Team Lead/Officer, I want to view a list of Bond Refund Requests so that I can process them

  Scenario Outline: RBU Team Leader/Officer is logged in to the portal
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I see text "Tasks" displayed
    And I click on text "Tasks"
    And I click on text "Refunds & Payments"

    Examples: 
      | PortalName | email                   | Password   | Message                                  |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. |

  Scenario Outline: Non RBU staff is logged in to the portal
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I see text "Tasks" not displayed

    Examples: 
      | PortalName | email            | Password   | Message                                  |
      | ARB        | lessor1@test.com | Support123 | Invalid login details. Please try again. |

  Scenario Outline: RBU Team Leader/Officer is logged in to the portal
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I see text "Tasks" displayed
    And I click on text "Tasks"
    And I click on text "Refunds & Payments"
    And I see text "Refund Raised" displayed
    And I see text "Refund Payments" displayed
    And I see text "Disputes" displayed

    Examples: 
      | PortalName | email                   | Password   | Message                                  |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. |

  Scenario Outline: RBU Team Leader/Officer is logged in to the portal
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I see text "Tasks" displayed
    And I click on text "Tasks"
    And I click on text "Refunds & Payments"
    And I click on text "Refund Raised"
    Then I click on button with value "Search"
    And I enter the details as
      | Fields      | Value    |
      | SearchInput | <BondId> |
    And I see text "<BondId>" displayed

    Examples: 
      | PortalName | email                   | Password   | Message                                  | BondId  |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | 1000210 |
      
      
      

#Feature: ARB-438: As an Agent Administrator/Property Manager/Lessor/RBU Team Leader/Officer, I want to capture the lodgement 'Type' so that it can be used for Land Tax reporting purposes

  Scenario Outline: Managing Agent is the party responsible for the bond
  Given I want to login to portal "<PortalName>"
  And I check I am on "Login" page
  And I enter the details as
  | Fields   | Value      |
  | Email    | <email>    |
  | Password | <Password> |
  And I hit Enter
  Then I click on text "Lodge Bond"
  And I see text "Please select" displayed
  Then I select "Residential" from "OccupancyType"
  
  Examples:
  | PortalName | email                | Password   | Message                                  |
  | ARB        | agentadmin2@test.com | Support123 | Invalid login details. Please try again. |
  
  Scenario Outline: User views the Lodgement Summary page
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
      | NumberOfBedrooms   |                                         21 |
      | TotalBondAmount    |                                       1000 |
      | WeeklyRentalAmount |                                       2000 |
    Then I select "Townhouse/Semi-Detached" from "DwellingType"
    Then I select "<OccType>" from "OccupancyType"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Parties" page
    And I enter the details as
      | Fields          | Value         |
      | TenantFirstName | TEST          |
      | TenantLastName  | TEST          |
      | TenantEmail     | TEST@TEST.com |
      | TenantPhone     |    1234567890 |
    Then I click on button "TenantFirstName"
    Then I click on button "TenantLastName"
    Then I click on button "TenantEmail"
    Then I click on button "TenantPhone"
    And I click on button "LessorRadio"
    And I enter the details as
      | Fields          | Value                                      |
      | LessorFirstName | TEST                                       |
      | LessorLastName  | TEST                                       |
      | LessorEmail     | TEST@TEST.com                              |
      | LessorPhone     |                                 1234567890 |
      | PostalAddress   | 217 Badger Creek Rd, Badger Creek VIC 3777 |
    Then I click on button with value "Next"
    And I check I am on "Bond Lodgement Summary" page
    And I see text "<OccType>" displayed

    Examples: 
      | PortalName | email                   | Password   | Message                                  | AgencyName  | OccType     |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | FirstAgency | Residential |
      

