import 'package:amigleapp/src/app/components/app_bar_widget.dart';
import 'package:amigleapp/src/app/components/nav_drawer.dart';
import 'package:amigleapp/src/app/shared/loading-screen/loading_screen.dart';
import 'package:amigleapp/src/app/utils/library/helpers/global.dart';
import 'package:amigleapp/src/app/utils/styles/colors_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _peers;
  var _selfId;
  bool _inCalling = false;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _showDialog(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
        body: Scaffold(
      appBar: AppBarWidget.build(popupMenu: true),
      body: _buildBody(),
      extendBody: true,
    ));
  }

  _buildBody() {
    return Scaffold(
      key: AppBarWidget.scaffoldKey,
      drawer: NavDrawer(),
      body: _buildStack(),
      extendBody: true,
    );
  }

  _buildStack() {
    return Stack(
      children: [
        Observer(builder: (_) {
          return Expanded(
              child: Container(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: RTCVideoView(chatController.remoteRenderer),
            decoration: BoxDecoration(color: Colors.black54),
          ));
        }),
        /*Positioned(
          left: 20.0,
          top: 20.0,
          child: Container(
            width:  90.0 ,
            height: 120.0 ,
            child: RTCVideoView(chatController.localRenderer),
            decoration: BoxDecoration(color: Colors.black54),
          ),
        ),*/
        //TakePictureScreen(),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.all(10),
                child: SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () {
                      chatController.disconnect();
                    },
                    child: Text(
                      'ENCERRAR CHAT',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: ColorsStyle.red,
                  ),
                ))),
      ],
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        child: SimpleDialog(
          contentPadding: EdgeInsets.all(20),
          children: [
            Text(
              'Inicie uma nova conversa',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Escolha entre iniciar uma conversa que encontrará alguem automaticamente com base em todas as suas tags, ou com base em uma tag específica.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                    padding: EdgeInsets.all(2),
                    onPressed: () {
                      appNavigator.popNavigate();
                      chatController.allTags();
                    },
                    child: Text(
                      'TODAS AS TAGS',
                      style: TextStyle(fontSize: 14, color: ColorsStyle.purple),
                    )),
                FlatButton(
                    padding: EdgeInsets.all(2),
                    onPressed: () {},
                    child: Text(
                      'TAG ESPECÍFICA',
                      style: TextStyle(fontSize: 14, color: ColorsStyle.purple),
                    ))
              ],
            )
          ],
        ));
  }
}
