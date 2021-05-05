import 'package:amigleapp/src/app/models/dto/tags/TagDTO.dart';
import 'package:amigleapp/src/app/utils/network/network_service.dart';

import 'base_service.dart';

class TagService extends BaseService {
  Future<List<TagDTO>> searchTag({var str}) {
    return this
        .request(HttpMethod.GET, 'tag?name=$str', headers: headers)
        .then((response) {
      if (response == null) return null;

      List tags = response as List;
      return tags.map((tag) => TagDTO.fromJson(tag)).toList();
    }).catchError((error) {
      throw (error);
    });
  }

  Future<dynamic> addTag({var idTag, var uid}) {
    return this
        .request(HttpMethod.POST, 'user/$uid/$idTag', headers: headers)
        .then((response) {
      if (response == null) return null;

      return response;
    }).catchError((error) {
      throw (error);
    });
  }

  Future<dynamic> deleteTag({var idTag, var uid}) {
    return this
        .request(HttpMethod.DELETE, 'user/$uid/$idTag', headers: headers)
        .then((response) {
      if (response == null) return null;

      return response;
    }).catchError((error) {
      throw (error);
    });
  }

  Future<dynamic> suggestTag({var name, var uid}) {
    var body = {'name': name};

    return this
        .request(HttpMethod.POST, 'tag/$uid', body: body, headers: headers)
        .then((response) {
      if (response == null) return null;

      return response;
    }).catchError((error) {
      throw (error);
    });
  }
}
