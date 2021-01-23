import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:injectable/injectable.dart';

@injectable
class AmplifyHttpManager {
  Future<Map<String, dynamic>> get(RestOptions restOptions) async {
    try {
      print('Get API ${restOptions.path} ${restOptions.queryParameters}');
      RestOperation restOperation = Amplify.API.get(restOptions: restOptions);
      RestResponse response = await restOperation.response;
      String jsonString = utf8.decode(String.fromCharCodes(response.data).trim().runes.toList());
      Map<String, dynamic> res = jsonDecode(jsonString);
      return res;
    } on ApiError catch (error) {
      print(error.details);
      throw error;
    }
  }
}
