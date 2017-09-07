package Utilities;

import java.awt.AWTException;
import java.awt.Robot;
import java.awt.Toolkit;
import java.awt.datatransfer.StringSelection;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.logging.Logger;

import org.apache.log4j.xml.DOMConfigurator;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;

import cucumber.api.DataTable;
import runnerAndSteps.BROWSER;
import runnerAndSteps.StepImplementations;

public class DBUtilities extends XPathGenerator {

	// constructor
	public DBUtilities(WebDriver dr) {
		super(dr);
	}

	
	private static final Logger Log = Logger.getLogger(StepImplementations.class.getName());

	
	public void logit()
	{
		DOMConfigurator.configure("log4j.xml");
	}
	
	// following will take 2 args from cucumber and one from page and then
	// compare both messages
	public static void checkElement(String arg1, String arg2) {
		Assert.assertEquals(arg1, arg2);
		System.out.println("Successfully displayed element" + arg2);

	}

	// following will take 2 args both strings and then compare them, basically
	// used for text on UI
	public static void checkMessage(String arg1, String arg2) {
		Assert.assertEquals(arg1, arg2);
		System.out.println("Successfully displayed message" + arg2);
	}

	// ***********************this is to hover over an
	// element****************************
	public void hoverOverElement(String arg1, String arg2) throws InterruptedException {
		DBUtilities createXpath = new DBUtilities(driver);
		String myXpath = createXpath.xpathMakerByClass(arg1);
		System.out.println("successfully dispays hint which was marked as infoicon before" + arg1);
		// String myXpath2 = createXpath.xpathMakerContainsText(arg2);
		Assert.assertTrue(driver.findElement(By.xpath(myXpath)).isDisplayed());
		Actions action = new Actions(driver);
		WebElement we = driver.findElement(By.xpath(myXpath));
		action.moveToElement(we).click().build().perform();
		// check for message to appear when icon is hovered on
		Thread.sleep(1000);
		if (driver.getPageSource().contains(arg2)) {
			System.out.println("Text is present" + arg2);
		} else {
			System.out.println("Text is absent" + arg2);
		}

	}

	// following will check if the text element exist on the screen
	public void checkTextElementPresent(String arg1) {

		DBUtilities checkElementDisplayed = new DBUtilities(driver);
		String myxpath = checkElementDisplayed.xpathMakerContainsText(arg1);
		Assert.assertTrue(driver.findElement(By.xpath(myxpath)).isDisplayed());

		// List<WebElement> list =
		// driver.findElements(By.xpath("//*[contains(text(),'" + arg1 +
		// "')]"));
		//
		// System.out.println("looking for text " +list);
		// Assert.assertTrue("Text not found!", list.size() > 0);

		System.out.println("***Page Element " + arg1 + " is displayed successfully***");
	}

	// following will check if the text element does NOT exist on the screen
	public void checkTextElementAbsent(String arg1) {

		try{
		//this will check even the hidden elements that are not displayed on UI
		DBUtilities checkElementDisplayed = new DBUtilities(driver);
		String myxpath = checkElementDisplayed.xpathMakerContainsText(arg1);
		int x = driver.findElement(By.xpath(myxpath)).getLocation().getX();
		int y = driver.findElement(By.xpath(myxpath)).getLocation().getY();
		
		Log.info("Coordinates for absent element are " +x +" and " +y);
		Assert.assertEquals("As expected element is not present on screen", 0,x);
		 } catch (Exception e) {
			 
			  e.printStackTrace();
			  Log.info("UNEXPECTED VALUE" +arg1 +" IS SHOWN ON SCREEN");
		 }
	}

	

	public void checkBoxClick(String arg1) throws InterruptedException {
		DBUtilities createXpath = new DBUtilities(driver);
		String myxpath = createXpath.xpathMakerContainsText(arg1);
		System.out.println("Clicking on the checkbox " + myxpath);
		//driver.findElement(By.xpath(myxpath)).click();
//		*****************8
		
		  WebElement element = driver.findElement(By.xpath(myxpath));

		    try {
		        element.click();
		    } catch (Exception e) {
		    	Actions actions = new Actions(driver);
		    	Thread.sleep(1000);
		    	actions.keyDown(Keys.CONTROL).sendKeys(Keys.END).perform();
		    	Thread.sleep(1000);
		        element.click();
		    }
		

		
	}

	public void checkTextElementAbsent(DataTable table) throws InterruptedException {
		Thread.sleep(3000);
		List<List<String>> data = table.raw();
		System.out.println(" value is ++" + data);
		for (int i = 1; i < data.size(); i++) {
			;
			String name = data.get(i).get(1);
			System.out.println(" Checking for absent element and the name is+++++" + name);
			Assert.assertTrue("Text not present", driver.findElements(By.xpath(name)).size() == 0);

		}
	}

