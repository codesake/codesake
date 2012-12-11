Feature: codesake complains if targets are missing
  When executed codesake needs one or more target to analyse

  Scenario: codesake complains if targets are missing
    Given an empty command line
    When I successfully run `codesake`
    Then the stderr should contain "missing targets"

