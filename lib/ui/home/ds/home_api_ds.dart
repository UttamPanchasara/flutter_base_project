import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutterbase/network/client/api_client.dart';
import 'package:flutterbase/network/helper/api_helper.dart';
import 'package:flutterbase/network/rest_constants.dart';
import 'package:flutterbase/ui/home/entity/product_list.dart';

class HomeApiDS<T> extends ApiHelper<T> {
  Stream<List<Post>> getAllPost() {
    return Stream.fromFuture(callApi(
      future: ApiClient().dio().get(RestConstants.GET_ALL_POST,
          options: Options(headers: {ApiClient.REQUIRES_HEADER: false})),
    )).map((dynamic response) {
      print('Response : $response');
      List<dynamic> posts = response;
      return List<Post>.from(posts.map((object) {
        Map<String, dynamic> map = object;
        return Post.fromJson(map);
      }));
    });
  }
}
