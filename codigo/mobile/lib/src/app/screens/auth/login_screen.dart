import 'package:amigleapp/src/app/components/app_bar_widget.dart';
import 'package:amigleapp/src/app/components/custom_button_widget.dart';
import 'package:amigleapp/src/app/components/text_field_widget.dart';
import 'package:amigleapp/src/app/screens/auth/register_screen.dart';
import 'package:amigleapp/src/app/shared/loading-screen/loading_screen.dart';
import 'package:amigleapp/src/app/utils/library/helpers/global.dart';
import 'package:amigleapp/src/app/utils/styles/colors_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
        body: GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          appBar: AppBarWidget.build(noAction: true), body: _buildBody()),
    ));
  }

  _buildBody() {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Login',
              style: TextStyle(color: Colors.black, fontSize: 34),
            ),
            SizedBox(
              height: 24,
            ),
            Observer(
              builder: (_) {
                return Column(
                  children: <Widget>[
                    TextFieldWidget(
                        label: 'E-mail',
                        password: false,
                        keyBoardType: TextInputType.emailAddress,
                        errorText: userController.errorEmail,
                        onChange: (text) {
                          userController.email = text?.trim();
                        }),
                    SizedBox(
                      height: 16,
                    ),
                    TextFieldWidget(
                        label: 'Senha',
                        password: true,
                        errorText: userController.errorPassword,
                        onChange: (text) {
                          userController.password = text?.trim();
                        }),
                  ],
                );
              },
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButtonWidget(
                  title: Text(
                    'CADASTRE-SE',
                    style: TextStyle(
                        color: ColorsStyle.purple, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    appNavigator.navigate(RegisterScreen());
                  },
                  borderColor: ColorsStyle.gray,
                  radius: 4,
                ),
                CustomButtonWidget(
                  title: Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: ColorsStyle.purple,
                  onPressed: userController.verify,
                  radius: 4,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
