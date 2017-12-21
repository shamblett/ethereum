/*
 * Packge : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 10/011/2017
 * Copyright :  S.Hamblett
 *
 * Provides a common interface for Ethereum to connect over HTTP,
 * allowing for different HTTP adapters to be used.
 */

part of ethereum_browser_client;

class EthereumBrowserHTTPAdapter implements EthereumIHTTPAdapter {
  static const String jsonMimeType = 'application/json';
  static const String contentType = "Content-Type";
  static const String contentLength = "Content-Length";

  /// Processes the HTTP request returning the  HTTP response as
  /// a JSON Object
  Future<JsonObjectLite> httpRequest(Uri uri, JsonObjectLite request) {
    final completer = new Completer();
    final String reqText = request.toString();
    final Map<String, dynamic> headers = {
      contentType: jsonMimeType,
      contentLength: reqText.length
    };
    HttpRequest.request(uri.toString(),
        method: 'POST',
        withCredentials: false,
        requestHeaders: headers,
        sendData: reqText)
      ..then((HttpRequest req) {
        final JsonObjectLite resp = new JsonObjectLite().fromString(
            req.responseText);
        completer.complete(resp);
      });
    return completer.future;
  }
}
