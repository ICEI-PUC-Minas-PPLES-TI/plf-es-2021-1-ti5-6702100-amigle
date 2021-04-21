import 'package:amigleapp/src/app/utils/library/helpers/global.dart';
import 'package:amigleapp/src/app/utils/styles/colors_style.dart';
import 'package:amigleapp/src/app/utils/vibration_util.dart';
import 'package:flutter/material.dart';
import 'package:vibrate/vibrate.dart';

enum AlertType { OK, YES_NO }

class AlertController {
  void showAlert(
      {String title,
      Colors titleColor,
      @required String message,
      Colors messageColor,
      AlertType alertType,
      Function() dialogCallback,
      Function() rejectDialogCallBack,
      bool barrierDismissible}) {
    try {
      FocusScope.of(appNavigator.currentContext).unfocus();
      showDialog(
        context: appNavigator.currentContext,
        builder: (x) => CustomAlert(
          message: message,
          title: title,
          alertType: alertType,
          titleColor: titleColor,
          messageColor: messageColor,
          dialogCallback: dialogCallback,
          rejectDialogCallback: rejectDialogCallBack,
        ),
        barrierDismissible: barrierDismissible ?? true,
      );
    } catch (e) {
      print('showAlert => invalid context');
    }
  }
}

class CustomAlert extends StatelessWidget {
  final AlertType alertType;

  final Function() dialogCallback;
  final Function() rejectDialogCallback;

  final String title;
  final Colors titleColor;

  final String message;
  final Colors messageColor;

  const CustomAlert(
      {Key key,
      this.title,
      this.titleColor,
      this.message,
      this.messageColor,
      this.alertType,
      this.dialogCallback,
      this.rejectDialogCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: _dialogContent(context),
    );
  }

  _createTitle() {
    return Column(
      children: <Widget>[
        Text(
          this.title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: ColorsStyle.gray,
              fontSize: 17,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  _dialogContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          this.title != null ? this._createTitle() : SizedBox.shrink(),
          Text(
            this.message ?? '',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: ColorsStyle.gray,
                fontSize: 13,
                fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: 16,
          ),
          (alertType == null || alertType == AlertType.OK)
              ? _buildSimpleButton(context)
              : _buildDecisionButton(context)
        ],
      ),
    );
  }

  Widget _buildSimpleButton(BuildContext context) {
    return Container(
      height: 50,
      child: FlatButton(
        onPressed: () {
          VibrationUtil.vibrate(FeedbackType.medium);
          Navigator.of(context).pop();
          if (dialogCallback != null) dialogCallback();
        },
        highlightColor: ColorsStyle.orangeLight,
        splashColor: ColorsStyle.orangeLight,
        color: Colors.transparent,
        child: Text(
          'OK',
          style: TextStyle(
              color: ColorsStyle.orange,
              fontSize: 13,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildDecisionButton(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 50,
          child: FlatButton(
            onPressed: () {
              VibrationUtil.vibrate(FeedbackType.light);
              Navigator.of(context).pop();
              if (rejectDialogCallback != null) rejectDialogCallback();
            },
            highlightColor: ColorsStyle.orangeLight,
            splashColor: ColorsStyle.orangeLight,
            color: Colors.transparent,
            child: Text(
              'NÃO',
              style: TextStyle(
                  color: ColorsStyle.gray,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Container(
          height: 50,
          child: FlatButton(
            onPressed: () {
              VibrationUtil.vibrate(FeedbackType.medium);
              Navigator.of(context).pop();
              if (dialogCallback != null) dialogCallback();
            },
            highlightColor: ColorsStyle.orangeLight,
            splashColor: ColorsStyle.orangeLight,
            color: Colors.transparent,
            child: Text(
              'SIM',
              style: TextStyle(
                  color: ColorsStyle.orange,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
