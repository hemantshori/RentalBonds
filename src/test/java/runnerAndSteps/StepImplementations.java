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
	BROWSER browser_type = BROWSER.CHROME; // change this to change what browser
											// is used
	Hashtable<String, Integer> summary = new Hashtable<String, Integer>();

	public void logit() {
		DOMConfigurator.configure("log4j.xml");
	}

	@Before()
	public void startUp() {

		Log.info("opening Browser");
		// //+++++++++++++ FOR CHROME ++++++++++++++++++++++++++

		// // following is added to fix chrome maximise issue

		if (browser_type == BROWSER.CHROME) {
			System.setProperty("webdriver.chrome.driver",
					"C:\\Program Files\\Automation Tools\\Drivers\\chromedriver.exe");
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

		} else if (browser_type == BROWSER.FIREFOX) {
			FirefoxDriverManager.getInstance().setup();
			File browserAppPath = null;

			// check if the platform is windows
			if (Platform.getCurrent().is(Platform.WINDOWS)) {
				browserAppPath = new File("C:\\Program Files\\Mozilla Firefox\\firefox.exe");

				// alternative path
				if (!browserAppPath.exists()) {
					browserAppPath = new File("C:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe");
				}
			} else {
				// Ubuntu
				browserAppPath = new File("/usr/bin/firefox/firefox-bin");
			}

			FirefoxBinary ffBinary = new FirefoxBinary(browserAppPath);

			// create a binary
			FirefoxProfile firefoxProfile = new FirefoxProfile();
			FirefoxOptions ffo = new FirefoxOptions().setBinary(ffBinary).setProfile(firefoxProfile);
			driver = new FirefoxDriver(ffo);

		}

		// ChromeOptions options = new ChromeOptions();
		// options.addArguments("test-type");
		// options.addArguments("start-maximized");
		// options.addArguments("--js-flags=--expose-gc");
		// options.addArguments("--enable-precise-memory-info");
		// options.addArguments("--disable-popup-blocking");
		// options.addArguments("--disable-default-apps");
		// options.addArguments("test-type=browser");
		// options.addArguments("disable-infobars");
		// driver = new ChromeDriver(options);
		////
		// +++++++++++++ FOR FIREFOX ++++++++++++++++++++++++++

	}
	// **************disable to leave browser
	// open***************************************

	@After()
	public void tearDown() {
		 driver.quit();
	}
	// ******************************************************************************

	// for Chrome driver
	// System.setProperty("webdriver.chrome.driver", "C:\\Program
	// Files\\Automation Tools\\Drivers\\chromedriver.exe");
	// driver = new ChromeDriver();
	// driver.manage().window().maximize();

	// for IE
	// System.setProperty("webdriver.chrome.driver", "C:\\Program
	// Files\\Automation Tools\\Drivers\\IEDriverServer.exe");
	// driver = new ChromeDriver();
	// driver.manage().window().maximize();

	// *****************************************************following are
	// steps******************************************

	@Given("^I adjust the zoom to \"(.*?)\"$")
	public void i_adjust_the_zoom_to(String arg1) throws Throwable {
		// Set up the zoom level....only use if required//

		JavascriptExecutor executor = (JavascriptExecutor) driver;
		executor.executeScript("document.body.style.zoom = '0.9'");
	}

	@Given("^I check if password is accepted$")
	public void i_check_if_password_is_accepted() throws Throwable {

		try {

			if (driver.getPageSource().contains("Your email address or password is incorrect, please try again.")) { // other
																														// methods
																														// may
																														// not
																														// work

				String txtToBeClicked = PageFactory.initElements(driver, DBUtilities.class)
						.xpathMakerByTextInClass("caret");
				WebElement exist = driver.findElement(By.xpath(txtToBeClicked));
				exist.click();
				String txtToBeClicked2 = PageFactory.initElements(driver, DBUtilities.class).xpathMaker("SecutityLink");
				WebElement exist2 = driver.findElement(By.xpath(txtToBeClicked));
				exist.click();

			} else {
				Log.info("password accepted ...nothing to do");
			}

		} catch (Exception | AssertionError e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Given("^I query interface \"(.*)?\"$")
	public void I_query_movie_by_title(String arg1) throws UnsupportedEncodingException {

		Log.info("Logging into " + arg1);
	}

	@When("^I make the rest call to \"(.*)?\"$")
	public void I_make_the_rest_call(String arg1) throws IOException, JSONException {
		this.APIName = arg1;

		try {
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

		Log.info("Now testing story " + arg1);
	}

	@Given("^I paste \"(.*?)\" value in \"(.*?)\"$")
	public void i_paste_value_in(String arg1, String arg2) throws Throwable {

		DBUtilities createXpath = new DBUtilities(driver);
		String myXpath = createXpath.xpathMakerById(arg2);
		Log.info("entering value in search field " + myXpath);
		// driver.findElement(By.xpath(myXpath)).click();
		driver.findElement(By.xpath(myXpath)).sendKeys(StepImplementations.Capture);

	}

	// ******************************************* WCAG Stuff
	// *************************************************************

	// @Given("^I paste \"(.*?)\"$")
	// public void i_paste(String arg1) throws Throwable {
	//
	// if(arg1.equals("BondId"))
	// {
	//
	// }else{
	//
	// System.out.println("Source code: " + sourceCode);
	//
	// StringSelection selection = new StringSelection(sourceCode);
	// Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
	//
	// // get the what was originally in the clipboard so that it can be
	// restored later
	// String oldContent = (String) clipboard.getData(DataFlavor.stringFlavor);
	//
	// // set the clipboard contents as what was captured in the previous
	// step(s)
	// clipboard.setContents(selection, selection);
	//
	//
	// // find the element
	// WebElement inputField = driver.findElement(By.xpath("//*[contains(@id,
	// 'checkpaste')]"));
	// inputField.click();
	//
	// //paste the captured stuff
	// Actions actions = new Actions(driver);
	// actions.keyDown(Keys.LEFT_CONTROL).sendKeys(String.valueOf('\u0076')).perform();
	// // this works on Firefox
	// //actions.sendKeys(Keys.chord(Keys.LEFT_CONTROL,
	// Keys.getKeyFromUnicode('V'))).build().perform();
	//
	//
	// StringSelection oldSelection = new StringSelection(oldContent);
	// clipboard.setContents(oldSelection, oldSelection);
	// }
	//
	// }

	@And("^I take a \"(.*?)\" of row \"(.*?)\" from the table \"(.*?)\"$")
	public void i_capture_from_the_table(String arg1, String arg2, String arg3) throws Throwable {
		if (arg1.equals("click")) {
			String myxpath = new DBUtilities(driver).xPathMakerForReadSomeRowOfSomeTable(arg2, arg3);
			WebElement rowToBeClicked = driver.findElement(By.xpath(myxpath));
			rowToBeClicked.click();
		} else if (arg1.equals("capture")) {
			String myxpath = new DBUtilities(driver).xPathMakerForReadSomeRowOfSomeTable(arg2, arg3);
			System.out.println("DEaling with table element " + myxpath);
			WebElement rowToBeCaptured = driver.findElement(By.xpath(myxpath));
			String captureElement = rowToBeCaptured.getText();
			System.out.println(captureElement);
			// this is specific case , change if required
			if (arg3.equals("DisputesTable")) {
				Capture = captureElement.substring(10, 18);
				System.out.println(Capture);
				if (arg2.equals("ACAT")) {
					Capture = captureElement.substring(19, 26);
					System.out.println(Capture);
				}
			} else {
				Capture = captureElement.substring(0, 7);
			}

		}
	}

	@Then("^I take a \"(.*?)\" of \"(.*?)\" element of row \"(.*?)\" from the table \"(.*?)\"$")
	public void i_take_a_of_element_of_row_from_the_table(String arg1, int arg2, int arg3, String arg4)
			throws Throwable {
		if (arg1.equals("capture")){
			String myxpath = new DBUtilities(driver).xPathMakerForSomeElementOfSomeRowOfSomeTable(arg2, arg3,arg4);
		System.out.println("DEaling with table element " + myxpath);
		WebElement elementToBeCaptured = driver.findElement(By.xpath(myxpath));
		String captureElement = elementToBeCaptured.getText();
		Capture = captureElement;
		System.out.println(captureElement);
		
			
		}else{
		String myxpath = new DBUtilities(driver).xPathMakerForSomeElementOfSomeRowOfSomeTable(arg2, arg3, arg4);
		System.out.println("DEaling with table element " + myxpath);
		WebElement xyz = driver.findElement(By.xpath(myxpath));
		Actions act = new Actions(driver);
		//will click on Bulls eye
		act.moveToElement(xyz, 10, 25).click().build().perform();
		//xyz.click();
	}
	
}

	@And("^I capture \"(.*?)\"$")
	public String i_capture(String arg1) throws Throwable {
		Thread.sleep(3000);
		if (arg1.equals("html")) {
			sourceCode = driver.getPageSource();
			URLCaptured = driver.getCurrentUrl();
			if (!sourceCode.startsWith("<!DOCTYPE html>")) {
				sourceCode = "<!DOCTYPE html>\n" + sourceCode;
			}
		} else if (arg1.equals("You have successfully raised Bond")) { // used
																			// for
																			// RB
																			// to
																			// capture
																			// Bond
																			// ID
																			// in
																			// string
			DBUtilities createXpath = new DBUtilities(driver);
			String myxpath = createXpath.xpathMakerContainsText(arg1);
			WebElement xyz = driver.findElement(By.xpath(myxpath));
			String GetBondId = xyz.getText();
			Capture = GetBondId.substring(36, 43);
			System.out.println("*****************************FINAL RESULTS*****************************" + Capture);
		} else {
			DBUtilities createXpath = new DBUtilities(driver);
			// *[@id='38']
			String myxpath = createXpath.xpathMakerByExactId(arg1);
			// String myxpath = createXpath.xpathMakerById(arg1);
			System.out.println(myxpath);
			WebElement xyz = driver.findElement(By.xpath(myxpath));
			Capture = xyz.getText();
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
		// DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd
		// HH\ua789mm\ua789ss");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		String currentDate = dateFormat.format(cal.getTime());
		String outputText = driver.findElement(By.xpath("//*[contains(@id, 'output_div')]")).getText();
		String lineSeparate = "-------------------------------------------------------------------------------------------";
		try {
			// write information to both files
			if (Integer.parseInt(Capture) > 0) {
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
			pwinfo.write(
					"\n\n\n(NUMBER OF 'COLUMN's in the OUTPUT TEXT should equal the NUMBER OF ERRORS. If not, contact Chris Tang for assistance and bugfixing.)");

			pwinfo.close();

		} catch (IOException e) {
			e.printStackTrace();
		}

		summary.put(arg1, Integer.parseInt(Capture));

	}

	// ******************************************* UI
	// *************************************************************
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
	public void i_enter_the_details_as(DataTable table) {
		try {
			PageFactory.initElements(driver, DBUtilities.class).enterCucumbertableValuesInUI(table);
		} catch (InterruptedException e) {

			e.printStackTrace();
		}

	}

	@Then("^I enter \"(.*?)\" with the current date prepended into \"(.*?)\"$")
	public void i_enter_with_the_current_date_appended_into(String arg1, String arg2) throws Throwable {
		DBUtilities util = new DBUtilities(driver);
		String myXpath;
		String inputText = util.date() + arg1;
		myXpath = util.xpathMakerByInputId(arg2);
		try {
			driver.findElement(By.xpath(myXpath)).clear();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Cannot find an input field! Now trying to find a textarea field...");
			myXpath = util.xpathMakerByTextAreaId(arg2);
			driver.findElement(By.xpath(myXpath)).clear();
		}
		driver.findElement(By.xpath(myXpath)).sendKeys(inputText);
	}

	@Given("^I check I am on \"(.*?)\" page$")
	public void i_check_I_am_on_page(String arg1) {
		try {
			PageFactory.initElements(driver, HomePage.class).checkIfOnRightPage(arg1);

			Log.info("Landed on the right page " + arg1);
		} catch (Exception e) {
			Log.warning("Not landed on  *******************************" + arg1);
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

	@Then("^I see text \"(.*?)\" displayed$")
	public void i_see_text_displayed(String arg1) throws Throwable {
		// LandingPage AU = PageFactory.initElements(driver, LandingPage.class);

		DBUtilities checkElementDisplayed = new DBUtilities(driver);

		checkElementDisplayed.checkTextElementPresent(arg1);

	}

	@Then("^I click on text \"(.*?)\"$")
	public void i_click_on_text(String arg1) throws Throwable {
		if (arg1.equals("Users")) {
			String txtToBeClicked = PageFactory.initElements(driver, DBUtilities.class).xpathMaker(arg1);
			WebElement exist = driver.findElement(By.xpath(txtToBeClicked));
			Log.info("clicking on " + exist);
			exist.click();
			// this is just add comment
		} else if (arg1.equals("+ ADD COMMENT")) {
			String txtToBeClicked = PageFactory.initElements(driver, DBUtilities.class).xpathMakerContainsText(arg1);
			WebElement exist = driver.findElement(By.xpath(txtToBeClicked));
			exist.click();
		} else if (arg1.equals("CLAIM BOND") || (arg1.equals("REQUEST REFUND"))) {
			String txtToBeClicked = PageFactory.initElements(driver, DBUtilities.class)
					.xpathMakerContainsText2ndOption(arg1);
			WebElement exist = driver.findElement(By.xpath(txtToBeClicked));
			exist.click();
		}
		else if (arg1.equals("")) {
			System.out.println(" Not expecting element to be present on screen so going to next step");
		} else if (!arg1.equals("")) 

		 {
			
			String txtToBeClicked = PageFactory.initElements(driver, DBUtilities.class).xpathMaker(arg1);
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

			Log.info("Comparing " + contents + " with " + arg2);

			Assert.assertTrue(contents.equals(arg2));
		} catch (Exception | AssertionError e) {
			e.printStackTrace();
		}
	}

	@Then("^I check \"(.*?)\" contains \"(.*?)\"$")
	public void i_Check_contains(String arg1, String arg2) throws Throwable {
		DBUtilities createXpath = new DBUtilities(driver);
		String myxpath = createXpath.xpathMakerById(arg1);
		WebElement inputBox = driver.findElement(By.xpath(myxpath));
		String contents = inputBox.getAttribute("value");
		Log.info("Comparing " + contents + " with " + arg2);

		try {
			Assert.assertTrue(contents.equals(arg2));
		} catch (AssertionError | Exception e) {
			// try {
			// myxpath = myxpath.replace("*", "input");
			// inputBox = driver.findElement(By.xpath(myxpath));
			// boxContents = inputBox.getAttribute("value");
			// System.out.println("boxContents: " + boxContents);
			// System.out.println("arg2: " + arg2);
			// Assert.assertTrue(boxContents.equals(arg2));
			// }
			// //check for origvalue
			// catch (AssertionError | Exception ae){
			// try{
			// System.out.println("Attempting to search for origvalue...");
			// boxContents = inputBox.getAttribute("origvalue");
			// System.out.println("boxContents: " + boxContents);
			// System.out.println("arg2: " + arg2);
			// Assert.assertTrue(boxContents.equals(arg2));
			// }
			// catch (AssertionError | Exception ae2) {
			// // for input fields that default to the placeholder value when
			// empty (very specific ones)
			// if (printErrors) ae2.printStackTrace();
			// System.out.println("Attempting to search for placeholder...");
			// boxContents = inputBox.getAttribute("placeholder");
			// System.out.println("boxContents: " + boxContents);
			// System.out.println("arg2: " + arg2);
			// Assert.assertTrue(boxContents.equals(arg2));
			// }
			// }
			e.printStackTrace();
		}

	}

	
	@And("^I click on button \"(.*?)\"$")
	public void i_click_on_button(String arg1) throws Throwable {
		String myXpath = null;
		DBUtilities createXpath = new DBUtilities(driver);

		if (arg1.equals("")) {
			System.out.println(" Not expecting element to be present on screen so going to next step");
		} else if (arg1.equals("close")) {
			myXpath = createXpath.xpathMakerByTextInClass(arg1);
			driver.findElement(By.xpath(myXpath)).click();
		} else {

			try {
				myXpath = createXpath.xpathMakerById(arg1);
				driver.findElement(By.xpath(myXpath)).click();
			} catch (Exception e) {

				if (driver.findElement(By.xpath(myXpath)).isDisplayed()) {
					System.out.println("Element is Present" + myXpath);
				} else {
					System.out.println("Element is Absent SOOOOOO SCROLLING DOWN" + myXpath);
					createXpath.scrollDownForElement(myXpath);
				}
				Thread.sleep(1000);

				driver.findElement(By.xpath(myXpath)).click();

				// delete it later if allis well 19/09/17
				// e.printStackTrace();
				// myXpath = createXpath.xpathMakerByClass(arg1);
				// driver.findElement(By.xpath(myXpath)).click();
			}
			Thread.sleep(2000);

		}
	}
	
	@And("^button \"(.*?)\" should not be displayed$")
		
		public void buttonShouldNotBeDisplayed(String arg1)	
			{
		if (arg1.equals("")) {
			System.out.println(" Not expecting element to be present on screen so going to next step");
		} else if (!arg1.equals("")) {
		DBUtilities createXpath = new DBUtilities(driver);
		createXpath.checkTextElementAbsent(arg1);	
			}
			}
	@And("^I click on button with value \"(.*?)\"$")
	public void i_click_on_button_with_value(String arg1) throws Throwable {
		String myXpath = null;
		DBUtilities createXpath = new DBUtilities(driver);
		try {
			myXpath = createXpath.xpathMakerByValue(arg1);
			Log.info("Clicking on element with xpath" +myXpath);
			Actions act = new Actions(driver);
			//will only click on visible element
			act.moveToElement(driver.findElement(By.xpath(myXpath))).click().build().perform();

		} catch (Exception e) {

			System.out.println("Element is Absent SOOOOOO SCROLLING DOWN" + myXpath);
			createXpath.scrollDownForElement(myXpath);
			myXpath = createXpath.xpathMakerByValue(arg1);
			//driver.findElement(By.xpath(myXpath)).click();
			Actions act = new Actions(driver);
			//will only click on visible element
			act.moveToElement(driver.findElement(By.xpath(myXpath))).click().build().perform();
		}
		Thread.sleep(1000);

	}

	@Then("^I see \"(.*?)\" displayed on popup and I click \"(.*?)\"$")
	public void i_see_displayed_on_popup_and_I_click(String arg1, String arg2) throws Throwable {
		// Thread.sleep(3000);
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
		catch (Exception e) {
			Assert.assertTrue(boxContents == null);
		}
	}

	// wrong step......dont hard code
	@Then("^I click on object with xpath \"(.*?)\"$")
	public void i_click_on_object_with_xpath(String arg1) throws Throwable {
		try {
			WebElement object = driver.findElement(By.xpath(arg1));
			object.click();
		} catch (Exception e) {
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
		} catch (Exception e) {
			String myxpath = checkElementDisplayed.xpathMakerByClass(arg1);
			WebElement object = driver.findElement(By.xpath(myxpath));
			Assert.assertTrue(object.isDisplayed());
		}

	}

	// for those Outsystems popups, set argument as 0 or 1 if there is only one
	// frame present
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
		} catch (Exception e) {
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
		if (arg1.isEmpty()) {
			Log.info("Element is not expected to appear on screen");
		} else if (arg1.equals("Property Manager") || arg1.equals("Agent Administrator")
				|| arg1.equals("RBU Team Leader") || arg1.equals("RBU Officer") || arg1.equals("Housing Officer")
				|| arg1.equals("Agency Admin")) {
			String myxpath = PageFactory.initElements(driver, DBUtilities.class).xpathMakerContainsText1stOption(arg1);
			String myxpath2 = PageFactory.initElements(driver, DBUtilities.class).xpathMakerById(arg2);
			System.out.println(" looking for dropdown xpath " + myxpath);
			driver.findElement(By.xpath(myxpath2)).click();
			Thread.sleep(1000);
			driver.findElement(By.xpath(myxpath)).click();
		} else {
			String myxpath = PageFactory.initElements(driver, DBUtilities.class).xpathMakerDivContainsText(arg1);
			String myxpath2 = PageFactory.initElements(driver, DBUtilities.class).xpathMakerById(arg2);
			System.out.println(" looking for dropdown xpath " + myxpath);
			driver.findElement(By.xpath(myxpath2)).click();
			Thread.sleep(1000);
			driver.findElement(By.xpath(myxpath)).click();

		}

	}

	// @Then("^I see element \"(.*?)\" displayed$")
	// public void i_see_element_displayed(DataTable table) throws Throwable {
	//
	// List<List<String>> data = table.raw();
	//
	// for (int i = 1; i <data.size(); i++){
	// String name = data.get(i).get(1);
	// System.out.println("The table length is .." +data.size());
	//
	// DBUtilities createXpath = new DBUtilities(driver);
	//
	// createXpath.checkUIElementTEXTIsDisplayed(name);
	// }
	//
	// }

	@Then("^I see \"(.*?)\" element \"(.*?)\" displayed$")
	public void i_see_element_displayed(String arg1, String arg2, DataTable table) throws Throwable {
		List<List<String>> data = table.raw();

		for (int i = 1; i < data.size(); i++) {
			String name = data.get(i).get(1);
			System.out.println("The table length is .." + data.size());

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

		if (arg2.equals("selectTheFirstRow")) {
			DBUtilities createXpath = new DBUtilities(driver);
			String checkFirstRowInTable = createXpath.xPathMakerForReadSomeRowOfSomeTable(arg2, arg3);
			// for a change putting double click
			driver.findElement(By.xpath(checkFirstRowInTable)).click();

		} else {

			if (arg1.equals("check")) {
				String checkElementInTable = PageFactory.initElements(driver, DBUtilities.class)
						.xpathMakerPickTrTextInTableID(arg2, arg3);
				// Assert.assertEquals(true, checkElementInTable.isDisplayed());
				Assert.assertTrue(driver.findElement(By.xpath(checkElementInTable)).isDisplayed());

			} else if (arg1.equals("click")) {

				if (arg2.equals("CheckBox")) {

					// hard coded for now but need to resolve this later
					String checkBoxToClick = PageFactory.initElements(driver, DBUtilities.class)
							.xpathMakerByInputId("wtBondsList_ctl03");
					WebElement element = driver.findElement(By.xpath(checkBoxToClick));
					element.click();

				} else {

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

		String tableXpath = PageFactory.initElements(driver, DBUtilities.class).xpathMakerPickTrTextInTableID(arg2,
				arg1);
		String rowContent = driver.findElements(By.xpath(tableXpath)).get(0).getText();
		System.out.println(rowContent);
		List<List<String>> tableData = table.raw();
		// List<String> rowContentList = Arrays.asList(rowContent.split("\n"));

		for (int i = 1; i < tableData.size(); i++) {
			String data = tableData.get(i).get(1);
			System.out.println("Checking for " + data);

			try {
				assertThat(rowContent, containsString(data));

			} catch (Exception e) {

				Log.info("Not found" + data);
			}
			// this step will click on table elements that generate popups, for
			// some reason
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
	// @Given("^I capture \"(.*?)\"$")
	// public String i_capture_someValue(String arg1) throws Throwable {
	//
	// DBUtilities createXpath = new DBUtilities(driver);
	//
	// String myxpath = createXpath.xpathMakerById(arg1);
	// StepImplementations.CapturedValue =
	// driver.findElement(By.xpath(myxpath)).getAttribute("value");
	// System.out.println("object that is captured is
	// *****************>>>>>>>>>>>>>>>>>>>>>>>> " + CapturedValue);
	//
	// return CapturedValue;
	//
	// }
}
