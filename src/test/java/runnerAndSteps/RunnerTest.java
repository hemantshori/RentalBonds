package runnerAndSteps;

import org.junit.runner.RunWith;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;

// This is Runner and the tests will be run from here......Right click and Run as Junit tests
@RunWith(Cucumber.class)
@CucumberOptions

// ************************************** DB Operations Portal 21/11/2017
// ***********************************

(plugin = { "pretty", "html:target/html/result.html" }, tags = { "@InterfaceCreateNewCustomer"},
		// *********************for
		// SHAKEOUT*************************************
		// features = "src/test/resource/com/GESSIT/SanityTestScript.feature")

		// ****************for API****************************
		// features = "src/test/resource/com/RentalBonds/InterfaceTest.feature")

		// ****************for Regression****************************
		//features = "src/test/resource/com/RentalBonds/Iteration2.feature")
		// features =
		// "src/test/resource/com/RentalBonds/Iteration1Tests.feature")
		// features = "src/test/resource/com/RentalBonds/WCAG.feature")

		// ****************for @InterfaceTestNew1****************************
		// features = "src/test/resource/com/DBOperations/InterfaceLoginTest.feature")
		// **************** @InterfaceTestNew2 *************
		// features = "src/test/resource/com/DBOperations/InterfaceNewProject1.feature")
		// ***************@InterfaceGPPageAccess ************************
		// features = "src/test/resource/com/DBOperations/InterfaceGPPageAccess.feature")
        //***************@InterfaceTestAssignments ************************
		// features = "src/test/resource/com/DBOperations/InterfaceNewAssignments.feature")
        //***************@InterfaceTestAssignments ************************
		features = "src/test/resource/com/DBOperations/wip.feature")

public class RunnerTest {

}
