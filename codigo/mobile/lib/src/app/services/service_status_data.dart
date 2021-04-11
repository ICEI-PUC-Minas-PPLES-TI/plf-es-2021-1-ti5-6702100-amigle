import 'package:mobx/mobx.dart';

part 'service_status_data.g.dart';

enum ServiceStatusEnum { DONE, PENDING, ERROR }

class ServiceStatusData<T> = _ServiceStatusData<T> with _$ServiceStatusData<T>;

abstract class _ServiceStatusData<T> with Store {
  @observable
  ServiceStatusEnum _status = ServiceStatusEnum.PENDING;

  @observable
  T _data;

  @observable
  dynamic _error;

  @computed
  bool get isDone => this._status == ServiceStatusEnum.DONE;

  @computed
  bool get isPending =>
      this._status == ServiceStatusEnum.PENDING || this._data == null;

  @computed
  bool get isError => this._status == ServiceStatusEnum.ERROR;

  @computed
  ServiceStatusEnum get getStatus => this._status;

  @computed
  T get getData => this._data;

  @computed
  dynamic get getError => this._error;

  @action
  setPending() {
    this._error = null;
    this._status = ServiceStatusEnum.PENDING;
    return this;
  }

  @action
  setDone(T data) {
    this._error = null;
    this._data = data;
    this._status = ServiceStatusEnum.DONE;
    return this;
  }

  @action
  setError(dynamic error) {
    this._data = null;
    this._error = error;
    this._status = ServiceStatusEnum.ERROR;
    return this;
  }
}
