import 'package:amigleapp/src/app/models/dto/user/UserDTO.dart';
import 'package:amigleapp/src/app/utils/network/network_service.dart';
import 'package:dio/dio.dart';

import 'base_service.dart';

class UserService extends BaseService {
  Future<UserDTO> registerUser({FormData user}) {
    return this
        .request(HttpMethod.POST, 'user', body: user, headers: headers)
        .then((response) {
      if (response == null) return null;
      return UserDTO.fromJson(response);
    }).catchError((error) {
      throw (error);
    });
  }

  Future<void> updateUser({FormData user, String uid}) {
    return this
        .request(HttpMethod.PUT, 'user/$uid', body: user, headers: headers)
        .then((response) {
      return;
    }).catchError((error) {
      throw (error);
    });
  }

  Future<UserDTO> login({FormData user}) {
    return this
        .request(HttpMethod.POST, 'user/login', body: user, headers: headers)
        .then((response) {
      if (response == null) return null;
      return UserDTO.fromJson(response);
    }).catchError((error) {
      throw (error);
    });
  }
}
