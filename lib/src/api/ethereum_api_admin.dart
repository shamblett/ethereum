/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 12/09/2018
 * Copyright :  S.Hamblett
 *
 * The Ethereum client package
 */

part of ethereum;

/// This class implements the Ethereuum Admin API
class EthereumApiAdmin {
  EthereumApiAdmin(this._client);

  /// Our client
  Ethereum _client;

  /// Message Id
  int get id => _client.id;

  /// Last error
  EthereumError get lastError => _client.lastError;
}
