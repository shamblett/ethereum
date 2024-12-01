/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/11/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of '../ethereum.dart';

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
  late Uri uri;

  /// The request method
  Future<Map<dynamic, dynamic>> request(String method, [dynamic parameters]) {
    final packet = <String, dynamic>{};
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
  void resetTransmissionId([int? value]) {
    if (value == null) {
      _id = 0;
    } else {
      _id = value;
    }
  }
}
