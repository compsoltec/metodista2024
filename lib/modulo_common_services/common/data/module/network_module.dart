import 'package:dio/dio.dart';
import '../data.dart';

class NetworkModule {
  final Dio _dio = new Dio();
  final String _baseUrl = "https://golang-heroku.herokuapp.com/api/";
  final RequestInterceptor requestInterceptor;

  NetworkModule({required this.requestInterceptor});

  BaseOptions _dioOptions() {
    BaseOptions opts = BaseOptions();
    opts.baseUrl = _baseUrl;
    opts.connectTimeout = Duration(seconds: 60000);
    opts.receiveTimeout = Duration(seconds: 60000);
    opts.sendTimeout = Duration(seconds: 60000);
    return opts;
  }

  Dio provideDio() {
    _dio.options = _dioOptions();
    _dio.interceptors.add(requestInterceptor);
    return _dio;
  }
}
