import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:share/share.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/model/News.dart';

@injectable
class ShareNewsUseCase {
  const ShareNewsUseCase();

  Future<void> call(BuildContext context, News news) async {
    final RenderBox box = context.findRenderObject();
    await Share.share(news.url, subject: news.title, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
