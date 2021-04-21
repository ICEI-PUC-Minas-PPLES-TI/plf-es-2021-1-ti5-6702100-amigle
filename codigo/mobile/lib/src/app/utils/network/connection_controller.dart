import 'package:connectivity/connectivity.dart';
import 'package:mobx/mobx.dart';

part 'connection_controller.g.dart';

class ConnectionController = _ConnectionControllerBase
    with _$ConnectionController;

abstract class _ConnectionControllerBase with Store {
  @observable
  bool isConnected = true;

  initConnectedListener() {
    Connectivity().onConnectivityChanged.listen((connection) {
      print('_isConnectedListener: $connection');
      if (connection == ConnectivityResult.none) {
        this.isConnected = false;
      } else {
        this.isConnected = true;
      }
    });
  }
}