	// note: HS: following is different from checkElementPresentMessage
	public void checkUIElementIsDisplayed(String arg1) throws InterruptedException {
		// if (arg1.equals("Please wait while we retrieve your account...")||
		// arg1.equals("Please contact Simply Energy on 13 88 08 to set up your
		// Direct Debit")){
		if (arg1.equals("highcharts-tracker")) {
			DBUtilities checkElementDisplayed = new DBUtilities(driver);
			String myxpath = checkElementDisplayed.xpathMakerByClass(arg1);
			Assert.assertTrue(driver.findElement(By.xpath(myxpath)).isDisplayed());
			System.out.println("Element " + arg1 + " is displayed as expected");

		} else {
			DBUtilities checkElementDisplayed = new DBUtilities(driver);
			String myxpath = checkElementDisplayed.xpathMakerBySpanID(arg1);
			System.out.println("**" + myxpath);
			Thread.sleep(2000);
			Assert.assertTrue(" Varification failed as " + myxpath + "NOT FOUND",
					driver.findElement(By.xpath(myxpath)).isDisplayed());

			if (driver.findElements(By.xpath(myxpath)).size() != 0) {
				System.out.println("Element is Present");
			} else {
				System.out.println("Element is Absent");
			}
		}

	}

	// differnt from above this checks for webelement

	public void isTextPresent(String arg1) throws InterruptedException {
		System.out.println(" ****" + arg1);
		Thread.sleep(4000);
		if (driver.getPageSource().contains(arg1)) {
			System.out.println("Text " + arg1 + "is present");
		} else {
			System.out.println("Text " + arg1 + "NOT present");
		}

	}
	// Scroll down the page

	public void scrollDownThePage(String arg1) throws InterruptedException {

		if (arg1.equals("down")) {
			JavascriptExecutor jse = (JavascriptExecutor) driver;
			jse.executeScript("window.scrollBy(0,5000)", "");
		} else {
			JavascriptExecutor jse = (JavascriptExecutor) driver;
			jse.executeScript("window.scrollBy(5000,0)", "");
		}
	}

	// scroll down till element is visible
	public void scrollDownForElement(String arg1) throws InterruptedException {
		JavascriptExecutor scrollTillVisible = (JavascriptExecutor) driver;
		scrollTillVisible.executeScript("arguments[0].scrollIntoView(true);", driver.findElement(By.xpath(arg1)));

	}

	// action performed on element(coming as arg)
	public void actionPerformedClick(String arg1) {
		System.out.println("Successfully displayed Link" + arg1);
		System.out.println("Clicking on " + arg1.toUpperCase());
	}

	// check that element is read Only

	public void elementIsreadOnly(String arg1) throws InterruptedException {

		DBUtilities createXpath = new DBUtilities(driver);
		String myXpath = createXpath.xpathMakerById(arg1);
		Thread.sleep(1000);
		WebElement some_element = driver.findElement(By.xpath(myXpath));
		// some_element.click();

		if (some_element.isEnabled()) {
			System.out.println("test failed " + some_element + "should be disabled");
		} else {
			System.out.println("test Passed " + some_element + "is disabled as expected");
		}

	}

	public String clickOnImage(String arg1) {

		DBUtilities createXpath = new DBUtilities(driver);
		String myXpath = createXpath.xpathMakerByImageName(arg1);
		System.out.println("clicking in image " + myXpath);
		// // WebElement some_image = driver.findElement(By.xpath(myXpath));
		// WebElement image = driver.findElement(By.xpath(myXpath));
		// System.out.println("clicking on image " +image);
		// image.click();
		return myXpath;

	}

	public String clickOn2ndOptionOnPopup(String arg1) {

		DBUtilities createXpath = new DBUtilities(driver);
		String myXpath = createXpath.xpathMakerContainsID2ndOption(arg1);
		System.out.println("clicking in image " + myXpath);

		return myXpath;

	}

	public void hitEnter() {

		Actions action = new Actions(driver);
		action.sendKeys(Keys.ENTER).build().perform();
		// action.sendKeys(Keys.RETURN);
	}

	public void hitDown() {

		Actions action = new Actions(driver);
		// action.sendKeys(Keys.ENTER).build().perform();
		action.sendKeys(Keys.ARROW_DOWN).perform();
		// action.sendKeys(Keys.RETURN);
	}

	public void hitUp() {

		Actions action = new Actions(driver);

		action.sendKeys(Keys.ARROW_UP).perform();
		// action.sendKeys(Keys.RETURN);
	}

	public void hitTab() {

		Actions action = new Actions(driver);
		action.sendKeys(Keys.TAB).build().perform();
		// action.sendKeys(Keys.RETURN);
	}

	// move control to new window and check if the right url is opened
	public void passControlToNewWindow(String arg1) {
		// It will return the parent window name as a String
		String parent = driver.getWindowHandle();

		// This will return the number of windows opened by Webdriver and will
		// return Set of St//rings
		Set<String> s1 = driver.getWindowHandles();
		System.out.println(s1);

		// Now we will iterate using Iterator
		Iterator<String> I1 = s1.iterator();

		while (I1.hasNext()) {

			String child_window = I1.next();

			// Here we will compare if parent window is not equal to child
			// window then we will close

			if (!parent.equals(child_window)) {
				driver.switchTo().window(child_window);

				String newPageURL = driver.switchTo().window(child_window).getCurrentUrl();
				System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++" + newPageURL);
				System.out.println(arg1);
				Assert.assertEquals(arg1, newPageURL);
			}
		}
	}

