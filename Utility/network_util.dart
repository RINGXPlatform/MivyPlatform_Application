import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:ring_mobile/common_widgets/custom_dialog.dart';
import 'package:ring_mobile/common_widgets/progress_dialog.dart';
import 'package:ring_mobile/data/app_preferences.dart';
import 'package:ring_mobile/translation/translations.dart';


int noOfCallRunning = 0;

class NetworkUtil {
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;
  final JsonDecoder _decoder = new JsonDecoder();

  Future<Response> getRequest({@required String url, Map headers}) async {
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) return Future.error("internet_issue");
    return http.get(url, headers: headers); // Make HTTP-POST request
  }

  Future<Response> postRequest({@required String url, Map headers, String body, encoding}) async {
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) return Future.error("internet_issue");
    return http.post(url, body: body, headers: headers, encoding: encoding); // Make HTTP-POST request
  }

  Future<Response> putRequest({@required String url, Map headers, String body, encoding}) async {
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) return Future.error("internet_issue");
    return http.put(url, body: body, headers: headers, encoding: encoding); // Make HTTP-POST request
  }

  Future<Response> patchRequest({@required String url, Map headers, String body, encoding}) async {
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) return Future.error("internet_issue");
    return http.patch(url, body: body, headers: headers, encoding: encoding); // Make HTTP-POST request
  }

  Future<Response> deleteRequest({@required String url, Map headers}) async {
    if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) return Future.error("internet_issue");
    return http.delete(url, headers: headers); // Make HTTP-POST request
  }

  Future<dynamic> callApi(
      {@required BuildContext context,
      @required RequestType requestType,
      @required String url,
      Map headers,
      String body,
      encoding,
      bool doStartLoader = false,
      bool doEndLoader = false}) {
    print("url = $url ,data = $body");
    print("doStartLoader = $doStartLoader ,$doEndLoader, $noOfCallRunning");
    startLoader(context, doStartLoader);

//     Connectivity().checkConnectivity().then((connectivityResult) {
//      if (connectivityResult == ConnectivityResult.none) {
//        endLoader(context, doEndLoader);
//        return Future.error("No internet connection");
//      }
//    });

    Future<Response> request;
    switch (requestType) {
      case RequestType.GET:
        request = getRequest(url: url, headers: headers);
        break;
      case RequestType.POST:
        request = postRequest(url: url, headers: headers, body: body, encoding: encoding);
        break;
      case RequestType.PUT:
        request = putRequest(url: url, headers: headers, body: body, encoding: encoding);
        break;
      case RequestType.PATCH:
        request = patchRequest(url: url, headers: headers, body: body, encoding: encoding);
        break;
      case RequestType.DELETE:
        request = deleteRequest(url: url, headers: headers);
        break;
    }

    return request.then((http.Response response) {
      // On response received
      endLoader(context, doEndLoader);

      // Get response status code
      final int statusCode = response.statusCode;
      print("statusCode => $statusCode");

      // Check response status code for error condition
      if (statusCode < 200 || statusCode >= 400 ||statusCode == 422 || json == null) {
        print("On Error of request : $url => ${response.body}");
        if (response.body.isNotEmpty) onHttpError(context, statusCode, response.body);
        return Future.error("Error while fetching data");
      } else {
        // No error occurred
        // Get response body
        final String res = response.body;
        print("data++"+response.body);
        // Convert response body to JSON object
//        print("res => $res");
        return _decoder.convert(res);
      }
    }, onError: (error) {
      if (error is String && error == "internet_issue") {
        noInternetDialog(context);
        endLoader(context, doEndLoader);
        Future.error("internet_issue");
      }
    });
  }

  Future<dynamic> uploadImage(BuildContext context, String url,
      {Map<String, String> headers, dio.FormData formData, bool doStartLoader = false, bool doEndLoader = false}) async {
    print("doStartLoader = $doStartLoader ,$doEndLoader, $noOfCallRunning");
    print("url = $url ,data = $formData");
    startLoader(context, doStartLoader);

    dio.Dio d = new dio.Dio();

/*
    var formData = dio.FormData.fromMap({
      key: await dio.MultipartFile.fromFile(imageFile.path),
    });
*/

    return d.post(url, data: formData, options: dio.Options(headers: headers)).then((dio.Response response) {
      endLoader(context, doEndLoader);

      final int statusCode = response.statusCode;
      print("statusCode => $statusCode");

      print("result => ${response.data}");
//      print("result => ${response.data}");

      if (statusCode < 200 || statusCode > 400 || json == null) {
        print("On Error => ${response.data}");
//        print("On Error => ${response.stream.toList()}");
//        print("On Error => ${response.stream.runtimeType}");
        throw new Exception("Error uplaoing media");
      } else {
//        response.stream.transform(utf8.decoder).listen((value) {
//          print(value);
//        });

        return response.data;
      }
    });

    /*var uri = Uri.parse(url);

    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(headers);
    var multipartFile = await http.MultipartFile.fromPath(key, imageFile.path);

    request.files.add(multipartFile);

    if (fields != null) {
      request.fields.addAll(fields);
    }

    return request.send().then((response) {
      endLoader(context, doEndLoader);

      final int statusCode = response.statusCode;
      print("statusCode => $statusCode");

      if (statusCode < 200 || statusCode > 400 || json == null) {
        print("On Error => ${response.stream}");
//        print("On Error => ${response.stream.toList()}");
//        print("On Error => ${response.stream.runtimeType}");
        throw new Exception("Error uplaoing media");
      } else {
//        response.stream.transform(utf8.decoder).listen((value) {
//          print(value);
//        });
        return response.stream.transform(utf8.decoder);
      }
    });*/
  }

  startLoader(BuildContext context, bool doStartLoader) {
    if (doStartLoader) {
      noOfCallRunning++;
      print("noOfCallRunning => $noOfCallRunning");
      if (noOfCallRunning == 1) showLoadingDialog(context);
    }
  }

  endLoader(BuildContext context, bool doEndLoader) {
    if (doEndLoader) {
      print("noOfCallRunning => $noOfCallRunning");
      if (noOfCallRunning == 1) Navigator.pop(context);
      noOfCallRunning--;
    }
  }

  void onHttpError(BuildContext context, int statusCode, String body) {
    var json = jsonDecode(body);
    switch (statusCode) {
      case 500: // ServerError
      case 400: // BadRequest
      case 403: // Unauthorized
      case 404: // NotFound
      case 409: // Conflict
      case 423: // Blocked
        showErrorDialog(context, json['message']);
        break;
      case 422: // InValidateData
        if (json['errors'] == null) {
          if (json['message'] != null) showErrorDialog(context, json['message']);
        } else {
          String errors = "";
          (json['errors'] as Map<String, dynamic>).forEach((k, v) {
            errors += "• $v\n";
          });
          showErrorDialog(context, errors);
        }
        break;
      case 401: // Unauthenticated
        AppPreferences().setIsLogin(false);
        Navigator.popUntil(context, ModalRoute.withName("/"));
        break;
      case 426: // ForceUpdate
        break;
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    print("message => $message");
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: translateValue("oops"),
        description: message,
        positiveButtonText: translateValue("okay"),
      ),
    );
  }

  void noInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: translateValue("network_issue"),
        description: translateValue("network_issue_desc"),
        positiveButtonText: translateValue("retry"),
      ),
    );
  }
}

enum RequestType { GET, POST, PUT, PATCH, DELETE }
