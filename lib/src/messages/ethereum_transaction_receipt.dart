/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 08/01/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of ethereum;

/// An ethereum transaction receipt message
class EthereumTransactionReceipt {
  EthereumTransactionReceipt();

  EthereumTransactionReceipt.fromMap(Map result) {
    construct(result);
  }

  /// Transaction hash. Hash of the transaction.
  BigInteger _transactionHash;

  BigInteger get transactionHash => _transactionHash;

  /// Transaction index. Ihe transactions index position in the block.
  int _transactionIndex;

  int get transactionIndex => _transactionIndex;

  /// Block hash. Hash of the block this transaction was in.
  BigInteger _blockHash;

  BigInteger get blockHash => _blockHash;

  /// Block number. Block number of this transaction.
  int _blockNumber;

  int get blockNumber => _blockNumber;

  /// Cumulative gas used. The total amount of gas used when this transaction was executed in the block.
  int _cumulativeGasUsed;

  int get cumulativeGasUsed => _cumulativeGasUsed;

  /// Gas used. The amount of gas used by this transaction.
  int _gasUsed;

  int get gasUsed => _gasUsed;

  /// Contract address. The contract address created, if the transaction was a contract creation, otherwise null.
  BigInteger _contractAddress;

  BigInteger get contractAddress => _contractAddress;

  /// Logs. List of log objects, which this transaction generated.
  List<EthereumLog> _logs;

  List<EthereumLog> get logs => _logs;

  /// Logs bloom. Bloom filter for light clients to quickly retrieve related logs.
  BigInteger _logsBloom;

  BigInteger get logsBloom => _logsBloom;

  /// Root. Post-transaction stateroot (pre Byzantium)
  /// Null if status is present.
  BigInteger _root;

  BigInteger get root => _root;

  /// Status. Either 1 (success) or 0 (failure)
  /// Null if root is present
  int _status;

  int get status => _status;

  /// Construct from the supplied Map, only check for the keys we need.
  void construct(Map data) {
    if (data[ethResultKey] == null) {
      return;
    }
  }
}
