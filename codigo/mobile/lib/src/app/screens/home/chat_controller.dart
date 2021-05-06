import 'dart:io';

import 'package:amigleapp/src/app/screens/home/Signaling.dart';
import 'package:amigleapp/src/app/utils/library/helpers/global.dart';
import 'package:amigleapp/src/configs/app_config.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mobx/mobx.dart';
import 'package:socket_io_client/socket_io_client.dart';

part 'chat_controller.g.dart';

class ChatController = _ChatControllerBase with _$ChatController;

abstract class _ChatControllerBase with Store {
  Socket socket;

  String otherUserSocketId;

  @observable
  String messageChat = "";

  @observable
  List<Message> messages = [];

  RTCPeerConnection peer;

  // @observable
  // RTCVideoRenderer localRenderer = RTCVideoRenderer();

  // @observable
  // RTCVideoRenderer remoteRenderer = RTCVideoRenderer();

  MediaStream localMediaStream;
  MediaStream remoteMediaStream;

  Signaling signaling;

  @action
  addMessage(String text, bool otherUser) {
    messages.add(Message(text, otherUser));
    messages = messages;
  }

  @action
  connect() async {
    socket = io(APP_CONFIG.SOCKET_SERVER, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.on('connect', (_) => print('Connected'));
    socket.connect();
  }

  @action
  allTags(Signaling signaling) async {
    await connect();
    this.signaling = signaling;
    localMediaStream = await _createStream();
    this.signaling.onLocalChange?.call(localMediaStream);
    //localRenderer.srcObject = localMediaStream;
    socket.emit("join-all-tags", userController.user.getData.toJson());
    frwkLoading.startLoading();
    _listenActions();
  }

  @action
  specificTag(tagId) {
    connect();
    _listenActions();
  }

  @action
  _listenActions() {
    socket.on("match-made", (data) {
      otherUserSocketId = data['socketId'];
      _callUser(data['socketId']);
    });

    socket.on("offer", (dynamic e) async {
      if (e == null) return;
      otherUserSocketId = e['caller'];
      peer = await _createPeerConnection(null);
      var desc = RTCSessionDescription(e['sdp']['sdp'], e['sdp']['type']);

      peer
          .setRemoteDescription(desc)
          .then((value) {
            localMediaStream.getTracks().forEach((track) {
              // peer.addStream(localMediaStream);
              peer.addTrack(track, localMediaStream);
            });
          })
          .then((i) => peer.createAnswer({
                'mandatory': {
                  'OfferToReceiveAudio': true,
                  'OfferToReceiveVideo': true,
                },
                'optional': [],
              }))
          .then((answer) => peer.setLocalDescription(answer))
          .then((j) async {
            print('a');

            var description = await peer.getLocalDescription();
            var payload = {
              'target': e['caller'],
              'caller': socket.id,
              'sdp': {'type': description.type, 'sdp': description.sdp},
            };

            otherUserSocketId = e['caller'];
            socket.emit("answer", payload);
            frwkLoading.stopLoading();
          });
    });

    socket.on("ice-candidate", (e) {
      if (e == null) return;
      RTCIceCandidate candidate =
          RTCIceCandidate(e['candidate'], e['sdpMid'], e['sdpMLineIndex']);
      peer?.addCandidate(candidate);
    });

    socket.on("answer", (payload) {
      if (payload == null) return;
      var desc = new RTCSessionDescription(
          payload['sdp']['sdp'], payload['sdp']['type']);
      peer.setRemoteDescription(desc);
    });

    socket.on("message-received", (message) {
      addMessage(message['text'], true);
    });

    socket.on("disconnect", (e) {
      print("disconnected");
      frwkLoading.stopLoading();
      peer.close();
      //peer?.dispose();
      //remoteRenderer?.dispose();
    });
  }

  @action
  disconnect() {
    socket.disconnect();
  }

  @action
  _callUser(String socketId) async {
    peer = await _createPeerConnection(socketId);

    /*peer
        .createOffer({})
        .then((offer) => peer.setLocalDescription(offer))
        .then((e) async {
          var description = await peer.getLocalDescription();

          if (description == null) return;

          var payload = {
            'target': socketId,
            'caller': socket.id,
            'sdp': {'type': description.type, 'sdp': description.sdp},
          };

          socket.emit("offer", payload);
          frwkLoading.stopLoading();
        });*/

    localMediaStream.getTracks().forEach((track) {
      // peer.addStream(localMediaStream);
      peer.addTrack(track, localMediaStream);
    });

    //userStream.getTracks().forEach((track) => peer.addTrack(track, userStream));
  }

  @action
  _createPeerConnection(String socketId) async {
    Map<String, dynamic> configuration = {
      "iceServers": [
        {
          'urls': "stun:stun.stunprotocol.org",
        },
        {
          'urls': "turn:numb.viagenie.ca",
          'credential': "muazkh",
          'username': "webrtc@live.com",
        },
      ]
    };

    final Map<String, dynamic> offerSdpConstraints = {
      "mandatory": {},
      "optional": [
        {'DtlsSrtpKeyAgreement': true},
      ],
    };

    //_localStream = await _getUserMedia();

    peer = await createPeerConnection({
      ...configuration,
      ...{'sdpSemantics': 'unified-plan'}
    }, offerSdpConstraints);
    // if (pc != null) print(pc);
    //pc.addStream(_localStream);

    peer.onIceCandidate = (RTCIceCandidate e) {
      if (e == null || e.candidate == null) return;
      var payload = {
        'target': socketId,
        'candidate': {
          'candidate': e.candidate,
          'sdpMid': e.sdpMid,
          'sdpMlineIndex': e.sdpMlineIndex
        },
      };

      socket.emit("ice-candidate", payload);
    };

    // peer.addTransceiver();

    peer.onTrack = (RTCTrackEvent e) {
      if (e == null || e.streams == null || e.streams.isEmpty) return;
      print(
          "----------------------------------------------------ONTRACK---------------------------------------");
      //remoteRenderer.srcObject = e.streams[0];
      signaling.onRemoteChange?.call(e.streams[0]);
    };

    peer.onRenegotiationNeeded = () {
      peer
          .createOffer({})
          .then((offer) => peer.setLocalDescription(offer))
          .then((e) async {
            var description = await peer.getLocalDescription();

            if (description == null) return;

            var payload = {
              'target': socketId,
              'caller': socket.id,
              'sdp': {'type': description.type, 'sdp': description.sdp},
            };

            socket.emit("offer", payload);
            frwkLoading.stopLoading();
          });
    };

    return peer;
  }

  @action
  Future<MediaStream> _createStream() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'facingMode': 'user',
        'optional': [],
      }
    };

    return await navigator.mediaDevices.getUserMedia(mediaConstraints);
  }

  @action
  sendMessage(String text) {
    addMessage(text, false);
    socket.emit('send-message', {"target": otherUserSocketId, "text": text});
  }
}

class Message {
  String text;
  bool otherUser = false;

  Message(this.text, this.otherUser);
}
