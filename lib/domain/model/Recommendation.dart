import 'package:equatable/equatable.dart';
import 'package:spent/domain/model/News.dart';

class Recommendation extends Equatable {
  final String recommendationID;
  final List<News> newsList;

  const Recommendation({this.newsList, this.recommendationID});

  @override
  List<Object> get props => [recommendationID, newsList];
}
