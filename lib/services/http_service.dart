import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import '../app/app.logger.dart';
import 'environment_service.dart';

enum _HttpMethod { get, post, patch, delete }

class HttpService {
  final int _connectTimeoutSecs = 60;
  late final Dio _httpClient;
  final _logger = getLogger('HttpService');
  final String _baseUrl = EnvironmentService.baseUrl;
  final String _projectId = EnvironmentService.awProjId;

  HttpService() {
    _httpClient = Dio();
    //set connection timeout seconds
    _httpClient.options.connectTimeout = Duration(seconds: _connectTimeoutSecs);
    //add retry interceptor to retry failed requests
    _httpClient.interceptors
        .add(RetryInterceptor(dio: _httpClient, logPrint: _logger.d));
  }

  Future<Map<String, dynamic>> login(
      {required String email, required String password}) async {
    Map<String, dynamic> response = {};
    await Future.delayed(const Duration(seconds: 3)).then((res) {
      //TODO: call login API from BAKANG
      response['success'] = res['success'] ?? true;
      response['message'] = res['message'] ?? "unknown response message";
    });
    return response;
  }

  // Future<List<Microservice>> fetchServicesFromRegistry() async {
  //   final response = await _makeHttpRequest(
  //     method: _HttpMethod.get,
  //     path: EnvironmentService.allServicesUrl,
  //   );
  //   if (response.statusCode != 200) {
  //     return Future.error(
  //         Exception("[${response.statusCode}] ${response.statusMessage}"));
  //   }
  //   List services = response.data;
  //   return services.map((e) => Microservice.fromMap(map: e)).toList();
  // }
  //
  // Future<Map<String, dynamic>> fetchSingleServiceFromRegistry(
  //     String id) async {
  //   final response = await _makeHttpRequest(
  //     method: _HttpMethod.get,
  //     path: "${EnvironmentService.srUrl}"
  //         "${EnvironmentService.serviceWithId}"
  //         "$id",
  //   );
  //   if (response.statusCode != 200) {
  //     _logger.e("[${response.statusCode}] ${response.statusMessage}");
  //     return {
  //       "error": true,
  //       "statusCode": response.statusCode,
  //       "statusMessage": response.statusMessage
  //     };
  //   }
  //   Map<String, dynamic> service = response.data;
  //   return service;
  // }
  //
  // Future patchFormServiceRegistry(
  //     {required String id, required List formConfig}) async {
  //   final response = await _makeHttpRequest(
  //       method: _HttpMethod.patch,
  //       headers: {'Content-Type': 'application/json'},
  //       path: "${EnvironmentService.srUrl}"
  //           "${EnvironmentService.servicePatchPath}"
  //           "$id",
  //       body: {'fields': formConfig});
  //   if (response.statusCode != 200) {
  //     _logger.e("[${response.statusCode}] ${response.statusMessage}");
  //     return {
  //       "error": true,
  //       "statusCode": response.statusCode,
  //       "statusMessage": response.statusMessage
  //     };
  //   }
  //   _logger.d(response);
  // }
  //
  // Future<Map<String, dynamic>> validateOtp(
  //     {required String userId, required String otp}) async {
  //   final response = await _makeHttpRequest(
  //       method: _HttpMethod.post,
  //       path: EnvironmentService.validateOtpUrl,
  //       headers: {'Content-Type': 'application/json'},
  //       body: {"username": userId, "otp": otp});
  //
  //   if (response.statusCode != 200) {
  //     _hd.silentReport(
  //         "ERROR: validateOtp | "
  //             "Code[${response.statusCode}] "
  //             "Data[${response.data}] "
  //             "Status Message [${response.statusMessage}]",
  //         Severity.HIGH);
  //     return Future.error(
  //         Exception("[${response.statusCode}] ${response.statusMessage}"));
  //   }
  //
  //   return response.data;
  // }
  //
  // Future<Map<String, dynamic>> refreshAccessToken(
  //     {required String refreshTkn}) async {
  //   String url = "${EnvironmentService.refreshTokenUrl}$refreshTkn";
  //   final response = await _makeHttpRequest(
  //     method: _HttpMethod.post,
  //     path: url,
  //     headers: {'Content-Type': 'application/json'},
  //   );
  //
  //   if (response.statusCode != 200) {
  //     _hd.silentReport(
  //         "ERROR: refreshAccessToken | "
  //             "Code[${response.statusCode}] "
  //             "Data[${response.data}] "
  //             "Status Message [${response.statusMessage}]",
  //         Severity.HIGH);
  //     return Future.error(
  //         Exception("[${response.statusCode}] ${response.statusMessage}"));
  //   }
  //
  //   return response.data;
  // }
  //
  // ///UPLOADS FILE TO 1GOV STORAGE SERVER AND RETURNS FILE METADATA AS BELOW:
  // /// {
  // ///   bucket: pcg-test,
  // ///   extension: png,
  // ///   original-name: Screenshot_2023-05-26_at_10.22.42.png,
  // ///   key: 3dc4f434-276d-4d2f-baf0-ca5a1ac87e4e
  // /// }
  // Future<Map<String, dynamic>> uploadFileToStorageServer(
  //     {required Uint8List fileBytes,
  //       required String fieldKey,
  //       required String fileName,
  //       required String fileType,
  //       required String serviceCode}) async {
  //   final formData = FormData.fromMap({
  //     "type": fileType,
  //     "description": fieldKey,
  //     "name": fileName,
  //     "file": MultipartFile.fromBytes(fileBytes, filename: fileName)
  //   });
  //   // log.d('Upload URL: ${EnvironmentService.uploadFileUrl+serviceCode}');
  //   final response = await _makeHttpRequest(
  //       method: _HttpMethod.post,
  //       path: EnvironmentService.uploadFileUrl + serviceCode,
  //       disableRetry: true,
  //       headers: {'Content-Type': 'multipart/form-data'},
  //       body: formData);
  //
  //   if (response.statusCode != 200) {
  //     _hd.silentReport(
  //         "ERROR: uploadFileToStorageServer | "
  //             "Code[${response.statusCode}] "
  //             "Data[${response.data}] "
  //             "Status Message [${response.statusMessage}]",
  //         Severity.HIGH);
  //     return Future.error(
  //         Exception("[${response.statusCode}] ${response.statusMessage}"));
  //   }
  //
  //   var responseData = response.data;
  //   log.d('Upload response: $responseData');
  //   return responseData;
  // }
  //
  // ///DOWNLOADS FILE FROM 1GOV STORAGE SERVER USING FILENAME, BUCKET_ID AND KEY :
  // Future<Uint8List?> downloadFileFromStorageServer(
  //     {required String fileKey,
  //       required String serviceCode,
  //       required String fileName}) async {
  //   log.d(
  //       'Download url: ${EnvironmentService.downloadFileUrl}$serviceCode/$fileKey');
  //   final response = await _makeHttpRequest(
  //     method: _HttpMethod.get,
  //     responseType: ResponseType.bytes,
  //     path: "${EnvironmentService.downloadFileUrl}$serviceCode/$fileKey",
  //   );
  //
  //   if (response.statusCode != 200) {
  //     _hd.silentReport(
  //         "ERROR: downloadFileFromStorageServer | "
  //             "Code[${response.statusCode}] "
  //             "Data[${response.data}] "
  //             "Status Message [${response.statusMessage}]",
  //         Severity.HIGH);
  //     return Future.error(
  //         Exception("[${response.statusCode}] ${response.statusMessage}"));
  //   }
  //
  //   if (kIsWeb) {
  //     // Running on the web: Use Blob and html AnchorElement to download the data.
  //     final blob = html.Blob([response.data]);
  //     final url = html.Url.createObjectUrlFromBlob(blob);
  //     final anchor = html.document.createElement('a') as html.AnchorElement
  //       ..href = url
  //       ..style.display = 'none'
  //       ..download = fileName;
  //     html.document.body!.children.add(anchor);
  //     anchor.click();
  //     html.document.body!.children.remove(anchor);
  //     html.Url.revokeObjectUrl(url);
  //   } else {
  //     // Running on a mobile platform: Write the file to the application documents directory.
  //     final appDocDir = await getApplicationDocumentsDirectory();
  //     final file = File('${appDocDir.path}/$fileName');
  //     await file.writeAsBytes(response.data as List<int>);
  //   }
  //
  //   return response.data;
  // }

