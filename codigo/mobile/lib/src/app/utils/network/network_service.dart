import 'package:amigleapp/src/app/utils/library/helpers/global.dart';
import 'package:amigleapp/src/configs/app_config.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum HttpMethod { GET, POST, PUT, PATCH, DELETE }

class NetworkService {
  Dio _dio;

  BaseOptions _baseOptions = new BaseOptions(
    baseUrl: APP_CONFIG.API_SERVER,
    connectTimeout: APP_CONFIG.REQUEST_TIME_OUT,
    receiveTimeout: APP_CONFIG.REQUEST_TIME_OUT,
    contentType: 'application/json',
  );

  /// ==========================================================
  /// Singleton Factory
  ///
  ///
  static final NetworkService _network = NetworkService._internal();
  factory NetworkService() {
    _network.init();
    return _network;
  }
  NetworkService._internal();

  /// ==========================================================
  /// One-time initialization
  ///
  ///
  init() {
    print('init() Network');
    if (_dio == null) {
      _dio = Dio(this._baseOptions);
    }
    return null;
  }

  /// ==========================================================
  /// Requests
  ///

  Future<dynamic> request(HttpMethod method, String endpoint,
      {Map headers, body, bool autoLoading = true}) async {
    if (autoLoading) frwkLoading.startLoading();

    dynamic response;

    try {
      if (method == HttpMethod.GET) {
        response = await this._get(endpoint, headers: headers);
      } else if (method == HttpMethod.POST) {
        response = await this._post(endpoint, body: body, headers: headers);
      } else if (method == HttpMethod.PUT) {
        response = await this._put(endpoint, body: body, headers: headers);
      } else if (method == HttpMethod.PATCH) {
        print('HttpMethod PATCH não implementado!');
      } else if (method == HttpMethod.DELETE) {
        response = await this._delete(endpoint, body: body, headers: headers);
      } else {
        print('HttpMethod desconhecido!');
      }
    } catch (e) {
      print('Request Exception => ($endpoint) $e');

      if (autoLoading) frwkLoading.stopLoading();

      if (e is DioError) {
        var dioError = e;
        String message = dioError?.response?.data['message'];
        if (message != null) {
          throw new Exception(message);
        } else {
          throw new Exception(
              'Erro desconhecido! Entre em contato com um administrador do sistema.');
        }
      } else {
        throw new Exception(
            'Não foi possível concluir sua chamada! Tente novamente mais tarde.');
      }
    }
    if (autoLoading) frwkLoading.stopLoading();

    return response;
  }

  Future<dynamic> _get(String endpoint, {Map headers}) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Response response = await _dio.get(
      endpoint,
      options: await this._getCustomConfig(headers),
    );
    return this._generateResponse(response);
  }

  Future<dynamic> _post(String endpoint, {Map headers, body}) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Response response = await _dio.post(
      endpoint,
      data: body,
      options: await this._getCustomConfig(headers),
    );

    return this._generateResponse(response);
  }

  Future<dynamic> _put(String endpoint, {Map headers, body}) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Response response = await _dio.put(
      endpoint,
      data: body,
      options: await this._getCustomConfig(headers),
    );
    return this._generateResponse(response);
  }

  Future<dynamic> _delete(String endpoint, {Map headers, body}) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Response response = await _dio.delete(
      endpoint,
      data: body,
      options: await this._getCustomConfig(headers),
    );
    return this._generateResponse(response);
  }

  /// ==========================================================
  /// Custom
  ///

  dynamic _generateResponse(Response response) {
    if (response == null) {
      print('404 - Response null');
      throw new Exception(
          'Não foi possível concluir sua chamada! Tente novamente mais tarde.');
    }

    final int statusCode = response.statusCode;

    if (APP_CONFIG.PRINT_LOG) {
      print("Request (${response.request.method}) => ${response.request.path}");
      print("Response ($statusCode) => ${response.data.toString()}");
    }

    final decoded = response.data;

    if (statusCode < 200 || statusCode > 204) {
      if (decoded != null && decoded["data"] != null) {
        throw new Exception(decoded["data"]);
      }
      throw new Exception(
          'Não foi possível concluir sua chamada! Tente novamente mais tarde.');
    }

    if (decoded is List) {
      return decoded;
    } else if (decoded is Map) {
      if (decoded["data"] != null) {
        return decoded["data"];
      } else if (decoded.isNotEmpty) {
        return decoded;
      } else {
        return null;
      }
    } else {
      return decoded;
    }
  }

  Future<Options> _getCustomConfig(Map<String, String> customHeader) async {
    Options options = Options();
    options.headers = await this._getDefaultHeader(customHeader);
    return options;
  }

  Future<Map<String, String>> _getDefaultHeader(
      Map<String, String> customHeader) async {
    if (customHeader != null) {
      return customHeader;
    }

    Map<String, String> header = {"Content-Type": "application/json"};

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('token') != null) {
      await this._refreshToken();
      header['Authorization'] = 'Bearer ${prefs.getString('token')}';
    }

    if (customHeader != null) {
      header.addAll(customHeader);
    }

    return header;
  }

  Future<void> _refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var refreshToken = prefs.getString('refreshToken');

    Response response = await _dio.post('login/auth/refresh',
        queryParameters: {'refreshToken': refreshToken});

    var data = this._generateResponse(response);

    await prefs.setString('token', data['token']);
    await prefs.setString('refreshToken', data['refreshToken']);
  }

  /// ==========================================================
  /// Extras
  ///

  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
