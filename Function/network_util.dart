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

 
