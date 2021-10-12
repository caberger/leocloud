Feature: Build the full name of a Person from first name and last name
  Jeder muss sonst überall selbst den Namen formatieren, wenn er ihn anzeigen will.

  Scenario: Firstname and Lastname gives fullname
    Given a person
    And first name is "Max"
    And last name is "Mustermann"
    When I ask for the full name
    Then I should be told "Max Mustermann"

  Scenario: no first name and only lastname given
    Given a person
    And last name is "Mustermann"
    When I ask for the full name
    Then I should be told "Mustermann"

  Scenario: first name given by no last name
    Given a person
    And first name is "John"
    When I ask for the full name
    Then I should be told "John"

  Scenario: no first name and no last name
    Given a person
    When I ask for the full name
    Then I should be told ""
