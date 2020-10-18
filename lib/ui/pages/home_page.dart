import 'package:flutter/material.dart';
import 'package:spent/model/news.dart';
import 'package:spent/ui/widgets/bottom_navbar.dart';
import 'package:spent/ui/widgets/card_base.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: news.length,
        itemBuilder: (BuildContext context, int index) =>
            CardBase(news: News.fromJson(news[index])),
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          height: 8,
        ),
      )),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
