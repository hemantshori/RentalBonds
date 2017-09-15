package runnerAndSteps;

import java.awt.Robot;
import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.StringSelection;
import java.awt.event.KeyEvent;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Hashtable;
import java.util.List;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import static org.junit.Assert.assertThat;
import static org.hamcrest.CoreMatchers.containsString;
import org.apache.http.HttpStatus;
import org.apache.log4j.xml.DOMConfigurator;
import org.json.JSONException;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.Platform;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxBinary;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.firefox.FirefoxProfile;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.PageFactory;

import com.jayway.restassured.http.ContentType;

import Utilities.DBUtilities;
import Utilities.HomePage;

import static com.jayway.restassured.RestAssured.given;

import cucumber.api.DataTable;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import io.github.bonigarcia.wdm.FirefoxDriverManager;


public class StepImplementations {
	// ********************************************** following is before and
	// after *****************************************
	WebDriver driver;
	private String bolt;
	static String CapturedValue;
	private static final Logger Log = Logger.getLogger(StepImplementations.class.getName());
	public static String APIName;
	
	
	// all WCAG stuff
	static String Capture;
	static String sourceCode;
	static String URLCaptured;
	final String wcag_subdirectory = "wcagoutput";
	final String screenshot_subdirectory = "screenshots";
	BROWSER browser_type = BROWSER.FIREFOX; // change this to change what browser is used
	Hashtable<String, Integer> summary = new Hashtable<String, Integer>();
	
	public void logit()
	{
		DOMConfigurator.configure("log4j.xml");
	}
	
	@Before()
	public void startUp() {

			
		Log.info("opening Browser");
//		//+++++++++++++ FOR CHROME ++++++++++++++++++++++++++
		
//		// following is added to fix chrome maximise issue
		
		if (browser_type == BROWSER.CHROME){
			System.setProperty("webdriver.chrome.driver", "C:\\Program Files\\Automation Tools\\Drivers\\chromedriver.exe");
			ChromeOptions options = new ChromeOptions();
			options.addArguments("test-type");
			options.addArguments("start-maximized");
			options.addArguments("--js-flags=--expose-gc");
			options.addArguments("--enable-precise-memory-info");
			options.addArguments("--disable-popup-blocking");
			options.addArguments("--disable-default-apps");
			options.addArguments("test-type=browser");
			options.addArguments("disable-infobars");
			driver = new ChromeDriver(options);
		}
		else if (browser_type == BROWSER.FIREFOX){
			FirefoxDriverManager.getInstance().setup();
	        File browserAppPath = null;
	        
	        //check if the platform is windows
	        if (Platform.getCurrent().is(Platform.WINDOWS)) {
	            browserAppPath = new File("C:\\Program Files\\Mozilla Firefox\\firefox.exe");
	            
	            // alternative path
	            if (!browserAppPath.exists()) {
	               browserAppPath = new File("C:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe");
	           }
	        } 
	        else {
	           // Ubuntu
	           browserAppPath = new File("/usr/bin/firefox/firefox-bin");
	        }
	        
	        FirefoxBinary ffBinary = new FirefoxBinary(browserAppPath);
	        
	        // create a binary 
	        FirefoxProfile firefoxProfile = new FirefoxProfile();      
	        FirefoxOptions ffo = new FirefoxOptions().setBinary(ffBinary).setProfile(firefoxProfile);
	        driver = new FirefoxDriver(ffo); 

			
		
		}
		
//		ChromeOptions options = new ChromeOptions();
//		options.addArguments("test-type");
//		options.addArguments("start-maximized");
//		options.addArguments("--js-flags=--expose-gc");
//		options.addArguments("--enable-precise-memory-info");
//		options.addArguments("--disable-popup-blocking");
//		options.addArguments("--disable-default-apps");
//		options.addArguments("test-type=browser");
//		options.addArguments("disable-infobars");
//		driver = new ChromeDriver(options);
////		
		//+++++++++++++ FOR FIREFOX ++++++++++++++++++++++++++
	
	
		
	

	}
	// **************disable to leave browser
	// open***************************************

	@After()
	public void tearDown() {
		//driver.quit();
	}
	// ******************************************************************************

	// for Chrome driver
//	 System.setProperty("webdriver.chrome.driver", "C:\\Program
//	 Files\\Automation Tools\\Drivers\\chromedriver.exe");
//	 driver = new ChromeDriver();
//	 driver.manage().window().maximize();

	// for IE
	// System.setProperty("webdriver.chrome.driver", "C:\\Program
	// Files\\Automation Tools\\Drivers\\IEDriverServer.exe");
	// driver = new ChromeDriver();
	// driver.manage().window().maximize();

	// *****************************************************following are steps******************************************

	@Given("^I check if password is accepted$")
	public void i_check_if_password_is_accepted() throws Throwable {


	        try {
	        	
				if(driver.getPageSource().contains("Your email address or password is incorrect, please try again.")){ // other methods may not work
                  
					String txtToBeClicked = PageFactory.initElements(driver, DBUtilities.class).xpathMakerByTextInClass("caret");
					WebElement exist = driver.findElement(By.xpath(txtToBeClicked));
					exist.click();
					String txtToBeClicked2 = PageFactory.initElements(driver, DBUtilities.class).xpathMaker("SecutityLink");
					WebElement exist2 = driver.findElement(By.xpath(txtToBeClicked));
					exist.click();

				}else{
				Log.info("password accepted ...nothing to do");
				}
				
	        }
	        catch (Exception | AssertionError e){
	        	e.printStackTrace();
	        	throw e;
	        }
	}
	

	@Then("^I see text \"(.*?)\" displayed$")
	public void i_see_text_displayed(String arg1) throws Throwable {
      //LandingPage AU = PageFactory.initElements(driver, LandingPage.class);

        DBUtilities checkElementDisplayed = new DBUtilities(driver);

        try {
        	String myxpath = checkElementDisplayed.xpathMakerContainsText(arg1);                                // keep an eye...changed because of 520
			Log.info("Checking for text: " +myxpath);
			Assert.assertTrue(driver.getPageSource().contains(arg1)); // other methods may not work
        }
        catch (Exception | AssertionError e){
        	Log.info("text " +arg1 +"not found on the page");
        }
	}

	@Given("^I query interface \"(.*)?\"$")
	public void I_query_movie_by_title(String arg1) throws UnsupportedEncodingException {
		
		 Log.info("Logging into " +arg1);
	}

	@When("^I make the rest call to \"(.*)?\"$")
	public void I_make_the_rest_call(String arg1) throws IOException, JSONException {
	this.APIName = arg1;
	
     try{
    	 given().when().get(arg1).then().statusCode(200);
    	 given().when().get(arg1).then().assertThat().statusCode(HttpStatus.SC_OK);
    	 
     } catch (Exception e) {
    	Log.warning("Can not reach interface*******************************");
     }

	}

	@Then("^response should contain \"(.+)\"")
	public void response_should_contain(String expecgted_json_str) throws JSONException {
		
		String resp = given().accept(ContentType.JSON).when().get(this.APIName).thenReturn().body().asString();
		System.out.println(resp);
	}
	
	
	@Given("^I am testing story \"(.*?)\"$")
	public void i_am_test_story(String arg1) throws JSONException {
		
		Log.info("Now testing story " +arg1);
	}
	
	
	@Given("^I paste \"(.*?)\" value in \"(.*?)\"$")
	public void i_paste_value_in(String arg1, String arg2) throws Throwable {
		
		DBUtilities createXpath = new DBUtilities(driver);
		String myXpath = createXpath.xpathMakerById(arg2);
		Log.info("entering value in search field " +myXpath) ;
		//driver.findElement(By.xpath(myXpath)).click();
		driver.findElement(By.xpath(myXpath)).sendKeys(StepImplementations.Capture);
		
	}
	
	//******************************************* WCAG Stuff *************************************************************

	
	@Given("^I paste \"(.*?)\"$")
	public void i_paste(String arg1) throws Throwable {
		
		if(arg1.equals("BondId"))
		{
			
		}else{
			
		  System.out.println("Source code: " + sourceCode);
		
	      StringSelection selection = new StringSelection(sourceCode);
	      Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
			
			// get the what was originally in the clipboard so that it can be restored later
			String oldContent = (String) clipboard.getData(DataFlavor.stringFlavor);
			
			// set the clipboard contents as what was captured in the previous step(s)
			clipboard.setContents(selection, selection);
			

			// find the element
			WebElement inputField =  driver.findElement(By.xpath("//*[contains(@id, 'checkpaste')]"));
			inputField.click();
			
			//paste the captured stuff
			Actions actions = new Actions(driver);
			actions.keyDown(Keys.LEFT_CONTROL).sendKeys(String.valueOf('\u0076')).perform(); // this works on Firefox
			//actions.sendKeys(Keys.chord(Keys.LEFT_CONTROL, Keys.getKeyFromUnicode('V'))).build().perform();
			

			StringSelection oldSelection = new StringSelection(oldContent);
			clipboard.setContents(oldSelection, oldSelection);
		}
		
	}
	

