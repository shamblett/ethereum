/*
 * Packge : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/12/2017
 * Copyright :  S.Hamblett
 *
 * Provides a common interface for Ethereum to connect over websockets in
 * the browser.
 */

part of '../../ethereum_browser_ws_client.dart';

/// The browser web socket adapter
class EthereumBrowserWSAdapter implements EthereumINetworkAdapter {
  @override
  Future<Map<dynamic, dynamic>> httpRequest(
    Uri uri,
    Map<String, dynamic> request,
  ) {
    final completer = Completer<Map<String, dynamic>>();
    final webSocket = WebSocket(uri.toString());
    final message = json.encode(request);
    webSocket.onOpen.listen((Event e) {
      webSocket.send(message.jsify()!);
    });
    webSocket.onError.listen((Event e) {
      print(
        'EthereumBrowserWSAdapter::WebSocket error, message not sent, '
        'state is ${webSocket.readyState.toString()}',
      );
      webSocket.close();
      completer.complete(<String, dynamic>{});
    });
    webSocket.onMessage.listen((MessageEvent e) {
      final String ret = e.data.toString();
      webSocket.close();
      completer.complete(json.decode(ret));
    });
    return completer.future;
  }
}
