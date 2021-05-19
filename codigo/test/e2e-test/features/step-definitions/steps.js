const { Given, When, Then } = require('cucumber');

const LoginPage = require('../pageobjects/login.page');
/*const AdminPage = require('../pageobjects/admin.page');*/


Given(/^I am on the login page$/, () => {
    LoginPage.open();
});

When(/^I login with '([^"']+)' and '([^"']+)'$/, (useremail, password) => {
    LoginPage.login(useremail, password)
});

/*Then(/^I should be able to access the admin page and see this '([^"']+)'$/, (message) => {
    expect(AdminPage.mainTitle).toBeExisting();
    expect(AdminPage.mainTitle).toHaveTextContaining(message);
});

When("I click on the Gerais button", () => {
    AdminPage.cardGerais.waitForDisplayed(30000);
    AdminPage.cardGerais.click();
});

When("I click on the Especificas button", () => {
    AdminPage.cardEspecificas.waitForDisplayed(30000);
    AdminPage.cardEspecificas.click();
});

When("I click on the Por Usuário button", () => {
    AdminPage.cardPorUsuario.waitForDisplayed(30000);
    AdminPage.cardPorUsuario.click();
});

When("I click on the Posts button", () => {
    AdminPage.cardPosts.waitForDisplayed(30000);
    AdminPage.cardPosts.click();
});

Then("I should be able to access the admin functionality and see this Estatísticas Gerais", () => {
    expect(AdminPage.h1Gerais).toBeExisting();
    expect(AdminPage.h1Gerais).toHaveTextContaining("Estatísticas Gerais");
});

Then("I should be able to access the admin functionality and see this Estatísticas Específicas", () => {
    expect(AdminPage.h1Especificas).toBeExisting();
    expect(AdminPage.h1Especificas).toHaveTextContaining("Estatísticas Específicas");
});

Then("I should be able to access the admin functionality and see this Estatísticas por Usuário", () => {
    expect(AdminPage.h1PorUsuario).toBeExisting();
    expect(AdminPage.h1PorUsuario).toHaveTextContaining("Estatísticas por Usuário");
});

Then("I should be able to access the admin functionality and see this Posts Cadastrados", () => {
    expect(AdminPage.h1Posts).toBeExisting();
    expect(AdminPage.h1Posts).toHaveTextContaining("Posts Cadastrados");
});*/