
@all
Feature: WCAG Report generation

  Scenario Outline: Login page
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I capture "html"
    And I want to login to portal "<PortalName2>"
    And I click on text "Paste HTML Markup"
    And I click on button "checkpaste"
    And I paste "html"
    And I click on button "validate_paste"
    And I capture "AC_num_of_errors"
    Then I write "Login" information to file

    Examples: 
      | PortalName | PortalName2 | email                | Password   | Message                                  |
      | ARB        | AC CHECKER  | agentadmin2@test.com | Support123 | Invalid login details. Please try again. |

  Scenario Outline: Home page
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I wait for "2000" milliseconds
    And I check I am on "ManageBonds" page
    And I capture "html"
    And I want to login to portal "<PortalName2>"
    And I click on text "Paste HTML Markup"
    And I click on button "checkpaste"
    And I paste "html"
    And I click on button "validate_paste"
    And I capture "AC_num_of_errors"
    Then I write "Home Page" information to file

    Examples: 
      | PortalName | PortalName2 | email                | Password   | Message                                  |
      | ARB        | AC CHECKER  | agentadmin2@test.com | Support123 | Invalid login details. Please try again. |

  Scenario Outline: Sign Out page
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page
    Then I click on text "Sign Out"
    And I capture "html"
    And I want to login to portal "<PortalName2>"
    And I click on text "Paste HTML Markup"
    And I click on button "checkpaste"
    And I paste "html"
    Then I wait for "2000" milliseconds
    And I click on button "validate_paste"
    And I capture "AC_num_of_errors"
    Then I write "Sign Out" information to file

    Examples: 
      | PortalName | PortalName2 | email                | Password   | Message                                  |
      | ARB        | AC CHECKER  | agentadmin2@test.com | Support123 | Invalid login details. Please try again. |

  Scenario Outline: Forgot Password Page
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    Then I click on text "FORGOT PASSWORD?"
    Then I check I am on "Forgot Password" page
    And I capture "html"
    And I want to login to portal "<PortalName2>"
    And I click on text "Paste HTML Markup"
    And I click on button "checkpaste"
    And I paste "html"
    And I click on button "validate_paste"
    And I capture "AC_num_of_errors"
    Then I write "Forgot Password" information to file

    Examples: 
      | PortalName | PortalName2 | email                | Password   | Message                                  |
      | ARB        | AC CHECKER  | agentadmin2@test.com | Support123 | Invalid login details. Please try again. |

  Scenario Outline: Registration Lessor
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    Then I click on button with value "Create Account"
    Then I wait for "2000" milliseconds
    Then I click on button "select2-chosen-1"
    Then I click on object with xpath "//div[contains(text(), 'Lessor')]"
    Then I wait for "2000" milliseconds
    And I enter the details as
      | Fields                  | Value                               |
      | LessorFirstNameInput    | TEST                                |
      | LessorLastNameInput     | TEST                                |
      | LessorEmailAddressInput | TESadsfsadfafsdT@TEST.com           |
      | LessorPhoneNumberInput  |                          1231232313 |
      | LessorAddressInput      | 10 FLORA AVE, BADGER CREEK VIC 3777 |
    Then I click on button "AgreeTermsCheckbox"
    Then I click on button "FirstSectionNextLessor"
    Then I wait for "2000" milliseconds
    Then I see text "Enter bank details for bond refunds." displayed
    And I enter the details as
      | Fields                   | Value        |
      | RefundBSBInput           |    123213231 |
      | RefundAccountNumberInput |    123213312 |
      | RefundAccountNameInput   | 123132312123 |
    Then I click on button "BankDetailsNext"
    And I capture "html"
    And I want to login to portal "<PortalName2>"
    And I click on text "Paste HTML Markup"
    And I click on button "checkpaste"
    And I paste "html"
    And I click on button "validate_paste"
    And I capture "AC_num_of_errors"
    Then I write "Registration Lessor" information to file

    Examples: 
      | PortalName | PortalName2 | email                | Password   | Message                                  |
      | ARB        | AC CHECKER  | agentadmin2@test.com | Support123 | Invalid login details. Please try again. |

  Scenario Outline: Registration Managing Agent
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    Then I click on button with value "Create Account"
    Then I wait for "2000" milliseconds
    Then I click on button "select2-chosen-1"
    Then I click on object with xpath "//div[contains(text(), 'Managing Agent')]"
    Then I wait for "1000" milliseconds
    And I enter the details as
      | Fields                   | Value       |
      | ABNInput                 | 55005825516 |
      | AgencyLicenceNumberInput |   123454312 |
    Then I click on button "AgreeTermsCheckbox"
    Then I click on button "FirstSectionNextAgency"
    Then I wait for "3000" milliseconds
    And I enter the details as
      | Fields                  | Value                             |
      | AgencyPhoneNumberInput  |                        1234567890 |
      | AgencyEmailAddressInput | test@test.com                     |
      | AgencyAddressInput      | 10 FLORA GR, FOREST HILL VIC 3131 |
    Then I click on button "AgencyDetailsNext"
    And I wait for "2000" milliseconds
    Then I check "RefundBSBInput" exists
    And I capture "html"
    And I want to login to portal "<PortalName2>"
    And I click on text "Paste HTML Markup"
    And I click on button "checkpaste"
    And I paste "html"
    And I click on button "validate_paste"
    And I capture "AC_num_of_errors"
    Then I write "Registration Managing Agent" information to file

    Examples: 
      | PortalName | PortalName2 | email                | Password   | Message                                  |
      | ARB        | AC CHECKER  | agentadmin2@test.com | Support123 | Invalid login details. Please try again. |

  Scenario Outline: Reset Password
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I capture "html"
    And I want to login to portal "<PortalName2>"
    And I click on text "Paste HTML Markup"
    And I click on button "checkpaste"
    And I paste "html"
    And I click on button "validate_paste"
    And I capture "AC_num_of_errors"
    Then I write "Reset Password" information to file

    Examples: 
      | PortalName | PortalName2 | email                | Password   | Message                                  |
      | ARB        | AC CHECKER  | agentadmin2@test.com | Support123 | Invalid login details. Please try again. |


  Scenario Outline: Profile Details
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page
    Then I click on text "Agent Admin Two"
    Then I click on text "MY Profile"
    Then I check I am on "Profile Details" page
    And I capture "html"
    And I want to login to portal "<PortalName2>"
    And I click on text "Paste HTML Markup"
    And I click on button "checkpaste"
    And I paste "html"
    And I click on button "validate_paste"
    And I capture "AC_num_of_errors"
    Then I write "Profile Details" information to file

    Examples: 
      | PortalName | PortalName2 | email                | Password   | Message                                  |
      | ARB        | AC CHECKER  | agentadmin2@test.com | Support123 | Invalid login details. Please try again. |

  Scenario Outline: Agency Profile Details
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page
    Then I click on text "Agent Admin Two"
    Then I click on text "Agency Profile"
    Then I check I am on "Agency Profile" page
    And I capture "html"
    And I want to login to portal "<PortalName2>"
    And I click on text "Paste HTML Markup"
    And I click on button "checkpaste"
    And I paste "html"
    And I click on button "validate_paste"
    And I capture "AC_num_of_errors"
    Then I write "Agency Profile" information to file

    Examples: 
      | PortalName | PortalName2 | email                | Password   | Message                                  |
      | ARB        | AC CHECKER  | agentadmin2@test.com | Support123 | Invalid login details. Please try again. |


  Scenario Outline: Password Change
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page
    Then I click on text "Agent Admin Two"
    Then I click on text "Security"
    Then I check I am on "Change Password" page
    And I capture "html"
    And I want to login to portal "<PortalName2>"
    And I click on text "Paste HTML Markup"
    And I click on button "checkpaste"
    And I paste "html"
    And I click on button "validate_paste"
    And I capture "AC_num_of_errors"
    Then I write "Change Password (Profile)" information to file

    Examples: 
      | PortalName | PortalName2 | email                | Password   | Message                                  |
      | ARB        | AC CHECKER  | agentadmin2@test.com | Support123 | Invalid login details. Please try again. |


  Scenario Outline: Manage Users
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page
    Then I click on text "Manage Users"
    Then I check I am on "ManageUsers" page
    And I capture "html"
    And I want to login to portal "<PortalName2>"
    And I click on text "Paste HTML Markup"
    And I click on button "checkpaste"
    And I paste "html"
    And I click on button "validate_paste"
    Then I wait for "6000" milliseconds
    And I capture "AC_num_of_errors"
    Then I write "Manage Users" information to file

    Examples: 
      | PortalName | PortalName2 | email                | Password   | Message                                  |
      | ARB        | AC CHECKER  | agentadmin2@test.com | Support123 | Invalid login details. Please try again. |

 
  Scenario Outline: Lodge Bond Part 1
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
    And I capture "html"
    And I want to login to portal "<PortalName2>"
    And I click on text "Paste HTML Markup"
    And I click on button "checkpaste"
    And I paste "html"
    And I click on button "validate_paste"
    Then I wait for "6000" milliseconds
    And I capture "AC_num_of_errors"
    Then I write "Bond Lodgement Premise" information to file

    Examples: 
      | PortalName | PortalName2 | email                | Password   | Message                                  |
      | ARB        | AC CHECKER  | agentadmin2@test.com | Support123 | Invalid login details. Please try again. |

  @current
  Scenario Outline: Lodge Bond Part 2
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
    And I enter the details as
      | Fields             | Value                               |
      | OneLineAddress     | 10 FLORA AVE, BADGER CREEK VIC 3777 |
      | NumberOfBedrooms   |                                  11 |
      | TotalBondAmount    |                                 100 |
      | WeeklyRentalAmount |                                 100 |
    Then I select "Separated House" from "DwellingType"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Parties" page
    And I capture "html"
    And I want to login to portal "<PortalName2>"
    And I click on text "Paste HTML Markup"
    And I click on button "checkpaste"
    And I paste "html"
    And I click on button "validate_paste"
    Then I wait for "6000" milliseconds
    And I capture "AC_num_of_errors"
    Then I write "Bond Lodgement Parties" information to file

    Examples: 
      | PortalName | PortalName2 | email                | Password   | Message                                  |
      | ARB        | AC CHECKER  | agentadmin2@test.com | Support123 | Invalid login details. Please try again. |


  Scenario Outline: Lodge Bond Part 3
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
    And I enter the details as
      | Fields             | Value                               |
      | OneLineAddress     | 10 FLORA AVE, BADGER CREEK VIC 3777 |
      | NumberOfBedrooms   |                                  11 |
      | TotalBondAmount    |                                 100 |
      | WeeklyRentalAmount |                                 100 |
    Then I select "Separated House" from "DwellingType"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Parties" page
    And I enter the details as
      | Fields              | Value         |
      | TenantFirstName     | TEST          |
      | TenantLastName      | TEST          |
      | TenantEmail         | TEST@TEST.com |
      | TenantPhone         |    1234567890 |
      #| TenantAccountName   | TEST          |
      #| TenantBSB           |        123456 |
      #| TenantAcctNum       |        123456 |
      | LessorFirstName     | TEST          |
      | LessorLastName      | TEST          |
      | LessorEmail         | TEST@TeST.com |
      | LessorPhone         |    1234567890 |
      | AgencyName         |    1234567890 |
      #| LessorAccountName   | TEST          |
      #| LessorBSB           |        123456 |
      #| LessorAccountNumber |        123456 |
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Summary" page
    And I capture "html"
    And I want to login to portal "<PortalName2>"
    And I click on text "Paste HTML Markup"
    And I click on button "checkpaste"
    And I paste "html"
    And I click on button "validate_paste"
    Then I wait for "6000" milliseconds
    And I capture "AC_num_of_errors"
    Then I write "Bond Lodgement Summary" information to file

    Examples: 
      | PortalName | PortalName2 | email                | Password   | Message                                  |
      | ARB        | AC CHECKER  | agentadmin2@test.com | Support123 | Invalid login details. Please try again. |

  @wip
  Scenario Outline: Lodge Bond Part 4
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
    And I enter the details as
      | Fields             | Value                               |
      | OneLineAddress     | 10 FLORA AVE, BADGER CREEK VIC 3777 |
      | NumberOfBedrooms   |                                  11 |
      | TotalBondAmount    |                                 100 |
      | WeeklyRentalAmount |                                 100 |
    Then I select "Separated House" from "DwellingType"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Parties" page
    And I enter the details as
      | Fields              | Value         |
      | TenantFirstName     | TEST          |
      | TenantLastName      | TEST          |
      | TenantEmail         | TEST@TEST.com |
      | TenantPhone         |    1234567890 |
      #| TenantAccountName   | TEST          |
      #| TenantBSB           |        123456 |
      #| TenantAcctNum       |        123456 |
      | LessorFirstName     | TEST          |
      | LessorLastName      | TEST          |
      | LessorEmail         | TEST@TeST.com |
      | LessorPhone         |    1234567890 |
      | AgencyName         |    1234567890 |
      #| LessorAccountName   | TEST          |
      #| LessorBSB           |        123456 |
      #| LessorAccountNumber |        123456 |
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Summary" page
    Then I click on button "ConfirmCheck"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Confirmation" page
    And I capture "html"
    And I want to login to portal "<PortalName2>"
    And I click on text "Paste HTML Markup"
    And I click on button "checkpaste"
    And I paste "html"
    And I click on button "validate_paste"
    Then I wait for "6000" milliseconds
    And I capture "AC_num_of_errors"
    Then I write "Bond Lodgement Confirmation" information to file

    Examples: 
      | PortalName | PortalName2 | email                | Password   | Message                                  |
      | ARB        | AC CHECKER  | agentadmin2@test.com | Support123 | Invalid login details. Please try again. |

  @wip
  Scenario Outline: Lodge Bond Part 5
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
    And I enter the details as
      | Fields             | Value                               |
      | OneLineAddress     | 10 FLORA AVE, BADGER CREEK VIC 3777 |
      | NumberOfBedrooms   |                                  11 |
      | TotalBondAmount    |                                 100 |
      | WeeklyRentalAmount |                                 100 |
    Then I select "Separated House" from "DwellingType"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Parties" page
     And I enter the details as
      | Fields              | Value         |
      | TenantFirstName     | TEST          |
      | TenantLastName      | TEST          |
      | TenantEmail         | TEST@TEST.com |
      | TenantPhone         |    1234567890 |
      #| TenantAccountName   | TEST          |
      #| TenantBSB           |        123456 |
      #| TenantAcctNum       |        123456 |
      | LessorFirstName     | TEST          |
      | LessorLastName      | TEST          |
      | LessorEmail         | TEST@TeST.com |
      | LessorPhone         |    1234567890 |
      | AgencyName         |    1234567890 |
      #| LessorAccountName   | TEST          |
      #| LessorBSB           |        123456 |
      #| LessorAccountNumber |        123456 |
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Summary" page
    Then I click on button "ConfirmCheck"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Confirmation" page
    Then I click on button with value "View Payment Info"
    Then I wait for "3000" milliseconds
    Then I check I am on "Bond Payment View" page
    And I capture "html"
    And I want to login to portal "<PortalName2>"
    And I click on text "Paste HTML Markup"
    And I click on button "checkpaste"
    And I paste "html"
    And I click on button "validate_paste"
    Then I wait for "6000" milliseconds
    And I capture "AC_num_of_errors"
    Then I write "Bond Payment View" information to file

    Examples: 
      | PortalName | PortalName2 | email                | Password   | Message                                  |
      | ARB        | AC CHECKER  | agentadmin2@test.com | Support123 | Invalid login details. Please try again. |
#	    	    Given I want to login to portal "<PortalName>"
#	    And I check I am on "Login" page
#	     And I enter the details as
      #| Fields   | Value      |
      #| Email    | <email>    |
      #| Password | <Password> |
#	    And I hit Enter
#	    And I check I am on "ManageBonds" page
#	    Then I click on text "Lodge Bond"
#	    Then I check I am on "Bond Step 1" page
#	      And I enter the details as
      #| Fields   | Value      |
      #| OneLineAddress    | 10 FLORA AVE, BADGER CREEK VIC 3777   |
      #| NumberOfBedrooms | 11 |
     #	| TotalBondAmount | 100 |
     #	| WeeklyRentalAmount | 100 |
#	   Then I select "Separated House" from "DwellingType"
#	    And I capture "html"
#	    And I want to login to portal "<PortalName2>"