	@And("^I take a \"(.*?)\" of row \"(.*?)\" from the table \"(.*?)\"$")
	public void i_capture_from_the_table(String arg1,String arg2, String arg3) throws Throwable {
		if(arg1.equals("click")){
		String myxpath = new DBUtilities(driver).xPathMakerForReadSomeRowOfSomeTable(arg2,arg3);
		WebElement rowToBeClicked =  driver.findElement(By.xpath(myxpath));
		rowToBeClicked.click();
	}else if(arg1.equals("capture")){
		String myxpath = new DBUtilities(driver).xPathMakerForReadSomeRowOfSomeTable(arg2,arg3);
		System.out.println("DEaling with table element " +myxpath);
		WebElement rowToBeCaptured =  driver.findElement(By.xpath(myxpath));
		  String captureElement = rowToBeCaptured.getText();
			System.out.println(captureElement);
			//this is specific case , change if required
			if(arg3.equals("DisputesTable")){
				Capture = captureElement.substring(10, 18);System.out.println(Capture);
			if(arg2.equals("ACAT"))
			{Capture = captureElement.substring(19, 26);System.out.println(Capture);
			}
			}else{
				Capture = captureElement.substring(0, 7);
			}
	
	}
	}
	
	@And("^I capture \"(.*?)\"$")
	public String i_capture(String arg1) throws Throwable {
		Thread.sleep(3000);
		if(arg1.equals("html")){
			sourceCode = driver.getPageSource();
			URLCaptured = driver.getCurrentUrl();
			if (!sourceCode.startsWith("<!DOCTYPE html>")){
				sourceCode = "<!DOCTYPE html>\n" + sourceCode;
			}
		}
		else if (arg1.equals("You have successfully lodged your Bond")){   // used for RB to capture Bond ID in string
			DBUtilities createXpath = new DBUtilities(driver);
			String myxpath = createXpath.xpathMakerContainsText(arg1);
			WebElement xyz = driver.findElement(By.xpath(myxpath));
		     String GetBondId = xyz.getText();
			Capture = GetBondId.substring(41, 48);
			System.out.println("*****************************FINAL RESULTS*****************************" +Capture);
		}else{
			DBUtilities createXpath = new DBUtilities(driver);
			//*[@id='38']
			String myxpath = createXpath.xpathMakerByExactId(arg1);
			//String myxpath = createXpath.xpathMakerById(arg1);
			System.out.println(myxpath);
					WebElement xyz = driver.findElement(By.xpath(myxpath));
			Capture= xyz.getText();
			System.out.println("*****************************FINAL RESULTS*****************************\n");
			System.out.println(URLCaptured + " HAS " + Capture + " WCAG ERRORS\n");
			System.out.println("***********************************************************************");
		}
		Thread.sleep(5000);
		return Capture;
  
	}
	
	@Given("^I write \"(.*?)\" information to file")
	public void i_write_information_to_file(String arg1) throws Throwable {
		
		// date format for timestamp in the filenames
		//DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH\ua789mm\ua789ss");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		String currentDate = dateFormat.format(cal.getTime());
		String outputText =  driver.findElement(By.xpath("//*[contains(@id, 'output_div')]")).getText();
		String lineSeparate = "-------------------------------------------------------------------------------------------";
		try {
			//write information to both files
			if (Integer.parseInt(Capture) > 0){ 
				PrintWriter pwsource = new PrintWriter(wcag_subdirectory + "/" + arg1 + " SOURCE CODE.html", "UTF-16");
				pwsource.write(sourceCode);
				pwsource.close();
			}
			PrintWriter pwinfo = new PrintWriter(wcag_subdirectory + "/" + arg1 + " WCAG EVALUATION.txt", "UTF-16");
			pwinfo.write("URL: " + URLCaptured);
			pwinfo.write("\n" + lineSeparate + "\n NUMBER OF ERRORS \n" + lineSeparate + "\n");
			pwinfo.write(Capture);
			pwinfo.write("\n" + lineSeparate + "\n OUTPUT TEXT \n" + lineSeparate + "\n");
			pwinfo.write(outputText);
			pwinfo.write("\n\n\n(NUMBER OF 'COLUMN's in the OUTPUT TEXT should equal the NUMBER OF ERRORS. If not, contact Chris Tang for assistance and bugfixing.)");
			
			pwinfo.close();

		}
		catch (IOException e){
			e.printStackTrace(); 
		}
		
		summary.put(arg1, Integer.parseInt(Capture));

	}
	
	
	//******************************************* UI *************************************************************
	@Given("^I want to login to portal \"(.*?)\"$")
	public void i_want_to_login_to_the_portal(String arg1) throws Throwable {
	  Log.info("logging into portal");
	  HomePage home = PageFactory.initElements(driver, HomePage.class);
		home.navigateTo(arg1);


	}

	@Then("^I wait for \"(.*?)\" milliseconds$")
	public void i_wait_for_millisecond(long arg1) throws Throwable {
		Thread.sleep(arg1);

	}
	@Given("^I enter the details as$")
	public void i_enter_the_details_as(DataTable table)  {
		try {
			PageFactory.initElements(driver, DBUtilities.class).enterCucumbertableValuesInUI(table);
		} catch (InterruptedException e) {
			
			e.printStackTrace();
		}	
	
	}
	
	@Then("^I enter \"(.*?)\" with the current date prepended into \"(.*?)\"$")
	public void i_enter_with_the_current_date_appended_into(String arg1, String arg2) throws Throwable{
		DBUtilities util = new DBUtilities(driver);
		String myXpath;
		String inputText = util.DNT() + arg1;
		myXpath = util.xpathMakerByInputId(arg2);
		try {	  
			  driver.findElement(By.xpath(myXpath)).clear();
		}
		catch (Exception e){
			  e.printStackTrace();
			  System.out.println("Cannot find an input field! Now trying to find a textarea field...");
			  myXpath = util.xpathMakerByTextAreaId(arg2);
			  driver.findElement(By.xpath(myXpath)).clear();
		}
		driver.findElement(By.xpath(myXpath)).sendKeys(inputText);
	}

	@Given("^I check I am on \"(.*?)\" page$")
	public void i_check_I_am_on_page(String arg1) {
		try{
		PageFactory.initElements(driver, HomePage.class).checkIfOnRightPage(arg1);

	Log.info("Landed on the right page " +arg1);
	}catch (Exception e) {
    	Log.warning("Not landed on  *******************************" +arg1);
     }
	}
	
	@And("^I hit Enter$")
	public DBUtilities I_hit_Enter() throws InterruptedException {
		PageFactory.initElements(driver, DBUtilities.class).hitEnter();
        Log.info("hitting Enter");
        
        Thread.sleep(2000);
		return PageFactory.initElements(driver, DBUtilities.class);
		
		
	}
	@Then("^\"(.*?)\" is displayed as \"(.*?)\"$")
	public void is_displayed_as(String arg1, String arg2, DataTable table) throws InterruptedException {
       
		PageFactory.initElements(driver, DBUtilities.class).checkElementPresentOnScreen(table);

	}
	
	
	@Then("^I see text \"(.*?)\" not displayed$")
	public void i_see_text_not_displayed(String arg1) throws Throwable {

		DBUtilities createXpath = new DBUtilities(driver);
		createXpath.checkTextElementAbsent(arg1);
	}
	
	@Then("^I click on text \"(.*?)\"$")
	public void i_click_on_text(String arg1) throws Throwable {
		if (arg1.equals("Users")){
			String txtToBeClicked = PageFactory.initElements(driver, DBUtilities.class).xpathMaker(arg1);
			WebElement exist = driver.findElement(By.xpath(txtToBeClicked));
			exist.click();
		}
		else {
			String txtToBeClicked = PageFactory.initElements(driver, DBUtilities.class).xpathMakerContainsText(arg1);
			WebElement exist = driver.findElement(By.xpath(txtToBeClicked));
			exist.click();
		}
		
	}
	

	
	@Then("^I check object with xpath \"(.*?)\" contains \"(.*?)\"$")
	public void i_check_object_with_xpath_contains(String arg1, String arg2) throws Throwable {
		DBUtilities createXpath = new DBUtilities(driver);
		String myxpath = arg1;
		try {
			WebElement inputBox = driver.findElement(By.xpath(myxpath));
			String contents = inputBox.getText().trim();
			
			Log.info("Comparing " + contents+ " with " + arg2);
			
			
			Assert.assertTrue(contents.equals(arg2));
		}
		catch (Exception | AssertionError e){
        	e.printStackTrace();
        }
	}
	

