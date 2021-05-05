// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'take_picture_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TakePictureController on _TakePictureControllerBase, Store {
  final _$cameraControllerAtom =
      Atom(name: '_TakePictureControllerBase.cameraController');

  @override
  CameraController get cameraController {
    _$cameraControllerAtom.context.enforceReadPolicy(_$cameraControllerAtom);
    _$cameraControllerAtom.reportObserved();
    return super.cameraController;
  }

  @override
  set cameraController(CameraController value) {
    _$cameraControllerAtom.context.conditionallyRunInAction(() {
      super.cameraController = value;
      _$cameraControllerAtom.reportChanged();
    }, _$cameraControllerAtom, name: '${_$cameraControllerAtom.name}_set');
  }

  final _$cameraReadyAtom =
      Atom(name: '_TakePictureControllerBase.cameraReady');

  @override
  bool get cameraReady {
    _$cameraReadyAtom.context.enforceReadPolicy(_$cameraReadyAtom);
    _$cameraReadyAtom.reportObserved();
    return super.cameraReady;
  }

  @override
  set cameraReady(bool value) {
    _$cameraReadyAtom.context.conditionallyRunInAction(() {
      super.cameraReady = value;
      _$cameraReadyAtom.reportChanged();
    }, _$cameraReadyAtom, name: '${_$cameraReadyAtom.name}_set');
  }

  final _$selectCameraAsyncAction = AsyncAction('selectCamera');

  @override
  Future selectCamera() {
    return _$selectCameraAsyncAction.run(() => super.selectCamera());
  }

  final _$_TakePictureControllerBaseActionController =
      ActionController(name: '_TakePictureControllerBase');

  @override
  dynamic configCamera({bool fromPin = false}) {
    final _$actionInfo =
        _$_TakePictureControllerBaseActionController.startAction();
    try {
      return super.configCamera(fromPin: fromPin);
    } finally {
      _$_TakePictureControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
