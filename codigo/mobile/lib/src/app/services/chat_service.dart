import 'package:amigleapp/src/app/models/dto/history/HistoryDTO.dart';
import 'package:amigleapp/src/app/utils/network/network_service.dart';

import 'base_service.dart';

class ChatService extends BaseService {
  Future<List<HistoryDTO>> searchHistory({var id}) {
    return this
        .request(HttpMethod.GET, 'chat/$id', headers: headers)
        .then((response) {
      if (response == null) return null;

      List tags = response as List;
      return tags.map((tag) => HistoryDTO.fromJson(tag)).toList();
    }).catchError((error) {
      throw (error);
    });
  }
}
