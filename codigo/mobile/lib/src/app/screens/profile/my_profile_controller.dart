import 'dart:core';
import 'dart:io';

import 'package:amigleapp/src/app/models/dto/user/UserDTO.dart';
import 'package:amigleapp/src/app/services/service_status_data.dart';
import 'package:amigleapp/src/app/services/user_service.dart';
import 'package:amigleapp/src/app/utils/library/helpers/flash_helper.dart';
import 'package:amigleapp/src/app/utils/library/helpers/global.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mobx/mobx.dart';

part 'my_profile_controller.g.dart';

class MyProfileController = _MyProfileControllerBase with _$MyProfileController;

abstract class _MyProfileControllerBase with Store {
  UserService _userService = UserService();

  ServiceStatusData<UserDTO> registeredUser = ServiceStatusData();

  @observable
  File image;

  @action
  setImage(File image) {
    this.image = image;
  }

  @observable
  String email;

  @observable
  String errorEmail;

  @computed
  bool get verifyEmail {
    if (email != null)
      return EmailValidator.validate(email.trim());
    else
      return false;
  }

  @observable
  String password;

  @observable
  String errorPassword;

  @computed
  bool get verifyPassword {
    if (password != null)
      return password.length >= 8;
    else
      return false;
  }

  @observable
  String confirmPassword;

  @observable
  String errorConfirm;

  @computed
  bool get verifyConfirm {
    if (confirmPassword != null && password != null)
      return password == confirmPassword;
    else
      return false;
  }

  @observable
  String name;

  @observable
  String errorName;

  @computed
  bool get verifyName {
    return name != null;
  }

  @observable
  String age;

  @observable
  String errorAge;

  @computed
  bool get verifyAge {
    return age != null;
  }

  @observable
  bool isValid = false;

  @action
  verify() {
    if (name == null && image == null && age == null) {
      return;
    }

    updateUser();
  }

  @action
  updateUser() async {
    var body;
    var ageArray;
    FormData form;

    if (image == null) {
      ageArray = age?.split('/') ?? [];

      body = {
        'name': name ?? userController.user.getData.name,
        'birthDate': ageArray.isNotEmpty
            ? '${ageArray[2]}-${ageArray[1]}-${ageArray[0]}'
            : userController.user.getData.birthDate
      };

      if (password != null) {
        body.addAll({'password': password});
      }

      _userService
          .updateUser(user: body, uid: userController.user.getData.id)
          .then((value) {
        FlashHelper.successBar(appNavigator.currentContext,
            message: 'Usuario atualizado com sucesso!',
            duration: Duration(seconds: 6));

        if (name != null) {
          userController.user.getData.name = name;
        }

        if (ageArray.isNotEmpty) {
          userController.user.getData.birthDate =
              '${ageArray[2]}-${ageArray[1]}-${ageArray[0]}';
        }
      }).catchError((e) {
        FlashHelper.errorBar(appNavigator.currentContext,
            message: 'Ops, erro ao atualizar usuario.',
            duration: Duration(seconds: 6));
      });
    } else {
      var form = FormData.fromMap({'profilePic': image.readAsBytesSync()});

      userController.uploadPic(form, userController.user.getData.id);
    }
  }
}
