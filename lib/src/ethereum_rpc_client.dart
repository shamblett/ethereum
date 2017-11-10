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

  EthereumRpcClient(this._adapter);

  /// The HTTP adapter
  EthereumIHTTPAdapter _adapter;

  /// The transmission id
  int _id = 0;

  int get id => _id;

  /// The request method
  Future<JsonObjectLite> request(String method, [JsonObjectLite parameters]) {

  }

  /// The notification method
  Future<JsonObjectLite> notification(String method,
      [JsonObjectLite parameters]) {

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
