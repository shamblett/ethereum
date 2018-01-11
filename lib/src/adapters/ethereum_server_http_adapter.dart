/*
 * Packge : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 10/011/2017
 * Copyright :  S.Hamblett
 *
 * Provides a common interface for Ethereum to connect over HTTP
 * on the server.
 */

part of ethereum_server_client;

class EthereumServerHTTPAdapter implements EthereumINetworkAdapter {
  /// The HTTP client
  HttpClient _client = new HttpClient();

  static const String jsonMimeType = 'application/json';

  /// Processes the HTTP request returning the  HTTP response as
  /// a map
  Future<Map> httpRequest(Uri uri, Map request) {
    final completer = new Completer();
    _client.postUrl(uri).then((HttpClientRequest req) {
      final payload = JSON.encode(request);
      req.headers.add(HttpHeaders.CONTENT_TYPE, jsonMimeType);
      req.contentLength = payload.length;
      req.write(payload);
      req.close().then((HttpClientResponse resp) {
        resp.listen((data) {
          final Map payload = JSON.decode(new String.fromCharCodes(data));
          completer.complete(payload);
        }, onError: (e) {
          print(e);
        }, onDone: () {
          _client.close();
        });
      });
    }, onError: (e) {
      print(e);
    });
    return completer.future;
  }
}
