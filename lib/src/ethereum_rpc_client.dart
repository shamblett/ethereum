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
  /// Version
  static const String jsonRPpcVersion = '2.0';

  /// The Uri
  late Uri uri;

  /// The HTTP adapter
  final EthereumINetworkAdapter _adapter;

  int _id = 0;

  /// The transmission id
  int get id => _id;

  /// Constructor
  EthereumRpcClient(this._adapter);

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
    _id = value ?? 0;
  }
}
