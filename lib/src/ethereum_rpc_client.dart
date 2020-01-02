/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/11/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of ethereum;

// ignore_for_file: omit_local_variable_types
// ignore_for_file: unnecessary_final
// ignore_for_file: avoid_annotating_with_dynamic

/// The RPC client
class EthereumRpcClient {
  /// Constructor
  EthereumRpcClient(this._adapter);

  /// Version
  static const String jsonRPpcVersion = '2.0';

  /// The HTTP adapter
  final EthereumINetworkAdapter _adapter;

  int _id = 0;

  /// The transmission id
  int get id => _id;

  /// The Uri
  Uri uri;

  /// The request method
  Future<Map<dynamic, dynamic>> request(String method, [dynamic parameters]) {
    final Map<String, dynamic> packet = <String, dynamic>{};
    packet['jsonrpc'] = jsonRPpcVersion;
    packet['method'] = method;
    if (parameters != null) {
      packet['params'] = parameters;
    }
    packet['id'] = id;
    _id++;
    return _adapter.httpRequest(uri, packet);
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
