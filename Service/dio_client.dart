import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

Dio dio;
Dio dioUploadFile;

BaseOptions options = new BaseOptions(
  baseUrl: base_url,
  connectTimeout: 60000,
  receiveTimeout: 5000,
  contentType: Headers.formUrlEncodedContentType,
);

BaseOptions optionsFileUpload = new BaseOptions(
  baseUrl: base_url,
  connectTimeout: 180000,
  receiveTimeout: 5000,
  contentType: Headers.formUrlEncodedContentType,
);

Options cacheOptions = buildCacheOptions(Duration(days: 7), forceRefresh: true);

dioSetUp() {
  dio = new Dio(options);
  dioUploadFile = new Dio(optionsFileUpload);
  dio.interceptors.add(DioInterceptors());
  dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: base_url)).interceptor);

  dioUploadFile.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions option) async {
    var token = await getToken();

    var customHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await getToken().then((value) => value)}',
      'VerifyToken': token
    };
    option.headers.addAll(customHeaders);
    return option;
  }));
}
