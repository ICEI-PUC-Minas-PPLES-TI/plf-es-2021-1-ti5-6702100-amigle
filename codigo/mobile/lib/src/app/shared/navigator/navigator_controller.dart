import 'package:flutter/material.dart';

class NavigatorController {
  GlobalKey<NavigatorState> _navigatorKey;

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  BuildContext get currentContext =>
      this._navigatorKey.currentState.overlay.context;

  void setNavigatorKey(GlobalKey<NavigatorState> navigatorKey) {
    this._navigatorKey = navigatorKey;
  }

  void navigate(dynamic destination,
      {bool modal, bool replace, bool maintainState}) {
    if (replace != null && replace == true) {
      this._navigatorKey.currentState.pushReplacement(
            MaterialPageRoute(
                builder: (context) => destination,
                fullscreenDialog: modal ?? false,
                maintainState: maintainState ?? true),
          );
    } else {
      this._navigatorKey.currentState.push(
            MaterialPageRoute(
                builder: (context) => destination,
                fullscreenDialog: modal ?? false,
                maintainState: maintainState ?? true),
          );
    }
  }

  popNavigate() {
    if (this._navigatorKey.currentState.canPop()) {
      this._navigatorKey.currentState.pop();
    }
  }

  popToRoot() {
    if (this._navigatorKey.currentState.canPop()) {
      this
          ._navigatorKey
          .currentState
          .popUntil((Route<dynamic> route) => route.isFirst);
    }
  }

  showBottomSheet(dynamic child, {Function closed}) {
    var modal = showModalBottomSheet(
      context: this.currentContext,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return child;
      },
    );
    modal.then((value) {
      print("bottomSheetController: $value");
      closed();
    });
  }
}