	@Then("^I check \"(.*?)\" contains \"(.*?)\"$")
	public void i_Check_contains(String arg1, String arg2) throws Throwable {
		DBUtilities createXpath = new DBUtilities(driver);
		String myxpath = createXpath.xpathMakerById(arg1);
		WebElement inputBox = driver.findElement(By.xpath(myxpath));
		String contents = inputBox.getAttribute("value");
		Log.info("Comparing " + contents+ " with " + arg2);
		
		try {
			Assert.assertTrue(contents.equals(arg2));
		}
		catch (AssertionError | Exception e){
//			try {
//				myxpath = myxpath.replace("*", "input");
//				inputBox = driver.findElement(By.xpath(myxpath));
//				boxContents = inputBox.getAttribute("value");
//				System.out.println("boxContents: " + boxContents);
//				System.out.println("arg2: " + arg2);
//				Assert.assertTrue(boxContents.equals(arg2));
//			}
//			//check for origvalue
//			catch (AssertionError | Exception ae){
//				try{
//					System.out.println("Attempting to search for origvalue...");
//					boxContents = inputBox.getAttribute("origvalue");
//					System.out.println("boxContents: " + boxContents);
//					System.out.println("arg2: " + arg2);
//					Assert.assertTrue(boxContents.equals(arg2));
//				}
//				catch (AssertionError | Exception ae2) {
//					// for input fields that default to the placeholder value when empty (very specific ones)
//					if (printErrors) ae2.printStackTrace();
//					System.out.println("Attempting to search for placeholder...");
//					boxContents = inputBox.getAttribute("placeholder");
//					System.out.println("boxContents: " + boxContents);
//					System.out.println("arg2: " + arg2);
//					Assert.assertTrue(boxContents.equals(arg2));
//				}
//			}
			e.printStackTrace();
		}
		

	}
	@And("^I click on button \"(.*?)\"$")
	public void i_click_on_button(String arg1) throws Throwable {
		String myXpath = null;
		DBUtilities createXpath = new DBUtilities(driver);
		
		if(arg1.equals("")){System.out.println(" Not expecting element to be present on screen so going to next step");}
		else if(arg1.equals("close"))
		{
			myXpath = createXpath.xpathMakerByTextInClass(arg1);
			driver.findElement(By.xpath(myXpath)).click();
		}else{
		
		try {
			myXpath = createXpath.xpathMakerById(arg1);
			driver.findElement(By.xpath(myXpath)).click();
		}
		catch (Exception e){
			e.printStackTrace();
			myXpath = createXpath.xpathMakerByClass(arg1);
			driver.findElement(By.xpath(myXpath)).click();
		}
		Thread.sleep(2000);
		
		}
	}
	
	@And("^I click on button with value \"(.*?)\"$")
	public void i_click_on_button_with_value(String arg1) throws Throwable {
		String myXpath = null;
		DBUtilities createXpath = new DBUtilities(driver);
		myXpath = createXpath.xpathMakerByValue(arg1);
		driver.findElement(By.xpath(myXpath)).click();

		
	}
	
	@Then("^I see \"(.*?)\" displayed on popup and I click \"(.*?)\"$")
	public void i_see_displayed_on_popup_and_I_click(String arg1, String arg2) throws Throwable {
   //Thread.sleep(3000);
		PageFactory.initElements(driver, DBUtilities.class).checkPopUpMessage(arg1, browser_type);
		PageFactory.initElements(driver, DBUtilities.class).clickOnPopUP(arg2);
		Thread.sleep(2000);
	}
	
	@Then("^I check \"(.*?)\" is empty$")
	public void i_check_is_empty(String arg1) throws Throwable {
		String myxpath = new DBUtilities(driver).xpathMakerById(arg1);
		WebElement inputBox = driver.findElement(By.xpath(myxpath));
		Assert.assertTrue(inputBox.isDisplayed());
		String boxContents = inputBox.getAttribute("value");
		try {
			Assert.assertTrue(boxContents.isEmpty());
		}
		// in the
		catch (Exception e){
			Assert.assertTrue(boxContents == null);
		}
	}
	
//wrong step......dont hard code
	@Then("^I click on object with xpath \"(.*?)\"$")
	public void i_click_on_object_with_xpath(String arg1) throws Throwable{
		try {
			WebElement object = driver.findElement(By.xpath(arg1));
			object.click();
		}
		catch (Exception e){
			e.printStackTrace();
		}
	}
	
	@Then("^I check \"(.*?)\" exists$")
	public void i_check_exists(String arg1) throws Throwable {
		DBUtilities checkElementDisplayed = new DBUtilities(driver);
		try {
			String myxpath = checkElementDisplayed.xpathMakerById(arg1);
			WebElement object = driver.findElement(By.xpath(myxpath));
			Assert.assertTrue(object.isDisplayed());
		}
		catch (Exception e){
			String myxpath = checkElementDisplayed.xpathMakerByClass(arg1);
			WebElement object = driver.findElement(By.xpath(myxpath));
			Assert.assertTrue(object.isDisplayed());
		}
		
		
	}
	
	// for those Outsystems popups, set argument as 0 or 1 if there is only one frame present
	@Then("^I switch to frame \"(.*?)\"$")
	public void i_switch_to_frame(String arg1) throws Throwable {
		int frameNum = Integer.parseInt(arg1);
		driver.switchTo().frame(frameNum);
	}
	
	@Then("^I clear \"(.*?)\" of content$")
	public void i_clear_of_content(String arg1) throws Throwable {
		DBUtilities checkElementDisplayed = new DBUtilities(driver);
		try {
			String myxpath = checkElementDisplayed.xpathMakerById(arg1);
			WebElement object = driver.findElement(By.xpath(myxpath));
			object.clear();
		}
		catch (Exception e){
			String myxpath = checkElementDisplayed.xpathMakerByClass(arg1);
			WebElement object = driver.findElement(By.xpath(myxpath));
			object.clear();
		}
	}
		
	@Then("^I check \"(.*?)\" is readonly$")
	public void i_check_is(String arg1) throws Throwable {
		PageFactory.initElements(driver, DBUtilities.class).elementIsreadOnly(arg1);
	}
	
	
	@Then("^I see popup \"(.*?)\" displayed$")
	public void i_see_popup_displayed(String arg1) throws Throwable {

		DBUtilities createXpath = new DBUtilities(driver);
		createXpath.xpathMakerByTextInClass(arg1);
	}
	
	@Given("^I enter popup values as$")
	public void i_enter_popup_values_as(DataTable table) throws Throwable {
		PageFactory.initElements(driver, DBUtilities.class).enterCucumbertableValuesInUI(table);

	}
	
	@And("^I click on \"(.*?)\" on popup$")
	public void i_click_on_popup(String arg1) throws Throwable {
		// give time for page loading
		DBUtilities createXpath = new DBUtilities(driver);
		String myxpath = createXpath.xpathMakerByValue(arg1);
		System.out.println("dededed");
		driver.findElement(By.xpath(myxpath)).click();

		}
	@And("^I select \"(.*?)\" from \"(.*?)\"$")
	public void i_select_from(String arg1, String arg2) throws Throwable {
	
		// following is RB special
		if (arg1.isEmpty())
		{
			Log.info("Element is not expected to appear on screen");
		}
		else if( arg1.equals("Property Manager")
				||arg1.equals("Agent Administrator")
				||arg1.equals("RBU Team Leader")
				||arg1.equals("RBU Officer")
				||arg1.equals("Housing Officer")
			    ||arg1.equals("ujaad singh"))
		{
			String myxpath = PageFactory.initElements(driver, DBUtilities.class).xpathMakerContainsText1stOption(arg1);
			String myxpath2 = PageFactory.initElements(driver, DBUtilities.class).xpathMakerById(arg2);
			System.out.println(" looking for dropdown xpath " +myxpath);
			driver.findElement(By.xpath(myxpath2)).click();
					Thread.sleep(1000);
					driver.findElement(By.xpath(myxpath)).click();
		}else{
		String myxpath = PageFactory.initElements(driver, DBUtilities.class).xpathMakerDivContainsText(arg1);
		String myxpath2 = PageFactory.initElements(driver, DBUtilities.class).xpathMakerById(arg2);
		System.out.println(" looking for dropdown xpath " +myxpath);
	driver.findElement(By.xpath(myxpath2)).click();
			Thread.sleep(1000);
			driver.findElement(By.xpath(myxpath)).click();
		
		}
		
	}
	
	
//	@Then("^I see element \"(.*?)\" displayed$")
//	public void i_see_element_displayed(DataTable table) throws Throwable {
//
//		List<List<String>> data = table.raw();
//			
//			for (int i = 1; i <data.size(); i++){
//				String name = data.get(i).get(1);
//				System.out.println("The table length is .." +data.size());	
//				
//			DBUtilities createXpath = new DBUtilities(driver);
//
//		createXpath.checkUIElementTEXTIsDisplayed(name);
//	}
//		
//	}
	
	
	@Then("^I see \"(.*?)\" element \"(.*?)\" displayed$")
	public void i_see_element_displayed(String arg1, String arg2, DataTable table) throws Throwable {
		List<List<String>> data = table.raw();
		
		for (int i = 1; i <data.size(); i++){
			String name = data.get(i).get(1);
			System.out.println("The table length is .." +data.size());	
			
		DBUtilities createXpath = new DBUtilities(driver);

	createXpath.checkUIElementTEXTIsDisplayed(name);
}
	}
	
