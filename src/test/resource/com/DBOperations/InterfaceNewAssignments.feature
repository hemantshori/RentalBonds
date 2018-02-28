Feature: Test New Assignment Request
@InterfaceTestAssignments
 Scenario Outline: As a DB Operation portal user I want to Create a New Assignment Request.
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
	Then I click on text "Assignments" 
	Then I wait for "1000" milliseconds 
	And I select option "Simplot Australia" from "CustomerDropBox2" 
	Then I wait for "1000" milliseconds 
	And I select option "Simplot Australia - Office 365 OCM" from "ProjectDropBox" 
	Then I wait for "1000" milliseconds 
	And I select option "" from "Pending Assignments" 
	Then I wait for "1000" milliseconds 
	Then I click on button with value "Submit All" 
	
   Examples:
    |PortalName | UserName   | Password      |
|DBOps | wenzil    |redRobin21|