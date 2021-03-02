/*
* Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:spent/domain/model/Block.dart';
import 'Bookmark.dart';
import 'History.dart';
import 'News.dart';
import 'User.dart';
import 'Block.dart';
import 'BlockTypes.dart';
import 'UserNewsAction.dart';

export 'Bookmark.dart';
export 'History.dart';
export 'HistoryStatus.dart';
export 'News.dart';
export 'User.dart';
export 'UserAction.dart';
export 'UserNewsAction.dart';
export 'Block.dart';
export 'BlockTypes.dart';

class ModelProvider implements ModelProviderInterface {
  @override
  String version = "92b6a8666e8ec38a96a773af1fa4a4be";
  @override
  List<ModelSchema> modelSchemas = [
    Bookmark.schema,
    History.schema,
    News.schema,
    User.schema,
    UserNewsAction.schema,
    Block.schema,
  ];
  static final ModelProvider _instance = ModelProvider();

  static ModelProvider get instance => _instance;

  ModelType getModelTypeByModelName(String modelName) {
    switch (modelName) {
      case "Bookmark":
        return Bookmark.classType;
      case "History":
        return History.classType;
      case "News":
        return News.classType;
      case "User":
        return User.classType;
      case "UserNewsAction":
        return UserNewsAction.classType;
      case "Block":
        return Block.classType;
      default:
        throw Exception("Failed to find model in model provider.");
    }
  }
}
