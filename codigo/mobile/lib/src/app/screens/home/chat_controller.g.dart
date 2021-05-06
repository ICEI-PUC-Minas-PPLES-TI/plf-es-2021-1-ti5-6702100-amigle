// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatController on _ChatControllerBase, Store {
  final _$messageChatAtom = Atom(name: '_ChatControllerBase.messageChat');

  @override
  String get messageChat {
    _$messageChatAtom.context.enforceReadPolicy(_$messageChatAtom);
    _$messageChatAtom.reportObserved();
    return super.messageChat;
  }

  @override
  set messageChat(String value) {
    _$messageChatAtom.context.conditionallyRunInAction(() {
      super.messageChat = value;
      _$messageChatAtom.reportChanged();
    }, _$messageChatAtom, name: '${_$messageChatAtom.name}_set');
  }

  final _$messagesAtom = Atom(name: '_ChatControllerBase.messages');

  @override
  List<Message> get messages {
    _$messagesAtom.context.enforceReadPolicy(_$messagesAtom);
    _$messagesAtom.reportObserved();
    return super.messages;
  }

  @override
  set messages(List<Message> value) {
    _$messagesAtom.context.conditionallyRunInAction(() {
      super.messages = value;
      _$messagesAtom.reportChanged();
    }, _$messagesAtom, name: '${_$messagesAtom.name}_set');
  }

  final _$connectAsyncAction = AsyncAction('connect');

  @override
  Future connect() {
    return _$connectAsyncAction.run(() => super.connect());
  }

  final _$allTagsAsyncAction = AsyncAction('allTags');

  @override
  Future allTags(Signaling signaling) {
    return _$allTagsAsyncAction.run(() => super.allTags(signaling));
  }

  final _$_callUserAsyncAction = AsyncAction('_callUser');

  @override
  Future _callUser(String socketId) {
    return _$_callUserAsyncAction.run(() => super._callUser(socketId));
  }

  final _$_createPeerConnectionAsyncAction =
      AsyncAction('_createPeerConnection');

  @override
  Future _createPeerConnection(String socketId) {
    return _$_createPeerConnectionAsyncAction
        .run(() => super._createPeerConnection(socketId));
  }

  final _$_createStreamAsyncAction = AsyncAction('_createStream');

  @override
  Future<MediaStream> _createStream() {
    return _$_createStreamAsyncAction.run(() => super._createStream());
  }

  final _$_ChatControllerBaseActionController =
      ActionController(name: '_ChatControllerBase');

  @override
  dynamic addMessage(String text, bool otherUser) {
    final _$actionInfo = _$_ChatControllerBaseActionController.startAction();
    try {
      return super.addMessage(text, otherUser);
    } finally {
      _$_ChatControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic specificTag(dynamic tagId) {
    final _$actionInfo = _$_ChatControllerBaseActionController.startAction();
    try {
      return super.specificTag(tagId);
    } finally {
      _$_ChatControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _listenActions() {
    final _$actionInfo = _$_ChatControllerBaseActionController.startAction();
    try {
      return super._listenActions();
    } finally {
      _$_ChatControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic disconnect() {
    final _$actionInfo = _$_ChatControllerBaseActionController.startAction();
    try {
      return super.disconnect();
    } finally {
      _$_ChatControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic sendMessage(String text) {
    final _$actionInfo = _$_ChatControllerBaseActionController.startAction();
    try {
      return super.sendMessage(text);
    } finally {
      _$_ChatControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
