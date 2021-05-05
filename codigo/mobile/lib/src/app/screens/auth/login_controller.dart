import 'package:amigleapp/src/app/models/dto/user/UserDTO.dart';
import 'package:amigleapp/src/app/screens/home/home_screen.dart';
import 'package:amigleapp/src/app/services/service_status_data.dart';
import 'package:amigleapp/src/app/services/user_service.dart';
import 'package:amigleapp/src/app/utils/library/helpers/flash_helper.dart';
import 'package:amigleapp/src/app/utils/library/helpers/global.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  UserService _userService = UserService();

  ServiceStatusData<UserDTO> user = ServiceStatusData();

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
  bool isValid = false;

  @action
  verify() {
    isValid = true;

    if (!verifyEmail) {
      isValid = false;
      errorEmail = 'Digite um email válido';
    } else {
      errorEmail = null;
    }

    if (!verifyPassword) {
      isValid = false;
      errorPassword = 'Digite uma senha com pelo menos 8 caracteres';
      return;
    } else {
      errorPassword = null;
    }

    if (isValid) login(email, password);
  }

  @action
  login(String email, String password, {var image}) {
    var body = {'email': email, 'password': password};

    _userService.login(user: body).then((value) async {
      appNavigator.navigate(HomeScreen(), replace: true);
      user.setDone(value);

      if (image != null) {
        var form = FormData.fromMap({'profilePic': image.readAsBytesSync()});

        uploadPic(form, value.id);
      }
    }).catchError((e) {
      FlashHelper.errorBar(appNavigator.currentContext,
          message: 'E-mail ou senha incorretos.',
          duration: Duration(seconds: 6));
    });
  }

  @action
  uploadPic(FormData form, String id) {
    _userService.uploadPicUser(pic: form, uid: id).then((value) {
      FlashHelper.successBar(appNavigator.currentContext,
          message: 'Foto do usuario atualizado com sucesso!',
          duration: Duration(seconds: 6));
    }).catchError((e) {
      FlashHelper.errorBar(appNavigator.currentContext,
          message: 'Ops, erro ao atualizar foto do usuario.',
          duration: Duration(seconds: 6));
    });
  }
}
