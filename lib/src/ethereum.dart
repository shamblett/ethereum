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
    channel = channel;
    rpcClient = new rpc.Client(channel);
  }

  /// The communications stream channel, if using the default constructor
  /// this must be set.
  StreamChannel channel;

  /// Json RPC
  rpc.Client rpcClient;

  /// isClosed indication from the rpc client
  bool get isClosed => rpcClient.isClosed;

  /// Close the client
  Future close() {
    return rpcClient.close();
  }
}