/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/11/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of ethereum;

class EthereumRpcClient {
  static const String jsonRPpcVersion = '2.0';

  EthereumRpcClient(this._adapter);

  /// The HTTP adapter
  EthereumINetworkAdapter _adapter;

  /// The transmission id
  int _id = 0;

  int get id => _id;

  /// The Uri
  Uri _uri;

  Uri get uri => _uri;

  set uri(Uri uri) => _uri = uri;

  /// The request method
  Future<Map> request(String method, [dynamic parameters]) {
    final Map packet = new Map();
    packet['jsonrpc'] = jsonRPpcVersion;
    packet['method'] = method;
    if (parameters != null) {
      packet['params'] = parameters;
    }
    packet['id'] = id;
    _id++;
    return _adapter.httpRequest(_uri, packet);
  }

  /// The notification method
  Future<Map> notification(String method, [dynamic parameters]) {
    final Map packet = new Map();
    packet['jsonrpc'] = jsonRPpcVersion;
    packet['method'] = method;
    if (parameters != null) {
      packet['params'] = parameters;
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
