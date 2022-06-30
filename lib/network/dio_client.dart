import 'dart:ffi';

import 'package:dio/dio.dart';



class DioClient extends Interceptor{
  late Dio dio;

  final baseUrl = "https://003c-2c0f-fe08-12-2-ec89-9da7-6f37-65e2.in.ngrok.io/";

  DioClient(){
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));

  }


  Future<Response> getRequest(String endPoint) async{
    Response response;
    try {
      
      response = await dio.get(endPoint);
      print(response);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  Future<Response> postRequest(String endPoint, var activity) async{
    var name = activity['name'];
    var description = activity['description'];
    Response response;
    try{
      response = await dio.post(endPoint, data:{'name': name, 'description':description});
      print(response);
    } on DioError catch (e){
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }
  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    print('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    return super.onError(err, handler);
  }




}