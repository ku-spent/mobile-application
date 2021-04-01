import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/model/search_item.dart';

class SearchResult extends Equatable {
  final List<News> news;
  final List<SearchItem> categories;
  final List<SearchItem> sources;

  const SearchResult({@required this.news, @required this.categories, @required this.sources});

  SearchResult copyWith(List<News> news) {
    return SearchResult(news: news, categories: categories, sources: sources);
  }

  @override
  List<Object> get props => [news, categories, sources];
}
