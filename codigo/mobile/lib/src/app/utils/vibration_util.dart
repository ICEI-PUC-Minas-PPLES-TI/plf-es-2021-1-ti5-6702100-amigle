import 'package:vibrate/vibrate.dart';

mixin VibrationUtil {
  static void vibrate(FeedbackType type) async {
    bool canVibrate = await Vibrate.canVibrate;
    if (canVibrate) Vibrate.feedback(type);
  }
}
