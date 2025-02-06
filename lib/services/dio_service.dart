import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_service;
import 'dart:developer' as developer;

class DioService {
  Dio dio = Dio();

  Future<dynamic> getMethod(String url) async {
    dio.options.headers['content-Type'] = "application/json";
    return await dio
        .get(url,
            options: Options(responseType: ResponseType.json, method: 'GET'))
        .then((response) {
      return response;
    }).catchError((err){
       if (err is DioException){
        return err.response!;
       }
    });
  }

  Future<dynamic> postMethod(Map<String, dynamic> map, String url) async {
    dio.options.headers['content-Type'] = "application/json";
    return await dio
        .post(url,
            data: dio_service.FormData.fromMap(map),
            options: Options(responseType: ResponseType.json, method: "POST"))
        .then((response) {
      developer.log(response.headers.toString());
      developer.log(response.data.toString());
      developer.log(response.statusCode.toString());
      return response;
    }).catchError((err){
      if (err == DioError){
        return err.response!;
      }
    });
  }
}
