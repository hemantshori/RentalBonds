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
| ProjectName      | WP Test 6         |
| TimesheetApprover|Leon Madafferri    |
| ProjectSite      |102 Collins Street |
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

 @InterfaceBrowsePageAccess
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
   
    
    Then I click on text "Project List" 
	Then I wait for "1000" milliseconds 
	Then I check I am on "Projects" page 
	## Then I see text "Projects"
	Then I click on text "Create a new Project" 
	Then I click on text "Assignments" 
	Then I wait for "1000" milliseconds 
	And I check I am on "Assignments" page 
	Then I wait for "1000" milliseconds 
	Then I click on text "Resourcing Approval" 
	And I check I am on "AssignmentApproval" page 
	Then I wait for "1000" milliseconds 
	Then I click on text "Delivery Approval" 
	Then I wait for "1000" milliseconds 
	Then I check I am on "DeliveryApproval" page 
	Then I click on text "DMO Inbox" 
	And I wait for "1000" milliseconds 
	Then I check I am on "DMOInbox" page 
	Then I click on text "Customer List" 
	And I wait for "1000" milliseconds 
	And I check I am on "Customer List" page 
	And I wait for "1000" milliseconds 
	Then I click on text "Project List" 
	And I wait for "1000" milliseconds 
	And I check I am on "Projects" page 
	And I wait for "1000" milliseconds 
	Then I click on text "Employees" 
	And I wait for "1000" milliseconds 
	And I check I am on "Employees" page 
	And I wait for "1000" milliseconds 
	## And I see text "Create a new Employee" 
	Then I click on text "Suppliers" 
	And I wait for "1000" milliseconds 
	Then I check I am on "Suppliers" page 
	#And I see text "Create a new Supplier" 
	#And I see text "Suppliers"
	Then I click on text "DB Operations Portal"
	And I check I am on "HomePage" page
	Then I click on button with value "Assignments"
	And I check I am on "Assignments" page
	And I wait for "1000" milliseconds
	Then I click on text "DB Operations Portal"
	And I check I am on "HomePage" page
	Then I click on button with value "Resourcing Approval"
	And I check I am on "AssignmentApproval" page
	And I wait for "1000" milliseconds
	Then I click on text "DB Operations Portal"
	And I check I am on "HomePage" page
	Then I click on button with value "Delivery Approval"
	And I check I am on "DeliveryApproval" page
	And I wait for "1000" milliseconds
	Then I click on text "DB Operations Portal"
	And I check I am on "HomePage" page
	Then I click on button with value "DMO Inbox"
	And I check I am on "DMOInbox" page
	And I wait for "1000" milliseconds
	Then I click on text "DB Operations Portal"
	And I check I am on "HomePage" page
	Then I click on button with value "Pending Records"
	And I check I am on "PendingRecords" page
	And I wait for "1000" milliseconds
	Then I click on text "DB Operations Portal"
	And I check I am on "HomePage" page
	Then I click on text "logout"
 Examples:
    |PortalName | UserName   | Password      | 
|DBOps | wenzil    |redRobin21 |
  
	
	@InterfaceAdminEmailUpdate
 Scenario Outline: As a DB Operation Admin user I want to update resourcing email.
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
   
    
Then I click on text "DB Operations Portal" 
And I check I am on "HomePage" page 
Then I click on button with value "Admin" 
And I check I am on "Admin" page 
And I wait for "1000" milliseconds 
And I enter the details as 
	| EField | EValue |
	| ResourcingEmail2     | <EValue1> |
	And I click on button with value "Update Resourcing Email" 
	Then I see popup "<Message>" displayed 
	And I wait for "1000" milliseconds 
	And I enter the details as 
		| EField | EValue |
		| ResourcingCC2     | <EValue2> |
		And I click on button with value "Update Resourcing CC" 
		Then I see popup "<Message1>" displayed 
		And I wait for "1000" milliseconds 
		And I enter the details as 
			| EField | EValue |
			| DMOInbox2     | <EValue3> |
			And I click on button with value "Update DMO Inbox" 
			Then I see popup "<Message2>" displayed 
			And I wait for "1000" milliseconds 
			And I enter the details as 
				| EField | EValue |
				| DeliveryEmail2     | <EValue4> |
				And I click on button with value "Update Delivery Email" 
				Then I see popup "<Message3>" displayed 
				And I wait for "1000" milliseconds 
				
				
				Then I click on text "logout" 
				
				
   Examples:
    |PortalName | UserName   | Password      | EValue1 | EValue2 | EValue3 | EValue4 | Message | Message1 | Message2 | Message3 |
|DBOps | wenzil    |redRobin21 | wenzil.puxty@dbresults.com.au | xyz2@dbresults.com.au | xyz3@dbresults.com.au | xyz4@dbresults.com.au | Successfully changed Delivery Emails to "EValue1" | Successfully changed Delivery Emails to "EValue2" | Successfully changed Delivery Emails to "EValue3" |  |
 
 
@InterfaceCreateNewCustomer 
Scenario Outline: As a DB Operation Admin user I want to create a new customer 

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
| item1 | My Activities |
| item2 | Assignments           |
| item3 | Resourcing Approval   |
| item4 | Delivery Approval     |
| item5 | DMO Inbox             |
| item6 | Customer List         |
| item7 | Project List          |

	
Then I click on text "Customer List" 
And I check I am on "Customer List" page 
Then I click on text "Request a new Customer" 
And I check I am on "CustomerNew" page 
And I wait for "1000" milliseconds 
And I enter the details as 
	| Fields                 | Value                 |
	| CustomerName           | My Fake 3             |
	| CustomerNotes          | My fake notes         |
	| TimeproId              | 1074                  |
	| ProjectName            | My Fake Project 3     |
	| ProjectStartDate       | 25/12/2017            |  
	| ProjectEndDate         | 25/01/2018            | 
	| ProjectDescription     | My fake description 3 |
	| Project_Summary        | My fake summary 3     |
	| ProjectSite            | 103 Collins Fake      |
	| ProjectNotes           | My fake notes 3       |
	
Then I select option "Outcome" from "ProjectTypeId" 























Then I select option "T&M" from "EngagementContractId" 
Then I select option "DB Results" from "BillingCompany" 
#Then I select option "Legal" from "Customer_IndustryId"
# And I click on "Submit"	
# Then I select "Legal" from "Customer_IndustryId" 
#Then I select "Wenzil Puxty" from "TimesheetApprover2" 
#Then I click on button with value "Send Request" 
#And I wait for "1000" milliseconds 
#Then I click on text "logout" 


Examples: 
	|PortalName | UserName              | Password      | DropDownValue1 | DropDownField |
	|DBOps      | testCreateCustomer    |redRobin21     | Legal          | Customer_IndustryId    |
	
 