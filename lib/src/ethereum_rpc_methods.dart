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
  /// Dapp
  /// Client version
  static const String web3ClientVersion = 'web3_clientVersion';

  /// SHA3
  static const String web3Sha3 = 'web3_sha3';

  /// Version
  static const String netVersion = 'net_version';

  /// Listening
  static const String netListening = 'net_listening';

  /// Peer count
  static const String netPeerCount = 'net_peerCount';

  /// Protocol version
  static const String protocolVersion = 'eth_protocolVersion';

  /// Syncing
  static const String syncing = 'eth_syncing';

  /// Coinbase address
  static const String coinbaseAddress = 'eth_coinbase';

  /// Mining
  static const String mining = 'eth_mining';

  /// Hashrate
  static const String hashrate = 'eth_hashrate';

  /// Gas price
  static const String gasPrice = 'eth_gasPrice';

  /// Accounts
  static const String accounts = 'eth_accounts';

  /// Block number
  static const String blockNumber = 'eth_blockNumber';

  /// Balance
  static const String balance = 'eth_getBalance';

  /// Storage
  static const String storageAt = 'eth_getStorageAt';

  /// Transaction count
  static const String transactionCount = 'eth_getTransactionCount';

  /// Block transaction count - hash
  static const String blockTransactionCountByHash =
      'eth_getBlockTransactionCountByHash';

  /// Block transaction count - number
  static const String blockTransactionCountByNumber =
      'eth_getBlockTransactionCountByNumber';

  /// Block uncle count - block hash
  static const String blockUncleCountByBlockHash =
      'eth_getUncleCountByBlockHash';

  /// Block uncle count - block number
  static const String blockUncleCountByBlockNumber =
      'eth_getUncleCountByBlockNumber';

  /// Code
  static const String code = 'eth_getCode';

  /// Sign
  static const String sign = 'eth_sign';

  /// Send transaction
  static const String sendTransaction = 'eth_sendTransaction';

  /// Send raw transaction
  static const String sendRawTransaction = 'eth_sendRawTransaction';

  /// Call
  static const String call = 'eth_call';

  /// Estimate gas
  static const String estimateGas = 'eth_estimateGas';

  /// Block hash
  static const String getBlockByHash = 'eth_getBlockByHash';

  /// Block number
  static const String getBlockByNumber = 'eth_getBlockByNumber';

  /// Transaction by hash
  static const String getTransactionByHash = 'eth_getTransactionByHash';

  /// Transaction by block hash and index
  static const String getTransactionByBlockHashAndIndex =
      'eth_getTransactionByBlockHashAndIndex';

  /// Transaction by block number and index
  static const String getTransactionByBlockNumberAndIndex =
      'eth_getTransactionByBlockNumberAndIndex';

  /// Transaction receipt
  static const String getTransactionReceipt = 'eth_getTransactionReceipt';

  /// Uncle by block hash and index
  static const String getUncleByBlockHashAndIndex =
      'eth_getUncleByBlockHashAndIndex';

  /// Uncle by block number and index
  static const String getUncleByBlockNumberAndIndex =
      'eth_getUncleByBlockNumberAndIndex';

  /// New filter
  static const String newFilter = 'eth_newFilter';

  /// New block filter
  static const String newBlockFilter = 'eth_newBlockFilter';

  /// New pending transaction filter
  static const String newPendingTransactionFilter =
      'eth_newPendingTransactionFilter';

  /// Uninstall a filter
  static const String uninstallFilter = 'eth_uninstallFilter';

  /// Filter changes
  static const String getFilterChanges = 'eth_getFilterChanges';

  /// Filter logs
  static const String getFilterLogs = 'eth_getFilterLogs';

  /// Logs
  static const String getLogs = 'eth_getLogs';

  /// Work
  static const String getWork = 'eth_getWork';

  /// Submit work
  static const String submitWork = 'eth_submitWork';

  /// Submit hashrate
  static const String submitHashrate = 'eth_submitHashrate';

  /// SHH version
  static const String shhVersion = 'shh_version';

  /// SHH post
  static const String shhPost = 'shh_post';

  /// SHH new identity
  static const String shhNewIdentity = 'shh_newIdentity';

  /// Administration
  /// Import raw key
  static const String importRawKey = 'personal_importRawKey';

  /// List accounts
  static const String listAccounts = 'personal_listAccounts';

  /// Lock account
  static const String lockAccount = 'personal_lockAccount';

  /// New account
  static const String newAccount = 'personal_newAccount';

  /// Unlock account
  static const String unlockAccount = 'personal_unlockAccount';

  /// Send transaction
  static const String psendTransaction = 'personal_sendTransaction';

  /// Sign
  static const String pSign = 'personal_sign';

  /// Recover
  static const String ecRecover = 'personal_ecRecover';
}
