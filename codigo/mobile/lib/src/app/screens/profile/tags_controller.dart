import 'dart:core';

import 'package:amigleapp/src/app/models/dto/tags/CategoryDTO.dart';
import 'package:amigleapp/src/app/models/dto/tags/TagDTO.dart';
import 'package:amigleapp/src/app/services/tag_service.dart';
import 'package:amigleapp/src/app/utils/library/helpers/flash_helper.dart';
import 'package:amigleapp/src/app/utils/library/helpers/global.dart';
import 'package:mobx/mobx.dart';

part 'tags_controller.g.dart';

class TagsController = _TagsControllerBase with _$TagsController;

abstract class _TagsControllerBase with Store {
  _TagsControllerBase() {
    setCategories();
  }

  TagService _tagService = TagService();

  @observable
  String tag;

  @observable
  TypeSearchTag type = TypeSearchTag.MY;

  @observable
  List<CategoryDTO> categories = [
    CategoryDTO(name: 'Todos', id: 0)..selected = true
  ];

  @action
  setCategories() {
    categories = [CategoryDTO(name: 'Todos', id: 0)..selected = true];
    userController.user.getData.tags.forEach((tag) {
      if (!categories.map((e) => e.id).contains(tag.category.id)) {
        categories.add(tag.category..selected = false);
      }
    });
  }

  @observable
  List<TagDTO> tags = userController.user.getData.tags;

  @action
  setTags(List<TagDTO> tags, TypeSearchTag type) {
    this.tags = tags;
    this.type = type;
    verifyFilterEnabled();
    setCategories();
  }

  @action
  selectCategory(num id) {
    categories.forEach((element) {
      if (element.id == id) {
        element.selected = true;
      } else {
        element.selected = false;
      }
    });
    categories = categories;

    tags = userController.user.getData.tags;

    if (id == 0) {
      return;
    }

    List<TagDTO> newTags = [];

    for (num i = 0; i < tags.length; i++) {
      if (tags[i].category.id == id) newTags.add(tags[i]);
    }

    tags = newTags;
  }

  @observable
  bool filterEnabled = true;

  @action
  verifyFilterEnabled() {
    if (type == TypeSearchTag.MY) {
      filterEnabled = true;
    } else {
      filterEnabled = false;
    }
  }

  @action
  searchTags(String text) {
    _tagService.searchTag(str: text).then((value) {
      setTags(value, TypeSearchTag.NEW);
    }).catchError((e) {
      print(e);
    });
  }

  @action
  actionTag(TagDTO tag, bool newTag) {
    if (newTag) {
      _tagService
          .addTag(idTag: tag.id, uid: userController.user.getData.id)
          .then((value) {
        userController.user.getData.tags.add(tag);
        setTags(userController.user.getData.tags, TypeSearchTag.MY);
        FlashHelper.successBar(appNavigator.currentContext,
            message: 'Tag adicionada com sucesso!',
            duration: Duration(seconds: 6));
      }).catchError((e) {
        print(e);
        FlashHelper.errorBar(appNavigator.currentContext,
            message: 'Erro ao adicionar tag, tente novamente!',
            duration: Duration(seconds: 6));
      });
    } else {
      _tagService
          .deleteTag(idTag: tag.id, uid: userController.user.getData.id)
          .then((value) {
        TagDTO tagRemove = TagDTO();
        userController.user.getData.tags.forEach((e) {
          if (e.id == tag.id) tagRemove = e;
        });
        userController.user.getData.tags.remove(tagRemove);
        //userController.user.getData.tags.remove(tag);
        setTags(userController.user.getData.tags, TypeSearchTag.MY);
        setCategories();
        this.tag = "";
        FlashHelper.successBar(appNavigator.currentContext,
            message: 'Tag removida com sucesso!',
            duration: Duration(seconds: 6));
      }).catchError((e) {
        print(e);
        FlashHelper.errorBar(appNavigator.currentContext,
            message: 'Erro ao remover tag, tente novamente!',
            duration: Duration(seconds: 6));
      });
    }
  }

  @action
  suggestTag(String name) {
    _tagService
        .suggestTag(name: name, uid: userController.user.getData.id)
        .then((value) {
      userController.user.getData.tags.add(TagDTO(
          id: 0,
          isApproved: false,
          name: name,
          category: CategoryDTO(
            id: 0,
            name: 'Todos',
          )));
      setTags(userController.user.getData.tags, TypeSearchTag.MY);
      FlashHelper.successBar(appNavigator.currentContext,
          message: 'Tag sugerida com sucesso!', duration: Duration(seconds: 6));
    }).catchError((e) {
      print(e);
      FlashHelper.errorBar(appNavigator.currentContext,
          message: 'Erro ao sugerir tag, tente novamente!',
          duration: Duration(seconds: 6));
    });
  }
}
