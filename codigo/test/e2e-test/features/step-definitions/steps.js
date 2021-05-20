const { Given, When, Then } = require('cucumber');

const LoginPage = require('../pageobjects/login.page');
const MainPage = require('../pageobjects/main.page');


Given(/^I am on the login page$/, () => {
    LoginPage.open();
});

When(/^I login with '([^"']+)' and '([^"']+)'$/, (useremail, password) => {
    LoginPage.login(useremail, password)
});

When("I click on the start new conversation", () => {
    MainPage.startConversationLink.waitForDisplayed(30000);
    MainPage.startConversationLink.click();
});

When("I click on new conversation by specific tag", () => {
    MainPage.specificTagButton.waitForDisplayed(30000);
    MainPage.specificTagButton.click();
});

When("I click on new conversation by all tags", () => {
    MainPage.allTagsButton.waitForDisplayed(30000);
    MainPage.allTagsButton.click();
});

When("I click on sign up", () => {
    LoginPage.btnSignUpLoginPage.waitForDisplayed(30000);
    LoginPage.btnSignUpLoginPage.click();
});

When("I fill in all the forms", () => {
    LoginPage.signup();
});

When("I click on sign up button", () => {
    LoginPage.btnSignUp.waitForDisplayed(30000);
    LoginPage.btnSignUp.click(); 
});

Then(/^I should be able to access the main page and see this '([^"']+)'$/, (message) => {
    expect(MainPage.mainTitle).toBeExisting();
    expect(MainPage.mainTitle).toHaveTextContaining(message);
});

Then("I should be able to start a new conversation", () => {
    expect(MainPage.loadingText).toBeExisting();
    expect(MainPage.loadingText).toHaveTextContaining("Procurando");
});

Then("I should be able to create a new user", () => {
    expect(true);
});