@InterfaceCreateNewCustomer
Feature: dfxgxd

  Scenario Outline: As a DB Operation Admin user I want to create a new customer
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields   | Value      |
      | UserName | <UserName> |
      | Password | <Password> |
    And I hit Enter
    Then I check I am on "HomePage" page
    Then I see text "Welcome to the DB Operations Portal" displayed
    # Then I click on text "logout"
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName            |
      | item1 | My Activities       |
      | item2 | Assignments         |
      | item3 | Resourcing Approval |
      | item4 | Delivery Approval   |
      | item5 | DMO Inbox           |
      | item6 | Customer List       |
      | item7 | Project List        |
    Then I click on text "Customer List"
    And I check I am on "Customer List" page
    Then I click on text "Request a new Customer"
    And I check I am on "CustomerNew" page
    And I wait for "1000" milliseconds
    And I enter the details as
      | Fields             | Value                 |
      | CustomerName       | My Fake 3             |
      | CustomerNotes      | My fake notes         |
      | TimeproId          |                  1074 |
      | ProjectName        | My Fake Project 3     |
      | ProjectStartDate   | 25/12/2017            |
      | ProjectEndDate     | 25/01/2018            |
      | ProjectDescription | My fake description 3 |
      | Project_Summary    | My fake summary 3     |
      | ProjectSite        | 103 Collins Fake      |
      | ProjectNotes       | My fake notes 3       |
    Then I select option "Outcome" from "ProjectTypeId"
    Then I select option "T&M" from "EngagementContractId"
    Then I select option "DB Results" from "BillingCompany"
    Then I select option "Legal" from "Customer_IndustryId"
    And I click on "Submit"
    Then I select "Legal" from "Customer_IndustryId"
    Then I select "Wenzil Puxty" from "TimesheetApprover2"
    Then I click on button with value "Send Request"
    And I wait for "1000" milliseconds
    Then I click on text "logout"

    Examples: 
      | PortalName | UserName           | Password   | DropDownValue1 | DropDownField       |
      | DBOps      | testCreateCustomer | redRobin21 | Legal          | Customer_IndustryId |
