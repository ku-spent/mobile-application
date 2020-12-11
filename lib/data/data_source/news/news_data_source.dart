import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:spent/domain/model/news.dart';

abstract class NewsDataSource {
  Future<List<News>> getFeeds(
    int from,
    int size,
    String queryField,
    String query,
  );
}
