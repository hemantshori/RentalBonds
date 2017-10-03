package Utilities;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

public class XPathGenerator {

	WebDriver driver = null;

	// constructor
	public XPathGenerator(WebDriver dr) {
		this.driver = dr;
	}

	public String xpathMaker(String buttonName) {
		String xpath = "//*[text()='" + buttonName + "']";
		return xpath;
	}

	public String xpathMakerById(String buttonName) {
		String xpath = "//*[contains(@id, '" + buttonName + "')]";
		System.out.println("xpath ::*** " + xpath);
		return xpath;
	}

	public String xpathMakerByExactId(String buttonName) {
		String xpath = "//*[@id='" + buttonName + "']";
		System.out.println("xpath ::*** " + xpath);
		return xpath;
	}

	public String xpathMakerForInputField(String fieldName) {
		String xpath = "//*[@id='" + fieldName + "']";
		System.out.println(" its " + xpath);
		return xpath;
	}

	public String xpathMakerBySpanID(String buttonName) {
		String xpath = "//span[text()='" + buttonName + "']";
		// contains(text()
		// String xpath = "//span[contains(text()='"+buttonName+"']";

		return xpath;
	}

	public String xpathMakerByLabelAndId(String buttonName) {
		String xpath = "//label[contains(@id, '" + buttonName + "')]";
		System.out.println("xpath ::*** " + xpath);
		return xpath;
	}

	public String xpathMakerByLabelContainsText(String buttonName) {
		String xpath = "//label[contains(text(), '" + buttonName + "')]";
		System.out.println("xpath ::*** " + xpath);
		return xpath;
	}

	public String xpathMakerBySpanAndId(String buttonName) {
		String xpath = "//span[contains(@id, '" + buttonName + "')]";
		System.out.println("xpath ::*** " + xpath);
		return xpath;
	}

	public String xpathMakerContainsText(String buttonName) {
		String xpath = "//*[contains(text(),'" + buttonName + "')]";
		return xpath;
	}

	public String xpathMakerContainsText2ndOption(String buttonName) {
		String xpath = "(//*[contains(text(),'" + buttonName + "')])[2]";
		return xpath;
	}

	public String xpathMakerContainsText1stOption(String buttonName) {
		String xpath = "(//*[contains(text(),'" + buttonName + "')])[1]";
		return xpath;
	}

	public String xpathMakerContainsID2ndOption(String arg1) {
		String xpath = "(//input[contains(@id, '" + arg1 + "')])[2]";

		System.out.println("Element found*** " + xpath);
		return xpath;
	}

	// span[@class='nav-selection']
	public String xpathMakerSpanClass(String buttonName) {
		String xpath = "//span[@class='" + buttonName + "']";
		return xpath;
	}

	// for input fields with input id
	public String xpathMakerByInputId(String arg1) {
		String xpath = "//input[contains(@id, '" + arg1 + "')]";
		// String xpath = "//*[contains(@id, '"+arg1+"')]";
		System.out.println("Element found*** " + xpath);
		return xpath;
	}

	public String xpathMakerByTextAreaId(String arg1) {
		String xpath = "//textarea[contains(@id, '" + arg1 + "')]";
		System.out.println("Element found*** " + xpath);
		return xpath;
	}

	public String xpathMakerByClass(String buttonName) {
		// *[@class = 'InfoTooltip OSInline']
		String xpath = "//*[@class ='" + buttonName + "']";
		return xpath;
	}

	// xpath creation by type
	public String xpathMakerByType(String name) {
		String xpath = "//*[@type ='" + name + "']";
		return xpath;
	}

	// xpath creation by ClassName
	public String xpathMakerByTextInClass(String text) {
		String xpath = "//*[contains(@class, '" + text + "')]";

		return xpath;
	}

	public String xpathMakerByImageName(String arg1) {
		String xpath = "//img[contains(@src,'" + arg1 + "')]";

		return xpath;

	}

	public String clickOn2ndOptionOnPopup(String arg1) {
		String xpath = "(//img[contains(@src,'" + arg1 + "')])[2]";
		System.out.println(" ssssssssssssssooooooooooooooooo" + xpath);
		return xpath;

	}

	public String xpathMakerById1AndId2(String arg1, String arg2) {
		String xpath = "//*[contains(@id, '" + arg1 + "')][contains(@id, '" + arg2 + "')]";

		System.out.println(" its " + xpath);
		return xpath;
	}

