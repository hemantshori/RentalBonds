 Feature: Login Action
 @InterfaceTestNew1
 Scenario Outline: As a DB Operation portal user I want to login to the Operations Portal.
 
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
	
   Examples:
		| PortalName | UserName   | Password      |
| DBOps | wenzil    |redRobin21|