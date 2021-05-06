import 'package:flutter_webrtc/flutter_webrtc.dart';

class Signaling {
  StreamStateCallback onLocalChange;
  StreamStateCallback onRemoteChange;
}

typedef void StreamStateCallback(MediaStream stream);
