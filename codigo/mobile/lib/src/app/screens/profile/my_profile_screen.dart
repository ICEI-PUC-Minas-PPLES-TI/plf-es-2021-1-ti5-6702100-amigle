import 'package:amigleapp/src/app/components/app_bar_widget.dart';
import 'package:amigleapp/src/app/components/custom_button_widget.dart';
import 'package:amigleapp/src/app/components/nav_drawer.dart';
import 'package:amigleapp/src/app/components/text_field_widget.dart';
import 'package:amigleapp/src/app/screens/profile/tags_screen.dart';
import 'package:amigleapp/src/app/shared/loading-screen/loading_screen.dart';
import 'package:amigleapp/src/app/utils/library/helpers/global.dart';
import 'package:amigleapp/src/app/utils/styles/colors_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

import 'my_profile_controller.dart';

class MyProfileScreen extends StatelessWidget {
  final MyProfileController _controller = MyProfileController();

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
          appBar: AppBarWidget.build(),
          body: Scaffold(
            key: AppBarWidget.scaffoldKey,
            drawer: NavDrawer(),
            body: _buildBody(),
          )),
    ));
  }

  _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Editar Perfil',
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
                      errorText: _controller.errorName,
                      onChange: (text) {
                        _controller.name = text?.trim();
                      }),
                  SizedBox(
                    height: 16,
                  ),
                  TextFieldWidget(
                      label: 'Data de nascimento',
                      keyBoardType: TextInputType.number,
                      password: false,
                      mask: '##/##/####',
                      errorText: _controller.errorAge,
                      onChange: (text) {
                        _controller.age = text?.trim();
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
                  'GERENCIAR TAGS',
                  style: TextStyle(
                      color: ColorsStyle.purple, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  appNavigator.navigate(TagsScreen());
                },
                borderColor: ColorsStyle.gray,
                radius: 4,
              ),
              CustomButtonWidget(
                title: Text(
                  'SALVAR',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                backgroundColor: ColorsStyle.purple,
                onPressed: _controller.verify,
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
            _controller.image != null
                ? Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(_controller.image))))
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
    _controller.setImage(await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50));
  }
}
