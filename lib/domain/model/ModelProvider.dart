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
import 'Bookmark.dart';
import 'History.dart';
import 'News.dart';
import 'User.dart';
import 'UserNewsAction.dart';

export 'Bookmark.dart';
export 'History.dart';
export 'HistoryStatus.dart';
export 'News.dart';
export 'User.dart';
export 'UserAction.dart';
export 'UserNewsAction.dart';

class ModelProvider implements ModelProviderInterface {
  @override
  String version = "8895a2a1631fee4b81fa047ed1cc5f2a";
  @override
  List<ModelSchema> modelSchemas = [
    Bookmark.schema,
    History.schema,
    News.schema,
    User.schema,
    UserNewsAction.schema
  ];
  static final ModelProvider _instance = ModelProvider();

  static ModelProvider get instance => _instance;
}
