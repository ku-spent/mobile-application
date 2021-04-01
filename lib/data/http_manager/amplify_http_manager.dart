import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:injectable/injectable.dart';

@injectable
class AmplifyHttpManager {
  Future<Map<String, dynamic>> get(RestOptions restOptions) async {
    try {
      print('Get API ${restOptions.path} ${restOptions.queryParameters}');
      final RestOperation restOperation = Amplify.API.get(restOptions: restOptions);
      final RestResponse response = await restOperation.response;
      final String jsonString = utf8.decode(String.fromCharCodes(response.data).trim().runes.toList());
      final Map<String, dynamic> res = jsonDecode(jsonString);
      return res;
    } on ApiException catch (e) {
      print('GET call failed: $e');
    }
  }

  Future<Map<String, dynamic>> post(RestOptions restOptions) async {
    try {
      print('Get API ${restOptions.path} ${restOptions.queryParameters}');
      final RestOperation restOperation = Amplify.API.post(restOptions: restOptions);
      final RestResponse response = await restOperation.response;
      final String jsonString = utf8.decode(String.fromCharCodes(response.data).trim().runes.toList());
      final Map<String, dynamic> res = jsonDecode(jsonString);
      return res;
    } on ApiException catch (e) {
      print('GET call failed: $e');
    }
  }

  Future<Map<String, dynamic>> put(RestOptions restOptions) async {
    try {
      print('Get API ${restOptions.path} ${restOptions.queryParameters}');
      final RestOperation restOperation = Amplify.API.put(restOptions: restOptions);
      final RestResponse response = await restOperation.response;
      final String jsonString = utf8.decode(String.fromCharCodes(response.data).trim().runes.toList());
      final Map<String, dynamic> res = jsonDecode(jsonString);
      return res;
    } on ApiException catch (e) {
      print('GET call failed: $e');
    }
  }

  Future<Map<String, dynamic>> delete(RestOptions restOptions) async {
    try {
      print('Get API ${restOptions.path} ${restOptions.queryParameters}');
      final RestOperation restOperation = Amplify.API.delete(restOptions: restOptions);
      final RestResponse response = await restOperation.response;
      final String jsonString = utf8.decode(String.fromCharCodes(response.data).trim().runes.toList());
      final Map<String, dynamic> res = jsonDecode(jsonString);
      return res;
    } on ApiException catch (e) {
      print('GET call failed: $e');
    }
  }
}
