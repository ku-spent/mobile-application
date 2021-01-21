class NewsSource {
  static const String voiceTV = 'Voice TV';
  static const String matichon = 'มติชน';
  // static const String thaipbs = 'thaipbs';
  static const String sanook = 'สนุกดอทคอม';
  static const String beartai = 'beartai';
  static const String hackernoon = 'hackernoon';

  static const List<String> values = [
    voiceTV,
    matichon,
    // thaipbs,
    sanook,
    beartai,
    hackernoon,
  ];

  static Map<String, String> newsSourceIcon = {
    voiceTV: 'https://upload.wikimedia.org/wikipedia/commons/4/4d/VoiceTV.png',
    matichon: 'https://www.matichon.co.th/wp-content/themes/matichon-theme/images/matichon-logo-retina.png',
    // thaipbs: 'https://upload.wikimedia.org/wikipedia/en/5/5a/Thai_PBS_logo.png',
    sanook: 'https://yt3.ggpht.com/a/AATXAJynpchFYOpyQnH5iQfAp7EDwBMJVg2X4YY3kSdezZU=s900-c-k-c0x00ffffff-no-rj',
    beartai: 'https://www.beartai.com/wp-content/uploads/2019/07/Beartai-logo.jpg',
    hackernoon: 'https://cdn-images-1.medium.com/max/1200/1*76XiKOa05Yya6_CdYX8pVg.jpeg',
  };

  static Map<String, String> newsSourceCover = {
    voiceTV: 'https://www.thairath.co.th/media/dFQROr7oWzulq5FZUIEyjkIzuxZVM7y9dNXa6BvDcWSyyVFqz6CEowoMZWpKrcbE7su.jpg',
    matichon: 'https://www.khaosod.co.th/wpapp/uploads/2020/02/%E0%B8%A1%E0%B8%95%E0%B8%B4%E0%B8%8A%E0%B8%99.jpg',
    // thaipbs: 'https://www.thaipbs.or.th/images/logo/home_logo.jpg',
    sanook: 'https://i.ibb.co/g3BdQk6/72611578-3147114532000712-3676700865340637184-n.png',
    beartai: 'https://i1.sndcdn.com/visuals-000579389466-Y87QZS-t1240x260.jpg',
    hackernoon:
        'https://res.cloudinary.com/practicaldev/image/fetch/s---0h02kbY--/c_imagga_scale,f_auto,fl_progressive,h_420,q_auto,w_1000/https://mk0thetokenist81xfs9.kinstacdn.com/wp-content/uploads/2019/02/hackernoon-logo.png',
  };
}
