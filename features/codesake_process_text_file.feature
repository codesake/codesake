Feature: codesake process a plain text file
  When a text file is given as input, codesake analyses it with the
  Codesake::Engine::Text engine looking for reserved words.

  The idea is that some sort of secrets are stored in documentation or text
  files in the sources.

  Scenario: the file doesn't exists and codesake gives an error message
    Given the file "/tmp/test.txt" doesn't exist
    When I successfully run `bundle exec codesake /tmp/test.txt`
    Then the stderr should contain "can't find /tmp/test.txt"

  Scenario: the file exists and codesake says it's going to process it
    Given the text file "/tmp/existing.txt" does exist
    When I successfully run `bundle exec codesake /tmp/existing.txt`
    Then the stdout should contain "processing /tmp/existing.txt"

  Scenario: the file exists and codesake says it contains a secrets word
    Given the text file "/tmp/secrets.txt" does exist
    When I successfully run `bundle exec codesake /tmp/secrets.txt`
    Then the stdout should contain "found "password" keyword (/tmp/secrets.txt@5)"
    And the stdout should contain "found "secret" keyword (/tmp/secrets.txt@17)"
    And the stdout should contain "found "password" keyword (/tmp/secrets.txt@21)"
