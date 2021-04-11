import 'package:intl/intl.dart';

extension NumExtension on num {
  String numberToCurrency({bool exibeMoeda}) {
    //varias formas
    return NumberFormat.simpleCurrency(name: exibeMoeda != null ? '' : null)
        .format(this);
  }

  get numberFormat {
    //varias formas
    return NumberFormat.decimalPattern().format(this);
  }
}