	// this is for checking checkbox
	@Given("^I click on \"(.*?)\" checkbox$")
	public void i_click_on_checkbox(String arg1) throws Throwable {

		PageFactory.initElements(driver, DBUtilities.class).checkBoxClick(arg1);

	}
	
	@Then("^I see \"(.*?)\" is in \"(.*?)\" field and \"(.*?)\" is displayed as \"(.*?)\" in the row$")
	public void i_see_is_in_field_and_is_displayed_as(String arg1, String arg2, String arg3, String arg4,
			DataTable table) throws Throwable {
		PageFactory.initElements(driver, DBUtilities.class).checkRowValuesOrder(arg2, arg1, table);
	}
	
	@Then("^I \"(.*?)\" text \"(.*?)\" displayed in table \"(.*?)\"$")
	public void i_should_see_displayed_in_table(String arg1, String arg2, String arg3) throws Throwable {

		if (arg2.equals("selectTheFirstRow")){
			DBUtilities createXpath = new DBUtilities(driver);
			String checkFirstRowInTable = createXpath.xPathMakerForReadSomeRowOfSomeTable(arg2, arg3);
			//for a change putting double click
			driver.findElement(By.xpath(checkFirstRowInTable)).click();

		}else{
		
		if (arg1.equals("check")) {
			String checkElementInTable = PageFactory.initElements(driver, DBUtilities.class)
					.xpathMakerPickTrTextInTableID(arg2, arg3);
			// Assert.assertEquals(true, checkElementInTable.isDisplayed());
			Assert.assertTrue(driver.findElement(By.xpath(checkElementInTable)).isDisplayed());

		} else if (arg1.equals("click")) {
			
			if(arg2.equals("CheckBox")){
				
				// hard coded for now but need to resolve this later
				String checkBoxToClick = PageFactory.initElements(driver, DBUtilities.class)
						.xpathMakerByInputId("wtBondsList_ctl03_wt1");
				WebElement element =	driver.findElement(By.xpath(checkBoxToClick));
				element.click();
			
		}else{

			DBUtilities createXpath = new DBUtilities(driver);
			String checkElementInTable = createXpath.xpathMakerPickTrTextInTableID(arg2, arg3);
			System.out.println("clicking on table element " + arg1);
			driver.findElement(By.xpath(checkElementInTable)).click();

		}
		}
		}
	}
	
	// Then I check that table ARG with row containing ARG2 has the following
	
	@Then("^I check that table \"(.*?)\" with row containing \"(.*?)\" has the following$")
	public void i_should_see_displayed_in_table(String arg1, String arg2, DataTable table) throws Throwable {

		String tableXpath = PageFactory.initElements(driver, DBUtilities.class).xpathMakerPickTrTextInTableID(arg2, arg1);
		String rowContent = driver.findElements(By.xpath(tableXpath)).get(0).getText();
		System.out.println(rowContent);
		List<List<String>> tableData = table.raw();
		//List<String> rowContentList = Arrays.asList(rowContent.split("\n"));
		
		for (int i = 1; i < tableData.size(); i++){
			String data = tableData.get(i).get(1);
			System.out.println("Checking for " +data);
			
		
		try{
			assertThat(rowContent, containsString(data));
			
	
		}catch (Exception e){
		
		Log.info("Not found" +data);
		}
		// this step will click on table elements that generate popups, for some reason
		// use this to refresh the page and make the popups disappear
		driver.navigate().refresh();
		
		}
		

	}
	
	@Then("^I click on \"(.*?)\" radio option$")
	public void i_click_on_radio_option(String arg1) throws Throwable {

		// following is for Gessit only.....because of poor coding practice
		String myxpath = PageFactory.initElements(driver, DBUtilities.class).xpathMakerById(arg1);
		// for overlapping

		// myXpath = createXpath.xpathMakerById(arg1);
		WebElement elementToBeClicked = driver.findElement(By.xpath(myxpath));
	
		
		 try {
				Thread.sleep(1000);
				elementToBeClicked.click();
		    } catch (Exception e) {
		    	Actions actions = new Actions(driver);
		    	Thread.sleep(1000);
		    	actions.keyDown(Keys.CONTROL).sendKeys(Keys.END).perform();
		    	Thread.sleep(1000);
		    	elementToBeClicked.click();
		    }

	}
//	@Given("^I capture \"(.*?)\"$")
//	public String i_capture_someValue(String arg1) throws Throwable {
//
//		DBUtilities createXpath = new DBUtilities(driver);
//		
//		String myxpath = createXpath.xpathMakerById(arg1);
//		StepImplementations.CapturedValue = driver.findElement(By.xpath(myxpath)).getAttribute("value");
//		System.out.println("object that is captured is *****************>>>>>>>>>>>>>>>>>>>>>>>> " + CapturedValue);
//
//		return CapturedValue;
//
//	}
}
	
	//***********************************************************************************************************
	//***********************************************************************************************************
	//***********************************************************************************************************
	//***********************************************************************************************************
	//*****************************************GESSIT ***********************************************************
	//***********************************************************************************************************
	//***********************************************************************************************************
	//***********************************************************************************************************
	//***********************************************************************************************************
	
