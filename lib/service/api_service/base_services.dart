import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ipapi/const/api_key.dart';
import 'package:ipapi/service/api_service/api_const.dart';

import 'app_exception.dart';

enum APIType { aPost, aGet, aPut, aPatch }

class APIService {
  var response;

  Future getResponse(
      {required String url,
      required APIType apiType,
      Map<String, dynamic>? body,
      Map<String, String>? header,
      bool fileUpload = false}) async {
    Map<String, String> headers = url.contains(BaseUrl.baseUrl)
        ? {}
        : {
            'Content-Type': 'application/json',
            'Authorization': 'Basic ${apiKey}'
          };
    try {
      if (apiType == APIType.aGet) {
        log('--- GET URL---${url}');
        final result = await http.get(Uri.parse(url), headers: headers);
        response = returnResponse(result.statusCode, result.body);
      } else if (apiType == APIType.aPost) {
        log('--- POST URL---${url}');
        final result = await http.post(Uri.parse(url),
            body: json.encode(body), headers: headers);

        response = returnResponse(result.statusCode, result.body);
      } else if (apiType == APIType.aPut) {
        log('--- PUT URL---${url}');
        final result = await http.put(Uri.parse(url),
            headers: headers, body: json.encode(body));
        response = returnResponse(result.statusCode, result.body);
      }
    } on SocketException {
      throw FetchDataException('No Internet access');
    }

    return response;
  }

  returnResponse(int status, String result) async {
    print('----STATUS CODE---${status}');
    switch (status) {
      case 200:
        log('------SUCCESS 200----${result}');

        return jsonDecode(result);
      case 201:
        print('------SUCCESS 201----${result}');

        return jsonDecode(result);
      case 400:
        return BadRequestException('Bad Request');
      case 401:
        throw UnauthorisedException('Unauthorised user');
      case 404:
        throw ServerException('Server Error');
      case 500:
      default:
        throw FetchDataException('Internal Server Error');
    }
  }
}