  /// dio http functions
  Future<Response> _makeHttpRequest({
    required _HttpMethod method,
    required String path,
    bool disableRetry = false,
    ResponseType? responseType,
    Map<String, dynamic> queryParameters = const {},
    body = const {},
    Map<String, dynamic> headers = const {},
  }) async {
    try {
      final response = await _sendRequest(
          method: method,
          path: path,
          disableRetry: disableRetry,
          queryParameters: queryParameters,
          body: body,
          headers: headers,
          responseType: responseType);

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.unknown && e.error is SocketException) {
        _logger.e(
            'There seems to be a network issue. Please check your network and try again.');
        rethrow;
      }

      if (e.type == DioExceptionType.connectionTimeout) {
        _logger.e(
            'Connection timed out. Please check your network and try again.');
        rethrow;
      }

      _logger.e(
          'A response error occurred. ${e.response?.statusCode}\nERROR: ${e.message}');
      rethrow;
    } catch (e) {
      _logger.e('Request to $path failed. Error details: $e');
      rethrow;
    }
  }

  Future<Response> _sendRequest({
    required _HttpMethod method,
    required String path,
    ResponseType? responseType,
    bool disableRetry = false,
    Map<String, dynamic> queryParameters = const {},
    body = const {},
    Map<String, dynamic> headers = const {},
  }) async {
    Response response;

    switch (method) {
      case _HttpMethod.post:
        response = await _httpClient.post(
          path,
          queryParameters: queryParameters,
          data: body,
          options: Options(headers: headers, responseType: responseType)
            ..disableRetry = disableRetry,
          // onSendProgress: (int sent, int total) {
          //   log.d('$sent $total');
          // },
        );
        break;
      case _HttpMethod.patch:
        response = await _httpClient.patch(path,
            queryParameters: queryParameters,
            data: body,
            options: Options(headers: headers, responseType: responseType)
              ..disableRetry = disableRetry);
        break;
      case _HttpMethod.delete:
        response = await _httpClient.delete(
          path,
          queryParameters: queryParameters,
        );
        break;
      case _HttpMethod.get:
      default:
        response = await _httpClient.get(path,
            queryParameters: queryParameters,
            options: Options(headers: headers, responseType: responseType)
              ..disableRetry = disableRetry);
    }

    return response;
  }
}
