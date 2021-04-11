import 'package:amigleapp/src/app/models/entities/user/user_entity.dart';
import 'package:hive/hive.dart';

class UserProvider {
  var userBox = Hive.box<UserEntity>('users');
  List<UserEntity> get users => userBox.values.toList();

  saveUser(UserEntity user) {
    return userBox.put(user.uid, user);
  }

  saveListUsers(List<UserEntity> list) {
    if (list == null) return;

    list.forEach((activity) => saveUser(activity));
  }

  void deleteUser(id) {
    userBox.delete(id);
  }

  UserEntity get loggedUser {
    if (users == null || users.isEmpty) return null;
    return users.firstWhere((element) => element.logged, orElse: null);
  }
}