//	
//	@Given("^I capture \"(.*?)\"$")
//	public String i_capture(String arg1) throws Throwable {
//
//		DBUtilities createXpath = new DBUtilities(driver);
//		
//		String myxpath = createXpath.xpathMakerById(arg1);
//		Gessit_StepImplementations.CapturedValue = driver.findElement(By.xpath(myxpath)).getAttribute("value");
//		System.out.println("object that is captured is *****************>>>>>>>>>>>>>>>>>>>>>>>> " + CapturedValue);
//
//		return CapturedValue;
//
//	}
//
//	@Given("^I paste \"(.*?)\"$")
//	public void i_paste(String arg1) throws Throwable {
//
//
//		System.out.println(Gessit_StepImplementations.CapturedValue);
//		String htmlToBePasted = Gessit_StepImplementations.CapturedValue;
//
//		DBUtilities createXpath = new DBUtilities(driver);
//		String myXpath = createXpath.xpathMakerById(arg1);
//		driver.findElement(By.xpath(myXpath)).sendKeys(Gessit_StepImplementations.CapturedValue);
//	}
//
//	@And("^I click on captured \"(.*?)\"$")
//	public void i_click_on_captured(String arg1) throws Throwable {
//		System.out.println(Gessit_StepImplementations.CapturedValue);
//		String htmlToBePasted = Gessit_StepImplementations.CapturedValue;
//		DBUtilities createXpath = new DBUtilities(driver);
//		String myXpath = createXpath.xpathMaker(htmlToBePasted);
//		WebElement some_element = driver.findElement(By.xpath(myXpath));
//		System.out.println("clicking on element captured " +some_element);
//		some_element.click();
//
//
//	}
//	@Then("^I check \"(.*?)\" is not readonly$")
//	public void i_check_is_not_readonly(String arg1) throws Throwable {
//		DBUtilities createXpath = new DBUtilities(driver);
//		String myXpath = createXpath.xpathMakerById(arg1);
//		Thread.sleep(1000);
//		WebElement some_element = driver.findElement(By.xpath(myXpath));
//		// some_element.click();
//		Assert.assertTrue(some_element.isEnabled());
//	}
//
//	// to check if astrick is present on a mandatory field
//	@Given("^I check \"(.*?)\" is marked as \"(.*?)\"$")
//	public void i_check_is_marked_as(String arg1, String arg2) throws Throwable {
//		String myxpath = new DBUtilities(driver).xpathMakerById(arg1);
//		WebElement elementName = driver.findElement(By.xpath(myxpath));
//		System.out.println(elementName);
//		String myxpath2 = new DBUtilities(driver).xpathMakerByTextInClass(arg2);
//
//		// following is generating a combined xpath and then looking for element
//		String combineXPaths = new DBUtilities(driver).combine2Xpaths(myxpath, myxpath2);
//		System.out.println(combineXPaths);
//		WebElement elementName2 = driver.findElement(By.xpath(combineXPaths));
//		System.out.println(elementName2);
//		Assert.assertTrue(elementName2.isDisplayed());
//
//	}
//
//	@Then("^I check \"(.*?)\" contains \"(.*?)\"$")
//	public void i_Check_contains(String arg1, String arg2) throws Throwable {
//		DBUtilities createXpath = new DBUtilities(driver);
//		String myxpath = createXpath.xpathMakerById(arg1);
//		Thread.sleep(3000);
//		// System.out.println(myxpath);
//		// String elementToBeSearched = StepImpe.Capture;
//		// System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
//		// +elementToBeSearched);
//		// DBUtilities t1 = new DBUtilities(driver);
//		// t1.isTextPresent(elementToBeSearched);
//		WebElement inputBox = driver.findElement(By.xpath(myxpath));
//		String boxContents = inputBox.getAttribute("value");
//		System.out.println("boxContents: " + boxContents);
//		System.out.println("arg2: " + arg2);
//
//		try {
//			Assert.assertTrue(boxContents.equals(arg2));
//		} catch (AssertionError e) {
//			// for input fields that default to the placeholder value when empty
//			// (very specific ones)
//			e.printStackTrace();
//			System.out.println("Attempting to search for placeholder...");
//			boxContents = inputBox.getAttribute("placeholder");
//			System.out.println("boxContents: " + boxContents);
//			System.out.println("arg2: " + arg2);
//			Assert.assertTrue(boxContents.equals(arg2));
//		}
//		boxContents = null;
//		inputBox = null;
//		Thread.sleep(2000);
//
//	}
//
//	@Then("^I check \"(.*?)\" is empty$")
//	public void i_check_is_empty(String arg1) throws Throwable {
//		String myxpath = new DBUtilities(driver).xpathMakerById(arg1);
//		WebElement inputBox = driver.findElement(By.xpath(myxpath));
//		Assert.assertTrue(inputBox.isDisplayed());
//		String boxContents = inputBox.getAttribute("value");
//		Assert.assertTrue(boxContents.isEmpty());
//	}
//
//	// *************************************************************************************************************************
//
//	@Given("^I want to login to portal \"(.*?)\"$")
//	public void i_want_to_login_to_portal(String arg1) throws Throwable {
//		HomePage home = PageFactory.initElements(driver, HomePage.class);
//		home.navigateTo(arg1);
//
//	}
//
//	@And("^I hit Enter$")
//	public LandingPage I_hit_Enter() throws InterruptedException {
//		PageFactory.initElements(driver, LandingPage.class).hitEnter();
//		Thread.sleep(1000);
//
//		return PageFactory.initElements(driver, LandingPage.class);
//	}
//
//	@And("^I hit tab$")
//	public LandingPage I_hit_Tab() throws InterruptedException {
//		PageFactory.initElements(driver, LandingPage.class).hitTab();
//		Thread.sleep(1000);
//
//		return PageFactory.initElements(driver, LandingPage.class);
//	}
//
//	// will be used to tab out to activate a button incase the button is not
//	// activated.
//	@Given("^I Tab Out$")
//	public void i_Tab_Out() throws Throwable {
//		new DBUtilities(driver).tabOut();
//	}
//
//	@Then("^I click on image \"(.*?)\"$")
//	public void i_click_on_image(String arg1) throws Throwable {
//		try {
//			driver.manage().timeouts().implicitlyWait(20, TimeUnit.SECONDS);
//			LandingPage lp = PageFactory.initElements(driver, LandingPage.class);
//			String imgToBeClicked = PageFactory.initElements(driver, Gessit_AddPatientPage.class).clickOnImage(arg1);
//			// lp.clickOnImage(arg1);
//			WebElement exist = driver.findElement(By.xpath(imgToBeClicked));
//			exist.click();
//		} catch (Exception e) {
//			System.out.println("Shori saab, Element image not visible on Screen");
//		}
//	}
//
//	// click on text
//	@Then("^I click on text \"(.*?)\"$")
//	public void i_click_on_text(String arg1) throws Throwable {
//		if (arg1.equals("Request Referral to Liver Clinic")) {
//			String txtToBeClicked = PageFactory.initElements(driver, Gessit_AddPatientPage.class)
//					.xpathMakerContainsText2ndOption(arg1);
//			WebElement exist = driver.findElement(By.xpath(txtToBeClicked));
//			exist.click();
//		} else {
//			String txtToBeClicked = PageFactory.initElements(driver, Gessit_AddPatientPage.class)
//					.xpathMakerContainsText(arg1);
//			WebElement exist = driver.findElement(By.xpath(txtToBeClicked));
//			exist.click();
//		}
//	}
//
//	@And("^I click on button \"(.*?)\"$")
//	public void i_click_on_button(String arg1) throws Throwable {
//		Thread.sleep(1000);
//		Pattern datePattern = Pattern.compile("\\d\\d\\d\\d\\d\\d\\d\\d"); // date
//																			// pattern
//																			// as
//																			// used
//																			// in
//																			// the
//																			// calendar
//																			// popup
//		String myXpath = null;
//		DBUtilities createXpath = new DBUtilities(driver);
//		if (datePattern.matcher(arg1).matches()) {
//			myXpath = createXpath.xpathMakerContainsCustomField("dyc-date", arg1);
//			try {
//				driver.findElement(By.xpath(myXpath)).click();
//			} catch (Exception e) {
//				for (int i = 0; i < 100; i++) {
//					System.out.println("(" + myXpath + ")[" + i + "]");
//					try {
//						driver.findElement(By.xpath("(" + myXpath + ")[" + i + "]")).click();
//						break;
//					} catch (Exception e2) {
//						System.out.println();
//					}
//				}
//
//			}
//		}
//
//		else {
//			myXpath = createXpath.xpathMakerById(arg1);
//			WebElement exist = driver.findElement(By.xpath(myXpath));
//			System.out.println(exist.getText());
//			((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", exist);
//			exist.click();
//
//		}
//
//		Thread.sleep(2500);
//
//	}
//
//	@And("^I scroll \"(.*?)\" the page$")
//	public void i_scroll_the_page(String arg1) throws Throwable {
//		new DBUtilities(driver).scrollDownThePage(arg1);
//	}
//
//	
//	
//	@And("^I click on \"(.*?)\"$")
//	public void i_click_on(String arg1) throws Throwable {
//		// give time for page loading
//
//		if (arg1.equals("Create New Patient") || (arg1.equals("Care Units")))
//
//		{
//			Thread.sleep(3000);
//			DBUtilities createXpath2 = new DBUtilities(driver);
//			String myxpath = createXpath2.xpathMakerContainsText(arg1);
//			System.out.println("cliclking on " + myxpath);
//			Assert.assertTrue(driver.findElement(By.xpath(myxpath)).isDisplayed());
//			driver.findElement(By.xpath(myxpath)).click();
//
//		}
//
//		else if (arg1.equals("Welcome,")) {
//			DBUtilities createXpath2 = new DBUtilities(driver);
//			String myxpath3 = createXpath2.xpathMakerContainsText1stOption(arg1);
//			System.out.println("Clicking on element " +myxpath3);
//			driver.findElement(By.xpath(myxpath3)).click();
//
//		}
//
//		else {
//			DBUtilities createXpath = new DBUtilities(driver);
//			String myxpath = createXpath.xpathMaker(arg1);
//			// createXpath.scrollDownForElement(myxpath);
//			System.out.println("cliclking on " + myxpath);
//
//			if (driver.findElement(By.xpath(myxpath)).isDisplayed()) {
//				System.out.println("Element is Present" + myxpath);
//			} else {
//				System.out.println("Element is Absent SOOOOOO SCROLLING DOWN" + myxpath);
//				createXpath.scrollDownForElement(myxpath);
//			}
//			Thread.sleep(1000);
//
//			driver.findElement(By.xpath(myxpath)).click();
//
//		}
//		Thread.sleep(1000);
//
//	}
//
//	
//	
//	// ****************************************************
//
//	// this is for pop-up only
//
//	// *********************************************************
//	
//

//
//	// only in emergency as gessit has some pop up values that has duplicates
//	// thanks to poor programming practices
//
//	@Given("^I enter pop field \"(.*?)\" as \"(.*?)\"$")
//	public void i_enter_pop_field_as(String arg1, String arg2) throws Throwable {
//		String myxpath = PageFactory.initElements(driver, DBUtilities.class).clickOn2ndOptionOnPopup(arg1);
//		driver.findElement(By.xpath(myxpath)).sendKeys(arg2);
//
//	}
//
//	// for drop down
//	
//