	// ********************* Check if on expected
	// page***************************************
	public void checkIfOnRightPage(String arg1) throws InterruptedException {
		System.out.println("****************Page Name*************************" + arg1);
		Thread.sleep(5000);
		String title = driver.getTitle();
		System.out.println("The page title is " + title);
		Assert.assertTrue(driver.getTitle().contains(arg1));

	}

	// capture date and time

	public String DNT() {

		DateFormat dateFormat = new SimpleDateFormat("ddMMYYYYHHmmss");
		// get current date time with Calendar()
		Calendar cal = Calendar.getInstance();
		String datentime = dateFormat.format(cal.getTime());
		System.out.println(" Current System DNT is " + datentime);
		String truncateddatentime = datentime.substring(4);
		System.out.println(" Truncated Current System DNT is " + datentime);
		System.out.println(" Truncated Current System DNT is " + truncateddatentime);
		return truncateddatentime;

		// DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy ");
		// Date date = new Date();
		// String currentDate = dateFormat.format(date);
		// System.out.println(" Current System DNT is "+ currentDate);
		// return currentDate;

	}

	public String date() {

		// DateFormat dateFormat = new SimpleDateFormat("dd-mm-yyyy");
		// //get current date time with Calendar()
		// Date date = new Date();
		// String datentime = dateFormat.format(date);
		//
		// System.out.println(" Current System date is "+ datentime);
		//
		String pattern = "dd-MM-yyyy";
		String dateInString = new SimpleDateFormat(pattern).format(new Date());
		System.out.println(" Current System date is " + dateInString);
		return dateInString;

	}

	// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	// ++++++++++++++++++++++++++++++++++Read table Rows and compare to an
	// expected number++++++++++++++++++++++++++++++++++++++++
	// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	public void readAndCompareTableRows(String arg1, String arg2, int arg3) {

		DBUtilities createXpath = new DBUtilities(driver);
		String myXpath = createXpath.xpathMakerByTextInClass(arg1);

