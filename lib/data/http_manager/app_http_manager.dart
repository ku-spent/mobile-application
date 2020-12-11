import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:spent/core/constants.dart';
import 'package:spent/data/http_manager/http_manager.dart';
import 'package:spent/domain/exceptions/app_exceptions.dart';

const timeout = Duration(seconds: 3);

@singleton
class AppHttpManager implements HttpManager {
  String accessToken;

  @override
  Future get({
    @required String path,
    Map<String, dynamic> query,
    Map<String, String> headers,
  }) async {
    try {
      print('Api Get request path $path');
      print(_queryBuilder(path, query));
      final response = await http
          .get(_queryBuilder(path, query), headers: _headerBuilder(headers))
          .timeout(timeout, onTimeout: () => throw TimeoutException());
      return _returnResponse(response);
    } on Exception catch (_) {
      throw NetworkException();
    }
  }

  @override
  Future<dynamic> post({
    @required String path,
    String endpoint,
    Map body,
    Map<String, dynamic> query,
    Map<String, String> headers,
  }) async {
    try {
      print('Api Post request path $path, with $body');
      final response = await http
          .post(_queryBuilder(path, query, endpoint: endpoint),
              body: body != null ? body : null, headers: _headerBuilder(headers))
          .timeout(timeout, onTimeout: () => throw TimeoutException());
      return _returnResponse(response);
    } on Exception catch (_) {
      throw NetworkException();
    }
  }

  @override
  Future<dynamic> put({
    @required String path,
    Map body,
    Map<String, dynamic> query,
    Map<String, String> headers,
  }) async {
    try {
      print('Api Put request path $path, with $body');
      final response = await http
          .put(_queryBuilder(path, query), body: json.encode(body), headers: _headerBuilder(headers))
          .timeout(timeout, onTimeout: () => throw TimeoutException());
      return _returnResponse(response);
    } on Exception catch (_) {
      throw NetworkException();
    }
  }

  @override
  Future<dynamic> delete({
    @required String path,
    Map<String, dynamic> query,
    Map<String, String> headers,
  }) async {
    try {
      print('Api Delete request path $path');
      final response = await http
          .delete(_queryBuilder(path, query), headers: _headerBuilder(headers))
          .timeout(timeout, onTimeout: () => throw TimeoutException());
      return _returnResponse(response);
    } on Exception catch (_) {
      throw NetworkException();
    }
  }

  Map<String, String> _headerBuilder(Map<String, String> headers) {
    final baseHeaders = <String, String>{};
    baseHeaders[HttpHeaders.acceptHeader] = 'application/json';
    baseHeaders[HttpHeaders.contentTypeHeader] = 'application/json';
    baseHeaders[HttpHeaders.authorizationHeader] = accessToken;

    if (headers != null && headers.isNotEmpty) {
      headers[HttpHeaders.authorizationHeader] = accessToken;
      return headers;
    }
    return baseHeaders;
  }

  String _queryBuilder(String path, Map<String, dynamic> query, {String endpoint}) {
    final curEndpoint = endpoint == null ? ENDPOINT : endpoint;
    final buffer = StringBuffer()..write(curEndpoint + path);
    if (query != null) {
      if (query.isNotEmpty) {
        buffer.write('?');
      }
      query.forEach((key, value) {
        if (value != null) buffer.write('$key=$value&');
      });
    }
    final queryString = buffer.toString();
    final lastIndex = queryString.length - 1;
    return queryString[lastIndex] == '&' ? queryString.substring(0, lastIndex) : queryString;
  }

  dynamic _returnResponse(http.Response response) {
    final responseJson = json.decode(utf8.decode(response.bodyBytes));
    // json.decode(response.body.toString());
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      print('Api response success with $responseJson');
      return responseJson;
    }
    print('Api response error with ${response.statusCode} + ${response.body}');
    switch (response.statusCode) {
      case 400:
        throw BadRequestException();
      case 401:
      case 403:
        throw UnauthorisedException();
      case 500:
      default:
        throw ServerException();
    }
  }
}
