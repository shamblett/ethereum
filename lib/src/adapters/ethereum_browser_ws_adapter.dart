/*
 * Packge : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/12/2017
 * Copyright :  S.Hamblett
 *
 * Provides a common interface for Ethereum to connect over websockets in
 * the browser.
 */

part of ethereum_browser_ws_client;

class EthereumBrowserWSAdapter implements EthereumINetworkAdapter {
  Future<Map> httpRequest(Uri uri, Map request) {
    final completer = Completer<Map>();
    final WebSocket webSocket = WebSocket(uri.toString());
    final String message = json.encode(request);
    webSocket.onOpen.listen((Event e) {
      webSocket.sendString(message);
    });
    webSocket.onError.listen((Event e) {
      print(
          'EthereumBrowserWSAdapter::WebSocket error, message not sent, state is ${webSocket.readyState.toString()}');
      webSocket.close();
      return completer.complete(null);
    });
    webSocket.onMessage.listen((MessageEvent e) {
      final String ret = e.data;
      webSocket.close();
      completer.complete(json.decode(ret));
    });
    return completer.future;
  }
}
