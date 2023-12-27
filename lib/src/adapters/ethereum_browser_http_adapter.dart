/*
 * Packge : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 10/011/2017
 * Copyright :  S.Hamblett
 *
 * Provides a common interface for Ethereum to connect over HTTP in the
 * browser.
 */

part of '../../ethereum_browser_http_client.dart';

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
  Future<Map<dynamic, dynamic>> httpRequest(
      Uri? uri, Map<String, dynamic> request) {
    final completer = Completer<Map<String, dynamic>>();
    final reqText = json.encode(request);
    final headers = <String, String>{contentType: jsonMimeType};
    HttpRequest.request(uri.toString(),
            method: 'POST',
            withCredentials: false,
            requestHeaders: headers,
            sendData: reqText)
        .then((HttpRequest req) {
      if (req.responseText != null) {
        final Map<String, dynamic> resp = json.decode(req.responseText!);
        completer.complete(resp);
        return completer.future;
      } else {
        completer.complete(<String, dynamic>{});
        return completer.future;
      }
    }, onError: (final error) {
      completer.complete(<String, dynamic>{});
      return completer.future;
    });
    return completer.future;
  }
}
