import 'package:amigleapp/src/app/components/app_bar_widget.dart';
import 'package:amigleapp/src/app/components/nav_drawer.dart';
import 'package:amigleapp/src/app/models/dto/history/HistoryDTO.dart';
import 'package:amigleapp/src/app/screens/history/history_controller.dart';
import 'package:amigleapp/src/app/utils/extensions/date_extension.dart';
import 'package:amigleapp/src/app/utils/extensions/string_exntension.dart';
import 'package:amigleapp/src/app/utils/styles/colors_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HistoryScreen extends StatelessWidget {
  final HistoryController _controller = HistoryController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBarWidget.build(),
          body: Scaffold(
            key: AppBarWidget.scaffoldKey,
            drawer: NavDrawer(),
            body: _buildBody(),
          ),
        ));
  }

  _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Histórico',
            style: TextStyle(color: Colors.black, fontSize: 34),
          ),
          SizedBox(
            height: 24,
          ),
          Observer(builder: (_) {
            return _buildListTags();
          }),
        ],
      ),
    );
  }

  _buildListTags() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _controller.histories.length,
        itemBuilder: (ctx, index) {
          HistoryDTO history = _controller.histories[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${history.startDate.toDate(format: 'yyyy-MM-dd HH:mm:ss').dateToString(format: 'dd/MM/yyyy HH:mm')} até ${history.endDate.toDate(format: 'yyyy-MM-dd HH:mm:ss').dateToString(format: 'HH:mm')}',
                          style: TextStyle(
                              fontSize: 10,
                              color: ColorsStyle.grayLight2,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          history.guestUserName,
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: ColorsStyle.grayLight,
                )
              ],
            ),
          );
        });
  }
}
