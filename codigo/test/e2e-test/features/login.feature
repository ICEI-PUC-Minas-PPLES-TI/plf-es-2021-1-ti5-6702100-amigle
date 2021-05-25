Feature: User functionalities

  Scenario: As an user, I want to login into the amigle website

    Given I am on the login page
    When I login with 'sam@gmail.com' and '12345678'
    Then I should be able to access the main page and see this 'Bem vindo ao Amigle!'

  Scenario: As an user, I want to login start a new conversation by specific tag

    Given I am on the login page
    When I login with 'sam@gmail.com' and '12345678'
    And I click on the start new conversation
    And I click on new conversation by specific tag
    Then I should be able to start a new conversation with specific tag

  Scenario: As an user, I want to login start a new conversation by all tags

    Given I am on the login page
    When I login with 'sam@gmail.com' and '12345678'
    And I click on the start new conversation
    And I click on new conversation by all tags
    Then I should be able to start a new conversation with all tags

  Scenario: As an user, I want to create a new account

    Given I am on the login page
    When I click on sign up
    And I fill in all the forms
    And I click on sign up button
    Then I should be able to create a new user