import 'dart:core';

import 'package:amigleapp/src/app/models/dto/history/HistoryDTO.dart';
import 'package:mobx/mobx.dart';

part 'history_controller.g.dart';

class HistoryController = _HistoryControllerBase with _$HistoryController;

abstract class _HistoryControllerBase with Store {
  @observable
  List<HistoryDTO> histories = [
    HistoryDTO('Lucas', '01/01/2021 às 20:50 - 15 minutos'),
    HistoryDTO('Isabella', '02/01/2021 às 20:50 - 10 minutos'),
    HistoryDTO('Samuel', '15/01/2021 às 20:50 - 5 minutos'),
  ];
}
