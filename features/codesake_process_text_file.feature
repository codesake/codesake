Feature: codesake process a plain text file
  When a text file is given as input, codesake analyses it with the
  Codesake::Engine::Text engine looking for reserved words.

  The idea is that some sort of secrets are stored in documentation or text
  files in the sources.

  Scenario: the file doesn't exists and codesake gives an error message
    Given the file "/tmp/test.txt" doesn't exist
    When I successfully run `bundle exec codesake /tmp/test.txt`
    Then the stderr should contain "can't find /tmp/test.txt"