//	
//
//	// same as above BUT this is for pop up as multiple elements detected.
//	@Then("^on popup I select \"(.*?)\" from \"(.*?)\"$")
//	public void on_popup_I_select_from(String arg1, String arg2) throws Throwable {
//		String myXpath = PageFactory.initElements(driver, DBUtilities.class).xpathMakerByExactId(arg2);
//		WebElement clickOn = driver.findElement(By.xpath(myXpath));
//		clickOn.click();
//		PageFactory.initElements(driver, DBUtilities.class).hitDown();
//		PageFactory.initElements(driver, DBUtilities.class).hitEnter();
//
//	}
//
//	// check for field text and text boxes
//	@And("^I enter the details as$")
//	public void I_enter_then_details_as(DataTable table) throws Throwable {
//
//		PageFactory.initElements(driver, DBUtilities.class).enterCucumbertableValuesInUI(table);
//		// In test
//		Thread.sleep(2000);
//
//	}
//
//	// simple wait
//	
//
//	// @And("^I enter then details as new$")
//	// public void enterCucumberTableValuesInUI(DataTable table) throws
//	// InterruptedException{
//	// PageFactory.initElements(driver,
//	// DBUtilities.class).enterCucumbertableValuesInUI(table);
//	//
//	// }
//
//	@Then("^I hover on \"(.*?)\" to verify \"(.*?)\" is displayed$")
//	public void i_hover_on_to_verify_is_displayed(String arg1, String arg2) throws Throwable {
//		PageFactory.initElements(driver, MakeAPaymentPage.class).hoverOverElement(arg1, arg2);
//
//	}
//
//	// Specifically for Gessit datepicker
//	@Then("^I use \"(.*?)\" to enter \"(.*?)\"$")
//	public void i_use_to_enter(String arg1, String arg2) throws Throwable {
//		String myxpath = PageFactory.initElements(driver, DBUtilities.class).xpathMakerById(arg1);
//		WebElement date = driver.findElement(By.xpath(myxpath));
//
//		Actions actions = new Actions(driver);
//		actions.moveToElement(date);
//		actions.click();
//		actions.sendKeys(arg2);
//		actions.build().perform();
//
//	}
//
//	// CHECK ELEMENT IS READ ONLY
//	@Then("^I check \"(.*?)\" is readonly$")
//	public void i_check_is(String arg1) throws Throwable {
//		PageFactory.initElements(driver, DBUtilities.class).elementIsreadOnly(arg1);
//	}
//

//
//	// *********************************************** read popup
//	// message********************************************
//	@Then("^I see \"(.*?)\" displayed on popup and I click \"(.*?)\"$")
//	public void i_see_displayed_on_popup_and_I_click(String arg1, String arg2) throws Throwable {
//		Thread.sleep(2000);
//		PageFactory.initElements(driver, DBUtilities.class).checkPopUpMessage(arg1);
//		PageFactory.initElements(driver, DBUtilities.class).clickOnPopUP(arg2);
//
//	}
//
//	// ***************************************************Landing
//	// Page********************************************************
//	@Then("^\"(.*?)\" is displayed as \"(.*?)\"$")
//	public void is_displayed_as(String arg1, String arg2, DataTable table) throws Throwable {
//
//		PageFactory.initElements(driver, LandingPage.class).checkElementPresentOnScreen(table);
//	}
//	// }
//
//	// this is for item link
//
//	@Then("^\"(.*?)\" link is displayed as \"(.*?)\"$")
//	public void link_is_displayed_as(String arg1, String arg2, DataTable table) throws Throwable {
//
//		PageFactory.initElements(driver, LandingPage.class).checkElementLinkPresentOnScreen(table);
//	}
//	// }
//
//	@Then("^\"(.*?)\" is NOT displayed as \"(.*?)\"$")
//	public void is_not_displayed_as(String arg1, String arg2, DataTable table) throws Throwable {
//		PageFactory.initElements(driver, LandingPage.class).checkTextElementAbsent(table);
//	}
//
//	// Read All SAs
//	@Then("^I read all \"(.*?)\" from the corousel$")
//	public void i_read_all_from_the_corousel(String arg1) throws Throwable {
//		PageFactory.initElements(driver, LandingPage.class).selectSAsFromCorousel(arg1);
//
//	}
//
//	// ******************************************************* new page is
//	// launched*********************************************
//	@Then("^a new page \"(.*?)\" is launched$")
//	public void a_new_page_is_launched(String arg1) throws Throwable {
//		String URL = driver.getCurrentUrl();
//		System.out.println(URL);
//		new DBUtilities(driver).passControlToNewWindow(arg1);
//
//	}
//
//	@Then("^I will see message \"(.*?)\"$") // this is just a workaround for the
//											// temp para coming in
//	public void i_will_see_message(String arg1) throws Exception {
//
//		Assert.assertTrue(driver.findElement(By.xpath("//*[contains(text(),arg1)]")).isDisplayed());
//		System.out.println("Message sucessfully displayed as " + arg1);
//		Thread.sleep(5000);
//	}
//
//	@When("^I view the left hand panel of screen$")
//	public void i_view_the_left_hand_panel_of_screen() throws Throwable {
//		System.out.println("Checking UI Elements on LHS of screen");
//		Thread.sleep(10000);
//	}
//
//	@Then("^I see \"(.*?)\" displayed$")
//	public void i_see_and_displayed(String arg1) throws Throwable {
//		PageFactory.initElements(driver, LandingPage.class).checkUIElementIsDisplayed(arg1);
//
//	}
//

//

//

