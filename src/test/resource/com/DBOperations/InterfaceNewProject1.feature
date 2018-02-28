 Feature: Test New Project Create page
@InterfaceTestNew2
 Scenario Outline: As a DB Operation portal user I want to Create a New Project.
 #Scenario 1: User accesses the DB Operations Portal 
 
    Given I want to login to portal "<PortalName>" 
	And I wait for "2000" milliseconds 
	And I check I am on "Login" page 
	And I enter the details as 
		| Fields   | Value      |
| UserName    | <UserName>    |
| Password | <Password> |
    And I hit Enter 
	Then I check I am on "HomePage" page 
	Then I see text "Welcome to the DB Operations Portal" displayed 
	# Then I click on text "logout"
	Then I click on text "Project List" 
	Then I wait for "1000" milliseconds 
	Then I click on text "Create a new Project" 
	And I enter the details as 
      | Fields           | Value             |
| ProjectName      | WP Test 4         |
| TimesheetApprover|Leon Madafferri    |
| ProjectSite      |101 Collins Street |
| ProjectStartDate | 11/12/2017        | 
| ProjectEndDate   | 18/12/2017        | 
           
    Then I select option "Internal" from "Project_ProjectTypeId"
  #  And I select "01-12-2017" from "Project_ProjectStartDate"
  #  And I select "10-12-2017" from "Project_ProjectEndDate"
    And I select option "Fixed Price" from "Project_ProjectEngagementId" 
	And I select option "Yarra Valley Water" from "Project_CustomerId" 
	And I select option "Southern" from "Project_LineOfBusiness" 
	And I select option "VIC" from "Project_Location" 
	And I select option "Project" from "Project_Service_Group3" 
	And I select option "Architecture" from "Project_Service_Group2" 
	And I select option "Yes" from "Project_Reimbursable" 
	And I select option "Comprehensive" from "Project_customer_relationship" 
	Then I click on text "Digital Services"
	Then I click on text "IP Owned By DB"
	Then I click on text "Exec Involved In Deal Shaping"
	Then I click on text "Standard Payment Terms"
	# Then I click on "Digital_Services" from checkbox "wtDigital_Services"
	Then I click on button with value "Send Request" 
	And I wait for "1000" milliseconds 
	And I see text "Project request successfully created" displayed 
	# And I select option "-" from "Project_customer_relationship"
	# And I see text "Required field!" displayed 
   Examples:
    |PortalName | UserName   | Password      |
|DBOps | wenzil    |redRobin21|
  