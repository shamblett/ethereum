/*
 * Packge : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 10/011/2017
 * Copyright :  S.Hamblett
 *
 * Provides a common interface for Ethereum to connect over HTTP in the
 * browser.
 */

part of ethereum_browser_client;

/// The browser HTTP adapter
class EthereumBrowserHTTPAdapter implements EthereumINetworkAdapter {
  /// Mime type
  static const String jsonMimeType = 'application/json';
  /// Content type
  static const String contentType = 'Content-Type';
  /// Content length
  static const String contentLength = 'Content-Length';

  /// Processes the HTTP request returning the  HTTP response as
  /// a JSON Object
  @override
  Future<Map<dynamic,dynamic>> httpRequest(Uri uri, Map<String,dynamic> request) {
    final  Completer<Map<dynamic,dynamic>> completer = Completer<Map<dynamic,dynamic>>();
    final String reqText = json.encode(request);
    final Map<String, String> headers = <String,String>{contentType: jsonMimeType};
    HttpRequest.request(uri.toString(),
        method: 'POST',
        withCredentials: false,
        requestHeaders: headers,
        sendData: reqText)
      .then((HttpRequest req) {
        final Map<dynamic,dynamic> resp = json.decode(req.responseText);
        completer.complete(resp);
      }, onError: print);
    return completer.future;
  }
}
