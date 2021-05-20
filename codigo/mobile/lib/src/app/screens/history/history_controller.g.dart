// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HistoryController on _HistoryControllerBase, Store {
  final _$historiesAtom = Atom(name: '_HistoryControllerBase.histories');

  @override
  List<HistoryDTO> get histories {
    _$historiesAtom.context.enforceReadPolicy(_$historiesAtom);
    _$historiesAtom.reportObserved();
    return super.histories;
  }

  @override
  set histories(List<HistoryDTO> value) {
    _$historiesAtom.context.conditionallyRunInAction(() {
      super.histories = value;
      _$historiesAtom.reportChanged();
    }, _$historiesAtom, name: '${_$historiesAtom.name}_set');
  }

  final _$_HistoryControllerBaseActionController =
      ActionController(name: '_HistoryControllerBase');

  @override
  dynamic setHistory(List<HistoryDTO> list) {
    final _$actionInfo = _$_HistoryControllerBaseActionController.startAction();
    try {
      return super.setHistory(list);
    } finally {
      _$_HistoryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getHistory() {
    final _$actionInfo = _$_HistoryControllerBaseActionController.startAction();
    try {
      return super.getHistory();
    } finally {
      _$_HistoryControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
