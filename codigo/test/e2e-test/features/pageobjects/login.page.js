const Page = require('./page');

class LoginPage extends Page {

    get inputUsername () { return $('#email') }
    get inputPassword () { return $('#password') }
    get btnSubmit () { return $('button[type="submit"]') }


    login (username, password) {
        this.inputUsername.waitForDisplayed(10000);
        this.inputUsername.setValue(username);
        this.inputPassword.setValue(password);
        this.btnSubmit.click(); 
    }

    open () {
        return super.open('login');
    }
}

module.exports = new LoginPage();
