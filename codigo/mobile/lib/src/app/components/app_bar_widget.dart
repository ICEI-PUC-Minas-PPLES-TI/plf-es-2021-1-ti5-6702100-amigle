import 'package:amigleapp/src/app/utils/library/helpers/global.dart';
import 'package:amigleapp/src/app/utils/styles/colors_style.dart';
import 'package:flutter/material.dart';

class AppBarWidget {
  static build({bool backButton = false}) {
    return AppBar(
      backgroundColor: ColorsStyle.purple,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text('Amigle'),
      leading: backButton ? _backButton() : _menuButton(),
    );
  }

  static _backButton() {
    return IconButton(
        icon: Icon(Icons.chevron_left),
        onPressed: () {
          appNavigator.popNavigate();
        });
  }

  static _menuButton() {
    return IconButton(icon: Icon(Icons.menu), onPressed: () {});
  }
}
