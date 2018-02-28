@InterfaceTestNew2 
 Feature: Test DB Operations Portal
 
 @InterfaceDBOps
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
	Then I click on text "Project List" 
	Then I wait for "1000" milliseconds 
	Then I click on text "Create a new Project" 
	And I enter the details as 
      | Fields           | Value             |
| ProjectName      | WP Test 5         |
| TimesheetApprover|Leon Madafferri    |
| ProjectSite      |101 Collins Street |
| ProjectStartDate | 11/12/2017        | 
| ProjectEndDate   | 18/12/2017        | 
           
    Then I select option "Internal" from "Project_ProjectTypeId" 
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
	Then I click on button with value "Send Request" 
	And I wait for "1000" milliseconds 
	And I see text "Project request successfully created" displayed 
	
   Examples:
    |PortalName | UserName   | Password      |
|DBOps | wenzil    |redRobin21|

 @InterfaceGPPageAccess
 Scenario Outline: As a DB Operation portal user I want to login and check tab availability.
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
	Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName        |
| item1 | Assignments           |
| item2 | Resourcing Approval   |
| item3 | Delivery Approval     |
| item4 | DMO Inbox             |
| item5 | Customer List         |
| item6 | Project List          |
| item7 | Employees             |
| item8 | Suppliers             |
    Then I click on text "<TabName>" 
    Then I wait for "1000" milliseconds 
    And I check I am on "<TabPage>" page
    Then I wait for "1000" milliseconds 
    
    | TabName         | TabPage             |
| Project List        | Projects            | 
| Assignments         | Assignments         |
| Resourcing Approval | AssignmentApproval  |
| Delivery Approval   | DeliveryApproval    |
| DMO Inbox           | DMOInbox            |
| Customer List       | Customer List       |
| Project List        | Projects            |
| Employees           | Employees           |
| Suppliers           | Suppliers           |

    
    #Then I click on text "Project List" 
	#Then I wait for "1000" milliseconds 
	#Then I check I am on "Projects" page 
	## Then I see text "Projects"
	#Then I click on text "Create a new Project" 
	#Then I click on text "Assignments" 
	#Then I wait for "1000" milliseconds 
	#And I check I am on "Assignments" page 
	#Then I wait for "1000" milliseconds 
	#Then I click on text "Resourcing Approval" 
	#And I check I am on "AssignmentApproval" page 
	#Then I wait for "1000" milliseconds 
	#Then I click on text "Delivery Approval" 
	#Then I wait for "1000" milliseconds 
	#Then I check I am on "DeliveryApproval" page 
	#Then I click on text "DMO Inbox" 
	#And I wait for "1000" milliseconds 
	#Then I check I am on "DMOInbox" page 
	#Then I click on text "Customer List" 
	#And I wait for "1000" milliseconds 
	#And I check I am on "Customer List" page 
	#And I wait for "1000" milliseconds 
	#Then I click on text "Project List" 
	#And I wait for "1000" milliseconds 
	#And I check I am on "Projects" page 
	#And I wait for "1000" milliseconds 
	#Then I click on text "Employees" 
	#And I wait for "1000" milliseconds 
	#And I check I am on "Employees" page 
	#And I wait for "1000" milliseconds 
	## And I see text "Create a new Employee" 
	#Then I click on text "Suppliers" 
	#And I wait for "1000" milliseconds 
	#Then I check I am on "Suppliers" page 
	#And I see text "Create a new Supplier" 
	#And I see text "Suppliers" 
	Then I click on text "logout" 
	
   Examples:
    |PortalName | UserName   | Password      |
|DBOps | wenzil    |redRobin21|
  