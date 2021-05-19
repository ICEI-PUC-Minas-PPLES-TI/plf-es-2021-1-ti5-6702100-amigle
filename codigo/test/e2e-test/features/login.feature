Feature: User functionalities

  Scenario: As an admin user, I want to login into the amigle website

    Given I am on the login page
    When I login with 'sam@gmail.com' and '12345678'
    Then I should be able to access the page to start a new conversation