package Utilities;

import org.openqa.selenium.WebDriver;
//import org.seleniumhq.jetty7.util.log.Log;

public class HomePage extends DBUtilities {


	public HomePage(WebDriver dr)
	{
		 super(dr);
	}
	public void navigateTo(String arg1) {
		if (arg1.equals("ARB")) {
    			driver.get("https://actrevenueofficetrial.outsystemsenterprise.com/ARBAccountMgmt/Login.aspx");
		}
		
		else if(arg1.equals("AC CHECKER")){
			driver.get("http://achecker.ca/checker/index.php");
		}
	
		else if(arg1.equals("PasswordReset")){
			driver.get("https://actrevenueofficetrial.outsystemsenterprise.com/ARBAccountMgmt/ResetYourPassword.aspx?Activation=22642e88e5fa480ea59d");
		}
		else if(arg1.equals("BondSearch")){
			driver.get("https://actrevenueofficetrial.outsystemsenterprise.com/ARBBondLodgement/Search.aspx");
		}
	}
}