//
//	// check i am on right page
//	@Given("^I check I am on \"(.*?)\" page$")
//	public void i_check_I_am_on_page(String arg1) throws Throwable {
//		PageFactory.initElements(driver, BillingHistoryPage.class).checkIfOnRightPage(arg1);
//
//		System.out.println(" on correct page " + arg1);
//	}
//
//	@Then("^I see sytem date displayed in \"(.*?)\"$")
//	public void i_see_sytem_date_displayed(String arg1) throws Throwable {
//		String date = PageFactory.initElements(driver, BillingHistoryPage.class).date();
//		String bodyText = PageFactory.initElements(driver, Gessit_AddPatientPage.class).xpathMakerById(arg1);
//		String downValue = driver.findElement(By.xpath(bodyText)).getText();
//		Assert.assertTrue("Text not found!", downValue.contains(date));
//	}
//
//	// check that a checkbox is checked
//	@Then("^I see checkbox \"(.*?)\" as selected$")
//	public void i_see_checkbox_as_selected(String arg1) throws Throwable {
//		DBUtilities createXpath = new DBUtilities(driver);
//		String myxpath = createXpath.xpathMakerById(arg1);
//		System.out.println("Checking if checkbox " + myxpath + " has been selected.");
//		Assert.assertTrue(driver.findElement(By.xpath(myxpath)).isSelected());
//	}
//
//	@Then("^I see checkbox \"(.*?)\" as not selected$")
//	public void i_see_checkbox_as_not_selected(String arg1) throws Throwable {
//		DBUtilities createXpath = new DBUtilities(driver);
//		String myxpath = createXpath.xpathMakerById(arg1);
//		System.out.println("Checking if checkbox " + myxpath + " has not been selected.");
//		Assert.assertFalse(driver.findElement(By.xpath(myxpath)).isSelected());
//	}
//
//	// check the dropdown displays expected
//	@Then("^\"(.*?)\" displays \"(.*?)\" by default$")
//	public void displays_by_default(String arg1, String arg2) throws Throwable {
//		DBUtilities createXpath = new DBUtilities(driver);
//		String myXpath = createXpath.xpathMakerContainsText(arg2);
//		WebElement dropdownValue = driver.findElement(By.xpath(myXpath));
//		System.out.println(dropdownValue.getText());
//		PageFactory.initElements(driver, AccountFinancialHistorypage.class).isTextPresent(arg2);
//
//		// DBUtilities createXpath = new DBUtilities(driver);
//		// String myxpath = createXpath.xpathMakerById(arg1);
//		// WebElement dropdown = driver.findElement(By.xpath(myxpath));
//		// Select mySelect = new Select(dropdown);
//		//
//		// String currentValue = mySelect.getFirstSelectedOption().getText();
//		// Assert.assertTrue(currentValue.equals(arg2));
//
//	}
//
//	// ***************************************** GRAPH CHECKS
//	// *********************
//	@Then("^the graph for \"(.*?)\" is displayed$")
//	public void the_graph_for_is_displayed(String arg1) throws Throwable {
//		DBUtilities createXpath = new DBUtilities(driver);
//		String myxpath = createXpath.xpathMakerById(arg1);
//		driver.findElement(By.xpath(myxpath)).click();
//	}
//
//	// ******************************************Compare values on
//	// screen*************************
//	@Then("^I compare \"(.*?)\" to \"(.*?)\"$")
//	public void i_compare_to(String arg1, String arg2) throws Throwable {
//		LandingPage compareValues = PageFactory.initElements(driver, LandingPage.class);
//		compareValues.compareValueOneToValueTwo(arg1, arg2);
//	}
//
//	// compare 2 values
//	@Then("^I verify \"(.*?)\" is \"(.*?)\" then \"(.*?)\"$")
//	public void i_verify_is_then(String arg1, String arg2, String arg3) throws Throwable {
//		DBUtilities val1 = new DBUtilities(driver);
//		String a = val1.xpathMakerById(arg1);
//		String currentValue1 = driver.findElement(By.xpath(a)).getText();
//		System.out.println(currentValue1);
//		String b = val1.xpathMakerById(arg3);
//		String currentValue2 = driver.findElement(By.xpath(b)).getText();
//		System.out.println(currentValue2);
//
//		DBUtilities compareAccountTotalToServiceTotal = new DBUtilities(driver);
//		String result = compareAccountTotalToServiceTotal.compare2DollarValues(currentValue1, currentValue2);
//
//		Assert.assertTrue(result.contains(arg2));
//
//	}
//
//	@Then("^I click on \"(.*?)\" radio option$")
//	public void i_click_on_radio_option(String arg1) throws Throwable {
//
//		// following is for Gessit only.....because of poor coding practice
//		String myxpath = PageFactory.initElements(driver, Gessit_AddPatientPage.class).xpathMakerByIdAndlabel(arg1);
//		// for overlapping
//
//		// myXpath = createXpath.xpathMakerById(arg1);
//		WebElement elementToBeClicked = driver.findElement(By.xpath(myxpath));
//		//System.out.println(elementToBeClicked.getText());
////		if (driver.findElement(By.xpath(myxpath)).isDisplayed())  {
////			System.out.println("Element is Present" +myxpath);
////		} else {
////			System.out.println("Element is Absent SOOOOOO SCROLLING DOWN");
////			DBUtilities createXpath = new DBUtilities(driver);
////			createXpath.scrollDownForElement(myxpath);
////		}
//		
//		 try {
//				Thread.sleep(1000);
//				elementToBeClicked.click();
//		    } catch (Exception e) {
//		    	Actions actions = new Actions(driver);
//		    	Thread.sleep(1000);
//		    	actions.keyDown(Keys.CONTROL).sendKeys(Keys.END).perform();
//		    	Thread.sleep(1000);
//		    	elementToBeClicked.click();
//		    }
//		
//
//
//
//	}
//
//	@And("^I check my \"(.*?)\"$")
//	public void i_check_my(String arg1) throws Throwable {
//		LandingPage checkMail = PageFactory.initElements(driver, LandingPage.class);
//		String myxpath = checkMail.xpathMakerByClass(arg1);
//		WebElement elementToBeClicked =  driver.findElement(By.xpath(myxpath));
//		elementToBeClicked.click();
//		
//		
//		
//	}
//	@Then("^I compare \"(.*?)\" to \"(.*?)\" to check if variation is displayed correctly$")
//	public void i_compare_to_to_check_if_variation_is_displayed_correctly(String arg1, String arg2) throws Throwable {
//		LandingPage compareValues = PageFactory.initElements(driver, LandingPage.class);
//		compareValues.compareValueOneToValueTwo(arg1, arg2);
//	}
//
//	// *****************************************************************************************
//	// **********************************************PAYMENT
//	// WINDOW*****************************
//	// *****************************************************************************************
//	@Then("^a new \"(.*?)\" window is open$")
//	public void a_new_window_is_open(String arg1) throws Throwable {
//		// to do... add test once bug is fixed.
//	}
//
//	// *****************************************************************************************
//	// **********************************************DATA BASE
//	// CONNECTION***********************
//	// *****************************************************************************************
//
//	@Given("^I want to connect to Webservice$")
//	public void i_want_to_connect_to_Webservice() throws Throwable {
//
//	}
//
//	// *****************************************************************************************
//	// **********************************************PDF FILE
//	// ***********************
//	// *****************************************************************************************
//
//	@Then("^I see a pdf document with name \"(.*?)\" generated$")
//	public void i_see_a_pdf_document_with_name_generated(String arg1) throws Throwable {
//		System.out.println("Yes******************* pdf is open");
//		// DBUtilities moveControlToNewWindow = new DBUtilities(driver);
//		new DBUtilities(driver).passControlToNewWindow(arg1);
//
//	}
//
//	// *****************************************************************************************
//	// **********************************************Verify Table Rows
//	// ***********************
//	// *****************************************************************************************
//
//	@Then("^I verify the \"(.*?)\" count is \"(.*?)\" to \"(.*?)\"$")
//	public void i_verify_the_count_is_to(String arg1, String arg2, int arg3) throws Throwable {
//		PageFactory.initElements(driver, AccountFinancialHistorypage.class).readAndCompareTableRows(arg1, arg2, arg3);
//
//	}
//
//	// ******************************CRAP**********************************
//	// @Given("^I copy and paste the html in \"(.*?)\"$")
//	// public void i_copy_and_paste_the_html_in_CIChecker(String arg1) throws
//	// Throwable {
//	// String html = driver.getPageSource();
//	// HomePage home = PageFactory.initElements(driver, HomePage.class);
//	// home.navigateTo(arg1);
//	// Thread.sleep(1000);
//	// driver.findElement(By.xpath("//*[contains(text(),'Paste HTML
//	// Markup')]")).click();
//	// Thread.sleep(1000);
//	// driver.findElement(By.xpath("//*[contains(@id,
//	// 'checkpaste')]")).sendKeys(html);
//	// Thread.sleep(3000);
//	//
//	//
//	// }
//
//	// **************************************************************************************************************************
//	// **************************************************************************************************************************
//	// **************************************************************************************************************************
//	// **************************************************************************************************************************
//	// ****************************************************UAP
//	// STEPS*************************************************************
//	// **************************************************************************************************************************
//	// **************************************************************************************************************************
//	// **************************************************************************************************************************
//	// **************************************************************************************************************************
//
//	@Given("^I read the table on \"(.*?)\" page$")
//	public void i_read_the_table_on_page(String arg1) throws Throwable {
//		new DBUtilities(driver).readTableAndCaptureInString(arg1);
//	}
//
//	// @Then("^I see the table \"(.*?)\" displayed$")
//	// public void i_see_the_table_displayed(String arg1) throws Throwable {
//	// PageFactory.initElements(driver,
//	// DBUtilities.class).checkUIElementTableIsDisplayed(arg1);
//	// }
//
//	// @And("^I see the number of \"(.*?)\" table records displayed$")
//	// public void i_see_the_number_of_table_records_displayed(String arg1)
//	// throws Throwable {
//	// PageFactory.initElements(driver,
//	// DBUtilities.class).checkNumberOfTableRecordsIsDisplayed(arg1);
//	// }
//	//
//	// @Then("^I see header \"(.*?)\" is displayed as \"(.*?)\" in table
//	// \"(.*?)\"$")
//	// public void i_see_header_is_displayed_as_in_table(String arg1, String
//	// arg2, String arg3, DataTable table) throws Throwable {
//	//
//	// PageFactory.initElements(driver,
//	// DBUtilities.class).checkTableHeadersOrder(arg3, table);
//	// }
//	//
//	// @And("^I see records in \"(.*?)\" are sorted by \"(.*?)\" in alphabetical
//	// order$")
//	// public void i_see_records_in_are_sorted_by_in_alphabetical_order(String
//	// arg1, String arg2) throws Throwable {
//	// PageFactory.initElements(driver,
//	// DBUtilities.class).checkTableRecordsOrder(arg1, arg2);
//	// }
//
//	// @And("^I click on Edit of \"(.*?)\" record$")
//	// public void i_click_on_Edit_of_record(String arg1) throws Throwable {
//	// Thread.sleep(3000);
//	// DBUtilities dbutilities = new DBUtilities(driver);
//	// WebElement myEdit = dbutilities.getEditbyRowNumber(arg1);
//	//
//	// JavascriptExecutor executor = (JavascriptExecutor)driver;
//	// executor.executeScript("arguments[0].scrollIntoView(true);",myEdit);
//	// myEdit.click();
//	// }
//	// TO DO for Justin toget the button name done.....later remove this step
//	// and use the generic step...
//	@Then("^I click on the \"(.*?)\" button$")
//	public void i_click_on_the_button(String arg1) throws Throwable {
//		Thread.sleep(3000);
//		DBUtilities dbutilities = new DBUtilities(driver);
//		String myxpath = dbutilities.xpathMaker(arg1);
//		WebElement mybutton = driver.findElement(By.xpath(myxpath));
//
//		JavascriptExecutor executor = (JavascriptExecutor) driver;
//		executor.executeScript("arguments[0].scrollIntoView(true);", mybutton);
//		mybutton.click();
//	}
//	// **************************************************************************************************************************
//	// **************************************************************************************************************************
//	// **************************************************************************************************************************
//	// **************************************************************************************************************************
//	// ************************************************Gessit Trial
//	// STEPS********************************************************
//	// **************************************************************************************************************************
//	// **************************************************************************************************************************
//	// **************************************************************************************************************************
//	// **************************************************************************************************************************
//
//	@Then("^I see the table \"(.*?)\" displayed$")
//	public void i_see_the_table_displayed(String arg1) throws Throwable {
//		PageFactory.initElements(driver, DBUtilities.class).checkUIElementTableIsDisplayed(arg1);
//	}
//
//	// @And("^I see the number of records are displayed in \"(.*?)\" table$")
//	// public void i_see_the_number_of_records_are_displayed_in(String arg1)
//	// throws Throwable {
//	// PageFactory.initElements(driver,
//	// DBUtilities.class).checkNumberOfTableRecordsIsDisplayed(arg1);
//	// }
//	//
//
//	// good example to convert string into webelement and vise versa

