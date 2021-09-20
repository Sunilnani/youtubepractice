import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:youtube_practice/models/add_category.dart';
import 'package:youtube_practice/models/categoriesmodel.dart';
import 'package:youtube_practice/network_calls/base_networks.dart';
import 'package:youtube_practice/network_calls/base_response.dart';
import 'package:youtube_practice/utils/urls.dart';

class ApiManagers{
  factory ApiManagers() {
    return _singleton;
  }

  ApiManagers._internal();

  static final ApiManagers _singleton = ApiManagers._internal();

  Future<ResponseData> fetch_categories( ) async {

    Response response;
    try {
      response = await dioClient.ref
          .get<dynamic>(URLS.baseUrl+"/categories/");

      if(response.statusCode == 200) {
        CategoriesModel? allcategories;
        allcategories = categoriesModelFromJson(jsonEncode(response.data));
        return ResponseData("success", ResponseStatus.SUCCESS ,data: allcategories);
      } else {
        var message = "Unknown error";
        if(response.data?.containsKey("message") == true){
          message = response.data['message'];
        }
        return ResponseData(message, ResponseStatus.FAILED);
      }
    } on Exception catch (err) {
      return ResponseData<dynamic>( 'Please check your internet', ResponseStatus.FAILED);
    }
  }

}
ApiManagers apimanager = ApiManagers() ;