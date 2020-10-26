import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spent/model/news.dart';
import 'package:http/http.dart' as http;

class FeedRepository {
  final http.Client client;
  final String endpoint =
      'https://8exva7q54m.execute-api.ap-southeast-1.amazonaws.com/dev';
  const FeedRepository({@required this.client});

  Future<List<News>> fetchFeeds({int from, int size}) async {
    try {
      final res = await client.get(endpoint + '/feed?from=$from&size=$size');
      if (res.statusCode == 200) {
        final data = json.decode(utf8.decode(res.bodyBytes))['data'];
        List items = data['hits'];
        return items.map((e) => News.fromJson(e['_source'])).toList();
      } else {
        throw Exception('error fetching feeds');
      }
    } catch (e) {
      print(e);
    }
  }
}

final List<dynamic> news = [
  {
    'source': 'ไทยรัฐ',
    'image':
        "https://www.thairath.co.th/media/dFQROr7oWzulq5FZUIK6yN28ukTeFChbXDrZSSGeCHgb8heV8rCzAd97ealY269dPrq.webp",
    'title':
        '"สมพงษ์" ลาออก หัวหน้าพรรคเพื่อไทยแล้ว มีผลตั้งแต่ 4 โมงเย็น วันนี้',
    'url':
        'https://stackoverflow.com/questions/45189282/mapping-json-into-class-objects',
    'summary':
        'พรรคเพื่อไทย ร่อนหนังสือ นายสมพงษ์ อมรวิวัฒน์ ขอลาออกจากตำแหน่งหัวหน้าพรรคแล้ว มีผลตั้งแต่ 16.00 น. วันนี้ เตรียมเรียกประชุมสมัยวิสามัญ และเลือกคณะกรรมการบริหารพรรคชุดใหม่',
    'pubDate': "2020-10-07T05:13:44.758Z"
  },
  {
    'source': 'ไทยรัฐ',
    'image':
        "https://www.thairath.co.th/media/dFQROr7oWzulq5FZUIK6yN28ukTeFChbXDrZSSGeCHgb8heV8rCzAd97ealY269dPrq.webp",
    'title':
        '"สมพงษ์" ลาออก หัวหน้าพรรคเพื่อไทยแล้ว มีผลตั้งแต่ 4 โมงเย็น วันนี้',
    'url':
        'https://stackoverflow.com/questions/45189282/mapping-json-into-class-objects',
    'summary':
        'พรรคเพื่อไทย ร่อนหนังสือ นายสมพงษ์ อมรวิวัฒน์ ขอลาออกจากตำแหน่งหัวหน้าพรรคแล้ว มีผลตั้งแต่ 16.00 น. วันนี้ เตรียมเรียกประชุมสมัยวิสามัญ และเลือกคณะกรรมการบริหารพรรคชุดใหม่',
    'pubDate': "2020-10-06T05:13:44.758Z"
  },
  {
    'source': 'ไทยรัฐ',
    'image':
        "https://www.thairath.co.th/media/dFQROr7oWzulq5FZUIK6yN28ukTeFChbXDrZSSGeCHgb8heV8rCzAd97ealY269dPrq.webp",
    'title':
        '"สมพงษ์" ลาออก หัวหน้าพรรคเพื่อไทยแล้ว มีผลตั้งแต่ 4 โมงเย็น วันนี้',
    'url':
        'https://stackoverflow.com/questions/45189282/mapping-json-into-class-objects',
    'summary':
        'พรรคเพื่อไทย ร่อนหนังสือ นายสมพงษ์ อมรวิวัฒน์ ขอลาออกจากตำแหน่งหัวหน้าพรรคแล้ว มีผลตั้งแต่ 16.00 น. วันนี้ เตรียมเรียกประชุมสมัยวิสามัญ และเลือกคณะกรรมการบริหารพรรคชุดใหม่',
    'pubDate': "2020-10-06T05:13:44.758Z"
  }
];
