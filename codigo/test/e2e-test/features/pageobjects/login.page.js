const Page = require('./page');

class LoginPage extends Page {

    get inputUsername () { return $('//*[@id="email"]/input') }
    get inputPassword () { return $('//*[@id="password"]/input') }
    get btnSubmit () { return $('/html/body/div[2]/main/section/div/div[2]/form/div[3]/button/div') }
    get btnSignInLoginPage () { return $('//*[@id="signupButton"]') }
    get inputName () { return $('//*[@id="name"]/input') }
    get inputBirth () { return $('//*[@id="birthDate"]/input') }
    get inputEmail () { return $('//*[@id="email"]/input') }
    get inputNewPassword () { return $('//*[@id="password"]/input') }
    get inputConfirmNewPassword () { return $('//*[@id="confirmPassword"]/input') }
    get btnSignUp () { return $('//*[@id="signupButton"]/div') }


    login (username, password) {
        this.inputUsername.waitForDisplayed(10000);
        this.inputUsername.setValue(username);
        this.inputPassword.setValue(password);
        this.btnSubmit.click(); 
    }

    signup () {
        this.inputName.waitForDisplayed(1000);
        this.inputBirth.setValue('21121998');
        this.inputEmail.setValue('tutu@gmail.com');
        this.inputNewPassword.setValue('12345678');
        this.inputConfirmNewPassword.setValue('12345678');
    }

    open () {
        return super.open('login');
    }
}

module.exports = new LoginPage();
