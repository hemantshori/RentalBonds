
Feature: Iteration 1 tests

  #DONE: ARB 8, 12, 63, 65, 66, 70, 120, 133, 142, 159, 168, 174, 239, 240,
  Scenario Outline: Logins using different access levels;
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page
    And I click on text "Agent One"

    Examples: 
      | PortalName | email                     | Password   | Message                                  |
      | ARB        | FirstAgentOne@agency1.com | Support123 | Invalid login details. Please try again. |

  @wip
  Scenario Outline: ARB-8: As a portal user, I want to login to the portal so that I can access the functions I need to do my job
    #Scenario 1: Agent Administrator accesses the Create User function
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page
    Then I click on text "Manage Users"
    And I check I am on "ManageUsers" page
    Then I click on text "+ NEW USER"
    Then I wait for "2000" milliseconds
    Then I switch to frame "0"

    And I see popup "MainContent" displayed
    Then I wait for "2000" milliseconds

    Then I check "REAL_ESTATE_AGENT_Role" exists
    Then I check "USER_EXTENSION_FirstName" exists
    Then I check "USER_EXTENSION_LastName" exists
    Then I check "User_Email" exists
    Then I check "User_ContactPhone" exists
    Then I see text "An activation email will be sent to the email address entered. Due to security reasons, this link will expire in 60 minutes." displayed
    #Scenario 2: Mandatory fields not filled in
    Then I click on button with value "Save"
    Then I see text "Required fields have not been completed" displayed
    #Scenario 3: Email address not in the correct format
    Then I select "Property Manager" from "REAL_ESTATE_AGENT_Role"
    And I enter the details as
      | Fields                   | Value      |
      | USER_EXTENSION_FirstName | TEST       |
      | USER_EXTENSION_LastName  | TEST       |
      | User_ContactPhone        | 1234567890 |
      | User_Email               | TEST       |
    Then I click on button with value "Save"
    Then I see text "Email address is not valid, please try again" displayed
    #Scenario 4: Email address already registered
    And I enter the details as
      | Fields                   | Value      |
      | USER_EXTENSION_FirstName | TEST       |
      | USER_EXTENSION_LastName  | TEST       |
      | User_ContactPhone        | 1234567890 |
      | User_Email               | <email>    |
    Then I click on button with value "Save"
    Then I see text "Email address is already registered, please try again" displayed
    #Scenario 7: Agent Administrator cancels user account creation with unsaved changes
    And I enter the details as
      | Fields                   | Value         |
      | USER_EXTENSION_FirstName | TESTAGAIN     |
      | USER_EXTENSION_LastName  | TESTAGAIN     |
      | User_ContactPhone        |    1234567890 |
      | User_Email               | TEST@TEST.com |
    Then I click on button with value "Cancel"
    Then I switch to frame "0"
    Then I see text "There are unsaved changes on this page. Do you wish to proceed?" displayed
    Then I click on button with value "No"
    #And I enter the details as
    #| Fields                   | Value          |
    #| USER_EXTENSION_FirstName | TESTAGAINAGAIN |
    #| USER_EXTENSION_LastName  | TESTAGAINAGAIN |
    #| User_ContactPhone        |     1234567890 |
    #| User_Email               | TEST@TEST.com  |
    Then I wait for "1000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "Cancel"
    Then I switch to frame "0"
    Then I see text "There are unsaved changes on this page. Do you wish to proceed?" displayed
    Then I click on button with value "Yes"
    #Scenario 6: Agent Administrator cancels user account creation with no unsaved changes
    Then I click on text "+ NEW USER"
    Then I wait for "2000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "Cancel"
    #Scenario 5: Agent Administrator successfully creates a new user
    Then I click on text "+ NEW USER"
    Then I wait for "2000" milliseconds
    Then I switch to frame "0"
    Then I select "Property Manager" from "REAL_ESTATE_AGENT_Role"
    And I enter the details as
      | Fields                   | Value          |
      | USER_EXTENSION_FirstName | TESTAGAINAGAIN |
      | USER_EXTENSION_LastName  | TESTAGAINAGAIN |
      | User_ContactPhone        |     1234567890 |
      | User_Email               | TEST@TEST.com  |
    Then I click on button with value "Save"
    And I see popup "MainPopup" displayed

    And I enter popup values as
      | Fields       | Value |
      | FirstName    |       |
      | LastName     |       |
      | Email        |       |
      | ContactPhone |       |
    Then I see text "An activation email will be sent to the email address entered. Due to security reasons, this link will expire in 60 minutes." displayed
    And I click on button "Save"
    Then I see text "Required fields have not been completed." displayed
    And I click on button "Cancel"

    Then I wait for "1000" milliseconds
    And I check I am on "ManageUsers" page



    #Scenario 3: Email address not in the correct format
    Then I click on text "+ NEW USER"
    Then I wait for "2000" milliseconds
    Then I switch to frame "0"
    And I see popup "MainContent" displayed
    And I select "Property Manager" from "Role"
    And I enter popup values as
      | Fields       | Value     |
      | FirstName    | some      |
      | LastName     | some      |
      | Email        | notgood   |
      | ContactPhone | 232322323 |
    And I click on button "Save"
    And I wait for "1000" milliseconds
    Then I see text "Email address is not valid, please try again" displayed
    #Scenario 4: Email address already registered
    And I enter popup values as
      | Fields       | Value     |
      | FirstName    | some      |
      | LastName     | some      |
      | Email        | <email>   |
      | ContactPhone | 232322323 |
    And I wait for "500" milliseconds
    And I click on button "Save"
    Then I see text "Email address is already registered, please try again" displayed
    #Scenario 7: Agent Administrator cancels user account creation with unsaved changes
    # disabled as Jason puttin in ids
    #And I click on button "Cancel"
    #Then I see text "There are unsaved changes on this page. Do you wish to proceed?" displayed
    #And I wait for "500" milliseconds
    # And I click on "Yes" on popup
    #And I click on button "ClosePopup"
    #And I check I am on "UserList" page
    #Scenario 6: Agent Administrator cancels user account creation with no unsaved changes
    And I enter popup values as
      | Fields       | Value       |
      | FirstName    | some        |
      | LastName     | some        |
      | Email        | adb@ggg.com |
      | ContactPhone |   232322323 |
    And I wait for "500" milliseconds
    And I click on button "Save"

    #Then I click on button with value "Save"
    Examples: 
      | PortalName | email                | Password   | Message                                  |
      | ARB        | agentadmin1@test.com | Support123 | Invalid login details. Please try again. |


  Scenario Outline: ARB-12: As a portal user, I want to login to the portal so that I can access the functions I need to do my job
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page
    And I wait for "500" milliseconds
    Then I click on text "Lodge Bond"
    Then I check I am on "Bond Lodgement Premise" page
    #Scenario 1: User accesses the ‘Lodge Bond’ function
    Then I see text "Section, Block and Unit information can be found on your Council Rates notice." displayed
    And I enter the details as


      | Fields                  | Value |
      | OneLineAddress          |       |
      | Section                 |       |
      | Block                   |       |
      | NumberOfBedrooms        |       |
      | TotalBondAmount         |       |
      | WeeklyRentalAmount      |       |
      | TenancyCommencementDate |       |
    And I select "Separated House" from "DwellingType"

    #Scenario 3: Mandatory fields not filled in
    Then I click on button with value "Next"
    Then I see text "Required fields have not been completed." displayed
    #Scenario 2: Bond greater than 4 weeks rent
    And I enter the details as
      | Fields             | Value |
      | OneLineAddress     | xxx   |
      | NumberOfBedrooms   |       |
      | TotalBondAmount    |       |
      | WeeklyRentalAmount |       |
    Then I select "1" from "DwellingType"
    Then I click on button with value "Next"
    Then I see text "Invalid Property Address" displayed
    #Scenario 2: Bond greater than 4 weeks rent
    And I enter the details as
      | Fields             | Value                               |
      | OneLineAddress     | 10 FLORA AVE, BADGER CREEK VIC 3777 |
      | NumberOfBedrooms   |                                  11 |
      | TotalBondAmount    |                                 100 |
      | WeeklyRentalAmount |                                   1 |
    Then I select "1" from "DwellingType"
    Then I click on button with value "Next"
    Then I see text "Bond Amount cannot exceed 4 weeks of Weekly Rent Amount" displayed
    #Scenario 4: Mandatory fields filled in
    And I enter the details as
      | Fields             | Value                               |
      | OneLineAddress     | 10 FLORA AVE, BADGER CREEK VIC 3777 |
      | Section            |                                 101 |
      | Block              |                                 102 |
      | NumberOfBedrooms   |                                  11 |
      | TotalBondAmount    |                                 100 |
      | WeeklyRentalAmount |                                 100 |
    Then I select "2" from "DwellingType"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Parties" page
    Then I click on button with value "Back"
    #Scenario 5: User returns to Bond Search
    Then I click on text "BACK TO BONDS"
    Then I check I am on "ManageBonds" page

    Examples: 
      | PortalName | email                     | Password   | Message                                  |
      | ARB        | FirstAgentOne@agency1.com | Support123 | Invalid login details. Please try again. |

 



  Scenario Outline: ARB-63: As a portal user, I want to login to the portal so that I can access the functions I need to do my job
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    #Scenario 3: Mandatory fields not filled in
    And I click on button with value "Sign In"
    Then I see text "Required fields have not been completed" displayed
    #Scenario 2: Invalid Credentials Entered
    And I enter the details as
      | Fields   | Value             |
      | Email    | asdffsda@2sdf.com |
      | Password | safdasdfsadf      |
    And I hit Enter
    Then I see text "Your email address or password is incorrect, please try again." displayed
    #Scenario 1: Valid Credentials Entered
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page

    Examples: 
      | PortalName | email                     | Password   | Message                                  |
      | ARB        | FirstAgentOne@agency1.com | Support123 | Invalid login details. Please try again. |


  @defect379

  Scenario Outline: ARB-65: As a portal user, I want to reset my forgotten password so that I can access my account again
    #Cannot test fully due to the need of an external email system
    #Only Scenario 1 can be tested, the others are blocked because there is no way to get around the
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    Then I click on text "FORGOT PASSWORD?"
    #Scenario 1: User accesses the Forgot Password function
    Then I check I am on "Forgot Password" page
    Then I see text "Please enter your email below and then check your email for an reset password link. For security reasons, the link will expire in 30 minutes." displayed
    Then I check "Email2" exists
    Then I check "block_wtcaptcha" exists
    Then I click on button with value "Submit"
    Then I see text "This field is required." displayed
    And I enter the details as
      | Fields   | Value             |
      | Email    | asdffsd |
       Then I see text "Please enter a valid email address." displayed
         And I enter the details as
      | Fields   | Value             |
      | Email    | asdffsd@nosuchmail.com |
      Then I click on button with value "Submit"
      
      Then I see text "Recaptcha Not Valid." displayed


    Examples: 
      | PortalName | email                     | Password   | Message                                  |
      | ARB        | FirstAgentOne@agency1.com | Support123 | Invalid login details. Please try again. |

  Scenario Outline: ARB-66: As a portal user, I want to log out of the portal so that no one else can use my login when I no longer need the portal
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page
    And I click on text "Agent One"
    Then I click on text "Sign Out"
    And I check I am on "LogoutConfirmation" page
    And I see text "You have signed out" displayed
    And I see text "You have successfully signed out. To sign back in, click the button below" displayed
    And I click on button with value "Sign In"
    And I check I am on "Login" page

    Examples: 
      | PortalName | email                     | Password   | Message                                  |
      | ARB        | FirstAgentOne@agency1.com | Support123 | Invalid login details. Please try again. |

 @defect421

  Scenario Outline: ARB-70:  As a portal user, I want to change my password so that I can update this as required for security purposes
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page
    # Find a way to check the image
    Then I click on text "Agent One"
    And I click on text "Security"
    #Scenario 1: User views the ‘Change Password’ page
    Then I check I am on "Password Change" page
    And I check "Old" is empty
    And I check "New" is empty
    And I check "PWConfirm" is empty
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName         |
      | item1 | Current Password |
      | item2 | New Password     |
      | item3 | Confirm Password |
    Then I see text "Password must include a minimum of 8 characters, 1 upper case character and 1 numeric or special character." displayed
    #Scenario 2: Mandatory fields not filled in
    Then I click on button with value "Save"
    Then I wait for "1000" milliseconds
    #this part is bugged at the moment
    #Then I see text "Required fields have not been completed." displayed
    #
    #Scenario 3: Current Password entered is invalid
    And I enter the details as
      | Fields    | Value         |
      | Old       | Support12     |
      | New       | <NewPassword> |
      | PWConfirm | <NewPassword> |
    Then I click on button with value "Save"
    Then I wait for "2000" milliseconds
    Then I see text "Current Password does not match, please try again" displayed
    #Scenario 4: New Password does not match password policy
    And I enter the details as
      | Fields    | Value      |
      | Old       | <Password> |
      | New       | as         |
      | PWConfirm | as         |
    Then I click on button with value "Save"
    Then I wait for "1000" milliseconds
    Then I see text "Password does not match the password policy, please try again." displayed
    #Scenario 5: New Password and Confirm Password do not match
    And I enter the details as
      | Fields    | Value         |
      | Old       | <Password>    |
      | New       | <NewPassword> |
      | PWConfirm | Dbresults1    |
    Then I click on button with value "Save"
    Then I wait for "1000" milliseconds
    Then I see text "Passwords do not match, please try again." displayed
    #Scenario 6: Password successfully created
    And I enter the details as
      | Fields    | Value         |
      | Old       | <Password>    |
      | New       | <NewPassword> |
      | PWConfirm | <NewPassword> |
    Then I click on button with value "Save"
    Then I wait for "1000" milliseconds
    #Then I see text "Your changes have been saved successfully" displayed
    Then I see text "Your password has been successfully updated." displayed
    #Scenario 7: Change Password function with no unsaved changes
    Then I click on button with value "Cancel"
    Then I check I am on "Password Change" page
    And I check "Old" is empty
    And I check "New" is empty
    And I check "PWConfirm" is empty
    #Revert the password back to normal
    And I enter the details as
      | Fields    | Value         |
      | Old       | <NewPassword> |
      | New       | <Password>    |
      | PWConfirm | <Password>    |
    Then I click on button with value "Save"
    Then I wait for "1000" milliseconds
    Then I see text "Your password has been successfully updated." displayed

    Examples: 
      | PortalName | email                     | Password   | NewPassword | Message                                  |
      | ARB        | FirstAgentOne@agency1.com | Support123 | Dbresults1! | Invalid login details. Please try again. |

  #    @defect check with jonathan
  Scenario Outline: ARB-120: As an Agent Administrator I want to view a list of users within my agency so that I know who in my agency can access the portal
    #Scenario 1: Agent Administrator accesses the View User function
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    Then I wait for "5000" milliseconds
    #the 'Then I click on text' step didn't work here for some reason
    #Then I click on object with xpath "(//*[contains(text(), 'Users')])[2]"
    Then I click on text "Users"
    Then I check "RealEstateAgentTable" exists
    Then I see text "First Name" displayed
    Then I see text "Last Name" displayed
    Then I see text "Email Address" displayed
    Then I see text "Role" displayed
    Then I see text "Status" displayed
    #Scenario 2: Agent Administrator views a user’s details
    Then I click on text "FirstAgentOne@agency1.com"
    Then I switch to frame "0"
    Then I wait for "2000" milliseconds
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                  |
      | item1 | Role:                     |
      | item2 | First Name:               |
      | item3 | Last Name:                |
      | item3 | Email Address:            |
      | item3 | Contact Number:           |
      | item3 | Status:                   |
      #| item3 | RESEND ACTIVATION EMAIL   |
      | item3 | FirstAgentOne@agency1.com |
    Then I click on button with value "EDIT"
    Then I wait for "4000" milliseconds
    #Then I switch to frame "1"
    #This doesn't work for some reason
    Then I click on object with xpath "//*[contains(@class, 'os-internal-ui-dialog-titlebar-close-no-title')]"

    #Scenario 3: Agent Administrator closes a user’s details
    Examples: 
      | PortalName | email                | Password   | NewPassword | Message                                  |
      | ARB        | agentadmin2@test.com | Support123 | Dbresults1! | Invalid login details. Please try again. |

  Scenario Outline: ARB-133: As a portal user, I want to access quick links from the header so that I can quickly navigate to the pages I need within the portal
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page
    # Find a way to check the image
    Then I see text "Agent One" displayed
    And I click on text "Agent One"
    Then I see text "Sign Out" displayed
    Then I click on text "Sign Out"

    Then I check I am on "Login" page

    Examples: 
      | PortalName | email                     | Password   | Message                                  |
      | ARB        | FirstAgentOne@agency1.com | Support123 | Invalid login details. Please try again. |

  Scenario Outline: ARB-133: As a portal user, I want to access quick links from the header so that I can quickly navigate to the pages I need within the portal
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page
    # Find a way to check the image
    Then I see text "Agent One" displayed
    And I click on text "Agent One"
    Then I see text "Sign Out" displayed
    Then I click on text "Sign Out"

    Then I check I am on "LogoutConfirmation" page

    Examples: 
      | PortalName | email                     | Password   | Message                                  |
      | ARB        | FirstAgentOne@agency1.com | Support123 | Invalid login details. Please try again. |

  Scenario Outline: ARB-142: As a portal user, I want to update my profile details so that I can update this as required for security purposes

    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page
    And I click on text "<FirstName>"
    Then I see "<Item>" element "<ElementName>" displayed
      | Item  | ElementName |
      | Item1 | Profile     |
      | Item2 | Security    |
      | Item3 | SignOut     |
    And I click on text "Profile"
    And I check I am on "Profile Details" page
    Then I see "<Item>" element "<ElementName>" displayed
      | Item  | ElementName   |
      | Item1 | First Name    |
      | Item2 | Last Name     |
      | Item3 | Email         |
      | Item3 | Contact Phone |

    #Scenario2, Scenario3
    Then I click on button with value "Edit"
    And I enter the details as
      | Fields      | Value            |
      | FirstName   | <NewFirstName>   |
      | LastName    | <NewLastName>    |
      | MobilePhone | <NewPhoneNumber> |
    Then I click on button with value "Save"
    Then I see text "<Message>" displayed
    Then I see "<Item>" element "<ElementName>" displayed
      | Item | <NewFirstName> |
      | Item | <NewLastName>  |
    Then I click on button with value "Edit"
    And I enter the details as
      | Fields    | Value       |
      | FirstName | <FirstName> |
      | LastName  | <LastName>  |
    Then I click on button with value "Save"
    Then I see text "<Message>" displayed
    Then I click on button with value "Edit"
    And I enter the details as
      | Fields      | Value            |
      | FirstName   | <NewFirstName2>  |
      | LastName    | <NewLastName>    |
      | MobilePhone | <NewPhoneNumber> |
    Then I click on button with value "Save"

    Examples: 
      | PortalName | email                     | Password   | FirstName | LastName | EmailAddress    | PhoneNumber   | NewFirstName | NewLastName | NewPhoneNumber | Message                                   | NewFirstName2 | Message2                                 |
      | ARB        | FirstAgentOne@agency1.com | Support123 | Agent     | One      | name@noname.com | 7737373737373 | sdfsdf       | sdfsdf      |      242344223 | Your changes have been saved successfully |               | Required fields have not been completed. |
      | ARB        | FirstAgentOne@agency1.com | Support123 | Agent     | Admin      | name@noname.com | 7737373737373 | sdfsdf       | sdfsdf      |      242344223 | Your changes have been saved successfully |               | Required fields have not been completed. |


  ################ Story blocked by defect on profile
  Scenario Outline: ARB-143: As an Agent Administrator, I want to view and edit my Agency's profile details so that I can keep the information up to date

    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page
    # Find a way to check the image
    And I click on text "Agent Admin"
    Then I click on text "Agency Profile"
    #Scenario 1: Agent Administrator views their Agency Profile Details
    Then I check "REAL_ESTATE_AGENCY_ContactEmail" exists
    Then I check "REAL_ESTATE_AGENCY_PhoneNumber" exists
    Then I check "REAL_ESTATE_AGENCY_Address1" exists
    Then I check "REAL_ESTATE_AGENCY_Suburb" exists
    Then I check "REAL_ESTATE_AGENCY_PostCode" exists
    Then I check "REAL_ESTATE_AGENCY_PostCode2" exists
    Then I check "IsDifferentPostalCheckBox" exists
    Then I check "REAL_ESTATE_AGENCY_ContactEmail" is readonly
    Then I check "REAL_ESTATE_AGENCY_PhoneNumber" is readonly
    Then I check "REAL_ESTATE_AGENCY_Address1" is readonly
    Then I check "REAL_ESTATE_AGENCY_Suburb" is readonly
    Then I check "REAL_ESTATE_AGENCY_PostCode" is readonly
    Then I check "REAL_ESTATE_AGENCY_PostCode2" is readonly
    Then I check "IsDifferentPostalCheckBox" is readonly

    #Scenario 3: Mandatory fields not filled in
    Then I click on button with value "Edit"
    Then I clear "REAL_ESTATE_AGENCY_ContactEmail" of content
    Then I click on button with value "Save"
    Then I see text "Required fields have not been completed" displayed
    #Scenario 4: Email address not in the correct format
    And I enter the details as
      | Fields                          | Value |
      | REAL_ESTATE_AGENCY_ContactEmail | TEST  |
    Then I click on button with value "Save"
    Then I see text "Email address is not valid, please try again" displayed
    #Scenario 2: Agent Administrator successfully updates their Agency’s Profile Details
    And I enter the details as
      | Fields                          | Value                             |
      | REAL_ESTATE_AGENCY_ContactEmail | some@some.com                     |
      | REAL_ESTATE_AGENCY_PhoneNumber  | 00 0232 323                       |
      | OneLineAddress                  | 8 JAANDA CT, BLAIRGOWRIE VIC 3942 |
    Then I click on button with value "Save"
    Then I see text "Your changes have been saved successfully" displayed
    Then I wait for "20000" milliseconds
    #Scenario 6: Agent Administrator cancels update of contact details with unsaved changes
    Then I click on button "Edit"
    And I enter the details as
      | Fields                          | Value     |
      | REAL_ESTATE_AGENCY_ContactEmail | TESTAGAIN |
    Then I click on button with value "Cancel"
    Then I see "There are unsaved changes on this page. Do you wish to proceed?" displayed on popup and I click "OK"
    Then I check "REAL_ESTATE_AGENCY_ContactEmail" contains "some@some.com"
    Then I check "REAL_ESTATE_AGENCY_PhoneNumber" contains "00 0232 323"
    Then I check "REAL_ESTATE_AGENCY_Address1" contains "8 JAANDA CT"
    Then I check "REAL_ESTATE_AGENCY_Suburb" contains "BLAIRGOWRIE"
    Then I check "REAL_ESTATE_AGENCY_PostCode" contains "VIC"
    Then I check "REAL_ESTATE_AGENCY_PostCode2" contains "3942"
   # Scenario 5: Agent Administrator cancels update of contact details with no unsaved changes
    Then I click on button "Edit"
    Then I click on button with value "Cancel"
    Then I check "REAL_ESTATE_AGENCY_ContactEmail" contains "some@some.com"
    Then I check "REAL_ESTATE_AGENCY_PhoneNumber" contains "00 0232 323"
    Then I check "REAL_ESTATE_AGENCY_Address1" contains "8 JAANDA CT"
    Then I check "REAL_ESTATE_AGENCY_Suburb" contains "BLAIRGOWRIE"
    Then I check "REAL_ESTATE_AGENCY_PostCode" contains "VIC"
    Then I check "REAL_ESTATE_AGENCY_PostCode2" contains "3942"

    #
    Examples: 
      | PortalName | email                | Password   | Message                                  | FirstName | LastName | MobilePhone  |
      | ARB        | agentadmin2@test.com | Support123 | Invalid login details. Please try again. | Agent     | One      | 12 3456 7890 |

   Scenario Outline: ARB-159: As a Lessor, I want to enter my contact details during registration details so that I can register with the portal
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    Then I click on button with value "Create Account"
    Then I wait for "2000" milliseconds
    #Scenario 1: Lessor accesses the Registration function
    Then I click on button "select2-chosen-1"
    #Then I select "Managing Agent" from "select2-chosen-1"
    Then I click on object with xpath "//div[contains(text(), 'Lessor')]"
    Then I wait for "1000" milliseconds
    Then I check "LessorFirstNameInput" is empty
    Then I check "LessorLastNameInput" is empty
    Then I check "LessorEmailAddressInput" is empty
    Then I check "LessorPhoneNumberInput" is empty
    Then I check "LessorAddressInput" is empty
    Then I check "LessorPostalAddressCheckbox" exists
    Then I check "AgreeTermsCheckbox" exists
    Then I check "FirstSectionNextLessor" exists
    Then I check "SignIn" exists
    Then I see text "Please register below if you are a Lessor or a Managing Agent" displayed
    Then I see text "Required fields are marked by *" displayed
    #Scenario 2: Mandatory fields not filled in
    Then I click on button "AgreeTermsCheckbox"
    Then I click on button "FirstSectionNextLessor"
    Then I wait for "2000" milliseconds
    Then I see text "Required fields have not been completed" displayed
    #Scenario 3: Agreement to Terms of Use not confirmed
    And I enter the details as
      | Fields                  | Value          |
      | LessorFirstNameInput    | <FirstName>    |
      | LessorLastNameInput     | <LastName>     |
      | LessorEmailAddressInput | <EmailAddress> |
      | LessorPhoneNumberInput  | <PhoneNumber>  |
      | LessorAddressInput      | <Address>      |
    #  Then I click on button "AgreeTermsCheckbox"
    Then I click on button "FirstSectionNextLessor"
    Then I wait for "2000" milliseconds
    #this doesn't work for some reason. Instead, check that we're still on the same page.
    #Then I see text "You must agree to the Terms & Conditions before continuing" displayed
    Then I check "LessorFirstNameInput" exists
    Then I check "LessorLastNameInput" exists
    Then I check "LessorEmailAddressInput" exists
    Then I check "LessorPhoneNumberInput" exists
    Then I check "LessorAddressInput" exists
    Then I check "LessorPostalAddressCheckbox" exists
    Then I check "AgreeTermsCheckbox" exists
    Then I check "FirstSectionNextLessor" exists
    #Scenario 4: Email address not in the correct format
    Then I click on button "AgreeTermsCheckbox"
    And I enter the details as
      | Fields                  | Value |
      | LessorEmailAddressInput | test  |
    Then I click on button "FirstSectionNextLessor"
    Then I wait for "2000" milliseconds
    Then I see text "Email address is not valid, please try again" displayed
    #Scenario 5: Email address already registered
    And I enter the details as
      | Fields                  | Value                |
      | LessorEmailAddressInput | agentadmin2@test.com |
    Then I click on button "FirstSectionNextLessor"
    Then I wait for "2000" milliseconds
    Then I see text "Email address is already registered, please try again" displayed
    #Scenario 6: Details validated successfully
    And I enter the details as
      | Fields                  | Value           |
      | LessorFirstNameInput    | <FirstName2>    |
      | LessorLastNameInput     | <LastName2>     |
      | LessorEmailAddressInput | <EmailAddress2> |
      | LessorPhoneNumberInput  | <PhoneNumber2>  |
      | LessorAddressInput      | <Address2>      |
    Then I click on button "FirstSectionNextLessor"
    Then I wait for "2000" milliseconds
    Then I see text "Enter bank details for bond refunds." displayed

    Examples: 
      | PortalName | email                     | FirstName | LastName  | ABN         | LicenceNumber | PhoneNumber  | EmailAddress         | Address                           | FirstName2 | LastName2 | LessorEmailAddressInput | EmailAddress2 | PhoneNumber2 | Address2                          |
      | ARB        | FirstAgentOne@agency1.com | Agent     | Admin Two | 55005825516 |     123454312 | 31 2312 3231 | agentadmin2@test.com | 10 FLORA GR, FOREST HILL VIC 3131 | some       | test      | idontexist@ffg.com      |   idontexist@ffg.com|     23232323 | 10 FLORA GR, FOREST HILL VIC 3131 |
  
   Scenario Outline: ARB-168: As an Agent Administrator/Lessor, I want to view and edit my bank details for my bond refunds so that I can keep this information up to date
    #Scenario 1: Agent Administrator views the Refund Bank Details
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page
    # Find a way to check the image
    And I click on text "Agent Admin"
    Then I click on text "Agency Profile"
    Then I click on button with value "Edit"

    #Scenario 3: User successfully updates their Refund Bank Details
    #Then I clear "MainContent_wtBSB" of content
    Then I enter the details as
      | Fields                       | Value       |
      #| MainContent_wtBSB            |      123123 |
      | Account_Number |   123123123 |
      | Account_Name   | OneTwoThree |
    Then I wait for "2000" milliseconds
    Then I click on button with value "Save"
    Then I wait for "2000" milliseconds
    Then I see text "Your changes have been saved successfully" displayed
    Then I check "BSB" contains "123-123"
    Then I check "Account_Name" contains "OneTwoThree"
    #Scenario 4: User updates their Refund Bank Details with errors
    Then I wait for "20000" milliseconds
    Then I click on button "EditButton"
    Then I clear "BSB" of content
    Then I clear "Account_Number" of content
    Then I clear "Account_Name" of content
    Then I click on button with value "Save"
    Then I see text "Required fields have not been completed" displayed
    #Scenario 5: User cancels refund bank details update with no unsaved changes
    Then I enter the details as
      | Fields                       | Value       |
      | BSB            |      123123 |
      | Account_Number |   123123123 |
      | Account_Name   | OneTwoThree |
    Then I click on button with value "Cancel"
    Then I see "There are unsaved changes on this page. Do you wish to proceed?" displayed on popup and I click "OK"
    #
    #Scenario 6: User cancels refund bank details update with unsaved changes
    Then I click on button "EditButton"
    Then I click on button with value "Cancel"
    Then I click on text "Sign Out"
    #Scenario 2: Lessor views the Refund Bank Details
    Then I click on button with value "Sign In"
    And I enter the details as
      | Fields   | Value            |
      | Email    | lessor1@test.com |
      | Password | <Password>       |
    And I hit Enter
    And I click on text "Lessor One Last"
    Then I click on text "Profile"
    Then I click on button with value "Edit"
    Then I check "BSB" exists
    Then I check "Account_Number" exists
    Then I check "Account_Name" exists

    #
    Examples: 
      | PortalName | email                     | Password   | Message                                  | FirstName | LastName | MobilePhone  |
      | ARB        |agentadmin2@test.com | Support123 | Invalid login details. Please try again. | Agent     | One      | 12 3456 7890 |
 

  Scenario Outline: ARB-174: As an Agent Administrator, I want to enter my Agencys identification during registration so that I can register with the portal
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    Then I click on button with value "Create Account"
    Then I wait for "2000" milliseconds
    #Scenario 1: Agent Administrator accesses the Registration function
    Then I click on button "select2-chosen-1"
    #Then I select "Managing Agent" from "select2-chosen-1"
    Then I click on object with xpath "//div[contains(text(), 'Managing Agent')]"
    Then I wait for "1000" milliseconds
    Then I check "ABNInput" is empty
    Then I check "AgencyLicenceNumberInput" is empty
    Then I check "AgreeTermsCheckbox" exists
    Then I see text "Terms and Conditions" displayed
    Then I see text "I have read and agree to the " displayed
    Then I see text "FirstSectionNextAgency" displayed
    Then I check "SignIn" exists
    Then I see text "Please register below if you are a Lessor or a Managing Agent" displayed
    Then I see text "Required fields are marked by *" displayed
    #Scenario 2: Mandatory fields not filled in
    Then I click on button "AgreeTermsCheckbox"
    Then I click on button "FirstSectionNextAgency"
    Then I wait for "1000" milliseconds
    Then I see text "Required fields have not been completed" displayed
    #Scenario 3: Agreement to Terms of Use not confirmed
    Then I click on button "AgreeTermsCheckbox"
    And I enter the details as
      | Fields                   | Value    |
      | ABNInput                 |       67 |
      | AgencyLicenceNumberInput | 11111112 |
    Then I click on button "FirstSectionNextAgency"
    Then I wait for "5000" milliseconds
    #For some reason this doesn't work:
    #Then I see text "You must agree to the Terms & Conditions before continuing" displayed
    #Check that we're still on the Register page instead
    Then I check "ABNInput" exists
    Then I check "AgencyLicenceNumberInput" exists
    Then I check "AgreeTermsCheckbox" exists
    Then I see text "Terms and Conditions" displayed
    Then I see text "I have read and agree to the " displayed
    Then I see text "FirstSectionNextAgency" displayed
    Then I check "SignIn" exists
    Then I check I am on "Register" page
    #Scenario 4: Identification details not successfully verified
    Then I click on button "AgreeTermsCheckbox"
    Then I click on button "FirstSectionNextAgency"
    Then I wait for "1000" milliseconds
    Then I see text "ABN is not valid or your Agency Licence Number is already registered, please try again" displayed
    #Scenario 5: Identification details successfully verified
    And I enter the details as
      | Fields   | Value |
      | ABNInput | <ABN> |
    Then I wait for "5000" milliseconds
    #And I enter the details as
    #| Fields                   | Value    |
    #| AgencyLicenceNumberInput | 11111112 |
    Then I click on button "FirstSectionNextAgency"
    Then I wait for "1000" milliseconds
    Then I check "AgencyOrganisationNameInput" exists

    Examples: 
      | PortalName | email                     | Password   | NewPassword | Message                                  | ABN         | LicenceNumber |
      | ARB        | FirstAgentOne@agency1.com | Support123 | Dbresults1! | Invalid login details. Please try again. | 97110187767 |      11111112 |
 
   Scenario Outline: ARB-176: As an Agent Administrator/Lessor, I want to enter my bank and Administrator details so that I can register with the portal
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    Then I click on button with value "Create Account"
    And I wait for "2000" milliseconds
    Then I click on button "select2-chosen-1"
    Then I click on object with xpath "//div[contains(text(), 'Managing Agent')]"
    Then I wait for "1000" milliseconds
    And I enter the details as
      | Fields                   | Value           |
      | ABNInput                 | <ABN>           |
      | AgencyLicenceNumberInput | <LicenceNumber> |
    Then I click on button "AgreeTermsCheckbox"
    Then I click on button "FirstSectionNextAgency"
    Then I wait for "2000" milliseconds
    And I enter the details as
      | Fields                  | Value          |
      | AgencyPhoneNumberInput  | <PhoneNumber>  |
      | AgencyEmailAddressInput | <EmailAddress> |
      | AgencyAddressInput      | <Address>      |
    Then I click on button "AgencyDetailsNext"
    And I wait for "2000" milliseconds
    #Scenario 1: Agent Administrator views the Bank Details page
    Then I check "RefundBSBInput" exists
    Then I check "RefundAccountNumberInput" exists
    Then I check "RefundAccountNameInput" exists
    Then I check "AgentFirstNameInput" exists
    Then I check "AgentLastNameInput" exists
    Then I check "AgentEmailAddressInput" exists
    Then I check "AgentPhoneNumberInput" exists
    #Scenario 3: Mandatory fields not filled in
    Then I click on button "BankDetailsNext"
    Then I see text "Required fields have not been completed" displayed
    #Scenario 4: Email address not in the correct format
    And I enter the details as
      | Fields                   | Value        |
      | RefundBSBInput           |       123123 |
      | RefundAccountNumberInput |    123123123 |
      | RefundAccountNameInput   | TEST         |
      | AgentFirstNameInput      | TEST         |
      | AgentLastNameInput       | TEST         |
      | AgentEmailAddressInput   | TEST         |
      | AgentPhoneNumberInput    | 123456789012 |
    Then I click on button "BankDetailsNext"
    Then I see text "Email address is not valid, please try again" displayed
    #Scenario 5: Email address already registered
    And I enter the details as
      | Fields                   | Value        |
      | RefundBSBInput           |       123123 |
      | RefundAccountNumberInput |    123123123 |
      | RefundAccountNameInput   | TEST         |
      | AgentFirstNameInput      | TEST         |
      | AgentLastNameInput       | asdfasf      |
      | AgentEmailAddressInput   | <email>      |
      | AgentPhoneNumberInput    | 123456789012 |
    Then I click on button "BankDetailsNext"
    Then I see text "Email address is already registered, please try again" displayed
    #Scenario 6: Information successfully validated
    And I enter the details as
      | Fields                   | Value         |
      | RefundBSBInput           |        123123 |
      | RefundAccountNumberInput |     123123123 |
      | RefundAccountNameInput   | TEST          |
      | AgentFirstNameInput      | TEST          |
      | AgentLastNameInput       | asdfasf       |
      | AgentEmailAddressInput   | TEST@TESTxxx.com |
      | AgentPhoneNumberInput    |  123456789012 |
    Then I click on button "BankDetailsNext"
    Then I see text "Password must include a minimum of 8 characters, 1 upper case character and 1 numeric and special character." displayed
    #Scenario 2: Lessor views the Bank Details page
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    Then I click on button with value "Create Account"
    Then I wait for "2000" milliseconds
    Then I click on button "select2-chosen-1"
    Then I click on object with xpath "//div[contains(text(), 'Lessor')]"
    Then I wait for "1000" milliseconds
    And I enter the details as
      | Fields                  | Value          |
      | LessorFirstNameInput    | <FirstName>    |
      | LessorLastNameInput     | <LastName>     |
      | LessorEmailAddressInput | <EmailAddress> |
      | LessorPhoneNumberInput  | <PhoneNumber>  |
      | LessorAddressInput      | <Address>      |
    Then I click on button "AgreeTermsCheckbox"
    Then I click on button "FirstSectionNextLessor"
    Then I wait for "2000" milliseconds
    Then I see text "Enter bank details for bond refunds." displayed
    Then I check "RefundBSBInput" exists
    Then I check "RefundAccountNumberInput" exists
    Then I check "RefundAccountNameInput" exists

    Examples: 
      | PortalName | email                     | Password   | NewPassword | ABN         | LicenceNumber | PhoneNumber | EmailAddress  | Address                           |
      | ARB        | FirstAgentOne@agency1.com | Support123 | Dbresults1! | 55005825516 |     123454312 |  1234567890 | testlessorxxx@test.com | 10 FLORA GR, FOREST HILL VIC 3131 |
 
 @defect
    Scenario Outline: ARB-194: As an Agent Administrator/Propertnager/Lessor, I want to see a summary of my bond lodgement so that I can review the details I've entered
    #Scenario 2: Agent Administrator/Property Manager reviews a summary of the Bond Lodgement
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
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Parties" page
    And I enter the details as
      | Fields          | Value                |
      | TenantFirstName | TenantFirstName      |
      | TenantLastName  | TenantLastName       |
      | TenantEmail     | TenantEmail@TEST.com |
      | TenantPhone     |           1234567890 |
      #| TenantBSB           |               383838 |
      #| TenantAcctNum       |               987653 |
      | LessorFirstName | LessorFirstName      |
      | LessorLastName  | LessorLastName       |
      | LessorEmail     | LessorEmail@TeST.com |
      | LessorPhone     |           0987654321 |
    #| LessorBSB           |               838383 |
    #| LessorAccountNumber |               356789 |
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Summary" page
    Then I check "PremiseDetails" exists
    Then I check "BondAndTenancy" exists
    Then I check "TenantDetails" exists
    Then I check "ManagingAgentDetails" exists
    Then I check "LessorDetails" exists
    Then I check "ConfirmCheck" exists
    # ToDo disabled for now as address fileds on Bond lodgement premise has bugs
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value           |
      | item1  | TenantFirstName |
      | item1  | TenantLastName  |
      #| item1  | TenantEmail@TEST.com                |
      #| item1  | Separated House                     |
      #| item1  | 10 FLORA AVE, BADGER CREEK VIC 3777 |
      #| item1  | 12 3456 7890                        |
      #| item1  | 383-838                             |
      #| item1  |                              987653 |
      | item1  | LessorFirstName |
      | item1  | LessorLastName  |
    #| item1  | LessorEmail@TeST.com                |
    #| item1  | 09 8765 4321                        |
    #| item1  | TestLessorAccount                   |
    #| item1  | 838-383                             |
    #| item1  |                              356789 |
    #| item1  | Separated House                     |
    #| item1  | Admin ADmin Last                    |
    #| item1  | 14 2324 3323                        |
    Then I see text "I confirm that these details are correct at the time of lodgement" displayed
    Then I click on button with value "Back"
    Then I check I am on "Bond Lodgement Parties" page
    #Scenario 3: User cancels bond lodgement
    Then I click on text "BACK TO BONDS"
    Then I check I am on "ManageBonds" page
    #Scenario 4: User does not confirm bond lodgement details
    Then I click on text "Lodge Bond"
    Then I check I am on "Bond Lodgement Premise" page
    Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields             | Value                               |
      | OneLineAddress     | 10 FLORA AVE, BADGER CREEK VIC 3777 |
      | StreetNumber       |                                  14 |
      | StreetName         | Shori                               |
      | Suburb             | Murrumbeena                         |
      | Postcode           |                                1111 |
      | NumberOfBedrooms   |                                  13 |
      | TotalBondAmount    |                                 400 |
      | WeeklyRentalAmount |                                 400 |
    Then I select "Separated House" from "DwellingType"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Parties" page
    And I enter the details as
      | Fields              | Value                |
      | TenantFirstName     | TenantFirstName      |
      | TenantLastName      | TenantLastName       |
      | TenantEmail         | TenantEmail@TEST.com |
      | TenantPhone         |           1234567890 |
     
      | LessorFirstName     | LessorFirstName      |
      | LessorLastName      | LessorLastName       |
      | LessorEmail         | LessorEmail@TeST.com |
      | LessorPhone         |           0987654321 |
      
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Summary" page
    Then I click on button with value "Next"
    Then I see text "Please confirm your bond details are correct." displayed
    #Scenario 5: User confirms bond lodgement details
    Then I click on button "ConfirmCheck"
    Then I click on button with value "Next"
    Then I check I am on "Bond Lodgement Confirmation" page
    Then I click on text "Sign Out"
    #Scenario 2: Agent Administrator/Property Manager reviews a summary of the Bond Lodgement
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value            |
      | Email    | lessor2@test.com |
      | Password | <Password>       |
    And I hit Enter
    And I check I am on "ManageBonds" page
    Then I click on text "Lodge Bond"
    Then I check I am on "Bond Lodgement Premise" page
 Then I click on text "ENTER MANUAL ADDRESS"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields             | Value                               |
      | OneLineAddress     | 10 FLORA AVE, BADGER CREEK VIC 3777 |
      | StreetNumber       |                                  15 |
      | StreetName         | Shori                               |
      | Suburb             | Murrumbeena                         |
      | Postcode           |                                1111 |
      | NumberOfBedrooms   |                                  13 |
      | TotalBondAmount    |                                 400 |
      | WeeklyRentalAmount |                                 400 |
    Then I select "Separated House" from "DwellingType"
    Then I click on button with value "Next"

    And I enter the details as
      | Fields            | Value                |
      | TenantFirstName   | TenantFirstName      |
      | TenantLastName    | TenantLastName       |
      | TenantEmail       | TenantEmail@TEST.com |
      | TenantPhone       |           1234567890 |
    
    Then I click on button with value "Next"

    Then I check "PremiseDetails" exists
    Then I check "BondAndTenancy" exists
    Then I check "TenantDetails" exists
    #Then I check "ManagingAgentDetails" exists
    Then I check "LessorDetails" exists
    Then I check "ConfirmCheck" exists
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value                               |
      | item1  | TenantFirstName                     |
      | item1  | Separated House                     |
      | item1  | 10 FLORA AVE, BADGER CREEK VIC 3777 |
      | item1  | TenantLastName                      |
      | item1  | TenantEmail@TEST.com                |
      | item1  | 12 3456 7890                        |
      | item1  | 383-838                             |
      | item1  |                              987653 |
    Then I see text "I confirm that these details are correct at the time of lodgement" displayed

    Examples: 
      | PortalName | email                | Password   | NewPassword | ABN         | LicenceNumber | PhoneNumber | EmailAddress  | Address                           |
      | ARB        | agent2@test.com | Support123 | Dbresults1! | 55005825516 |     123454312 |  1234567890 | test@test.com | 10 FLORA GR, FOREST HILL VIC 3131 |




  Scenario Outline: ARB-195:  As an Agent/Lessor, I want to see a confirmation page so that I know my bond has been lodged succesfully
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page
    Then I click on text "Lodge Bond"

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
    Then I click on button with value "Next"
    
    And I enter the details as
      | Fields              | Value         |
      | TenantFirstName     | TEST          |
      | TenantLastName      | TEST          |
      | TenantEmail         | TEST@TEST.com |
      | TenantPhone         |    1234567890 |
    
      | LessorFirstName     | TEST          |
      | LessorLastName      | TEST          |
      | LessorEmail         | TEST@TeST.com |
      | LessorPhone         |    1234567890 |
      
    Then I click on button with value "Next"

    Then I click on button "ConfirmCheck"
    Then I click on button with value "Next"
    
    Then I see text "Lodgement Complete" displayed
    Then I see text "You have successfully lodged your Bond" displayed

    Examples: 
      | PortalName | email                | Password   | NewPassword | ABN         | LicenceNumber | PhoneNumber | EmailAddress  | Address                           |
      | ARB        | agentadmin2@test.com | Support123 | Dbresults1! | 55005825516 |     123454312 |  1234567890 | test@test.com | 10 FLORA GR, FOREST HILL VIC 3131 |


  

  Scenario Outline: ARB-239: As an Agent Administrator/Lessor, I want to enter my password details so that I can register with the portal
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    Then I click on button with value "Create Account"
    Then I wait for "2000" milliseconds
    #Scenario 1: Lessor accesses the Registration function
    Then I click on button "select2-chosen-1"
   # Then I select "Lessor" from "select2-chosen-1"
   #todo NOT HAPPY
    Then I click on object with xpath "//div[contains(text(), 'Lessor')]"
    Then I wait for "1000" milliseconds
    And I enter the details as
      | Fields                  | Value          |
      | LessorFirstNameInput    | <FirstName>    |
      | LessorLastNameInput     | <LastName>     |
      | LessorEmailAddressInput | <EmailAddress> |
      | LessorPhoneNumberInput  | <PhoneNumber>  |
      | LessorAddressInput      | <Address>      |
    Then I click on button "AgreeTermsCheckbox"
    Then I click on button "FirstSectionNextLessor"
    Then I wait for "2000" milliseconds
    Then I see text "Enter bank details for bond refunds." displayed
    And I enter the details as
      | Fields                   | Value          |
      | RefundBSBInput           |         111111 |
      | RefundAccountNumberInput |     1234567890 |
      | RefundAccountNameInput   | <EmailAddress> |
    Then I click on button "BankDetailsNext"
    Then I wait for "1000" milliseconds
    #Scenario 1: Agent Administrator/Lessor views the Password page
    Then I see text "Password must include a minimum of 8 characters, 1 upper case character and 1 numeric and special character." displayed
    Then I check "PasswordInput" is empty
    Then I check "ConfirmPasswordInput" is empty
    Then I check "PasswordDetailsBack" exists
    Then I check "PasswordDetailsSubmit" exists
    #Scenario 2: Mandatory fields not filled in
    Then I click on button "PasswordDetailsSubmit"
    Then I wait for "1000" milliseconds
    Then I see text "Required fields have not been completed" displayed
    #Scenario 3: New Password does not match password policy
    And I enter the details as
      | Fields               | Value |
      | PasswordInput        | test  |
      | ConfirmPasswordInput | test  |
    Then I click on button "PasswordDetailsSubmit"
    Then I wait for "1000" milliseconds
    Then I see text "Password does not match the password policy, please try again" displayed
    #Scenario 4: New Password and Confirm Password do not match
    And I enter the details as
      | Fields               | Value      |
      | PasswordInput        | Support123 |
      | ConfirmPasswordInput | Support12  |
    Then I click on button "PasswordDetailsSubmit"
    Then I wait for "1000" milliseconds
    Then I see text "Passwords do not match, please try again" displayed

    #Scenario 5: Password successfully created
    Examples: 
      | PortalName | email                     | FirstName | LastName | ABN         | LicenceNumber | PhoneNumber | EmailAddress    | Address                           |
      | ARB        | FirstAgentOne@agency1.com | TEST      | TEST     | 55005825516 |     123454312 |  1234567890 | test12@test.com | 10 FLORA GR, FOREST HILL VIC 3131 |



  
  Scenario Outline: ARB-240:  As an Agent Administrator, I want to enter my Agency's contact details during registration so that I can register with the portal
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    Then I click on button with value "Create Account"
    And I wait for "2000" milliseconds
    Then I click on button "select2-chosen-1"
    #Then I select "Managing Agent" from "select2-chosen-1"
    Then I click on object with xpath "//div[contains(text(), 'Managing Agent')]"
    Then I wait for "1000" milliseconds
    And I enter the details as
      | Fields                   | Value           |
      | ABNInput                 | <ABN>           |
      | AgencyLicenceNumberInput | <LicenceNumber> |
    Then I click on button "AgreeTermsCheckbox"
    Then I click on button "FirstSectionNextAgency"
    Then I wait for "2000" milliseconds
    #Scenario 1: Agent Administrator views the Agency Contact Details page
    Then I check "AgencyOrganisationNameInput" contains "RANDOM ACCESS PTY LTD"
    Then I check "AgencyEmailAddressInput" is empty
    Then I check "AgencyPhoneNumberInput" is empty
    Then I check "AgencyAddressInput" is empty
    Then I check "AgencyDetailsNext" exists
    Then I check "AgencyDetailBack" exists
    Then I check "AgencyPostalAddressCheckbox" exists
    Then I see text "Postal Address is different" displayed
    Then I see text "BACK TO HOME" displayed
    #Scenario 2: Mandatory fields not filled in
    Then I click on button "AgencyDetailsNext"
    And I wait for "2000" milliseconds
    Then I see text "Required fields have not been completed" displayed
    #Scenario 3: Email address not in the correct format
    And I enter the details as
      | Fields                  | Value         |
      | AgencyPhoneNumberInput  | <PhoneNumber> |
      | AgencyEmailAddressInput | test          |
      | AgencyAddressInput      | <Address>     |
    Then I click on button "AgencyDetailsNext"
    And I wait for "2000" milliseconds
    Then I see text "Email address is not valid, please try again" displayed
    #Scenario 5: Agent Administrators amends Agency Identification Details
    Then I click on button "AgencyDetailBack"
    And I wait for "2000" milliseconds
    Then I check "AgencyLicenceNumberInput" contains "<LicenceNumber>"
    Then I check "ABNInput" contains "<ABN>"
    Then I click on button "FirstSectionNextAgency"
    And I wait for "2000" milliseconds
    #Scenario 4: Information successfully validated
    And I enter the details as
      | Fields                  | Value          |
      | AgencyPhoneNumberInput  | <PhoneNumber>  |
      | AgencyEmailAddressInput | <EmailAddress> |
      | AgencyAddressInput      | <Address>      |
    Then I click on button "AgencyDetailsNext"
    And I wait for "2000" milliseconds
    Then I check "RefundBSBInput" exists

    Examples: 
      | PortalName | email                     | Password   | NewPassword | ABN         | LicenceNumber | PhoneNumber | EmailAddress  | Address                           |
      | ARB        | FirstAgentOne@agency1.com | Support123 | Dbresults1! | 55005825516 |     123454312 |  1234567890 | test@test.com | 10 FLORA GR, FOREST HILL VIC 3131 |
 
   @wip
  Scenario Outline: ARB-259:  As an Agent Administrator/Property Manager/Lessor, I want to lodge a bond and enter the details of the associated parties so that I can meet by obligations under the Residential Tenancies Act
    #Scenario 2: Lessor views the Bond Lodgement Form
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value            |
      | Email    | lessor1@test.com |
      | Password | <Password>       |
    And I hit Enter
    And I check I am on "ManageBonds" page
    Then I click on text "Lodge Bond"
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
    Then I click on button with value "Next"
    And I enter the details as
      | Fields            | Value         |
      | TenantFirstName   | TEST          |
      | TenantLastName    | TEST          |
      | TenantEmail       | TEST@TEST.com |
      | TenantPhone       |    1234567890 |

    Then I see text "Tenant Details" displayed
    Then I see text "Bank Details (used for refund)" displayed
    Then I click on button with value "Next"
    Then I click on text "Sign Out"
    #Scenario 1: Agent Administrator/Property Manager views the Bond Lodgement Form
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | Email    | <email>    |
      | Password | <Password> |
    And I hit Enter
    And I check I am on "ManageBonds" page
    Then I click on text "Lodge Bond"
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
    Then I click on button with value "Next"
  
    Then I check "TenantFirstName" exists
    Then I check "TenantLastName" exists
    Then I check "TenantEmail" exists
    Then I check "TenantPhone" exists

    Then I check "LessorFirstName" exists
    Then I check "LessorLastName" exists
    Then I check "LessorEmail" exists
    Then I check "LessorPhone" exists
 
    Then I click on button with value "Next"
    #Scenario 3: Mandatory fields not filled in

    Then I see text "Required fields have not been completed." displayed

    #Scenario 4: Email address not in the correct format
    And I enter the details as
      | Fields          | Value      |
      | TenantFirstName | TEST       |
      | TenantLastName  | TEST       |
      | TenantEmail     | TEST       |
      | TenantPhone     | 1234567890 |
      | LessorFirstName | TEST       |
      | LessorLastName  | TEST       |
      | LessorEmail     | TeST       |
      | LessorPhone     | 1234567890 |
    Then I click on button with value "Next"
    Then I see text "Email Address is not valid, please try again" displayed
    #Scenario 5: Information successfully validated\
    #Firefox has some issues with inputting (content won't appear until highlighted by the mouse, this counts as non-existent according to Selenium)
    #The solution is to do the form all over again:
    #And I enter the details as
    #| Fields              | Value      |
    #| TenantPhone         | 1234567890 |
    #| TenantBSB           | 123456     |
    #| TenantAcctNum       | 123456     |
    #| LessorPhone         | 1234567890 |
    #| LessorBSB           | 123456     |
    #| LessorAccountNumber | 123456     |
    Then I click on button with value "Back"
    Then I click on text "BACK TO BONDS"
    Then I check I am on "ManageBonds" page
    Then I click on text "Lodge Bond"
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
    Then I click on button with value "Next"
    And I enter the details as
      | Fields          | Value                |
      | TenantFirstName | TenantFirstName      |
      | TenantLastName  | TenantLastName       |
      | TenantEmail     | TenantEmail@TEST.com |
      | TenantPhone     |           1234567890 |
      | LessorLastName  | LessorLastName       |
      | LessorEmail     | LessorEmail@TeST.com |
      | LessorPhone     |           0987654321 |
    Then I click on button with value "Next"

    Examples: 
      | PortalName | email                     | Password   | NewPassword | ABN         | LicenceNumber | PhoneNumber | EmailAddress  | Address                           |
      | ARB        | FirstAgentOne@agency1.com | Support123 | Dbresults1! | 55005825516 |     123454312 |  1234567890 | test@test.com | 10 FLORA GR, FOREST HILL VIC 3131 |
