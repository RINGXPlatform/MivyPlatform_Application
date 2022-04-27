import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioInterceptors extends Interceptor {
  bool doWriteLog = true;
  bool doEncryption = true;

  @override
  Future<dynamic> onRequest(RequestOptions options) async {
    if (doWriteLog) {
      if (options.queryParameters != null) {
      }
      if (options.data != null) {
      }
    }

    return Future.value(options);
  }

  @override
  Future<dynamic> onError(DioError dioError) {
    if (doWriteLog) {
    }
    return Future.value(dioError);
  }

  @override
  Future<dynamic> onResponse(Response response) {
    if (doWriteLog) {

    }

    var resp = response.data;
    CommonCallBack commonCallBack;

    commonCallBack = CommonCallBack.fromJson(resp);

    response.data = commonCallBack;
    return Future.value(response);
  }

  static Future<Map<String, String>> getCommonHeader() async {
    var map = Map<String, String>();
    return map;
  }
}