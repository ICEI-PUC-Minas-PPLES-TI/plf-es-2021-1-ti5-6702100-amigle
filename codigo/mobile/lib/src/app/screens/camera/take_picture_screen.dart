import 'package:amigleapp/src/app/screens/camera/take_picture_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TakePictureScreen extends StatefulWidget {
  static final String route = '/take-picture';

  final bool fromPin;

  const TakePictureScreen({Key key, this.fromPin}) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState(fromPin);
}

class TakePictureScreenState extends State<TakePictureScreen> {
  final _controller = TakePictureController();

  final bool fromPin;

  var size;
  var deviceRatio;

  TakePictureScreenState(this.fromPin);

  @override
  void initState() {
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.configCamera();

      _controller.selectCamera();
    });*/

    WidgetsFlutterBinding.ensureInitialized();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _controller.configCamera(fromPin: fromPin);
      _controller.selectCamera();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    double height =
        size.height == null || size.height == 0 ? size.width : size.height;
    deviceRatio = size.width / height;

    return _buildBody(context);
  }

  _buildBody(BuildContext context) {
    return Observer(builder: (_) {
      if (_controller.cameraReady) {
        return Stack(
          children: <Widget>[
            Container(
              color: Colors.black,
              child: Transform.scale(
                scale: 1.2,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: _controller.cameraController.value.aspectRatio,
                    child: CameraPreview(
                      _controller.cameraController,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
      return SizedBox.shrink();
    });
  }

  @override
  void dispose() {
    _controller.configCamera();
    super.dispose();
  }
}
