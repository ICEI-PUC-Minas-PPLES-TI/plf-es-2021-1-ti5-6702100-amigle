import 'package:amigleapp/src/app/models/entities/user/user_entity.dart';
import 'package:amigleapp/src/app/screens/auth/login_controller.dart';
import 'package:amigleapp/src/app/screens/auth/login_screen.dart';
import 'package:amigleapp/src/app/screens/auth/register_controller.dart';
import 'package:amigleapp/src/app/utils/network/connection_controller.dart';
import 'package:amigleapp/src/app/utils/network/network_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'src/app/shared/alert-dialog/alert_controller.dart';
import 'src/app/shared/alert-dialog/loading_hud.dart';
import 'src/app/shared/loading-screen/loading_controller.dart';
import 'src/app/shared/navigator/navigator_controller.dart';
import 'src/app/utils/styles/colors_style.dart';

bool intro;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _configDatabase();
  _registerStores();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  runApp(MyApp());

  Intl.defaultLocale = 'pt';
}

_registerStores() {
  GetIt getIt = GetIt.I;

  // ** BASE **
  getIt.registerSingleton(NavigatorController());
  getIt.registerSingleton(LoadingController());
  getIt.registerSingleton(AlertController());
  getIt.registerSingleton(LoadingHUD());

  // ** APPLICATION **

  getIt.registerSingleton(NetworkService());

  getIt.registerSingleton(RegisterController());
  getIt.registerSingleton(LoginController());
  getIt.registerSingleton(ConnectionController());
}

_configDatabase() async {
  final dir = await getApplicationDocumentsDirectory();
  Hive
    ..init(dir.path)
    ..registerAdapter(UserEntityAdapter()); //

  await Hive.openBox<UserEntity>('users');
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    GetIt.I<NavigatorController>().setNavigatorKey(this._navigatorKey);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Observer(
      builder: (_) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Amigle',
          navigatorKey: this._navigatorKey,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          theme: ThemeData(
              fontFamily: 'Roboto',
              backgroundColor: ColorsStyle.background,
              canvasColor: Colors.transparent,
              primaryColor: ColorsStyle.purple),
          // home: AberturaScreen(),
          home: LoginScreen(),
        );
      },
    );
  }
}
