import 'package:amigleapp/src/app/screens/auth/login_screen.dart';
import 'package:amigleapp/src/app/screens/history/history_screen.dart';
import 'package:amigleapp/src/app/screens/home/home_screen.dart';
import 'package:amigleapp/src/app/screens/profile/my_profile_screen.dart';
import 'package:amigleapp/src/app/screens/trending/trending_screen.dart';
import 'package:amigleapp/src/app/utils/library/helpers/global.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Início'),
            onTap: () {
              appNavigator.popNavigate();
              appNavigator.navigate(HomeScreen(), replace: true);
            },
          ),
          ListTile(
            title: Text('Trending'),
            onTap: () {
              appNavigator.popNavigate();
              appNavigator.navigate(TrendingScreen(), replace: true);
            },
          ),
          ListTile(
            title: Text('Histórico'),
            onTap: () {
              appNavigator.popNavigate();
              appNavigator.navigate(HistoryScreen(), replace: true);
            },
          ),
          ListTile(
            title: Text('Meu Perfil'),
            onTap: () {
              appNavigator.popNavigate();
              appNavigator.navigate(MyProfileScreen(), replace: true);
            },
          ),
          ListTile(
            title: Text('Sair'),
            onTap: () {
              appNavigator.popNavigate();
              appNavigator.navigate(LoginScreen(), replace: true);
            },
          ),
        ],
      ),
    );
  }
}
