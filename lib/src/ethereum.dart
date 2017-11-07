/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/011/2017
 * Copyright :  S.Hamblett
 *
 * The Ethereum client package
 */

part of ethereum;

/// The Ethereum JSON-RPC client class. This implements the Ethereum RPC interface for a
/// pre-supplied channel(socket).
class Ethereum {

  Ethereum();

  Ethereum.fromChannel(StreamChannel channel) {
    _channel = channel;
    _rpcClient = new rpc.Client(_channel);
  }

  /// The communications stream channel
  StreamChannel _channel;

  StreamChannel get channel => _channel;

  /// Json RPC
  rpc.Client _rpcClient;

  rpc.Client get rpcClient => _rpcClient;

}