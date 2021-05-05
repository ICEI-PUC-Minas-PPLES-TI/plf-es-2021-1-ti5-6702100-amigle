// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TagsController on _TagsControllerBase, Store {
  final _$tagAtom = Atom(name: '_TagsControllerBase.tag');

  @override
  String get tag {
    _$tagAtom.context.enforceReadPolicy(_$tagAtom);
    _$tagAtom.reportObserved();
    return super.tag;
  }

  @override
  set tag(String value) {
    _$tagAtom.context.conditionallyRunInAction(() {
      super.tag = value;
      _$tagAtom.reportChanged();
    }, _$tagAtom, name: '${_$tagAtom.name}_set');
  }

  final _$typeAtom = Atom(name: '_TagsControllerBase.type');

  @override
  TypeSearchTag get type {
    _$typeAtom.context.enforceReadPolicy(_$typeAtom);
    _$typeAtom.reportObserved();
    return super.type;
  }

  @override
  set type(TypeSearchTag value) {
    _$typeAtom.context.conditionallyRunInAction(() {
      super.type = value;
      _$typeAtom.reportChanged();
    }, _$typeAtom, name: '${_$typeAtom.name}_set');
  }

  final _$categoriesAtom = Atom(name: '_TagsControllerBase.categories');

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

  final _$tagsAtom = Atom(name: '_TagsControllerBase.tags');

  @override
  List<TagDTO> get tags {
    _$tagsAtom.context.enforceReadPolicy(_$tagsAtom);
    _$tagsAtom.reportObserved();
    return super.tags;
  }

  @override
  set tags(List<TagDTO> value) {
    _$tagsAtom.context.conditionallyRunInAction(() {
      super.tags = value;
      _$tagsAtom.reportChanged();
    }, _$tagsAtom, name: '${_$tagsAtom.name}_set');
  }

  final _$filterEnabledAtom = Atom(name: '_TagsControllerBase.filterEnabled');

  @override
  bool get filterEnabled {
    _$filterEnabledAtom.context.enforceReadPolicy(_$filterEnabledAtom);
    _$filterEnabledAtom.reportObserved();
    return super.filterEnabled;
  }

  @override
  set filterEnabled(bool value) {
    _$filterEnabledAtom.context.conditionallyRunInAction(() {
      super.filterEnabled = value;
      _$filterEnabledAtom.reportChanged();
    }, _$filterEnabledAtom, name: '${_$filterEnabledAtom.name}_set');
  }

  final _$_TagsControllerBaseActionController =
      ActionController(name: '_TagsControllerBase');

  @override
  dynamic setCategories() {
    final _$actionInfo = _$_TagsControllerBaseActionController.startAction();
    try {
      return super.setCategories();
    } finally {
      _$_TagsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTags(List<TagDTO> tags, TypeSearchTag type) {
    final _$actionInfo = _$_TagsControllerBaseActionController.startAction();
    try {
      return super.setTags(tags, type);
    } finally {
      _$_TagsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic selectCategory(num id) {
    final _$actionInfo = _$_TagsControllerBaseActionController.startAction();
    try {
      return super.selectCategory(id);
    } finally {
      _$_TagsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic verifyFilterEnabled() {
    final _$actionInfo = _$_TagsControllerBaseActionController.startAction();
    try {
      return super.verifyFilterEnabled();
    } finally {
      _$_TagsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic searchTags(String text) {
    final _$actionInfo = _$_TagsControllerBaseActionController.startAction();
    try {
      return super.searchTags(text);
    } finally {
      _$_TagsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic actionTag(TagDTO tag, bool newTag) {
    final _$actionInfo = _$_TagsControllerBaseActionController.startAction();
    try {
      return super.actionTag(tag, newTag);
    } finally {
      _$_TagsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic suggestTag(String name) {
    final _$actionInfo = _$_TagsControllerBaseActionController.startAction();
    try {
      return super.suggestTag(name);
    } finally {
      _$_TagsControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
