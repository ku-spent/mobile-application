import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/di/di.dart';
import 'package:spent/presentation/bloc/suggest/suggest_bloc.dart';
import 'package:spent/presentation/widgets/card_base.dart';
import 'package:spent/presentation/widgets/retry_error.dart';

class SuggestCarousel extends StatefulWidget {
  final String category;
  final String filterOutId;
  SuggestCarousel({Key key, this.category, this.filterOutId}) : super(key: key);

  @override
  _SuggestCarouselState createState() => _SuggestCarouselState();
}

class _SuggestCarouselState extends State<SuggestCarousel> {
  final String queryField = 'category';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SuggestFeedBloc>(
      create: (BuildContext context) =>
          getIt<SuggestFeedBloc>()..add(InitialSuggestFeed(query: widget.category, queryField: queryField)),
      child: BlocBuilder<SuggestFeedBloc, SuggestFeedState>(builder: (context, state) {
        if (state is SuggestFeedLoaded) {
          return Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child:
                      Text('ข่าวที่เกี่ยวข้อง', style: GoogleFonts.kanit(fontWeight: FontWeight.bold, fontSize: 16.0)),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    // aspectRatio: 2.0,
                    viewportFraction: 0.9,
                    autoPlayInterval: const Duration(seconds: 10),
                    // enlargeCenterPage: true,
                    height: 400,
                  ),
                  items: state.feeds
                      .where((news) => news.id != widget.filterOutId)
                      .toList()
                      .sublist(0, 6)
                      .map((news) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            child: CardBase(
                              news: news,
                              isSubCard: true,
                              showSummary: false,
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          );
        } else if (state is SuggestFeedError) {
          return RetryError();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
