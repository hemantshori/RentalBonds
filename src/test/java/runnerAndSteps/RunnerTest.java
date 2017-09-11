package runnerAndSteps;

import org.junit.runner.RunWith;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;

// This is Runner and the tests will be run from here......Right click and Run as Junit tests
@RunWith(Cucumber.class)
@CucumberOptions

// ************************************** CSS Portal as on 17/10/2016
// OCT***********************************

(format = { "pretty", "html:target/html/result.html" }, tags = { "@wip" },
		// *********************for
		// SHAKEOUT*************************************
		// features = "src/test/resource/com/GESSIT/SanityTestScript.feature")

		// ****************for API****************************
		//features = "src/test/resource/com/RentalBonds/InterfaceTest.feature")

// ****************for Regression****************************
//features = "src/test/resource/com/RentalBonds/Iteration2.feature")
//features = "src/test/resource/com/RentalBonds/Iteration1Tests.feature")
//features = "src/test/resource/com/RentalBonds/WCAG.feature")



//****************for WIP****************************
 features = "src/test/resource/com/RentalBonds/wip.feature")



public class RunnerTest {

}
