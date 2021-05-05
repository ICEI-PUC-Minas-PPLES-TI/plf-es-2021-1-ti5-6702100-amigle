import 'package:amigleapp/src/app/components/app_bar_widget.dart';
import 'package:amigleapp/src/app/components/custom_container.dart';
import 'package:amigleapp/src/app/components/text_field_widget.dart';
import 'package:amigleapp/src/app/screens/home/chat_controller.dart';
import 'package:amigleapp/src/app/utils/library/helpers/global.dart';
import 'package:amigleapp/src/app/utils/styles/colors_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ChatScreen extends StatelessWidget {
  TextEditingController _chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.build(backButton: true),
      body: _buildBody(),
      extendBody: true,
    );
  }

  _buildBody() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Observer(builder: (_){
              return Expanded(
                child: ListView.separated(
                    itemBuilder: (ctx, index) {
                      Message message = chatController.messages[index];
                      return Align(
                        alignment: message.otherUser
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: CustomContainer(
                          radius: 4,
                          padding: EdgeInsets.all(16),
                          child: Text(
                            message.text,
                            style: TextStyle(
                                color: message.otherUser
                                    ? Colors.black
                                    : Colors.white),
                          ),
                          color: message.otherUser
                              ? ColorsStyle.grayLight
                              : ColorsStyle.purple,
                        ),
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return SizedBox(
                        height: 16,
                      );
                    },
                    itemCount: chatController.messages.length),
              );
            }),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: TextFieldWidget(
                      controller: _chatController,
                      label: 'Mensagem',
                      password: false,
                      keyBoardType: TextInputType.text,
                      onChange: (text) {
                        chatController.messageChat = text;
                      }),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: ColorsStyle.purple,
                  ),
                  onPressed: () {
                    chatController.sendMessage(_chatController.text);
                    _chatController.clear();
                  },
                )
              ],
            ),
          ],
        ));
  }
}
