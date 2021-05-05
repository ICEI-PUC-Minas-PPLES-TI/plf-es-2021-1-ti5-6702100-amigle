import 'package:amigleapp/src/app/components/app_bar_widget.dart';
import 'package:amigleapp/src/app/components/custom_button_widget.dart';
import 'package:amigleapp/src/app/components/nav_drawer.dart';
import 'package:amigleapp/src/app/models/dto/tags/CategoryDTO.dart';
import 'package:amigleapp/src/app/models/dto/trending/TrendingDTO.dart';
import 'package:amigleapp/src/app/screens/trending/trending_controller.dart';
import 'package:amigleapp/src/app/utils/styles/colors_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TrendingScreen extends StatelessWidget {
  final TrendingController _controller = TrendingController();

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
            'Tags em Alta',
            style: TextStyle(color: Colors.black, fontSize: 34),
          ),
          SizedBox(
            height: 24,
          ),
          Observer(builder: (_) {
            return _buildFilter();
          }),
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

  _buildFilter() {
    return Container(
      height: 32.0,
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: _controller.categories.length,
        itemBuilder: (ctx, index) {
          CategoryDTO categoryDTO = _controller.categories[index];
          return CustomButtonWidget(
            title: Text(
              categoryDTO.name,
              style: TextStyle(
                  color:
                      categoryDTO.selected ? ColorsStyle.purple : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: categoryDTO.selected
                ? ColorsStyle.purpleLight
                : ColorsStyle.grayLight,
            onPressed: () {
              _controller.selectCategory(categoryDTO.name);
            },
            borderColor:
                categoryDTO.selected ? ColorsStyle.purple : ColorsStyle.gray,
            radius: 16,
          );
        },
        separatorBuilder: (ctx, index) {
          return SizedBox(
            width: 8,
          );
        },
      ),
    );
  }

  _buildListTags() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _controller.trendings.length,
        itemBuilder: (ctx, index) {
          TrendingDTO trending = _controller.trendings[index];
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
                          '${trending.number} PESSOAS FALANDO SOBRE',
                          style: TextStyle(
                              fontSize: 10,
                              color: ColorsStyle.grayLight2,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          trending.tag,
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
