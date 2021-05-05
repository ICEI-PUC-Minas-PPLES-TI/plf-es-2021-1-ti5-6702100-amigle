import 'dart:core';
import 'dart:io';

import 'package:amigleapp/src/app/models/dto/user/UserDTO.dart';
import 'package:amigleapp/src/app/services/service_status_data.dart';
import 'package:amigleapp/src/app/services/user_service.dart';
import 'package:amigleapp/src/app/utils/library/helpers/flash_helper.dart';
import 'package:amigleapp/src/app/utils/library/helpers/global.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mobx/mobx.dart';

part 'register_controller.g.dart';

class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase with Store {
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
    isValid = true;

    if (!verifyName) {
      isValid = false;
      errorName = 'Digite um nome válido';
    } else {
      errorName = null;
    }

    if (!verifyAge) {
      isValid = false;
      errorAge = 'Digite uma data de nascimento válida';
    } else {
      errorAge = null;
    }

    if (!verifyEmail) {
      isValid = false;
      errorEmail = 'Digite um email válido';
    } else {
      errorEmail = null;
    }

    if (!verifyPassword) {
      isValid = false;
      errorPassword = 'Digite uma senha com pelo menos 8 caracteres';
    } else {
      errorPassword = null;
    }

    if (!verifyConfirm) {
      isValid = false;
      errorConfirm = 'A confirmação da senha deve ser igual a senha';
    } else {
      errorConfirm = null;
    }

    if (isValid) registerUser();
  }

  @action
  registerUser() {
    var ageArray = age.split('/');
    var body = {
      'name': name,
      'email': email,
      'password': password,
      'birthDate': '${ageArray[2]}-${ageArray[1]}-${ageArray[0]}'
    };

    _userService.registerUser(user: body).then((value) {
      FlashHelper.successBar(appNavigator.currentContext,
          message: 'Usuario cadastrado com sucesso!',
          duration: Duration(seconds: 6));

      userController.login(email, password, image: image);
    }).catchError((e) {
      FlashHelper.errorBar(appNavigator.currentContext,
          message: 'Ops, erro ao cadastrar usuario.',
          duration: Duration(seconds: 6));
    });
  }

  @action
  updateUser() {}
}
