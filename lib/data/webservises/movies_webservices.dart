import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:provider_riverpod/constants/strings.dart';
import 'package:provider_riverpod/data/models/model.dart';

class MoviesWebService{
  late Dio dio;

  MoviesWebService(){
    var headers = {
      'X-RapidAPI-Key': X_RapidAPI_Key,
      'X-RapidAPI-Host': X_RapidAPI_Host
    };
    BaseOptions baseopts = BaseOptions(
      method: 'GET',
      headers: headers,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(baseopts);
  }

  Future<List<dynamic>?> getAllMovies() async{
    try{
      Response res =await dio.request(baseUrl);
      return res.data;
    }catch(e){
      return [];
      print(e);
    }

  }


}