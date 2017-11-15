/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/011/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of ethereum;

/// The Ethereum RPC method names
class EthereumRpcMethods {
  static const String web3ClientVersion = 'web3_clientVersion';
  static const String web3Sha3 = 'web3_sha3';
  static const String netVersion = 'net_version';
  static const String netListening = 'net_listening';
  static const String netPeerCount = 'net_peerCount';
  static const String protocolVersion = 'eth_protocolVersion';
  static const String syncing = 'eth_syncing';
  static const String coinbaseAddress = 'eth_coinbase';
  static const String mining = 'eth_mining';
  static const String hashrate = 'eth_hashrate';
  static const String gasPrice = 'eth_gasPrice';
  static const String accounts = 'eth_accounts';
  static const String blockNumber = 'eth_blockNumber';
  static const String balance = 'eth_getBalance';
  static const String storageAt = 'eth_getStorageAt';
  static const String transactionCount = 'eth_getTransactionCount';
}