//
//	@Then("^I see header \"(.*?)\" is displayed as \"(.*?)\" in table \"(.*?)\"$")
//	public void i_see_header_is_displayed_as_in_table(String arg1, String arg2, String arg3, DataTable table)
//			throws Throwable {
//
//		PageFactory.initElements(driver, DBUtilities.class).checkTableHeadersOrder(arg3, table);
//	}
//
	
//
//	// @And("^I see records in \"(.*?)\" are sorted by \"(.*?)\" in alphabetical
//	// order$")
//	// public void i_see_records_in_are_sorted_by_in_alphabetical_order(String
//	// arg1, String arg2) throws Throwable {
//	// PageFactory.initElements(driver,
//	// DBUtilities.class).checkColumnValuesOrder(arg1, arg2);
//	// }
//
//	@And("^I click on \"(.*?)\" of the record with$")
//	public void i_click_on_of_the_record_with(String arg1, DataTable table) throws Throwable {
//		Thread.sleep(3000);
//		DBUtilities dbutilities = new DBUtilities(driver);
//		WebElement myElement = dbutilities.getElementbyRowIndexandClass(arg1, table);
//
//		JavascriptExecutor executor = (JavascriptExecutor) driver;
//		executor.executeScript("arguments[0].scrollIntoView(true);", myElement);
//		myElement.click();
//	}
//
//	@And("^I click on \"(.*?)\" of the \"(.*?)\" list from the record with$")
//	public void i_click_on_of_the_list_from_the_record_with(String arg1, String arg2, DataTable table)
//			throws Throwable {
//		Thread.sleep(3000);
//		DBUtilities dbutilities = new DBUtilities(driver);
//		WebElement myElement = dbutilities.getLinkFromListInTableRecord(arg2, arg1, table);
//
//		JavascriptExecutor executor = (JavascriptExecutor) driver;
//		executor.executeScript("arguments[0].scrollIntoView(true);", myElement);
//		myElement.click();
//	}
//
//	// Checking the value of element attributes, for example, checking the value
//	// of class, or type or value attributes
//	@And("^I check \"(.*?)\" of \"(.*?)\" field is \"(.*?)\"$")
//	public void i_check_of_field_is(String arg1, String arg2, String arg3) throws Throwable {
//		String myxpath = "//*[contains(@id, '" + arg2 + "')][@" + arg1 + " = '" + arg3 + "']";
//		System.out.println("checking ========= " + myxpath);
//		Assert.assertTrue(driver.findElement(By.xpath(myxpath)).isDisplayed());
//	}
//
//	@And("^I check \"(.*?)\" of \"(.*?)\" field is not \"(.*?)\"$")
//	public void i_check_of_field_is_not(String arg1, String arg2, String arg3) throws Throwable {
//		String myxpath = "//*[contains(@id, '" + arg2 + "')][@" + arg1 + " = '" + arg3 + "']";
//		System.out.println("checking ========= " + myxpath);
//		Assert.assertFalse(driver.findElement(By.xpath(myxpath)).isDisplayed());
//	}
//
//	// Checking if the checkbox is checked (only for Outsystems checkboxes)
//	@And("^I check the status of checkbox \"(.*?)\" is checked$")
//	public void i_check_the_status_of_checkbox_is_checked(String arg1) throws Throwable {
//		String myxpath = "//*[contains(@id, '" + arg1 + "')][contains(@class, 'Changed')]";
//		System.out.println("checking ========= " + myxpath);
//		Assert.assertTrue(driver.findElement(By.xpath(myxpath)).isDisplayed());
//	}
//
//	// Checking if the checkbox is unchecked (only for Outsystems checkboxes)
//	@And("^I check the status of checkbox \"(.*?)\" is not checked$")
//	public void i_check_the_status_of_checkbox_is_not_checked(String arg1) throws Throwable {
//		String myxpath = "//*[contains(@id, '" + arg1 + "')][contains(@class, 'Changed')]";
//		System.out.println("checking ========= " + myxpath);
//		Assert.assertFalse(driver.findElement(By.xpath(myxpath)).isDisplayed());
//	}
//
//	@And("^I click on radiobuttons as$")
//	public void i_click_on_radiobuttons_as(DataTable table) throws Throwable {
//		List<List<String>> data = table.raw();
//		DBUtilities dbutilities = new DBUtilities(driver);
//		for (int i = 1; i < data.size(); i++) {
//			String myxpath = dbutilities.getInputXpathByTypeAndId("radio", data.get(i).get(1));
//			WebElement myRadiobutton = driver.findElement(By.xpath(myxpath));
//			myRadiobutton.click();
//			Thread.sleep(5000);
//		}
//	}
//
//	@Then("^I check \"(.*?)\" \"(.*?)\" is displayed as \"(.*?)\"$")
//	public void i_check_is_displayed_as(String type, DataTable table) throws Throwable {
//		List<List<String>> data = table.raw();
//		DBUtilities dbutilities = new DBUtilities(driver);
//		boolean isDisplayed = true;
//		for (int i = 1; i < data.size(); i++) {
//			String myxpath = dbutilities.getInputXpathByTypeAndId(type, data.get(i).get(1));
//			if (!driver.findElement(By.xpath(myxpath)).isDisplayed()) {
//				isDisplayed = false;
//				break;
//			}
//		}
//		Assert.assertTrue(isDisplayed);
//	}
//
//	@Then("^I see values of fields are displayed as$")
//	public void i_see_values_of_fields_are_displayed_as(DataTable table) throws Throwable {
//		List<List<String>> data = table.raw();
//		DBUtilities dbutilities = new DBUtilities(driver);
//		boolean isDisplayed = true;
//		for (int i = 1; i < data.size(); i++) {
//			String myxpath1 = dbutilities.xpathMakerByInputId(data.get(i).get(0));
//			String myxpath2 = dbutilities.xpathMakerByValue(data.get(i).get(1));
//			String combineXpath = dbutilities.combine2Xpaths(myxpath1, myxpath2);
//			System.out.println("===========#########" + combineXpath);
//			if (!driver.findElement(By.xpath(combineXpath)).isDisplayed()) {
//				isDisplayed = false;
//			}
//		}
//		Assert.assertTrue(isDisplayed);
//	}
//
//	@Then("^I \"(.*?)\" date as \"(.*?)\" date \"(.*?)\" \"(.*?)\" days$")
//	// And I "verify" date as "today" date "plus" "4" days
//	public void i_date_as_date_days(String arg1, String arg2, String arg3, String arg4) throws Throwable {
//
//		if (arg2.equals("today")) {
//			String readDNT = new DBUtilities(driver).DNT();
//			String changedDate = readDNT + arg4;
//			System.out.println("+++++++++" + changedDate);
//
//		}
//
//	}
//
//	// 8888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
//
//	// only fill in elements if preseent on screen, use carefully
//	// 888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
//
//	@Given("^I enter the details if present$")
//	public void i_enter_the_details_if_present(DataTable table) throws Throwable {
//
//		PageFactory.initElements(driver, DBUtilities.class).enterCucumbertableValuesInUIOnlyIfPresent(table);
//		// In test
//		Thread.sleep(1000);
//
//	}
//
//	@And("^I click on \"(.*?)\" if present$")
//	public void i_click_on_if_present(String arg1) throws Throwable {
//		// give time for page loading
//
//		DBUtilities createXpath = new DBUtilities(driver);
//		String myxpath = createXpath.xpathMaker(arg1);
//		boolean isPresent = driver.findElements(By.xpath(myxpath)).size() > 0;
//
//		if (isPresent == true) {
//			driver.findElement(By.xpath(myxpath)).click();
//
//		} else {
//			System.out.println(
//					" Element not present so not doing anything as this function only does something when element is present");
//		}
//
//	}
//
//	@Then("^I click on \"(.*?)\" radio option if present$")
//	public void i_click_on_radio_option_if_present(String arg1) throws Throwable {
//
//		String myxpath = PageFactory.initElements(driver, Gessit_AddPatientPage.class).xpathMakerByIdAndlabel(arg1);
//		boolean isPresent = driver.findElements(By.xpath(myxpath)).size() > 0;
//		if (isPresent == true) {
//			driver.findElement(By.xpath(myxpath)).click();
//			System.out.println(" Selecting radio option " + arg1);
//		} else {
//			System.out.println(
//					" Element not present so not doing anything as this function only does something when element is present");
//		}

	
//	###########################    Gessit The end#############################################

