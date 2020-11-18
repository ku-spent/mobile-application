class NewsSource {
  static const String voiceTV = 'Voice TV';
  static const String matichon = 'มติชน';
  static const String thaipbs = 'thaipbs';
  static const String sanook = 'สนุกดอทคอม';

  static const List<String> values = [
    voiceTV,
    matichon,
    thaipbs,
    sanook,
  ];

  static Map<String, String> newsSourceIcon = {
    voiceTV: 'https://upload.wikimedia.org/wikipedia/commons/4/4d/VoiceTV.png',
    matichon: 'https://www.matichon.co.th/wp-content/themes/matichon-theme/images/matichon-logo-retina.png',
    thaipbs: 'https://upload.wikimedia.org/wikipedia/en/5/5a/Thai_PBS_logo.png',
    sanook: 'https://yt3.ggpht.com/a/AATXAJynpchFYOpyQnH5iQfAp7EDwBMJVg2X4YY3kSdezZU=s900-c-k-c0x00ffffff-no-rj'
  };

  static Map<String, String> newsSourceCover = {
    voiceTV: 'https://www.thairath.co.th/media/dFQROr7oWzulq5FZUIEyjkIzuxZVM7y9dNXa6BvDcWSyyVFqz6CEowoMZWpKrcbE7su.jpg',
    matichon: 'https://www.khaosod.co.th/wpapp/uploads/2020/02/%E0%B8%A1%E0%B8%95%E0%B8%B4%E0%B8%8A%E0%B8%99.jpg',
    thaipbs: 'https://www.thaipbs.or.th/images/logo/home_logo.jpg',
    sanook:
        'https://scontent.fbkk2-8.fna.fbcdn.net/v/t1.0-9/72611578_3147114532000712_3676700865340637184_n.png?_nc_cat=100&ccb=2&_nc_sid=e3f864&_nc_aid=0&_nc_eui2=AeHGgOEV8_cvPtjqfDAJzZGy9ppUjCh3Zt32mlSMKHdm3cd08XWr0UFH3OIDjdWqUPzt1RzdmHgVlKwn8wMwp09w&_nc_ohc=YBwCRnm4yL4AX91n3fo&_nc_ht=scontent.fbkk2-8.fna&oh=4429fbb007af656822620233e108d54a&oe=5FBF87B3'
  };
}
