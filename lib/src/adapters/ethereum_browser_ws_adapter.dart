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
  Future<JsonObjectLite> httpRequest(Uri uri, JsonObjectLite request) {
    final completer = new Completer();
    final WebSocket webSocket = new WebSocket(uri.toString());
    final String message = request.toString();
    if (webSocket != null && webSocket.readyState == WebSocket.OPEN) {
      webSocket.sendString(message);
    } else {
      print(
          'EthereumBrowserWSAdapter::WebSocket not connected, message not sent');
    }
    webSocket.onMessage.listen((MessageEvent e) {
      final String ret = e.data;
      webSocket.close();
      completer.complete(new JsonObjectLite().fromString(ret));
    });
    return completer.future;
  }
}
