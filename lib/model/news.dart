class News {
  String imageUrl;
  String title;
  String body;
  String url;
  DateTime publishDate;

  News(Map news) {
    this.imageUrl = news['imageUrl'];
    this.title = news['title'];
    this.body = news['body'];
    this.url = news['url'];
    this.publishDate = DateTime.parse(news['publishDate']);
  }
}