		System.out.println("So the xpath for table is " + myXpath);
		// List<WebElement> rows = driver.findElements(By.xpath(myXpath));
		List<WebElement> rows = driver.findElements(By.xpath(myXpath));
		System.out.println("Balley balley ni taur ni punjabban di Total number of rows :" + rows.size());

	}

	// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	// ++++++++++++++++++++++++++++++++++Read table Rows and compare to an
	// expected number++++++++++++++++++++++++++++++++++++++++
	// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	public void readTableAndCaptureInString(String arg1) {
		//System.out.println("Balley balley ni taur ni punjabban di");
		DBUtilities createXpath = new DBUtilities(driver);
		String myXpath = createXpath.xpathMakerById(arg1);

		System.out.println("So the xpath for table is " + myXpath);
		// List<WebElement> rows = driver.findElements(By.xpath(myXpath));

		List<WebElement> rows = driver.findElements(By.xpath(myXpath));
		System.out.println("Total number of rows :" + rows.size());

		List<WebElement> rowElements = driver.findElements(By.tagName("tr"));
		System.out.println(rowElements.size());
		String Table_data = driver.findElement(By.xpath(myXpath)).getText();
		System.out.println("Table data" + Table_data);

	}

	// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	// ++++++++++++++++++++++++++++++++++Check Dropdown value displayed by
	// default++++++++++++++++++++++++++++++++++++++++
	// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	public void checkDropDownDefaultValue(String arg2) {

		DBUtilities createXpath = new DBUtilities(driver);
		String myXpath = createXpath.xpathMakerContainsText(arg2);
		WebElement dropdownValue = driver.findElement(By.xpath(myXpath));
		// assertTrue(isElementPresent(By.id(myXpath)));

		// dropdownValue.isDisplayed();
		//
		// String visibleValue = dropdownValue.getText();
		// System.out.println(visibleValue);
		// Assert.assertEquals(arg2, visibleValue);
	}

	public void selectDropdownValue(String arg1, String arg2) throws InterruptedException {
		String myxpath = new DBUtilities(driver).xpathMakerContainsText(arg1);
		//driver.findElement(By.xpath(myxpath)).click();
		// disabling following as Gessit format is different
		// String myxpath2= new DBUtilities(driver).xpathMakerById(arg2);
		// driver.findElement(By.xpath(myxpath2)).click();
//		************* 
		WebElement element = driver.findElement(By.xpath(myxpath));

	    try {
	        element.click();
	    } catch (Exception e) {
	    	Actions actions = new Actions(driver);
	    	actions.keyDown(Keys.CONTROL).sendKeys(Keys.END).perform();
	    	
	        element.click();
	    }

	}

	public static void uploadAnAttachmentFile() throws AWTException, InterruptedException {
		StringSelection ss = new StringSelection("C:\\Users\\HShori.DBRESULTS\\Desktop\\Jeetu Todos");
		Toolkit.getDefaultToolkit().getSystemClipboard().setContents(ss, null);
		// perform keystrokes
		Robot robot = new Robot();
		robot.keyPress(java.awt.event.KeyEvent.VK_ENTER);
		Thread.sleep(500);
		robot.keyRelease(java.awt.event.KeyEvent.VK_ENTER);
		Thread.sleep(500);
		robot.keyPress(java.awt.event.KeyEvent.VK_CONTROL);
		Thread.sleep(500);
		robot.keyPress(java.awt.event.KeyEvent.VK_V);
		Thread.sleep(500);
		robot.keyRelease(java.awt.event.KeyEvent.VK_V);
		Thread.sleep(500);
		robot.keyRelease(java.awt.event.KeyEvent.VK_CONTROL);
		Thread.sleep(500);
		robot.keyPress(java.awt.event.KeyEvent.VK_ENTER);
		Thread.sleep(500);
		robot.keyRelease(java.awt.event.KeyEvent.VK_ENTER);
	}

	public void generateException(String arg1) {
		System.out.println("********************************************************");
		System.out.println("***************Element not displayed" + arg1 + "*********");
		System.out.println("********************************************************");
	}

	// ********************************this function is used for
	// reporting*****************************
	public void writeLog(String arg1) {
		System.out.println(arg1 + " ** exist on screen");
		// String timeStamp = new SimpleDateFormat("[dd/MM/yyyy
		// HH:mm:ss]").format(new Date(0));
		// System.out.println(timeStamp + " " + arg1+ " ** exist on screen");
	}

	// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	// ++++++++++++++++++++++++++++++++++Enter Input
	// Field++++++++++++++++++++++++++++++++++++++++
	// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	// the abopve will read the cucumber table and input values on screen as per
	// provided in table
	public String getInputXpathByTypeAndId(String type, String inputId) throws InterruptedException {
		DBUtilities createXpath = new DBUtilities(driver);
		String myxpath1 = createXpath.xpathMakerByInputId(inputId);
		String myxpath2 = createXpath.xpathMakerByType(type);
		String myXpath = createXpath.combine2Xpaths(myxpath1, myxpath2);
		System.out.println("===========#########" + myXpath);
		System.out.println("Is " + myXpath + " Interactable? " + driver.findElement(By.xpath(myXpath)).isEnabled());
		return myXpath;
	}

	// entering cucumber table values
	public void enterCucumbertableValuesInUI (DataTable table) throws InterruptedException 
			 {
		
				 	String myXpath;
					List<List<String>> data = table.raw();
						
						for (int i = 1; i <data.size(); i++){
							String name = data.get(i).get(1);
							System.out.println("The table length is .." +data.size());	
							
						DBUtilities createXpath = new DBUtilities(driver);
						if(name.equals("")){System.out.println(" Not expecting element to be present on screen so going to next step");}
						else if(!name.equals("")){
						try {
							
							  myXpath = createXpath.xpathMakerByInputId(data.get(i).get(0));
							  System.out.println(i);
							  System.out.println(myXpath);
							  System.out.println("Is " + myXpath + " Interactable? " + driver.findElement(By.xpath(myXpath)).isEnabled());
							  driver.findElement(By.xpath(myXpath)).clear();
						  }
						  catch (Exception e){
							  e.printStackTrace();
							  System.out.println("Cannot find an input field! Now trying to find a textarea field...");
							  //myXpath = createXpath.xpathMakerByInputId(data.get(i).get(0));
							  
							  myXpath = createXpath.xpathMakerByTextAreaId(data.get(i).get(0));
							  System.out.println(i);
							  System.out.println(myXpath);
							  driver.findElement(By.xpath(myXpath)).clear();
						  }
						
					 // driver.findElement(By.xpath(myXpath)).click();
						// disabled above as we have already clicked it before
					// following is to make the input parameters unique to avoid duplocation error on UI
						
						if(myXpath.contains("OneLineAddress")||(myXpath.contains("StreetNumber"))){
						String nameToBeEntered= data.get(i).get(1);
						System.out.println(nameToBeEntered);
					String dnt =	DNT();
					System.out.println(dnt);
						
						 driver.findElement(By.xpath(myXpath));
						 String nameAfterAddingSuffix = dnt+nameToBeEntered;
						 System.out.println(nameAfterAddingSuffix);
						 driver.findElement(By.xpath(myXpath)).sendKeys(nameAfterAddingSuffix);
						 }
						else if(myXpath.contains("medicare")){
							 String nameToBeEntered= data.get(i).get(1);
								System.out.println(nameToBeEntered);
							String dnt =	DNT();
							System.out.println(dnt);
					        driver.findElement(By.xpath(myXpath));
								 String nameAfterAddingSuffix = nameToBeEntered+dnt;
								 System.out.println(nameAfterAddingSuffix);
								 driver.findElement(By.xpath(myXpath)).sendKeys(nameAfterAddingSuffix);
							 
						 
						}else {
						 driver.findElement(By.xpath(myXpath)).sendKeys(data.get(i).get(1));
						System.out.println("Entering value in table " +myXpath +"as" +name);  
						}
						}
						}
			 }

	// entering cucumber table values
	public void enterCucumbertableValuesInUIOnlyIfPresent(DataTable table) throws InterruptedException {
		String myXpath;
		List<List<String>> data = table.raw();

		for (int i = 1; i < data.size(); i++) {
			String name = data.get(i).get(1);
			System.out.println("The table length is .." + data.size());
			DBUtilities createXpath = new DBUtilities(driver);
			myXpath = createXpath.xpathMakerByInputId(data.get(i).get(0));
			System.out.println(i);
			System.out.println(myXpath);

			try {
				driver.findElement(By.xpath(myXpath)).isDisplayed();
				driver.findElement(By.xpath(myXpath)).sendKeys(data.get(i).get(1));
				System.out.println("Entering value in table " + myXpath + "as" + name);
			}

			catch (Exception e) {
				System.out.println(
						" Element not present so not doing anything as this function only does something when element is present");
			}

		}

	}
	// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	// ++++++++++++++++++++++++++++++++++compare 2 dollar
	// values++++++++++++++++++++++++++++++++++++++++
	// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	public String compare2DollarValues(String value1, String value2) {

		String result;
		System.out.println("" + value1);
		System.out.println("" + value1);

		String newValue1 = value1.replaceAll("[^\\d.]+", "");
		System.out.println(" its " + newValue1);
		double intnewValue1 = Double.parseDouble(newValue1);
		System.out.println(" its**************************** " + intnewValue1);
		String newValue2 = value2.replaceAll("[^\\d.]+", "");
		System.out.println(" its " + newValue2);
		double intnewValue2 = Double.parseDouble(newValue2);
		System.out.println(" its*********************** " + intnewValue2);

		if (intnewValue1 <= intnewValue2) {
			System.out.println("Service total is Less then account total");
			result = "Service total is Less then account total";
		} else {
			System.out.println("Service total is ***********MORE******** then account total");
			result = "Service total is ***********MORE******** then account total";
		}

		return result;
	}
	// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	// ++++++++++++++++++++++++++++++++++PopUp
	// handlers++++++++++++++++++++++++++++++++++++++++
	// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	public void checkPopUpMessage(String arg1, BROWSER browser_type) {
		String popUpMessage = driver.switchTo().alert().getText();
		System.out.println("the pop up message text is " + popUpMessage);
		if (browser_type == BROWSER.CHROME){
			Assert.assertTrue(arg1, popUpMessage.equals(arg1));
		}
		else if (browser_type == BROWSER.FIREFOX){
			// Firefox has a habit of changing the popup messages automatically 
			// the message below is the default Firefox popup message
			Assert.assertTrue(popUpMessage.equals("This page is asking you to confirm that you want to leave - data you have entered may not be saved."));
		}
	}

	public void tabOut() {
		Actions action = new Actions(driver);
		action.sendKeys(Keys.TAB).perform();
	}

	public void clickOnPopUP(String arg1) throws InterruptedException {
		if (arg1.equals("OK")) {
			Thread.sleep(5000);
			driver.switchTo().alert().accept();
			System.out.println("Clicking " + arg1 + " on PopUp");
		} else if (arg1.equals("Cancel")) {
			Thread.sleep(5000);
			driver.switchTo().alert().dismiss();
			System.out.println("Clicking " + arg1 + " on PopUp");
		} else if (arg1.equals("Inbox")) {
			Thread.sleep(5000);
			driver.switchTo().alert().sendKeys(arg1);
			System.out.println("Entering " + arg1 + " on PopUp");

		}

	}

	// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	// ++++++++++++++++++++++++++++++++++copy and paste page
	// html++++++++++++++++++++++++++++++++++++++++
	// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	public String getPageHTML() {
		String Capture2 = driver.getPageSource();

		return Capture2;

	}

	public void paste(String arg1) {

	}

	// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	// ++++++++++++++++++++++++++++++++++PopUp
	// handlers++++++++++++++++++++++++++++++++++++++++
	// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	public void readAllPDFAndCheckTextPresent(String arg1) {
		// protected String getLastWindow() {
		// return session().getEval("var windowId; for(var x in
		// selenium.browserbot.openedWindows ){windowId=x;} ");
		// }

		// @Test
		// public void testTextInPDF() {
		// session().click("link=View PDF");
		// String popupName = getLastWindow();
		// session().waitForPopUp(popupName, PAGE_LOAD_TIMEOUT);
		// session().selectWindow(popupName);
		//
		// session().windowMaximize();
		// session().windowFocus();
		// Thread.sleep(3000);
		//
		// session().keyDownNative("17"); // Stands for CTRL key
		// session().keyPressNative("65"); // Stands for A "ascii code for A"
		// session().keyUpNative("17"); //Releases CTRL key
		// Thread.sleep(1000);
		//
		// session().keyDownNative("17"); // Stands for CTRL key
		// session().keyPressNative("67"); // Stands for C "ascii code for C"
		// session().keyUpNative("17"); //Releases CTRL key
		//
		// TextTransfer textTransfer = new TextTransfer();
		// assertTrue(textTransfer.getClipboardContents().contains("Some text in
		// my pdf"));
		// }

	}

	// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	// ++++++++++++++++++++++++++++++++++Table
	// handlers++++++++++++++++++++++++++++++++++++++++
	// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	public WebElement getTableBodyByTableId(String arg1) throws InterruptedException {
		String myxpath = new DBUtilities(driver).xpathMakerTbodyById(arg1);

		// To locate table
		WebElement myTable = driver.findElement(By.xpath(myxpath));
		return myTable;
	}

	public WebElement getTableBody() throws InterruptedException {
		String myxpath = new DBUtilities(driver).xpathMakerTbody();
		// To locate table
		WebElement myTable = driver.findElement(By.xpath(myxpath));
		return myTable;
	}

	public WebElement getTableRowContentByTableId(String arg2, String arg3) throws InterruptedException {
		WebElement myTable = getTableBodyByTableId(arg3);
		String contents = myTable.getText();

		return myTable;
	}

	public WebElement getTableRow(String arg1) throws InterruptedException {
		String myxpath = new DBUtilities(driver).xpathMakerByTd(arg1);
		// To locate table
		WebElement myTable = driver.findElement(By.xpath(myxpath));

		return myTable;
	}

	public WebElement clickTableRowContentByTableId(String arg1) throws InterruptedException {
		WebElement myTable = getTableBodyByTableId(arg1);
		myTable.click();

		return myTable;
	}

	public List<WebElement> getTableRows() throws InterruptedException {
		WebElement myTable = getTableBody();
		// To locate rows of table.
		List<WebElement> rows = myTable.findElements(By.tagName("tr"));
		return rows;
	}

	public List<WebElement> getTableRowByValue(String arg1, String arg2) throws InterruptedException {
		List<List<WebElement>> tableCells = getTableCells();
		int indexColumn = getColumnIndex(arg1);
		int indexRow = 0;
		for (int i = 0; i < tableCells.size(); i++) {
			if (tableCells.get(i).get(indexColumn).getText().equals(arg2)) {
				indexRow = i;
				break;
			}
		}
		// To locate rows of table.

		return tableCells.get(indexRow);
	}

	public List<WebElement> getTableHeaderByTableId(String arg1) throws InterruptedException {
		String myxpath = new DBUtilities(driver).xpathMakerTheadById(arg1);
		// To locate table
		WebElement myTable = driver.findElement(By.xpath(myxpath));
		List<WebElement> headers = myTable.findElements(By.tagName("th"));
		return headers;
	}

	public List<WebElement> getTableHeader() throws InterruptedException {
		String myxpath = new DBUtilities(driver).xpathMakerThead();
		// To locate table
		WebElement myTable = driver.findElement(By.xpath(myxpath));
		List<WebElement> headers = myTable.findElements(By.tagName("th"));
		return headers;
	}

	// public List<List<WebElement>> getTableCellsByTableId(String arg1) throws
	// InterruptedException
	// {
	// List<List<WebElement>> tableCells = new ArrayList<List<WebElement>>();
	// List < WebElement > rows = getTableRowContentByTableId(arg1);
	// for (int i=0; i < rows.size(); i++){
	// List < WebElement > cells = rows.get(i).findElements(By.tagName("td"));
	// tableCells.add(cells);
	// System.out.println(cells);
	// }
	// return tableCells;
	// }

	public List<List<WebElement>> getTableCells() throws InterruptedException {
		List<List<WebElement>> tableCells = new ArrayList<List<WebElement>>();
		List<WebElement> rows = getTableRows();
		for (int i = 0; i < rows.size(); i++) {
			List<WebElement> cells = rows.get(i).findElements(By.tagName("td"));
			tableCells.add(cells);
		}
		return tableCells;
	}

	public int getColumnIndex(String arg1) throws InterruptedException {
		List<WebElement> headers = getTableHeader();
		int index = 0;
		for (int i = 0; i < headers.size(); i++) {
			if (headers.get(i).getText().equals(arg1)) {
				index = i;
				break;
			}
		}
		return index;
	}

	// public List< WebElement > getTableColumnsByTableId(String arg1, String
	// arg2) throws InterruptedException
	// {
	// List < WebElement > headers = getTableHeaderByTableId(arg1);
	// int index = 0;
	// for (int i=0; i < headers.size(); i++){
	// if (headers.get(i).getText().equals(arg2)) {
	// index = i;
	// break;
	// }
	// }
	//
	// List< WebElement > columns = new ArrayList< WebElement >();
	// List<List<WebElement>> tableCells = getTableCellsByTableId(arg1);
	// for (int i=0; i < tableCells.size(); i++){
	// columns.add(tableCells.get(i).get(index));
	// }
	// return columns;
	// }

	public List<WebElement> getTableColumns(String arg1) throws InterruptedException {
		List<WebElement> headers = getTableHeader();
		int index = 0;
		for (int i = 0; i < headers.size(); i++) {
			if (headers.get(i).getText().equals(arg1)) {
				index = i;
				break;
			}
		}

		List<WebElement> columns = new ArrayList<WebElement>();
		List<List<WebElement>> tableCells = getTableCells();
		for (int i = 0; i < tableCells.size(); i++) {
			columns.add(tableCells.get(i).get(index));
		}
		return columns;
	}

	public void checkUIElementTableIsDisplayed(String arg1) throws InterruptedException {
		WebElement myTable = getTableBodyByTableId(arg1);
		System.out.println("table displeyed as ************" + myTable);
		// verify table on screen
		Assert.assertTrue(" Varification failed as table NOT FOUND", myTable.isDisplayed());
	}

	public String getCombineText(String arg1, String arg2) {
		DBUtilities dbutilities = new DBUtilities(driver);
		String myxpath1 = dbutilities.xpathMakerContainsText(arg1);
		String myxpath2 = dbutilities.xpathMakerContainsText(arg2);
		String combineXPaths = dbutilities.combine2Xpaths(myxpath1, myxpath2);
		System.out.println(combineXPaths);
		return combineXPaths;
	}

	public void checkCombineTextIsDisplayed(String arg1, String arg2) {
		DBUtilities dbutilities = new DBUtilities(driver);
		String combineXPaths = dbutilities.getCombineText(arg1, arg2);
		System.out.println(combineXPaths);
		Assert.assertTrue(driver.findElement(By.xpath(combineXPaths)).isDisplayed());
	}

	// public void checkNumberOfTableRecordsIsDisplayed (String arg1) throws
	// InterruptedException
	// {
	// List < WebElement > rows = getTableRowContentByTableId(arg1);
	// checkCombineTextIsDisplayed(rows.size() + "", "record");
	// //Assert.assertTrue(" Varification failede as " +myxpath +"NOT FOUND",
	// driver.findElement(By.xpath(myxpath)).isDisplayed());
	// }
	//
	//// public void checkSpecificTextInTable (String arg1, DataTable table)
	// throws InterruptedException
	//// {
	//// List < WebElement > rows = getTableRowsByTableId(table);
	////
	//// }

	public void checkTableHeadersOrder(String arg1, DataTable table) throws InterruptedException {
		List<WebElement> headers = getTableHeaderByTableId(arg1);
		List<List<String>> data = table.raw();
		Boolean val = true;
		System.out.println(" value is ++" + data);
		for (int i = 1; i < data.size(); i++) {
			Thread.sleep(3000);
			String name = data.get(i).get(1);
			System.out.println(" and the name is+++++" + name + " == " + headers.get(i).getText());
			if (!name.equals(headers.get(i).getText())) {
				val = false;
				break;
			}
		}
		Thread.sleep(2000);
		Assert.assertTrue("Headers are not displayed in a correct order", val);
	}

	// public void checkColumnValuesOrder(String arg1, String arg2) throws
	// InterruptedException
	// {
	// List <String> vals = new ArrayList <String>();
	// List < WebElement > columns = getTableColumnsByTableId(arg1, arg2);
	// for (int i=0; i < columns.size(); i++){
	// System.out.println("value: " + columns.get(i).getText());
	// vals.add(columns.get(i).getText());
	// }
	// boolean isSorted = true;
	// for(int i = 0; i < vals.size() - 1; i++) {
	// // current String is > than the next one (if there are equal list is
	// still sorted)
	// if(vals.get(i).compareToIgnoreCase(vals.get(i + 1)) > 0) {
	// isSorted = false;
	// break;
	// }
	// }
	// Assert.assertTrue("The values are not sorted in alphabetical
	// order.",isSorted);
	// }
	//

	public void checkRowValuesOrder(String arg1, String arg2, DataTable table) throws InterruptedException {
		List<WebElement> row = getTableRowByValue(arg1, arg2);
		List<List<String>> data = table.raw();
		Boolean isEqual = true;
		for (int i = 1; i < data.size(); i++) {
			Thread.sleep(3000);
			String name = data.get(i).get(1);
			System.out.println(" and the name is+++++" + name + " == " + row.get(i).getText());
			if (!name.equals(row.get(i).getText())) {
				System.out.println(" !name.equals(row.get(i).getText())");
				isEqual = false;
				break;
			}
		}
		Thread.sleep(2000);
		Assert.assertTrue("Row values are not correct", isEqual);
	}

	public int getTableHeaderIndex(String arg1) throws InterruptedException {
		List<WebElement> headers = getTableHeader();
		int index = 0;
		System.out.println("arg1: " + arg1);
		for (int i = 0; i < headers.size(); i++) {
			if (headers.get(i).getText().equals(arg1)) {
				index = i;
			}
		}
		return index;
	}

	public int getTableRowIndexByElement(DataTable table) throws InterruptedException {
		List<List<WebElement>> tableCells = getTableCells();
		List<List<String>> data = table.raw();
		int rowindex = 0;
		int columnindex = getTableHeaderIndex(data.get(1).get(0));
		for (int i = 0; i < tableCells.size(); i++) {
			if (tableCells.get(i).get(columnindex).getText().equals(data.get(1).get(1))) {
				rowindex = i + 1;
			}
		}
		return rowindex;
	}

	public WebElement getElementbyRowIndexandClass(String arg1, DataTable table) throws InterruptedException {
		int index = getTableRowIndexByElement(table);
		String myxpath = new DBUtilities(driver).xpathMakerElementByRowIndexandClass(index, arg1);
		WebElement myElement = driver.findElement(By.xpath(myxpath));
		return myElement;
	}

	public WebElement getLinkFromListInTableRecord(String arg1, String arg2, DataTable table)
			throws InterruptedException {
		int index = getTableRowIndexByElement(table);
		String myxpath = new DBUtilities(driver).xpathMakerElementByRowIndexandId(index, arg1) + "//a[text() = '" + arg2
				+ "']";
		WebElement myElement = driver.findElement(By.xpath(myxpath));
		return myElement;
	}
	// xpathMakerEditByRowIndex
	
	
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
	public void checkElementPresentOnScreen(DataTable table) throws InterruptedException {
		Thread.sleep(3000);
		List<List<String>> data = table.raw();
		System.out.println(" value is ++" + data);
		for (int i = 1; i < data.size(); i++) {

			String name = data.get(i).get(1);
		
				// String myxpath = createXpath.xpathMakerById(name);
				String myxpath = new DBUtilities(driver).xpathMakerContainsText(name);
				Log.info("and element............" + myxpath + "is displayed successfully");
			
				Assert.assertTrue(" Varification failede as " + myxpath + "NOT FOUND",
						driver.findElement(By.xpath(myxpath)).isDisplayed());
		}
	}

	public void checkElementLinkPresentOnScreen(DataTable table) throws InterruptedException {
		Thread.sleep(3000);
		List<List<String>> data = table.raw();
		System.out.println(" value is ++" + data);
		for (int i = 1; i < data.size(); i++) {

			String name = data.get(i).get(1);
			System.out.println(" and the name is+++++" + name);
			String myxpath = new DBUtilities(driver).xpathMakerDivContainsText(name);
			System.out.println("*checking for*  " + myxpath);
			if (driver.findElements(By.xpath(myxpath)).size() != 0) {
				System.out.println("Element is Present");
			} else {
				System.out.println("Element is Absent");
			}
			Thread.sleep(2000);
			Assert.assertTrue(" Varification failede as " + myxpath + "NOT FOUND",
					driver.findElement(By.xpath(myxpath)).isDisplayed());
		}

	}

	public void checkUIElementTEXTIsDisplayed(String arg1) throws InterruptedException {
		DBUtilities checkElementDisplayed = new DBUtilities(driver);
		// String myxpath=checkElementDisplayed.xpathMaker(arg1);
		String myxpath = checkElementDisplayed.xpathMakerContainsText(arg1); 
		System.out.println("checking for text " + myxpath);

		driver.getPageSource().contains(arg1);
		Assert.assertTrue(" Varification failed as " + arg1 + "NOT FOUND", driver.getPageSource().contains(arg1));
		// Assert.assertTrue(" Varification failed as " +myxpath +"NOT
		// FOUND",driver.findElement(By.xpath(myxpath)).isDisplayed());

		if (driver.findElements(By.xpath(myxpath)).size() != 0) {
			System.out.println("Element is Present");
		} else {
			System.out.println("Element is Absent");
		}
	}

	// following are for RHS colouns......

	// checks high and lower values and verify that the correct result is
	// displayed in correct format
	public void compareValueOneToValueTwo(String arg1, String arg2) {

		DBUtilities createXpath = new DBUtilities(driver);
		String myxpath = createXpath.xpathMakerById(arg1);
		String currentBill = driver.findElement(By.xpath(myxpath)).getText();

		String myxpath2 = createXpath.xpathMakerById(arg2);
		String lastBill = driver.findElement(By.xpath(myxpath2)).getText();
		System.out.println(lastBill);

		String newCurrentBill = currentBill.replaceAll("[^\\d.]+", "");
		// System.out.println(" its "+newCurrentBill);
		double intnewCurrentBill = Double.parseDouble(newCurrentBill);
		System.out.println(" its**************************** " + intnewCurrentBill);
		String newLastBill = lastBill.replaceAll("[^\\d.]+", "");
		// System.out.println(" its "+newLastBill);
		double intnewLastBill = Double.parseDouble(newLastBill);
		System.out.println(" its*********************** " + intnewLastBill);

		// if val1<val2
		if (intnewCurrentBill < intnewLastBill) {
			DBUtilities createXpath3 = new DBUtilities(driver);
			String myxpath3 = createXpath3.xpathMakerSpanClass("fa fa-fw fa-caret-down");
			// driver.findElement(By.xpath(myxpath3)).getText();
			Assert.assertTrue(driver.findElement(By.xpath(myxpath3)).isDisplayed());

			System.out.println("*******************it should be greeen and arrow is pointing down**************");
		} else if (intnewCurrentBill > intnewLastBill) {
			System.out.println("*****************it should be red and arrow is pointing up*****************");
			DBUtilities createXpath4 = new DBUtilities(driver);
			String myxpath4 = createXpath4.xpathMakerSpanClass("fa fa-fw fa-caret-up");
			Assert.assertTrue(driver.findElement(By.xpath(myxpath4)).isDisplayed());

		}

	}

	public void selectSAsFromCorousel(String arg1) {

		String myxpath = new DBUtilities(driver).xpathMakerById(arg1);
		// String howManySAsInCorousel = myxpath
		// Select listSAa = new Select(driver.findElement(By.xpath(myxpath)));
		System.out.println(myxpath);
		List<WebElement> mylist = driver.findElements(By.xpath(myxpath));
		for (int i = 0; i < mylist.size(); i++) {
			System.out.println(i + mylist.get(i).getText());

		}

	}


}
