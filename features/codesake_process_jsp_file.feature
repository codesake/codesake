@WORK_IN_PROGRESS
Feature: codesake process a jsp page
  When a Jsp file is given as input, codesake analyses it with the
  Codesake::Engine::Jsp engine for security issues.

  When a Jsp file is analyzed the following information will be gathered:
  * imported packages
  * variable read from requests
  * cookies created
  * reserved keywords

  Scenario:  the file doesn't exists and codesake gives an error message
    Given the file "/tmp/test.jsp" doesn't exist
    When I successfully run `bundle exec codesake /tmp/test.jsp`
    Then the stderr should contain "can't find /tmp/test.jsp"

  Scenario: the file exists and codesake says it's going to process it
    Given the jsp file "/tmp/existing.jsp" does exist
    When I successfully run `bundle exec codesake /tmp/existing.jsp`
    Then the stdout should contain "processing /tmp/existing.jsp"

  Scenario: codesake processing the file finds the "request" keyword we threat as reserved
    Given the jsp file "/tmp/existing.jsp" does exist
    And we add "request" as reserved word
    When I successfully run `bundle exec codesake /tmp/existing.jsp --add-keys request` 
    Then the stdout should contain "reserved keyword found: "request" (/tmp/existing.jsp@8)"
    And the stdout should contain "reserved keyword found: "request" (/tmp/existing.jsp@24)"
    And the stdout should contain "reserved keyword found: "request" (/tmp/existing.jsp@25)"
    And the stdout should contain "reserved keyword found: "request" (/tmp/existing.jsp@26)"
    And the stdout should contain "reserved keyword found: "request" (/tmp/existing.jsp@27)"
    And the stdout should contain "reserved keyword found: "request" (/tmp/existing.jsp@28)"
    And the stdout should contain "reserved keyword found: "request" (/tmp/existing.jsp@32)"
    And the stdout should contain "reserved keyword found: "request" (/tmp/existing.jsp@44)"
    And the stdout should contain "reserved keyword found: "request" (/tmp/existing.jsp@46)"

  Scenario: codesake processing the file finds the imported packages
    Given the jsp file "/tmp/existing.jsp" does exist
    When I successfully run `bundle exec codesake /tmp/existing.jsp`
    Then the stdout should contain "imported package found: \"com.codesake.test\""

  Scenario: codesake processing the file finds attack entrypoints
    Given the jsp file "/tmp/existing.jsp" does exist
    When I successfully run `bundle exec codesake /tmp/existing.jsp`
    Then the stdout should contain "attack entrypoint found: parameter \"message\" stored in \"message\" (/tmp/existing.jsp@32)"

  Scenario: codesake processing the file finds potential reflected xss and it shows also suspiscious results
    Given the jsp file "/tmp/existing.jsp" does exist
    When I successfully run `bundle exec codesake /tmp/existing.jsp --all-vulnerabilities` 
    Then the stdout should contain "suspicious reflected xss found: "request.getContextPath()" (/tmp/existing.jsp@8)"
    And the stdout should contain "suspicious reflected xss found: "request.getContextPath()" (/tmp/existing.jsp@24)"
    And the stdout should contain "suspicious reflected xss found: "request.getContextPath()" (/tmp/existing.jsp@25)"
    And the stdout should contain "suspicious reflected xss found: "request.getContextPath()" (/tmp/existing.jsp@26)"
    And the stdout should contain "suspicious reflected xss found: "request.getContextPath()" (/tmp/existing.jsp@27)"
    And the stdout should contain "suspicious reflected xss found: "request.getContextPath()" (/tmp/existing.jsp@28)"
    And the stdout should contain "reflected xss found: "message" (/tmp/existing.jsp@36)"
    And the stdout should contain "suspicious reflected xss found: "request.getContextPath()" (/tmp/existing.jsp@44)"
    And the stdout should contain "suspicious reflected xss found: "request.getLocalName()" (/tmp/existing.jsp@46)"

  Scenario: codesake processing the file finds potential reflected xss and it shows also suspiscious results (as default behaviour)
    Given the jsp file "/tmp/existing.jsp" does exist
    When I successfully run `bundle exec codesake /tmp/existing.jsp` 
    Then the stdout should contain "suspicious reflected xss found: "request.getContextPath()" (/tmp/existing.jsp@8)"
    And the stdout should contain "suspicious reflected xss found: "request.getContextPath()" (/tmp/existing.jsp@24)"
    And the stdout should contain "suspicious reflected xss found: "request.getContextPath()" (/tmp/existing.jsp@25)"
    And the stdout should contain "suspicious reflected xss found: "request.getContextPath()" (/tmp/existing.jsp@26)"
    And the stdout should contain "suspicious reflected xss found: "request.getContextPath()" (/tmp/existing.jsp@27)"
    And the stdout should contain "suspicious reflected xss found: "request.getContextPath()" (/tmp/existing.jsp@28)"
    And the stdout should contain "reflected xss found: "message" (/tmp/existing.jsp@36)"
    And the stdout should contain "suspicious reflected xss found: "request.getContextPath()" (/tmp/existing.jsp@44)"
    And the stdout should contain "suspicious reflected xss found: "request.getLocalName()" (/tmp/existing.jsp@46)"



  Scenario: codesake processing the file finds potential reflected xss and it shows only confirmed results
    Given the jsp file "/tmp/existing.jsp" does exist
    When I successfully run `bundle exec codesake /tmp/existing.jsp --confirmed-vulnerabilities` 
    Then the stdout should contain "reflected xss found: "message" (/tmp/existing.jsp@36)"

  Scenario: codesake processing the file finds cookies that are created by the page
    Given the jsp file "/tmp/existing.jsp" with cookies does exist
    When I successfully run `bundle exec codesake /tmp/existing.jsp` 
    Then the stdout should contain "cookie \"name\" found with value: \"a_value\" (/tmp/existing.jsp@51)"
    And the stdout should contain "cookie \"second\" found with value: \"12\" (/tmp/existing.jsp@52)"




 
