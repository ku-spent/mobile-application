class News {
  String imageUrl;
  String title;
  String body;
  String url;
  String source;
  DateTime publishDate;

  News(Map news) {
    this.imageUrl = news['imageUrl'];
    this.title = news['title'];
    this.body = news['body'];
    this.url = news['url'];
    this.source = news['source'];
    this.publishDate = DateTime.parse(news['publishDate']);
  }
}
