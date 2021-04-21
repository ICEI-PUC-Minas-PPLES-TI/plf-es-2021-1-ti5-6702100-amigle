// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_status_data.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ServiceStatusData<T> on _ServiceStatusData<T>, Store {
  Computed<bool> _$isDoneComputed;

  @override
  bool get isDone =>
      (_$isDoneComputed ??= Computed<bool>(() => super.isDone)).value;
  Computed<bool> _$isPendingComputed;

  @override
  bool get isPending =>
      (_$isPendingComputed ??= Computed<bool>(() => super.isPending)).value;
  Computed<bool> _$isErrorComputed;

  @override
  bool get isError =>
      (_$isErrorComputed ??= Computed<bool>(() => super.isError)).value;
  Computed<ServiceStatusEnum> _$getStatusComputed;

  @override
  ServiceStatusEnum get getStatus => (_$getStatusComputed ??=
          Computed<ServiceStatusEnum>(() => super.getStatus))
      .value;
  Computed<T> _$getDataComputed;

  @override
  T get getData =>
      (_$getDataComputed ??= Computed<T>(() => super.getData)).value;
  Computed<dynamic> _$getErrorComputed;

  @override
  dynamic get getError =>
      (_$getErrorComputed ??= Computed<dynamic>(() => super.getError)).value;

  final _$_statusAtom = Atom(name: '_ServiceStatusData._status');

  @override
  ServiceStatusEnum get _status {
    _$_statusAtom.context.enforceReadPolicy(_$_statusAtom);
    _$_statusAtom.reportObserved();
    return super._status;
  }

  @override
  set _status(ServiceStatusEnum value) {
    _$_statusAtom.context.conditionallyRunInAction(() {
      super._status = value;
      _$_statusAtom.reportChanged();
    }, _$_statusAtom, name: '${_$_statusAtom.name}_set');
  }

  final _$_dataAtom = Atom(name: '_ServiceStatusData._data');

  @override
  T get _data {
    _$_dataAtom.context.enforceReadPolicy(_$_dataAtom);
    _$_dataAtom.reportObserved();
    return super._data;
  }

  @override
  set _data(T value) {
    _$_dataAtom.context.conditionallyRunInAction(() {
      super._data = value;
      _$_dataAtom.reportChanged();
    }, _$_dataAtom, name: '${_$_dataAtom.name}_set');
  }

  final _$_errorAtom = Atom(name: '_ServiceStatusData._error');

  @override
  dynamic get _error {
    _$_errorAtom.context.enforceReadPolicy(_$_errorAtom);
    _$_errorAtom.reportObserved();
    return super._error;
  }

  @override
  set _error(dynamic value) {
    _$_errorAtom.context.conditionallyRunInAction(() {
      super._error = value;
      _$_errorAtom.reportChanged();
    }, _$_errorAtom, name: '${_$_errorAtom.name}_set');
  }

  final _$_ServiceStatusDataActionController =
      ActionController(name: '_ServiceStatusData');

  @override
  dynamic setPending() {
    final _$actionInfo = _$_ServiceStatusDataActionController.startAction();
    try {
      return super.setPending();
    } finally {
      _$_ServiceStatusDataActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDone(T data) {
    final _$actionInfo = _$_ServiceStatusDataActionController.startAction();
    try {
      return super.setDone(data);
    } finally {
      _$_ServiceStatusDataActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setError(dynamic error) {
    final _$actionInfo = _$_ServiceStatusDataActionController.startAction();
    try {
      return super.setError(error);
    } finally {
      _$_ServiceStatusDataActionController.endAction(_$actionInfo);
    }
  }
}
