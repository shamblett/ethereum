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

// ignore_for_file: omit_local_variable_types
// ignore_for_file: unnecessary_final
// ignore_for_file: cascade_invocations
// ignore_for_file: avoid_print
// ignore_for_file: avoid_types_on_closure_parameters
// ignore_for_file: avoid_annotating_with_dynamic

/// The server HTTP adapter
class EthereumServerHTTPAdapter implements EthereumINetworkAdapter {
  /// Mime type
  static const String jsonMimeType = 'application/json';

  /// Processes the HTTP request returning the  HTTP response as
  /// a map
  @override
  Future<Map<dynamic, dynamic>> httpRequest(
      Uri uri, Map<String, dynamic> request) {
    final HttpClient client = HttpClient();
    final Completer<Map<dynamic, dynamic>> completer =
        Completer<Map<dynamic, dynamic>>();
    client.postUrl(uri).then((HttpClientRequest req) {
      final dynamic payload = json.encode(request);
      req.headers.add(HttpHeaders.contentTypeHeader, jsonMimeType);
      req.contentLength = payload.length;
      req.write(payload);
      req.close().then((HttpClientResponse resp) {
        resp.listen(
          (dynamic data) {
            final Map<dynamic, dynamic> payload =
                json.decode(String.fromCharCodes(data));
            completer.complete(payload);
          },
          onError: print,
        );
      });
    }, onError: print);
    return completer.future;
  }
}
