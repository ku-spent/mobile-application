abstract class HttpManager {
  Future<dynamic> get({
    String path,
    Map<String, dynamic> query,
    Map<String, String> headers,
  });

  Future<dynamic> post({
    String path,
    String endpoint,
    Map body,
    Map<String, dynamic> query,
    Map<String, String> headers,
  });

  Future<dynamic> put({
    String path,
    Map body,
    Map<String, dynamic> query,
    Map<String, String> headers,
  });

  Future<dynamic> delete({
    String path,
    Map<String, dynamic> query,
    Map<String, String> headers,
  });
}
