 Feature: Test APIs
 @wip
 Scenario Outline: Get many movies by title

    Given I query interface "<title>"
    When I make the rest call to "https://actrevenueofficetrial.outsystemsenterprise.com/IntegrationTest/Addressify.aspx"
    Then response should contain "<genres>"
    
    Examples: No special characters in movie titles
    
    | title        | genres                                                               |
    | Finding Nemo | {"genres":["Animation","Adventure","Comedy","Family"]}               |

