@RB_Regression
Feature: Iteration 2 tests

  Scenario Outline: ARB-91: As an anonymous user E.g. Tenant who is not logged in, I want to search for a bond so that I can view details of this bond
    Given I want to login to portal "<PortalName>"
    #Scenario 1: User accesses the anonymous Search Bond function
    Then I see text "Please type the bond number and the last (family) name of any tenant listed on the bond." displayed
    Then I check "BondNumber2" exists
    Then I check "LastName3" exists
    Then I check "SearchButton" exists

    #Can't do the rest of this due to captcha...
    Examples: 
      | PortalName | email                   | Password   | Message                                  | email1       | email2          |
      | BondSearch | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | RBU@Test.com | 123arb@test.com |

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
    Then I wait for "2000" milliseconds
    Then I see text "details have been successfully updated." displayed

    Examples: 
      | PortalName | email                | Password   | Message                                  | email_test                      |
      | ARB        | agentadmin2@test.com | Support123 | Invalid login details. Please try again. | ron.coldebella@dbresults.com.au |

  Scenario Outline: ARB-123: As an RBU Team Leader, I want to create user accounts for RBU and ACT Housing Officers so that they can access the portal
    Given I want to login to portal "<PortalName>"
    And I wait for "4000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    #Scenario 1: RBU Team Leader accesses the Create User function
    Then I click on text "Manage Users"
    Then I click on text "+ NEW USER"
    Then I wait for "2000" milliseconds
    Then I switch to frame "0"
    Then I check "User_Role" exists
    Then I check "USER_EXTENSION_FirstName" exists
    Then I check "USER_EXTENSION_LastName" exists
    Then I check "User_Email" exists
    Then I check "User_ContactPhone" exists
    Then I see text "An activation email will be sent to the email address entered. Due to security reasons, this link will expire in 60 minutes." displayed
    #Scenario 2: Mandatory fields not filled in
    Then I click on button with value "Save"
    Then I see text "Required fields have not been completed" displayed
    Then I wait for "2000" milliseconds
    #Scenario 3: Email address not in the correct format
    Then I select "RBU Team Leader" from "Role"
    And I enter the details as
      | Fields       | Value       |
      | FirstName    | <FirstName> |
      | LastName     | <LastName>  |
      | ContactPhone |  1234567890 |
      | Email        | TEST        |
    Then I click on button with value "Save"
    Then I see text "Email address is not valid, please try again" displayed
    #Scenario 4: Email address already registered
    And I enter the details as
      | Fields    | Value       |
      | FirstName | <FirstName> |
      | LastName  | <LastName>  |
      | Phone     |  1234567890 |
      | Email     | <email>     |
    Then I click on button with value "Save"
    Then I see text "Email address is already registered, please try again" displayed
    Then I wait for "1000" milliseconds
    Then I click on button with value "Cancel"
    #Scenario 7: RBU Team Leader cancels user account creation with unsaved changes
    Then I wait for "2000" milliseconds
    Then I click on text "+ NEW USER"
    Then I wait for "2000" milliseconds
    Then I switch to frame "0"
    And I enter the details as
      | Fields       | Value         |
      | FirstName    | <FirstName>   |
      | LastName     | <LastName>    |
      | ContactPhone |    1234567890 |
      | Email        | TEST@TEST.com |
    Then I click on button with value "Cancel"
    Then I see "There are unsaved changes on this page. Do you wish to proceed?" displayed on popup and I click "Cancel"
    Then I wait for "1000" milliseconds
    Then I click on button with value "Cancel"
    Then I see "There are unsaved changes on this page. Do you wish to proceed?" displayed on popup and I click "OK"
    #Scenario 6: RBU Team Leader cancels user account creation with no unsaved changes
    Then I click on text "+ NEW USER"
    Then I wait for "2000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "Cancel"
    #USER_EMAIL MUST BE CHANGED EACH TIME
    #Scenario 5: RBU Team Leader successfully creates a new user
    Then I click on text "+ NEW USER"
    Then I wait for "2000" milliseconds
    Then I switch to frame "0"
    Then I select "RBU Team Leader" from "User_Role"
    And I enter the details as
      | Fields       | Value       |
      | FirstName    | <FirstName> |
      | LastName     | <LastName>  |
      | ContactPhone |  1234567890 |
    # | Email               | TEST17F@asdfasfdasdf.com |
    Then I enter "TEST@asdfsafd.com" with the current date prepended into "User_Email"
    Then I click on button with value "Save"
    Then I wait for "2000" milliseconds
    Then I see text "User TESTAGAINAGAIN TESTAGAINAGAIN successfully created" displayed

    Examples: 
      | PortalName | email                   | Password   | Message                                  | email_test                      | FirstName      | LastName       | UserEmail                |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | ron.coldebella@dbresults.com.au | TESTAGAINAGAIN | TESTAGAINAGAIN | TEST16F@asdfasfdasdf.com |

  Scenario Outline: ARB-139, ARB-137: As an RBU Team Leader, I want to reactivate a user within RBU or ACT Housing so that they can access the portal again
    Given I want to login to portal "<PortalName>"
    And I wait for "6000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Manage Users"
    Then I wait for "2000" milliseconds
    Then I check that table "UserListTable" with row containing "<email_test>" has the following
      | Fields | Value        |
      | item1  | Aaron        |
      | item1  | Able         |
      | item1  | <email_test> |
      | item1  | RBU Officer  |
      | item1  | Inactive     |
    #Scenario 3: RBU Team Leader does not confirm reactivation
    Then I click on text "<email_test>"
    Then I wait for "4000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I wait for "4000" milliseconds
    Then I click on button with value "Active"
    Then I click on button with value "Save"
    Then I wait for "4000" milliseconds
    Then I see text "Are you sure you want to reactivate this user?" displayed
    Then I click on button with value "No"
    Then I wait for "4000" milliseconds
    Then I click on button with value "Cancel"
    Then I check that table "UserListTable" with row containing "<email_test>" has the following
      | Fields | Value        |
      | item1  | Aaron        |
      | item1  | Able         |
      | item1  | <email_test> |
      | item1  | RBU Officer  |
      | item1  | Inactive     |
    #Scenario 1: RBU Team Leader reactivates user account
    Then I click on text "<email_test>"
    Then I wait for "4000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I wait for "4000" milliseconds
    Then I click on button with value "Active"
    Then I click on button with value "Save"
    Then I wait for "4000" milliseconds
    #
    Then I see text "Are you sure you want to reactivate this user?" displayed
    Then I click on button with value "Yes"
    Then I wait for "4000" milliseconds
    Then I see text "details have been successfully updated." displayed
    Then I check that table "UserListTable" with row containing "<email_test>" has the following
      | Fields | Value        |
      | item1  | Aaron        |
      | item1  | Able         |
      | item1  | <email_test> |
      | item1  | RBU Officer  |
      | item1  | Active       |
    #Scenario 2: RBU Team Leader confirms reactivation
    Then I click on text "Sign Out"
    Given I want to login to portal "<PortalName>"
    And I wait for "4000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I check I am on "ManageBonds" page
    Then I click on text "Sign Out"
    Given I want to login to portal "<PortalName>"
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Manage Users"
    Then I click on text "<email_test>"
    Then I wait for "4000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I wait for "4000" milliseconds
    Then I click on button with value "Inactive"
    Then I click on button with value "Save"
    Then I wait for "4000" milliseconds
    # now reactive the user again
    Then I see text "Are you sure you want to deactivate this user?" displayed
    Then I click on button with value "Yes"
    Then I wait for "4000" milliseconds
    Then I check that table "UserListTable" with row containing "<email_test>" has the following
      | Fields | Value        |
      | item1  | Aaron        |
      | item1  | Able         |
      | item1  | <email_test> |
      | item1  | RBU Officer  |
      | item1  | Inactive     |

    Examples: 
      | PortalName | email                   | Password   | Message                                  | email_test             |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | aaronable@golemico.com |

  Scenario Outline: ARB-165: As an RBU Team Leader, I want to resend the activation email so that the user can activate their account and login to the portal
    Given I want to login to portal "<PortalName>"
    And I wait for "4000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Manage Users"
    #Scenario 1: RBU Team Leader is viewing a user account where the status is not ‘Registered’
    Then I click on text "<email2>"
    Then I wait for "4000" milliseconds
    Then I switch to frame "0"
    Then I see text "RESEND ACTIVATION EMAIL" not displayed
    Then I click on button with value "EDIT"
    Then I wait for "4000" milliseconds
    Then I click on button with value "Cancel"
    #Scenario 2: RBU Team Leader is viewing a user account where the status is ‘Registered’
    Then I click on text "<emailRegistered>"
    Then I wait for "4000" milliseconds
    Then I switch to frame "0"
    Then I wait for "8000" milliseconds
    Then I see text "RESEND ACTIVATION EMAIL" displayed
    #Scenario 3: RBU re-sends activation email
    Then I click on text "RESEND ACTIVATION EMAIL"
    Then I wait for "4000" milliseconds
    Then I see text "The activation email has been sent." displayed

    Examples: 
      | PortalName | email                | Password   | Message                                  | email2                        | emailRegistered             |
      | ARB        | agentadmin2@test.com | Support123 | Invalid login details. Please try again. | pleasedonotuse@automation.com | nitin.paul@dbresults.com.au |

  @defect
  Scenario Outline: ARB-126
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Manage Users"
    And I wait for "4000" milliseconds
    Then I check that table "UserListTable" with row containing "<email_test>" has the following
      | Fields | Value                  |
      | item1  | Property Manager       |
      | item1  | <email_test>           |
      | item1  | 11111 Please donot use |
      | item1  | Active                 |
    #Scenario 3: RBU Team Leader does not confirm deactivation
    Then I click on text "<email_test>"
    Then I wait for "1000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I wait for "2000" milliseconds
    Then I click on button with value "Inactive"
    Then I click on button with value "Save"
    Then I wait for "2000" milliseconds
    Then I see text "Are you sure you want to deactivate this user?" displayed
    Then I click on button with value "No"
    Then I wait for "2000" milliseconds
    Then I click on button with value "Cancel"
    Then I wait for "1000" milliseconds
    Then I check that table "UserListTable" with row containing "<email_test>" has the following
      | Fields | Value                  |
      | item1  | Property Manager       |
      | item1  | <email_test>           |
      | item1  | 11111 Please donot use |
      | item1  | Active                 |
    #Scenario 1: RBU Team Leader deactivates user account
    Then I click on text "<email_test>"
    Then I wait for "2000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I wait for "2000" milliseconds
    Then I click on button with value "Inactive"
    Then I click on button with value "Save"
    Then I wait for "2000" milliseconds
    #
    Then I see text "Are you sure you want to deactivate this user?" displayed
    Then I click on button with value "Yes"
    Then I wait for "4000" milliseconds
    Then I check that table "UserListTable" with row containing "<email_test>" has the following
      | Fields | Value                  |
      | item1  | Property Manager       |
      | item1  | <email_test>           |
      | item1  | 11111 Please donot use |
      | item1  | Inactive               |
    #Scenario 2: RBU Team Leader confirms deactivation
    Then I click on text "Sign Out"
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value        |
      | Email    | <email_test> |
      | Password | <Password>   |
    And I hit Enter
    Then I see text "Your email address or password is incorrect, please try again." displayed
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Manage Users"
    Then I click on text "<email_test>"
    Then I wait for "2000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I wait for "2000" milliseconds
    Then I click on button with value "Active"
    Then I click on button with value "Save"
    Then I wait for "2000" milliseconds
    # now reactive the user again
    Then I see text "Are you sure you want to reactivate this user?" displayed
    Then I click on button with value "Yes"
    Then I wait for "4000" milliseconds
    Then I check that table "UserListTable" with row containing "<email_test>" has the following
      | Fields | Value                  |
      | item1  | Property Manager       |
      | item1  | <email_test>           |
      | item1  | 11111 Please donot use |
      | item1  | Active                 |

    Examples: 
      | PortalName | email                | Password   | Message                                  | email_test                    |
      | ARB        | agentadmin2@test.com | Support123 | Invalid login details. Please try again. | pleasedonotuse@automation.com |

  Scenario Outline: ARB-267, As an Agent Administrator/Property Manager/Lessor, I want to add multiple tenants on a Bond Lodgement form so that all parties contributing to the Bond are captured
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
    #Scenario #2 Invalid email
    And I enter the details as
      | Fields          | Value           |
      | TenantFirstName | TenantFirstName |
      | TenantLastName  | TenantLastName  |
      | TenantEmail     | TenantEmail@    |
      | TenantPhone     |      1234567890 |
    Then I see text "Please enter a valid email address." displayed
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
    Then I click on text "ADD TENANT"
    And I wait for "1000" milliseconds
    Then I click on button with value "Next"
    And I wait for "1000" milliseconds
    Then I see text "Required fields have not been completed." displayed

    Examples: 
      | PortalName | email                | Password   | Message                                  | email_test             |
      | ARB        | agentadmin2@test.com | Support123 | Invalid login details. Please try again. | honesurevo@mystvpn.com |
      | ARB        | lessor2@test.com     | Support123 | Invalid login details. Please try again. | honesurevo@mystvpn.com |

  Scenario Outline: ARB-94: As an RBU Team Leader/Officer, I want to add comments to a bond
    #Scenario 1 - RBU Team Leader/Officer adds a comment to an exisiting bond
    Given I want to login to portal "<PortalName>"
    And I wait for "4000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on button with value "Search"
    And I enter the details as
      | Fields      | Value    |
      | SearchInput | <BondId> |
    And I hit Enter
    Then I wait for "2000" milliseconds
    #Then I click on button "BondsTable TableRecords_OddLine PremiseClass"....remove it later
    And I click on text "<BondId>"
    Then I wait for "2000" milliseconds
    Then I click on text "+ ADD COMMENT"
    Then I wait for "6000" milliseconds
    And I enter the details as
      | Fields       | Value                   |
      | CommentInput | This is a test comment! |
    Then I click on text "SAVE"
    Then I wait for "1000" milliseconds
    Then I see text "This is a test comment!" displayed
    #Scenario 2: Non RBU User views a Bond
    Then I click on text "Sign Out"
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email2>   |
      | Password | <Password> |
    And I hit Enter
    Then I click on button with value "Search"
    And I enter the details as
      | Fields      | Value    |
      | SearchInput | <BondId> |
    And I hit Enter
    #Then I click on button "BondsTable TableRecords_OddLine PremiseClass"
    And I wait for "2000" milliseconds
    Then I "click" text "1" displayed in table "MainContent"
    Then I wait for "2000" milliseconds
    Then I see text "This is a test comment!" not displayed
    Then I see text "+ ADD COMMENT" not displayed

    Examples: 
      | PortalName | email                   | email2               | Password   | Message                                  | email_test                      | BondId  |
      | ARB        | rbuteamleader1@test.com | agentadmin2@test.com | Support123 | Invalid login details. Please try again. | ron.coldebella@dbresults.com.au | 1000125 |

  Scenario Outline: ARB-114: As a Logged in user, I want to view a bond history Audit trail which have occurred on a bond so that I can best manage this bond.
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on button with value "Search"
    And I enter the details as
      | Fields      | Value    |
      | SearchInput | <BondId> |
    And I hit Enter
    Then I "click" text "1" displayed in table "MainContent"
    Then I click on text "HISTORY"
    And I wait for "1000" milliseconds
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value |
      | item1  | Name |
      | item1  | Role  |
      | item1  | Date  |
    And I wait for "2000" milliseconds
    Then I check that table "BondHistoryListTable" with row containing "<Name>" has the following
      | Fields | Value               |
      | item1  | Bond Raised         |
      | item1  | <Name>              |
      | item1  | Agent Administrator |
      | item1  | 23/08/17 15:46      |

    Examples: 
      | PortalName | email                | Password   | Message                                  | BondId  | Name            |
      | ARB        | agentadmin2@test.com | Support123 | Invalid login details. Please try again. | 1000125 | Agent Admin Two |

  Scenario Outline: ARB-97: As an Agent Administrator/Property Manager/Lessor/RBU Team Leader/RBU Officer, I want to select the Bond/s I want to pay so that I can pay them in one payment transaction.
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
      | Section          |                                  12 |
      | Block            |                                  10 |
      | NumberOfBedrooms |                                  13 |
    Then I select "Separated House" from "DwellingType"
    And I select "Residential" from "OccupancyType"
    And I enter the details as
      | Fields             | Value |
      | TotalBondAmount    |   400 |
      | WeeklyRentalAmount |   400 |
    And I select "Residential" from "OccupancyType"
    Then I click on button with value "Next"
    #ARB-574
    And I wait for "1000" milliseconds
    # Then I see text "SSBU entered is not valid, please try again." displayed
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value                                        |
      | item1  | SSBU entered is not valid, please try again. |
    #enter valid canberra address
    And I enter the details as
      | Fields         | Value                               |
      | OneLineAddress | 10 FLORA AVE, BADGER CREEK VIC 3777 |
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
    And I select "Residential" from "OccupancyType"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Parties" page
    And I enter the details as
      | Fields          | Value                               |
      | TenantFirstName | TenantFirstName                     |
      | TenantLastName  | TenantLastName                      |
      | TenantEmail     | TenantEmail@TEST.com                |
      | TenantPhone     |                          1234567890 |
      | LessorFirstName | LessorFirstName                     |
      | LessorLastName  | LessorLastName                      |
      | LessorEmail     | LessorEmail@TeST.com                |
      | LessorPhone     |                          0987654321 |
      | PostalAddress   | 10 FLORA AVE, BADGER CREEK VIC 3777 |
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Summary" page
    Then I click on button with value "Submit"
    And I wait for "1000" milliseconds
    Then I see text "Please confirm your bond details are correct." displayed
    Then I click on button "ConfirmCheck"
    Then I click on button with value "Submit"
    Then I check I am on "Bond Lodgement Confirmation" page
    # this will capture the bond id
    And I capture "You have successfully raised Bond"
    Then I click on text "BACK TO BONDS"
    Then I check I am on "ManageBonds" page
    Then I click on button with value "Search"
    And I paste "BondID" value in "SearchInput"
    And I hit Enter
    Then I check I am on "ManageBonds" page
    Then I "check" text "Raised" displayed in table "wtBondsList"
    #Then I "click" text "CheckBox" displayed in table "wtBondsList"
    And I take a "click" of "1" element of row "1" from the table "BondsList"
    #Scenario 1
    And I wait for "2000" milliseconds
    Then I click on button with value "View Payment Info"
    And I wait for "2000" milliseconds
    Then I check I am on "Bond Payment View" page
    #to do check where the values are coming from and add in as a check
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value            |
      | item1  | Reference Code   |
      | item2  | Account Name     |
      | item3  | ACT Rental Bonds |
      | item4  | BSB              |
      | item5  | Account Number   |
      | item6  | ACT Rental Bonds |
      | item7  | Direct Deposit   |
    Then I click on button with value "Cancel"
    #Scenario 4
    Then I check I am on "ManageBonds" page
    Then I "check" text "Raised" displayed in table "wtBondsList"
    #Then I "click" text "CheckBox" displayed in table "wtBondsList"
     And I take a "click" of "1" element of row "2" from the table "BondsList"
    And I wait for "2000" milliseconds
    Then I click on button with value "View Payment Info"
    And I wait for "2000" milliseconds
    Then I check I am on "Bond Payment View" page
    #to do check where the values are coming from and add in as a check
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value            |
      | item1  | Reference Code   |
      | item2  | Account Name     |
      | item3  | ACT Rental Bonds |
      | item4  | BSB              |
      | item5  | Account Number   |
      | item6  | ACT Rental Bonds |
      | item7  | Direct Deposit   |
    Then I click on button with value "Submit"
    And I wait for "2000" milliseconds
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value                    |
      | item1  | Raised - Payment Pending |

    Examples: 
      | PortalName | email                | Password   | Message                                  | BondId  | Name            |
      | ARB        | agentadmin2@test.com | Support123 | Invalid login details. Please try again. | 1000125 | Agent Admin Two |
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
      | Fields             | Value  |
      | StreetNumber       |     13 |
      | StreetName         | Shori  |
      | Suburb             | Kaleen |
      | Postcode           |   1111 |
      | Section            |      13 |
      | Block              |     1 |
      | NumberOfBedrooms   |      3 |
      | TotalBondAmount    |    400 |
      | WeeklyRentalAmount |    400 |
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
    Then I click on button with value "Submit"
    And I wait for "1000" milliseconds
    Then I see text "Please confirm your bond details are correct." displayed
    Then I click on button "ConfirmCheck"
    Then I click on button with value "Submit"
    Then I check I am on "Bond Lodgement Confirmation" page
    #Scenario 1
    Then I click on button with value "View Payment Details"
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
  Then I click on button with value "View Payment Details"
    And I wait for "2000" milliseconds
    Then I check I am on "Bond Payment View" page
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value          |
      | item1  | BACK TO BONDS  |
      | item2  | Reference Code |
      | item4  | BSB            |
      | item5  | Account Number |
    Then I click on button with value "Submit"
    And I wait for "2000" milliseconds
    #Then I see text "The status of your Bond/s has been changed to 'Raised-Pending Payment'." displayed

    Examples: 
      | PortalName | email                | Password   | Message                                  | Name            | LessorFirstName | LessorLastName | LessorEmail          | LessorPhone | PostalAddress                       |
      | ARB        | agentadmin2@test.com | Support123 | Invalid login details. Please try again. | Agent Admin Two | LessorFirstName | LessorLastName | LessorEmail@TeST.com |  0987654321 | 10 FLORA AVE, BADGER CREEK VIC 3777 |

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
      | TenantPhone     |           0298789763 |
      | TenantEmail     | TenantEmail@TEST.com |
    Then I click on button with value "Next"
    And I wait for "2000" milliseconds
    #Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Summary" page
    Then I click on button with value "Submit"
    And I wait for "1000" milliseconds
    Then I see text "Please confirm your bond details are correct." displayed
    Then I click on button "ConfirmCheck"
    Then I click on button with value "Submit"
    Then I check I am on "Bond Lodgement Confirmation" page
    #Scenario 1
     Then I click on button with value "View Payment Details"
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
    And I wait for "1000" milliseconds
  Then I click on button with value "View Payment Details"
    Then I check I am on "Bond Payment View" page
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value          |
      | item1  | BACK TO BONDS  |
      | item2  | Reference Code |
      | item4  | BSB            |
      | item5  | Account Number |
    Then I click on button with value "Submit"
    And I wait for "2000" milliseconds
  #  Then I see text "The status of your Bond/s has been changed to" displayed

    Examples: 
      | PortalName | email            | Password   | Message                                  | Name |
      | ARB        | lessor2@test.com | Support123 | Invalid login details. Please try again. | Agen |

  

  Scenario Outline: ARB-124, As an RBU Team Leader, I want to view a list of users within the RBU and ACT Housing so that I know who can access the portal
    #Scenario 1,2
    Given I want to login to portal "<PortalName>"
    And I wait for "6000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I check I am on "ManageBonds" page
    Then I click on text "Manage Users"
    Then I check I am on "ManageUsers" page
    Then I check that table "UserListTable" with row containing "<Email>" has the following
      | Fields | Value       |
      | item1  |         123 |
      | item1  | RBU Officer |
    Then I "click" text "<Email>" displayed in table "UserListTable"
    And I see popup "MainContent" displayed
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value         |
      | item1  | Role          |
      | item1  | First Name    |
      | item1  | Last Name     |
      | item1  | Email Address |
      | item1  | Status        |
    #Scenario 3
    And I click on button "close"
    Then I check I am on "ManageUsers" page

    Examples: 
      | PortalName | email                   | Password   | Email           |
      | ARB        | rbuteamleader1@test.com | Support123 | 123arb@test.com |

  #################################################################################################################################
  #################################################################################################################################
  ########## ITERATION 3 ##################
  #################################################################################################################################
  #################################################################################################################################
  Scenario Outline: ARB-16, As an RBU Team Leader/Officer, I want to complete a Bond Lodgement form on the portal
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
    Then I click on text "Lodgement"
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
      | Fields | Value                          |
      | item1  | <SelectValue1>                 |
      | item2  | <SelectValue2>                 |
      | item3  | LessorFirstName LessorLastName |
      | item5  | LessorEmail@TEST.com           |
    Then I click on text "I confirm that these details are correct at the time of lodgement"
    And I click on button with value "Submit"
    And I wait for "1000" milliseconds
    Then I see text "Lodgement Complete" displayed
    # capture bond ID to check bond status and then submit it
     And I capture "You have successfully raised Bond"
    Then I click on text "BACK TO BONDS"
    Then I check I am on "ManageBonds" page
    Then I click on button with value "Search"
    # ARB-335,ARB-79 search bond
    And I paste "BondID" value in "SearchInput"
    And I hit Enter
    Then I check I am on "ManageBonds" page
    Then I "check" text "Raised" displayed in table "wtBondsList"
    Then I "click" text "CheckBox" displayed in table "wtBondsList"
    And I wait for "1000" milliseconds
    And I click on button with value "View Payment Info"
    Then I check I am on "Bond Payment View" page
    # check only correct responsible party is displayed
    Then I see text "RESEND ACTIVATION EMAIL" not displayed
    # submitting the bond
    Then I click on button with value "Submit"
    And I wait for "2000" milliseconds
    Then I see text "The status of your Bond/s has been changed to" displayed

    Examples: 
      | PortalName | email                         | Password   | Message                                  | email_test             | Responsible_Party  | TextOnSelection        | SelectValue1     | Dropdown1      | SelectValue2 | Dropdown2 |
      | ARB        | backofficeteamleader@test.com | Support123 | Invalid login details. Please try again. | honesurevo@mystvpn.com | ManagingAgentRadio | Managing Agent Details | DOG & CO PTY LTD | AgencyNameDrop | Agency Admin | AgentDrop |
      | ARB        | backofficeteamleader@test.com | Support123 | Invalid login details. Please try again. | honesurevo@mystvpn.com | LessorRadio        | Responsible Party      |                  |                |              |           |
 
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

  Scenario Outline: ARB-38,As an RBU Team Leader/Officer, I want to Approve a Refund Request so the Bond can be refunded to the nominated parties
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
      # | item4  | Claims          |
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
      | Fields | Value  |
      | item1  | XXXXXX |
    And I click on text "EDIT DETAILS"
    And I wait for "1000" milliseconds
    And I see popup "MainContent" displayed
    Then I switch to frame "0"
    #Scenario 2: Fields should be editable
    And I enter popup values as
      | Fields        | Value       |
      | AccountNumber |      123654 |
      | AccountNumber |   123123123 |
      | AccountName   | OneTwoThree |
    Then I click on button with value "Cancel"
    And I click on text "EDIT DETAILS"
    And I wait for "1000" milliseconds
    And I see popup "MainContent" displayed
    Then I switch to frame "0"
    #Scenario 3: hitting submit
    And I enter popup values as
      | Fields        | Value                    |
      | AccountNumber |                   123654 |
      | AccountNumber |                123123123 |
      | AccountName   | OneTwoThree              |
      | Phone         | <PhoneNumberToBeUpdated> |
    Then I click on button with value "Save"
    Then I check I am on "ApproveRefundRequest" page
    Then I see text "<PhoneNumberToBeUpdated>" displayed
    #Scenario:5
    Then I click on button with value "Approve Refund"
    And I see popup "MainContent" displayed
    And I wait for "2000" milliseconds
    Then I switch to frame "0"
    Then I see text "Are you sure to approve this refund?" displayed
    And I click on "Yes" on popup
    #  Then I click on button with value "Yes"
    And I wait for "1000" milliseconds
    Then I see text "Refund successfully approved." displayed
    Then I check I am on "TaskList" page

    Examples: 
      | PortalName | email                           | Password   | email_2                 | BondId  | PhoneNumberToBeUpdated |
      | ARB        | backoffice_rbuofficer@gmail.com | Support123 | rbuteamleader1@test.com | 1000088 |             0398100609 |

  Scenario Outline: ARB-387, As an RBU Team Lead/Officer, I want to view a list of Bond Refund Requests so that I can process them
    # this test is to be preceded by the setup,
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
      | item5  | Bond No.        |
      | item6  | Date Requested  |
      | item6  | Requested By    |
      | item6  | Amount          |
    And I click on text "Refund Payments"
    And I wait for "1000" milliseconds
    And I take a "capture" of row "2" from the table "RefundPaymentsTable"
    #Scenario 3
    Then I click on button with value "Search"
    And I paste "BondID" value in "SearchInput"
    And I hit Enter
    Then I see text "$" displayed
    And I hit Enter

    Examples: 
      | PortalName | email                | Password   | email_2                 |
      | ARB        | agentadmin2@test.com | Support123 | rbuteamleader1@test.com |

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
    # Then I "click" text "selectTheFirstRow" displayed in table "Bonds"
    #remove following once JL fixes the thing on row click
    Then I "click" text "selectTheFirstRow" displayed in table "BondsList"
    #The RBU Team Leader/Officer successfully updates the status of a Bond from 'Raised' to 'Cancelled'
    # following is to go to "..." till and id is provided.
    And I wait for "1000" milliseconds
    Then I check I am on "Bond Detail" page
    Then I click on button "fa fa-fw fa-ellipsis-h fa-2x"
    And I wait for "2000" milliseconds
    Then I click on text "CANCEL BOND"
    And I wait for "2000" milliseconds
    Then I switch to frame "0"
    #Scenario :3
    Then I click on button with value "No"
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
    Then I click on button with value "Submit"
    And I wait for "1000" milliseconds
    #Then I see text "Please confirm your bond details are correct." displayed
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value                                         |
      | item1  | Please confirm your bond details are correct. |
    Then I click on button "ConfirmCheck"
    Then I click on button with value "Submit"
    Then I check I am on "Bond Lodgement Confirmation" page
    And I capture "You have successfully lodged your Bond"
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
    Then I click on button with value "View Payment Info"
    And I wait for "2000" milliseconds
    Then I check I am on "Bond Payment View" page
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value          |
      | item1  | BACK TO BONDS  |
      | item2  | Reference Code |
      | item4  | BSB            |
      | item5  | Account Number |
    Then I click on button with value "Submit"
    And I wait for "2000" milliseconds
    And I paste "BondID" value in "SearchInput"
    And I hit Enter
    And I wait for "1000" milliseconds
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value                    |
      | item1  | Raised - Payment Pending |

    Examples: 
      | PortalName | email                | Password   | Message                                  | Name            | LessorFirstName | LessorLastName | LessorEmail          | LessorPhone | PostalAddress                       |
      | ARB        | agentadmin2@test.com | Support123 | Invalid login details. Please try again. | Agent Admin Two | LessorFirstName | LessorLastName | LessorEmail@TeST.com |  0987654321 | 10 FLORA AVE, BADGER CREEK VIC 3777 |

  Scenario Outline: ARB-434  :	As an RBU Team Leader/Officer, I want to view a list of Bonds that are in dispute so that I know which ones are awaiting resolution
    #Scenario :1 RBU officer should not be able to access "Refunds Payments"
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
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
      | item6  | Sign Out           |
    # because currently only RBU lead can acces Manage users
    Then I see text "Manage Users" not displayed
    Then I click on text "Refunds & Payments"
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value          |
      | item1  | Refunds Raised |
      | item3  | Disputes       |
      | item5  | Bond No.       |
      | item6  | Date Requested |
      | item5  | Manage Users   |
      | item6  | Requested By   |
      | item6  | Amount         |
    Then I click on text "Disputes"
    And I wait for "2000" milliseconds
    And I take a "capture" of row "1" from the table "DisputesTable"
    #Scenario 3
    Then I click on button with value "Search"
    And I paste "BondID" value in "SearchInput"
    And I hit Enter
    #TO add search by ACAT number....currently at defect
    And I take a "capture" of "3" element of row "1" from the table "DisputesTable"
    #Scenario 4
    And I clear "SearchInput" of content
    And I paste "ACAT_ORDER_NO" value in "SearchInput"

    Examples: 
      | PortalName | Password   | email                   |
      | ARB        | Support123 | rbuteamleader1@test.com |

  Scenario Outline: ARB-21, As an RBU Team Leader/Officer, I want to fill in a Claim for Unclaimed Bond form on the portal, from a hardcopy of the form
    # as this is other half f CSV upload so existing data will be used
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Manage Bonds"
    And I wait for "1000" milliseconds
    Then I click on text "UNCLAIMED"
    And I wait for "1000" milliseconds
    And I take a "click" of row "5" from the table "MainContent"
    # following is to go to "..." till and id is provided.
    And I wait for "1000" milliseconds
    # ask JL to provide id for ...
    Then I click on button "ARB_Patterns_wt239_block_wtMainContent_CloneOfWebPatterns_wt378_block_wtText"
    And I wait for "1000" milliseconds
    Then I click on text "CLAIM BOND"
    Then I check I am on "ClaimBond" page
    Then I click on button with value "Submit Claim"
    Then I see text "Please select a transaction to Submit Claim." displayed
    And I take a "click" of row "1" from the table "TableRecords"
    And I take a "click" of "1" element of row "1" from the table "TableRecords"
    Then I click on button with value "Submit Claim"
    And I wait for "1000" milliseconds
    Then I see text "Bond Claim Submitted" displayed

    Examples: 
      | PortalName | email                         | Password   | Message                                  | email_test             | Responsible_Party  | TextOnSelection        | SelectValue1     | Dropdown1      | SelectValue2 | Dropdown2 |
      | ARB        | backofficeteamleader@test.com | Support123 | Invalid login details. Please try again. | honesurevo@mystvpn.com | ManagingAgentRadio | Managing Agent Details | DOG & CO PTY LTD | AgencyNameDrop | Agency Admin | AgentDrop |

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
    #Scenario:2
    Then I see text "BSB Number" not displayed
    Then I see text "Account Number" not displayed
    Then I click on text "Back"
    Then I check I am on "BMS Bond Lodgement Premise" page
    Then I click on text "Unclaimed"
    Then I click on button with value "Next"
    Then I check I am on "Historical Bond Tenants" page
    #Scenario:2, Condition1, if Unclaimed is selected, bank details should be visible
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value               |
      | item1  | BSB Number          |
      | item2  | Account Number      |
      | item2  | Account Holder Name |
    #Scenario:3
    Then I click on button with value "Next"
    And I wait for "1000" milliseconds
    #defect 579, enable following step once fixed
    # Then I see text "Required fields have not been completed." displayed
    #Scenario :4
    Then I select "DB RESULTS PTY LTD" from "AgencyNameDrop"
    And I wait for "500" milliseconds
    Then I select "ujaad singh" from "AgentDrop"
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

  Scenario Outline: ARB-190: RBU Team Leader/Officer I want to view the Dispute Request for a bond
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
    #Scenario:1
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value              |
      | item1  | Refunds & Payments |
      | item2  | Reconciliation     |
      | item3  | Manage Bonds       |
      | item4  | Lodge Bond         |
      | item5  | Manage Users       |
      | item6  | Sign Out           |
    Then I click on text "Refunds & Payments"
    Then I check I am on "TaskList" page
    Then I click on text "Disputes"
    And I wait for "1000" milliseconds
    And I click on text "Acat Order No."
    And I wait for "1000" milliseconds
    And I take a "click" of "2" element of row "6" from the table "DisputesTable"
    Then I check I am on "DisputeRefundRequest" page
    Then I click on button with value "Back"
    Then I check I am on "TaskList" page
    #Scenario:2
    Then I click on text "Disputes"
    And I wait for "1000" milliseconds
    And I take a "click" of "2" element of row "2" from the table "DisputesTable"
    Then I check I am on "DisputeRefundRequest" page
    And I click on text "+ ADD ACAT ORDER NUMBER"
    Then I check I am on "DisputeRefundRequest" page
    And I enter " " with the current date prepended into "DATE"
    And I click on button with value "resolve"
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value                   |
      | item1  | This field is required. |
    #Scenario:3
    And I enter the details as
      | Fields            | Value                                 |
      | ACAT_ORDER_NUMBER | 12 DO NOT RESOLVE USED FOR AUTO TESTS |

    #ToDo not implemented yet as id needs to be provided also if saved, can not be used again
    #Then I click on text "SAVE"
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
      # | OneLineAddress     | 10 FLORA AVE, BADGER CREEK VIC 3777 |
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

      | PortalName | email            | Password   | Message                                  | email_test             | DoIExist2                                                                     | Responsible_Party | TextOnSelection   | DoIExist1 |
      | ARB        | lessor2@test.com | Support123 | Invalid login details. Please try again. | honesurevo@mystvpn.com | wtMainContent_CloneOfWebPatterns_wt378_block_wtLabel | LessorRadio       | Responsible Party |           |
      
