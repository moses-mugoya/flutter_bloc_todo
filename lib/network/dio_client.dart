import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:todo/network/custom_exceptions.dart';
import 'package:todo/network/dio_interceptor.dart';



class DioClient{
  late Dio dio;

  final baseUrl = "https://3d0d-2c0f-fe08-12-2-1d00-a9ca-9a0c-b0d9.in.ngrok.io/";

  DioClient(){
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));

    dio.interceptors.add(DioInterceptor());

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
      if(e.response?.statusCode == 400){
        throw CustomException(e.response!.data);
      }else{
        throw Exception(e.message); 
      }
      
    } 
    return response;
  }



}