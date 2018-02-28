 Feature: Test DB Operations Portal Tab Access
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
	Then I click on text "Project List" 
	Then I wait for "1000" milliseconds 
	Then I check I am on "Projects" page
	# Then I see text "Projects"
	Then I click on text "Create a new Project"  
	Then I click on text "Assignments" 
	Then I wait for "1000" milliseconds 
	# Then I see text "Assignments" 
	And I see text "Select Customer" 
	Then I click on text "Resourcing Approval" 
	Then I wait for "1000" milliseconds 
	And I see text "Assignments Awaiting Approval" 
	Then I click on text "Delivery Approval" 
	Then I wait for "1000" milliseconds 
	Then I check I am on "DeliveryApproval" page 
	Then I see text "Requests Awaiting Approval" 
	Then I see text "Projects Awaiting Approval" 
	And I see text "Customers Awaiting Approval" 
	Then I click on text "DMO Inbox" 
	And I wait for "1000" milliseconds 
	Then I check I am on "DMOInbox" page 
	And I see text "Records Ready to Enter" 
	And I see text "Employees To Enter" 
	And I see text "Projects To Enter" 
	And I see text "Customers To Enter" 
	And I see text "Assignments to Enter" 
	Then I click on text "Customer List " 
	And I wait for "1000" milliseconds 
	Then I check I am on "Customer" page 
	And I see text "Request a new Customer" 
	Then I click on text "Employees" 
	And I wait for "1000" milliseconds 
	Then I check I am on "Employees" page 
	And I see text "Create a new Employee" 
	Then I click on text "Suppliers" 
	And I wait for "1000" milliseconds 
	Then I check I am on "Suppliers" page 
	And I see text "Create a new Supplier" 
	And I see text "Suppliers" 
	Then I click on text "logout" 
	
   Examples:
    |PortalName | UserName   | Password      |
|DBOps | wenzil    |redRobin21|
  