	public String xpathMakerContainsCustomField(String arg1, String arg2) {
		String xpath = "//*[contains(@" + arg1 + ", '" + arg2 + "')]";
		System.out.println(" its " + xpath);
		return xpath;
	}

	public String xpathMakerByValue(String arg1) {
		String xpath = "//*[contains(@value, '" + arg1 + "')]";
		System.out.println("xpath ::*** " + xpath);
		return xpath;
	}

	public String combine2Xpaths(String arg1, String arg2) {
		System.out.println(arg1);
		System.out.println(arg2);
		String truncatedXpath2 = arg2.substring(3);
		System.out.println(truncatedXpath2);
		System.out.println(arg1 + truncatedXpath2);
		return arg1 + truncatedXpath2;

	}

	// specifically for gessit when a trwith specific text is to be selected
	// from a table id
	public String xpathMakerPickTrTextInTableID(String arg1, String arg2) {

		String xpath = "//table[contains(@id, '" + arg2 + "')]//tbody//tr[contains(.,'" + arg1 + "')]";
		System.out.println(" its " + xpath);
		return xpath;
	}

	public String xpathMakerPickFirstRowInTable(String arg1, String arg2) {
		// avoid using this one as this is only because RB cursor has to be
		// moved on LHS
		String xpath = "//table[contains(@id, '" + arg2 + "')]//tbody//tr[1]//td[1]";
		System.out.println("Picking the first row from table " + arg2 + " with Xpath" + xpath);
		return xpath;
	}

	public String xpathMakerTbodyById(String arg1) {
		String xpath = "//table[contains(@id, '" + arg1 + "')]/tbody";
		System.out.println(" its " + xpath);
		return xpath;
	}

	public String xpathMakerForTableElement(String arg1) {
		String xpath = "//tr/td[(text())=arg1]";
		System.out.println(" its " + xpath);
		return xpath;
	}

	public String xpathMakerTbody() {
		String xpath = "//table/tbody";
		System.out.println(" its " + xpath);
		return xpath;
	}

	public String xpathMakerTheadById(String arg1) {
		String xpath = "//table[contains(@id, '" + arg1 + "')]/thead/tr";
		System.out.println(" its " + xpath);
		return xpath;
	}

	public String xpathMakerThead() {
		String xpath = "//table/thead/tr";
		System.out.println(" its " + xpath);
		return xpath;
	}

	public String xpathMakerDivContainsText(String arg1) {
		String xpath = "//div[contains(text(), '" + arg1 + "')]";
		System.out.println(" its " + xpath);
		return xpath;
	}

	public String xpathMakerDivContainsClass(String arg1) {
		String xpath = "//div[contains(@class, '" + arg1 + "')]";
		System.out.println(" its " + xpath);
		return xpath;
	}

	public String xpathMakerElementByRowIndexandClass(int index, String arg1) {
		String xpath = "//table/tbody/tr[" + index + "]//*[contains(@class, '" + arg1 + "')]";
		System.out.println(" its " + xpath);
		return xpath;
	}

	public String xpathMakerElementByRowIndexandId(int index, String arg1) {
		String xpath = "//table/tbody/tr[" + index + "]//*[contains(@id, '" + arg1 + "')]";
		System.out.println(" its " + xpath);
		return xpath;
	}

	// following is only for gessit.......because of poor code practicing
	public String xpathMakerByIdAndlabel(String buttonName) {
		String xpath = "//*[contains(@id, '" + buttonName + "')]/label";
		System.out.println("xpath ::*** " + xpath);
		return xpath;
	}

	public String xpathMakerByTd(String arg1) {
		String xpath = "//td[contains(., '" + arg1 + "')]";
		System.out.println("xpath ::*** " + xpath);
		return xpath;
	}

	// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	// ++++++++++++++++++++++++++++++++++Read "some" Row of the
	// table++++++++++++++++++++++++++++
	// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	public String xPathMakerForReadSomeRowOfSomeTable(String arg1, String arg2) {
		String xpath = "//table[contains(@id,'" + arg2 + "')] //tbody//tr[" + arg1 + "]";
		return xpath;

	}

	public String xPathMakerForSomeElementOfSomeRowOfSomeTable(int arg1, int arg2, String arg3) {
		String xpath = "//table[contains(@id,'" + arg3 + "')] //tbody//tr[" + arg2 + "]//td[" + arg1 + "]";
		return xpath;

	}

}
