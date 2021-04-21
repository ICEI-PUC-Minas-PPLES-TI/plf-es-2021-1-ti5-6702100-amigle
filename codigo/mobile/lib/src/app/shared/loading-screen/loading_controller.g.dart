// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loading_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoadingController on _LoadingController, Store {
  final _$isLoadingAtom = Atom(name: '_LoadingController.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.context.enforceReadPolicy(_$isLoadingAtom);
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.context.conditionallyRunInAction(() {
      super.isLoading = value;
      _$isLoadingAtom.reportChanged();
    }, _$isLoadingAtom, name: '${_$isLoadingAtom.name}_set');
  }

  final _$skeletonLoadingAtom =
      Atom(name: '_LoadingController.skeletonLoading');

  @override
  bool get skeletonLoading {
    _$skeletonLoadingAtom.context.enforceReadPolicy(_$skeletonLoadingAtom);
    _$skeletonLoadingAtom.reportObserved();
    return super.skeletonLoading;
  }

  @override
  set skeletonLoading(bool value) {
    _$skeletonLoadingAtom.context.conditionallyRunInAction(() {
      super.skeletonLoading = value;
      _$skeletonLoadingAtom.reportChanged();
    }, _$skeletonLoadingAtom, name: '${_$skeletonLoadingAtom.name}_set');
  }

  final _$_LoadingControllerActionController =
      ActionController(name: '_LoadingController');

  @override
  void startLoading() {
    final _$actionInfo = _$_LoadingControllerActionController.startAction();
    try {
      return super.startLoading();
    } finally {
      _$_LoadingControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stopLoading() {
    final _$actionInfo = _$_LoadingControllerActionController.startAction();
    try {
      return super.stopLoading();
    } finally {
      _$_LoadingControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startSkeletonLoading() {
    final _$actionInfo = _$_LoadingControllerActionController.startAction();
    try {
      return super.startSkeletonLoading();
    } finally {
      _$_LoadingControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stopSkeletonLoading() {
    final _$actionInfo = _$_LoadingControllerActionController.startAction();
    try {
      return super.stopSkeletonLoading();
    } finally {
      _$_LoadingControllerActionController.endAction(_$actionInfo);
    }
  }
}
