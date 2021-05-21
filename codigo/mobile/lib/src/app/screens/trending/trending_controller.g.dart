// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TrendingController on _TrendingControllerBase, Store {
  final _$categoriesAtom = Atom(name: '_TrendingControllerBase.categories');

  @override
  List<CategoryDTO> get categories {
    _$categoriesAtom.context.enforceReadPolicy(_$categoriesAtom);
    _$categoriesAtom.reportObserved();
    return super.categories;
  }

  @override
  set categories(List<CategoryDTO> value) {
    _$categoriesAtom.context.conditionallyRunInAction(() {
      super.categories = value;
      _$categoriesAtom.reportChanged();
    }, _$categoriesAtom, name: '${_$categoriesAtom.name}_set');
  }

  final _$trendingsAtom = Atom(name: '_TrendingControllerBase.trendings');

  @override
  List<TrendingDTO> get trendings {
    _$trendingsAtom.context.enforceReadPolicy(_$trendingsAtom);
    _$trendingsAtom.reportObserved();
    return super.trendings;
  }

  @override
  set trendings(List<TrendingDTO> value) {
    _$trendingsAtom.context.conditionallyRunInAction(() {
      super.trendings = value;
      _$trendingsAtom.reportChanged();
    }, _$trendingsAtom, name: '${_$trendingsAtom.name}_set');
  }

  final _$_TrendingControllerBaseActionController =
      ActionController(name: '_TrendingControllerBase');

  @override
  dynamic setTrending() {
    final _$actionInfo =
        _$_TrendingControllerBaseActionController.startAction();
    try {
      return super.setTrending();
    } finally {
      _$_TrendingControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic selectCategory(String name) {
    final _$actionInfo =
        _$_TrendingControllerBaseActionController.startAction();
    try {
      return super.selectCategory(name);
    } finally {
      _$_TrendingControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
