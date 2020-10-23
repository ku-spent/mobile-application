import 'package:spent/model/news.dart';

class FeedRepository {
  Future<List<News>> fetchFeeds() async {
    try {
      return Future.delayed(const Duration(milliseconds: 500),
          () => news.map((e) => News.fromJson(e)).toList());
    } catch (e) {
      print(e);
    }
  }
}

final List<dynamic> news = [
  {
    'source': 'ไทยรัฐ',
    'imageUrl':
        "https://www.thairath.co.th/media/dFQROr7oWzulq5FZUIK6yN28ukTeFChbXDrZSSGeCHgb8heV8rCzAd97ealY269dPrq.webp",
    'title':
        '"สมพงษ์" ลาออก หัวหน้าพรรคเพื่อไทยแล้ว มีผลตั้งแต่ 4 โมงเย็น วันนี้',
    'url':
        'https://stackoverflow.com/questions/45189282/mapping-json-into-class-objects',
    'summary':
        'พรรคเพื่อไทย ร่อนหนังสือ นายสมพงษ์ อมรวิวัฒน์ ขอลาออกจากตำแหน่งหัวหน้าพรรคแล้ว มีผลตั้งแต่ 16.00 น. วันนี้ เตรียมเรียกประชุมสมัยวิสามัญ และเลือกคณะกรรมการบริหารพรรคชุดใหม่',
    'publishDate': "2020-10-07T05:13:44.758Z"
  },
  {
    'source': 'ไทยรัฐ',
    'imageUrl':
        "https://www.thairath.co.th/media/dFQROr7oWzulq5FZUIK6yN28ukTeFChbXDrZSSGeCHgb8heV8rCzAd97ealY269dPrq.webp",
    'title':
        '"สมพงษ์" ลาออก หัวหน้าพรรคเพื่อไทยแล้ว มีผลตั้งแต่ 4 โมงเย็น วันนี้',
    'url':
        'https://stackoverflow.com/questions/45189282/mapping-json-into-class-objects',
    'summary':
        'พรรคเพื่อไทย ร่อนหนังสือ นายสมพงษ์ อมรวิวัฒน์ ขอลาออกจากตำแหน่งหัวหน้าพรรคแล้ว มีผลตั้งแต่ 16.00 น. วันนี้ เตรียมเรียกประชุมสมัยวิสามัญ และเลือกคณะกรรมการบริหารพรรคชุดใหม่',
    'publishDate': "2020-10-06T05:13:44.758Z"
  },
  {
    'source': 'ไทยรัฐ',
    'imageUrl':
        "https://www.thairath.co.th/media/dFQROr7oWzulq5FZUIK6yN28ukTeFChbXDrZSSGeCHgb8heV8rCzAd97ealY269dPrq.webp",
    'title':
        '"สมพงษ์" ลาออก หัวหน้าพรรคเพื่อไทยแล้ว มีผลตั้งแต่ 4 โมงเย็น วันนี้',
    'url':
        'https://stackoverflow.com/questions/45189282/mapping-json-into-class-objects',
    'summary':
        'พรรคเพื่อไทย ร่อนหนังสือ นายสมพงษ์ อมรวิวัฒน์ ขอลาออกจากตำแหน่งหัวหน้าพรรคแล้ว มีผลตั้งแต่ 16.00 น. วันนี้ เตรียมเรียกประชุมสมัยวิสามัญ และเลือกคณะกรรมการบริหารพรรคชุดใหม่',
    'publishDate': "2020-10-06T05:13:44.758Z"
  }
];
