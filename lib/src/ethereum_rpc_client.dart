/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/011/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of ethereum;

class EthereumRpcClient {
  static const String jsonRPpcVersion = '2.0';

  EthereumRpcClient(this._adapter);

  /// The HTTP adapter
  EthereumIHTTPAdapter _adapter;

  /// The transmission id
  int _id = 0;

  int get id => _id;

  /// The Uri
  Uri _uri;

  Uri get uri => _uri;

  set uri(Uri uri) => _uri = uri;

  /// The request method
  Future<JsonObjectLite> request(String method, [JsonObjectLite parameters]) {
    final JsonObjectLite packet = new JsonObjectLite();
    packet.jsonrpc = jsonRPpcVersion;
    packet.method = method;
    if (parameters != null) {
      packet.params = parameters;
    }
    packet.id = id;
    _id++;
    return _adapter.httpRequest(_uri, packet);
  }

  /// The notification method
  Future<JsonObjectLite> notification(String method,
      [JsonObjectLite parameters]) {
    final JsonObjectLite packet = new JsonObjectLite();
    packet.jsonrpc = jsonRPpcVersion;
    packet.method = method;
    if (parameters != null) {
      packet.params = parameters;
    }
    return _adapter.httpRequest(_uri, packet);
  }

  /// Reset the transmission id
  void resetTransmissionId([int value]) {
    if (value == null) {
      _id = 0;
    } else {
      _id = value;
    }
  }
}
