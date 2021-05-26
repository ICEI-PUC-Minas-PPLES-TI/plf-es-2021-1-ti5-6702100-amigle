import 'package:amigleapp/src/app/components/app_bar_widget.dart';
import 'package:amigleapp/src/app/components/nav_drawer.dart';
import 'package:amigleapp/src/app/models/dto/tags/TagDTO.dart';
import 'package:amigleapp/src/app/screens/home/Signaling.dart';
import 'package:amigleapp/src/app/shared/loading-screen/loading_screen.dart';
import 'package:amigleapp/src/app/utils/library/helpers/global.dart';
import 'package:amigleapp/src/app/utils/styles/colors_style.dart';
import 'package:flutter/material.dart';
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

  Signaling signaling = Signaling();

  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  @override
  void initState() {
    super.initState();
    initRenderers();
  }

  initRenderers() async {
    try {
      await _localRenderer.initialize();
      await _remoteRenderer.initialize();

      signaling.onLocalChange = (m) {
        setState(() {
          _localRenderer.srcObject = m;
        });
      };

      signaling.onRemoteChange = (m) {
        setState(() {
          _remoteRenderer.srcObject = m;
        });
      };
    } catch (e) {
      print(e);
    }
  }

  @override
  deactivate() {
    super.deactivate();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
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
    return Observer(builder: (_) {
      return Scaffold(
        key: AppBarWidget.scaffoldKey,
        drawer: NavDrawer(),
        body: chatController.connected ? _buildStack() : _buildInitialPage(),
        extendBody: true,
      );
    });
  }

  _buildInitialPage() {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Expanded(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Bem vindo ao Amigle!',
                style: TextStyle(fontSize: 32),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Uma nova forma de conhecer pessoas novas com base em seus interesses!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                  color: ColorsStyle.purple,
                  onPressed: () {
                    _showDialog(context);
                  },
                  child: Text(
                    'INICIAR UMA CONVERSA',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ))
            ],
          ),
        )));
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
            child: RTCVideoView(_remoteRenderer),
            decoration: BoxDecoration(color: Colors.black54),
          ));
        }),
        Observer(builder: (_) {
          return Positioned(
            left: 20.0,
            top: 20.0,
            child: Container(
              width: 90.0,
              height: 120.0,
              child: RTCVideoView(
                _localRenderer,
              ),
              decoration: BoxDecoration(color: Colors.black54),
            ),
          );
        }),
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
                      chatController.allTags(signaling);
                    },
                    child: Text(
                      'TODAS AS TAGS',
                      style: TextStyle(fontSize: 14, color: ColorsStyle.purple),
                    )),
                FlatButton(
                    padding: EdgeInsets.all(2),
                    onPressed: () {
                      appNavigator.popNavigate();
                      _showDialogTags(context);
                    },
                    child: Text(
                      'TAG ESPECÍFICA',
                      style: TextStyle(fontSize: 14, color: ColorsStyle.purple),
                    ))
              ],
            )
          ],
        ));
  }

  _showDialogTags(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        child: SimpleDialog(
          contentPadding: EdgeInsets.all(20),
          children: [
            Text(
              'Escolha a Tag',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 200,
              child: ListView.separated(
                itemCount: userController.user.getData.tags.length,
                itemBuilder: (ctx, index) {
                  TagDTO tag = userController.user.getData.tags[index];
                  return ListTile(
                    onTap: () {
                      appNavigator.popNavigate();
                      chatController.specificTag(signaling, tag.id);
                    },
                    title: Text(tag.name),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return Container(
                    height: 1,
                    width: double.infinity,
                    color: ColorsStyle.grayLight,
                  );
                },
              ),
            ),
          ],
        ));
  }
}
