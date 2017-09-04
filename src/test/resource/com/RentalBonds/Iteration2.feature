@RB_Regression
Feature: Iteration 2 tests

  #DONE: 91, 122, 123, 125, 126, 139, 165,
  #CANNOT DO: 121,
  #DONE: ARB-333
  
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
    Then I wait for "4000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I click on button with value "Cancel"
    Then I click on text "ron.coldebella@dbresults.com.au"
    Then I wait for "4000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I select "Agent Administrator" from "User_Role"
    Then I click on button with value "Save"
    Then I click on text "ron.coldebella@dbresults.com.au"
    Then I wait for "4000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I select "Property Manager" from "User_Role"
    Then I click on button with value "Save"
    Then I see text "Ron Coldebella's details have been successfully updated." displayed

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
    #Scenario 3: Email address not in the correct format
    Then I select "RBU Team Leader" from "Role"
    And I enter the details as
      | Fields                   | Value       |
      | USER_EXTENSION_FirstName | <FirstName> |
      | USER_EXTENSION_LastName  | <LastName>  |
      | User_ContactPhone        |  1234567890 |
      | User_Email               | TEST        |
    Then I click on button with value "Save"
    Then I see text "Email address is not valid, please try again" displayed
    #Scenario 4: Email address already registered
    And I enter the details as
      | Fields                   | Value       |
      | USER_EXTENSION_FirstName | <FirstName> |
      | USER_EXTENSION_LastName  | <LastName>  |
      | User_ContactPhone        |  1234567890 |
      | User_Email               | <email>     |
    Then I click on button with value "Save"
    Then I see text "Email address is already registered, please try again" displayed
    Then I click on button with value "Cancel"
    #Scenario 7: RBU Team Leader cancels user account creation with unsaved changes
    Then I wait for "2000" milliseconds
    Then I click on text "+ NEW USER"
    Then I wait for "2000" milliseconds
    Then I switch to frame "0"
    And I enter the details as
      | Fields                   | Value         |
      | USER_EXTENSION_FirstName | <FirstName>   |
      | USER_EXTENSION_LastName  | <LastName>    |
      | User_ContactPhone        |    1234567890 |
      | User_Email               | TEST@TEST.com |
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
      | Fields                   | Value       |
      | USER_EXTENSION_FirstName | <FirstName> |
      | USER_EXTENSION_LastName  | <LastName>  |
      | User_ContactPhone        |  1234567890 |
    # | User_Email               | TEST17F@asdfasfdasdf.com |
    Then I enter "TEST@asdfsafd.com" with the current date prepended into "User_Email"
    Then I click on button with value "Save"
    Then I wait for "2000" milliseconds
    Then I see text "User TESTAGAINAGAIN TESTAGAINAGAIN successfully created" displayed

    Examples: 
      | PortalName | email                   | Password   | Message                                  | email_test                      | FirstName      | LastName       | UserEmail                |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | ron.coldebella@dbresults.com.au | TESTAGAINAGAIN | TESTAGAINAGAIN | TEST16F@asdfasfdasdf.com |

  Scenario Outline: ARB-125: As an RBU Team Leader, I want to deactivate a user within RBU or ACT Housing so that they can no longer access the portal
    #Scenario 1: RBU Team Leader accesses the edit user account function from the Manage Users page
    Given I want to login to portal "<PortalName>"
    And I wait for "4000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Manage Users"
    Then I click on text "123arb@test.com"
    And I wait for "4000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    And I wait for "4000" milliseconds
    Then I check "User_Role" exists
    Then I check "USER_EXTENSION_FirstName" is readonly
    Then I check "USER_EXTENSION_LastName" is readonly
    Then I check "User_Email" is readonly
    Then I check "User_ContactPhone" is readonly
    #Scenario 4: RBU Team Leader cancels user account creation with no unsaved changes
    Then I click on button with value "Cancel"
    Then I check I am on "ManageUsers" page
    #Scenario 5: RBU Team Leader cancels user account creation with unsaved changes
    Then I click on text "123arb@test.com"
    And I wait for "4000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I select "RBU Officer" from "User_Role"
    Then I click on button with value "Cancel"
    Then I see "There are unsaved changes on this page. Do you wish to proceed?" displayed on popup and I click "Cancel"
    Then I click on button with value "Cancel"
    Then I see "There are unsaved changes on this page. Do you wish to proceed?" displayed on popup and I click "OK"
    #Scenario 3: RBU Team Leader updates a user’s role
    Then I click on text "123arb@test.com"
    And I wait for "4000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I select "RBU Team Leader" from "User_Role"
    Then I click on button with value "Save"
    Then I click on text "123arb@test.com"
    And I wait for "4000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I select "RBU Team Leader" from "User_Role"
    Then I click on button with value "Save"

    Examples: 
      | PortalName | email                   | Password   | Message                                  | email_test      |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | 123arb@test.com |

  Scenario Outline: ARB-139: As an RBU Team Leader, I want to reactivate a user within RBU or ACT Housing so that they can access the portal again
    Given I want to login to portal "<PortalName>"
    And I wait for "6000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I click on text "Manage Users"
    Then I check that table "RealEstateAgentTable_Wrapper" with row containing "<email_test>" has the following
      | Fields | Value           |
      | item1  | Nitin           |
      | item1  | Paul            |
      | item1  | <email_test>    |
      | item1  | RBU Team Leader |
      | item1  | Inactive        |
    #Scenario 3: RBU Team Leader does not confirm reactivation
    Then I click on text "<email_test>"
    Then I wait for "6000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I wait for "6000" milliseconds
    Then I click on button with value "Active"
    Then I click on button with value "Save"
    Then I wait for "6000" milliseconds
    Then I see text "Are you sure you want to reactivate this user?" displayed
    Then I click on button with value "No"
    Then I wait for "6000" milliseconds
    Then I click on button with value "Cancel"
    Then I check that table "RealEstateAgentTable_Wrapper" with row containing "<email_test>" has the following
      | Fields | Value           |
      | item1  | Nitin           |
      | item1  | Paul            |
      | item1  | <email_test>    |
      | item1  | RBU Team Leader |
      | item1  | Inactive        |
    #Scenario 1: RBU Team Leader reactivates user account
    Then I click on text "<email_test>"
    Then I wait for "6000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I wait for "6000" milliseconds
    Then I click on button with value "Active"
    Then I click on button with value "Save"
    Then I wait for "6000" milliseconds
    #
    Then I see text "Are you sure you want to reactivate this user?" displayed
    Then I click on button with value "Yes"
    Then I wait for "6000" milliseconds
    Then I see text "Nitin Paul's details have been successfully updated." displayed
    Then I check that table "RealEstateAgentTable_Wrapper" with row containing "<email_test>" has the following
      | Fields | Value           |
      | item1  | Nitin           |
      | item1  | Paul            |
      | item1  | <email_test>    |
      | item1  | RBU Team Leader |
      | item1  | Active          |
    #Scenario 2: RBU Team Leader confirms reactivation
    Then I click on text "Sign Out"
    Given I want to login to portal "<PortalName>"
    And I wait for "6000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value        |
      | Email    | <email_test> |
      | Password | <Password>   |
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
    Then I wait for "6000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "EDIT"
    Then I wait for "6000" milliseconds
    Then I click on button with value "Inactive"
    Then I click on button with value "Save"
    Then I wait for "6000" milliseconds
    # now reactive the user again
    Then I see text "Are you sure you want to deactivate this user?" displayed
    Then I click on button with value "Yes"
    Then I wait for "6000" milliseconds
    Then I check that table "RealEstateAgentTable_Wrapper" with row containing "<email_test>" has the following
      | Fields | Value           |
      | item1  | Nitin           |
      | item1  | Paul            |
      | item1  | <email_test>    |
      | item1  | RBU Team Leader |
      | item1  | Inactive        |

    Examples: 
      | PortalName | email                   | Password   | Message                                  | email_test       |
      | ARB        | rbuteamleader1@test.com | Support123 | Invalid login details. Please try again. | nitin@amail.club |

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
      | PortalName | email                   | Password   | Message                                       | email2          |emailRegistered|
      | ARB        | agentadmin2@test.com | Support123 | Invalid login details. Please try again. |  pleasedonotuse@automation.com |nitin.paul@dbresults.com.au|
  
  @RB_Regression
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
      | Fields             | Value                               |
      | OneLineAddress     | 10 FLORA AVE, BADGER CREEK VIC 3777 |
      | StreetNumber       |                                  13 |
      | StreetName         | Shori                               |
      | Suburb             | Murrumbeena                         |
      | Postcode           |                                1111 |
      | NumberOfBedrooms   |                                  13 |
      | TotalBondAmount    |                                 400 |
      | WeeklyRentalAmount |                                 400 |
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
    Then I click on button "BondsTable TableRecords_OddLine PremiseClass"
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
    And I wait for "4000" milliseconds
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
    Then I click on button "BondsTable TableRecords_OddLine PremiseClass"
    Then I wait for "2000" milliseconds
    Then I see text "This is a test comment!" not displayed
    Then I see text "+ ADD COMMENT" not displayed

    Examples: 
      | PortalName | email                   | email2               | Password   | Message                                  | email_test                      | BondId  |
      | ARB        | rbuteamleader1@test.com | agentadmin2@test.com | Support123 | Invalid login details. Please try again. | ron.coldebella@dbresults.com.au | 1000125 |

   Scenario Outline: ARB-114: As a Logged in user, I want to view a bond history (Audit trail) which have occurred on a bond so that I can best manage this bond.
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
    Then I click on button "BondsTable TableRecords_OddLine PremiseClass"
    Then I click on text "HISTORY"
    And I wait for "1000" milliseconds
    Then I see text "Description" displayed
    Then I see text "Name" displayed
    Then I see text "Role" displayed
    Then I see text "Date" displayed
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
      | Fields          | Value                              |
      | TenantFirstName | TenantFirstName                    |
      | TenantLastName  | TenantLastName                     |
      | TenantEmail     | TenantEmail@TEST.com               |
      | TenantPhone     |                         1234567890 |
      | LessorFirstName | LessorFirstName                    |
      | LessorLastName  | LessorLastName                     |
      | LessorEmail     | LessorEmail@TeST.com               |
      | LessorPhone     |                         0987654321 |
      | PostalAddress   | 10 FLORA AVE, BADGER CREEK VIC 3777 |
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Summary" page
    Then I click on button with value "Next"
    And I wait for "1000" milliseconds
    Then I see text "Please confirm your bond details are correct." displayed
    Then I click on button "ConfirmCheck"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Confirmation" page
    # this will capture the bond id
    And I capture "You have successfully lodged your Bond"
    Then I click on text "BACK TO BONDS"
    Then I check I am on "ManageBonds" page
    Then I click on button with value "Search"
    And I paste "BondID" value in "SearchInput"
    And I hit Enter
    Then I check I am on "ManageBonds" page
    Then I "check" text "Raised" displayed in table "wtBondsList"
    Then I "click" text "CheckBox" displayed in table "wtBondsList"
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
    Then I "click" text "CheckBox" displayed in table "wtBondsList"
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
    Then I see text "The status of your Bond/s has been changed to 'Raised-Pending Payment'." displayed

    Examples: 
      | PortalName | email                | Password   | Message                                  | BondId  | Name            |
      | ARB        | agentadmin2@test.com | Support123 | Invalid login details. Please try again. | 1000125 | Agent Admin Two |
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
    And I paste "BondID" value in "SearchInput"
    And I hit Enter
    Then I check I am on "ManageBonds" page
    Then I "check" text "Raised" displayed in table "wtBondsList"
    Then I "click" text "CheckBox" displayed in table "wtBondsList"
    #start here
    And I click on button with value "View Payment Info"
    Then I check I am on "Bond Payment View" page
    # check only correct responsible party is displayed
    Then I see text "RESEND ACTIVATION EMAIL" not displayed
    # submitting the bond
    Then I click on button with value "Submit"
    And I wait for "1000" milliseconds
    Then I see text "The status of your Bond/s has been changed to 'Raised-Pending Payment'." displayed

    Examples: 
      | PortalName | email                         | Password   | Message                                  | email_test             | Responsible_Party  | TextOnSelection        | SelectValue1       | Dropdown1      | SelectValue2 | Dropdown2 |
      | ARB        | backofficeteamleader@test.com | Support123 | Invalid login details. Please try again. | honesurevo@mystvpn.com | ManagingAgentRadio | Managing Agent Details | DB RESULTS PTY LTD | AgencyNameDrop | ujaad singh  | AgentDrop |
      | ARB        | backofficeteamleader@test.com | Support123 | Invalid login details. Please try again. | honesurevo@mystvpn.com | LessorRadio        | Responsible Party      |                    |                |              |           |

  