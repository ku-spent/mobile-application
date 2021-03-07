import 'package:equatable/equatable.dart';
import 'package:spent/domain/model/News.dart';

class Recommendation extends Equatable {
  final String recommendationID;
  final List<String> newsIdList;
  List<News> newsList;

  Recommendation({this.newsList = const [], this.newsIdList = const [], this.recommendationID});

  void setNewsList(List<News> newsList) {
    this.newsList = newsList;
  }

  @override
  List<Object> get props => [recommendationID, newsIdList, newsList];
}
