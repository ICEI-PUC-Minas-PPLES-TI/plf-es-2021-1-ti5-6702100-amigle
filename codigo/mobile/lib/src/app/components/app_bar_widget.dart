import 'package:amigleapp/src/app/screens/home/chat_screen.dart';
import 'package:amigleapp/src/app/utils/library/helpers/global.dart';
import 'package:amigleapp/src/app/utils/styles/colors_style.dart';
import 'package:flutter/material.dart';

class AppBarWidget {
  static GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  static List<String> menu = [
    'Desligar Microfone',
    'Desligar Câmera',
    'Mostrar Chat'
  ];

  static build(
      {bool noAction = false,
      bool backButton = false,
      Function actionMenu,
      bool popupMenu = false}) {
    return AppBar(
      backgroundColor: ColorsStyle.purple,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text('Amigle'),
      leading: noAction
          ? null
          : backButton ? _backButton() : _menuButton(actionMenu),
      actions: [
        popupMenu
            ? PopupMenuButton<String>(
                onSelected: (text) {
                  if (text == 'Mostrar Chat') {
                    appNavigator.navigate(ChatScreen());
                  }
                },
                itemBuilder: (BuildContext context) {
                  return menu.map((e) {
                    return PopupMenuItem<String>(
                      value: e,
                      child: Text(e),
                    );
                  }).toList();
                },
              )
            : SizedBox.shrink()
      ],
    );
  }

  static _backButton() {
    return IconButton(
        icon: Icon(Icons.chevron_left),
        onPressed: () {
          appNavigator.popNavigate();
        });
  }

  static _menuButton(Function actionMenu) {
    return IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          if (scaffoldKey.currentState.isDrawerOpen == false) {
            scaffoldKey.currentState.openDrawer();
          } else {
            scaffoldKey.currentState.openEndDrawer();
          }
        });
  }
}
