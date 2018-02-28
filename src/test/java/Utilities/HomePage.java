package Utilities;

import org.openqa.selenium.WebDriver;
//import org.seleniumhq.jetty7.util.log.Log;

public class HomePage extends DBUtilities {

	public HomePage(WebDriver dr) {
		super(dr);
	}

	public void navigateTo(String arg1) {
		if (arg1.equals("DBOps")) {
			driver.get("https://dbdigital.dev.dbresults.com.au/DBOperationsportal/HomePage.aspx");
		}

		else if (arg1.equals("AC CHECKER")) {
			driver.get("http://achecker.ca/checker/index.php");
		}

	}
}