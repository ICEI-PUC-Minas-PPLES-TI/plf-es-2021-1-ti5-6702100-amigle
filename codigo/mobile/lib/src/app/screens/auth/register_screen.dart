import 'package:amigleapp/src/app/components/app_bar_widget.dart';
import 'package:amigleapp/src/app/components/custom_button_widget.dart';
import 'package:amigleapp/src/app/components/text_field_widget.dart';
import 'package:amigleapp/src/app/shared/loading-screen/loading_screen.dart';
import 'package:amigleapp/src/app/utils/library/helpers/global.dart';
import 'package:amigleapp/src/app/utils/styles/colors_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatelessWidget {
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
          backgroundColor: ColorsStyle.background,
          appBar: AppBarWidget.build(backButton: true),
          body: _buildBody()),
    ));
  }

  _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Cadastro',
            style: TextStyle(color: Colors.black, fontSize: 34),
          ),
          SizedBox(
            height: 24,
          ),
          Observer(
            builder: (_) {
              return Column(
                children: <Widget>[
                  _buildUserImage(),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldWidget(
                      label: 'Nome',
                      password: false,
                      keyBoardType: TextInputType.text,
                      errorText: registerController.errorName,
                      onChange: (text) {
                        registerController.name = text?.trim();
                      }),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldWidget(
                      label: 'Idade',
                      keyBoardType: TextInputType.number,
                      password: false,
                      onChange: (text) {
                        registerController.age = text?.trim();
                      }),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldWidget(
                      label: 'E-mail',
                      password: false,
                      keyBoardType: TextInputType.emailAddress,
                      errorText: registerController.errorEmail,
                      onChange: (text) {
                        registerController.email = text?.trim();
                      }),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldWidget(
                      label: 'Senha',
                      password: true,
                      errorText: registerController.errorPassword,
                      onChange: (text) {
                        registerController.password = text?.trim();
                      }),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldWidget(
                      label: 'Confirmar Senha',
                      password: true,
                      errorText: registerController.errorConfirm,
                      onChange: (text) {
                        registerController.confirmPassword = text?.trim();
                      }),
                ],
              );
            },
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButtonWidget(
                title: Text(
                  'CADASTRAR',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                backgroundColor: ColorsStyle.purple,
                onPressed: registerController.verify,
                radius: 4,
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildUserImage() {
    return InkWell(
      onTap: _pickImage,
      child: Container(
        child: Row(
          children: [
            FlatButton.icon(
              onPressed: _pickImage,
              icon: Icon(
                Icons.add,
                color: ColorsStyle.purple,
              ),
              label: Text(
                'ESCOLHER IMAGEM DE PERFIL',
                style: TextStyle(
                    color: ColorsStyle.purple, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            registerController.image != null
                ? Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(registerController.image))))
                : Icon(
                    Icons.account_circle,
                    size: 40,
                    color: ColorsStyle.gray,
                  )
          ],
        ),
      ),
    );
  }

  _pickImage() async {
    registerController.setImage(await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50));
  }
}
