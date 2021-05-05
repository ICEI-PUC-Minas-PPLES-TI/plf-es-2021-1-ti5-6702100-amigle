import 'package:amigleapp/src/app/components/app_bar_widget.dart';
import 'package:amigleapp/src/app/components/custom_button_widget.dart';
import 'package:amigleapp/src/app/components/text_field_widget.dart';
import 'package:amigleapp/src/app/models/dto/tags/CategoryDTO.dart';
import 'package:amigleapp/src/app/models/dto/tags/TagDTO.dart';
import 'package:amigleapp/src/app/screens/profile/tags_controller.dart';
import 'package:amigleapp/src/app/utils/library/helpers/global.dart';
import 'package:amigleapp/src/app/utils/styles/colors_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TagsScreen extends StatelessWidget {
  final TagsController _controller = TagsController();

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
          appBar: AppBarWidget.build(backButton: true),
          body: _buildBody(),
        ));
  }

  _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Gerenciar Tags',
            style: TextStyle(color: Colors.black, fontSize: 34),
          ),
          SizedBox(
            height: 24,
          ),
          Observer(
            builder: (_) {
              return Column(
                children: <Widget>[
                  TextFieldWidget(
                      label: 'Buscar Tags',
                      password: false,
                      keyBoardType: TextInputType.text,
                      onChange: (text) {
                        _controller.tag = text?.trim();

                        if (text != null && text.isNotEmpty) {
                          _controller.searchTags(text);
                          _controller.selectCategory(-1);
                        } else {
                          _controller.setTags(userController.user.getData.tags,
                              TypeSearchTag.MY);
                          _controller.selectCategory(0);
                        }
                      }),
                ],
              );
            },
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
        scrollDirection: Axis.horizontal,
        itemCount: _controller.categories.length,
        itemBuilder: (ctx, index) {
          CategoryDTO categoryDTO = _controller.categories[index];
          return CustomButtonWidget(
            title: Text(
              categoryDTO.name,
              style: TextStyle(
                  color: categoryDTO.selected && _controller.filterEnabled
                      ? ColorsStyle.purple
                      : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: categoryDTO.selected && _controller.filterEnabled
                ? ColorsStyle.purpleLight
                : ColorsStyle.grayLight,
            onPressed: () {
              if (_controller.filterEnabled) {
                _controller.selectCategory(categoryDTO.id);
              }
            },
            borderColor: categoryDTO.selected && _controller.filterEnabled
                ? ColorsStyle.purple
                : ColorsStyle.gray,
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
    if (_controller.tag != null &&
        _controller.tag.isNotEmpty &&
        (_controller.tags == null || _controller.tags.isEmpty)) {
      return Column(
        children: [
          Text('Nenhuma tag encontrada'),
          SizedBox(
            height: 16,
          ),
          FlatButton.icon(
            onPressed: () {
              _controller.suggestTag(_controller.tag);
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: Text(
              'SUGERIR TAG',
              style: TextStyle(color: Colors.white),
            ),
            color: ColorsStyle.purple,
          )
        ],
      );
    }

    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _controller.tags.length,
        itemBuilder: (ctx, index) {
          TagDTO tagDTO = _controller.tags[index];
          bool tagMine = userController.user.getData.tags
              .map((e) => e.id)
              .contains(tagDTO.id);
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tagDTO.category.name.toUpperCase(),
                        style: TextStyle(
                            fontSize: 10,
                            color: ColorsStyle.grayLight2,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${tagDTO.name}${!tagDTO.isApproved ? ' (SUGERIDA)' : ''}',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  tagDTO.isApproved
                      ? FlatButton(
                          onPressed: () {
                            bool newTag = !tagMine;
                            _controller.actionTag(tagDTO, newTag);
                          },
                          child: Text(
                            !tagMine ? 'ADICIONAR' : 'REMOVER',
                            style: TextStyle(
                                color: !tagMine
                                    ? ColorsStyle.purple
                                    : ColorsStyle.red),
                          ))
                      : SizedBox(
                          height: 50,
                        ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: ColorsStyle.grayLight,
              )
            ],
          );
        });
  }
}
