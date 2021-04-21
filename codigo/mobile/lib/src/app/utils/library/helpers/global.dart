import 'package:amigleapp/src/app/screens/auth/login_controller.dart';
import 'package:amigleapp/src/app/screens/auth/register_controller.dart';
import 'package:amigleapp/src/app/shared/alert-dialog/alert_controller.dart';
import 'package:amigleapp/src/app/shared/alert-dialog/loading_hud.dart';
import 'package:amigleapp/src/app/shared/loading-screen/loading_controller.dart';
import 'package:amigleapp/src/app/shared/navigator/navigator_controller.dart';
import 'package:amigleapp/src/app/utils/network/connection_controller.dart';
import 'package:amigleapp/src/app/utils/network/network_cache.dart';
import 'package:amigleapp/src/app/utils/network/network_service.dart';
import 'package:get_it/get_it.dart';

final frwkNetwork = GetIt.I<NetworkService>();
final frwkNetworkCache = GetIt.I<NetworkCache>();
final frwkLoading = GetIt.I<LoadingController>();
final appNavigator = GetIt.I<NavigatorController>();
final frwkAlert = GetIt.I<AlertController>();
final frwkLoadHud = GetIt.I<LoadingHUD>();

final registerController = GetIt.I<RegisterController>();
final userController = GetIt.I<LoginController>();
final appConnection = GetIt.I<ConnectionController>();
