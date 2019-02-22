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
  /// Constructor
  EthereumTransactionReceipt();

  /// From map
  EthereumTransactionReceipt.fromMap(Map<String, dynamic> result) {
    construct(result);
  }

  EthereumData _transactionHash;

  /// Transaction hash. Hash of the transaction.
  EthereumData get transactionHash => _transactionHash;

  int _transactionIndex;

  /// Transaction index. Ihe transactions index position in the block.
  int get transactionIndex => _transactionIndex;

  EthereumData _blockHash;

  /// Block hash. Hash of the block this transaction was in.
  EthereumData get blockHash => _blockHash;

  int _blockNumber;

  /// Block number. Block number of this transaction.
  int get blockNumber => _blockNumber;

  int _cumulativeGasUsed;

  /// Cumulative gas used. The total amount of gas used when this transaction was executed in the block.
  int get cumulativeGasUsed => _cumulativeGasUsed;

  int _gasUsed;

  /// Gas used. The amount of gas used by this transaction.
  int get gasUsed => _gasUsed;

  EthereumAddress _contractAddress;

  /// Contract address. The contract address created, if the transaction was a contract creation, otherwise null.
  EthereumAddress get contractAddress => _contractAddress;

  List<EthereumLog> _logs;

  /// Logs. List of log objects, which this transaction generated.
  List<EthereumLog> get logs => _logs;

  EthereumData _logsBloom;

  /// Logs bloom. Bloom filter for light clients to quickly retrieve related logs.
  EthereumData get logsBloom => _logsBloom;

  EthereumData _root;

  /// Root. Post-transaction stateroot (pre Byzantium)
  /// Null if status is present.
  EthereumData get root => _root;

  int _status;

  /// Status. Either 1 (success) or 0 (failure)
  /// Null if root is present
  int get status => _status;

  /// Construct from the supplied Map, only check for the keys we need.
  void construct(Map<String, dynamic> data) {
    if ((data == null) || (data[EthereumConstants.ethResultKey] == null)) {
      return;
    }
    if (data[EthereumConstants.ethResultKey].containsKey('transactionHash')) {
      _transactionHash = EthereumData.fromString(
          data[EthereumConstants.ethResultKey]['transactionHash']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('transactionIndex')) {
      _transactionIndex = EthereumUtilities.hexToInt(
          data[EthereumConstants.ethResultKey]['transactionIndex']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('blockHash')) {
      _blockHash = EthereumData.fromString(
          data[EthereumConstants.ethResultKey]['blockHash']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('blockNumber')) {
      _blockNumber = EthereumUtilities.hexToInt(
          data[EthereumConstants.ethResultKey]['blockNumber']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('cumulativeGasUsed')) {
      _cumulativeGasUsed = EthereumUtilities.hexToInt(
          data[EthereumConstants.ethResultKey]['cumulativeGasUsed']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('gasUsed')) {
      _gasUsed = EthereumUtilities.hexToInt(
          data[EthereumConstants.ethResultKey]['gasUsed']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('contractAddress')) {
      _contractAddress = EthereumAddress.fromString(
          data[EthereumConstants.ethResultKey]['contractAddress']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('logsBloom')) {
      _logsBloom = EthereumData.fromString(
          data[EthereumConstants.ethResultKey]['logsBloom']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('root')) {
      _root =
          EthereumData.fromString(data[EthereumConstants.ethResultKey]['root']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('status')) {
      _status = EthereumUtilities.hexToInt(
          data[EthereumConstants.ethResultKey]['status']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('logs')) {
      if ((data[EthereumConstants.ethResultKey]['logs'] != null) &&
          (data[EthereumConstants.ethResultKey]['logs'].isNotEmpty)) {
        _logs = List<EthereumLog>();
        for (Map<String, dynamic> log in data[EthereumConstants.ethResultKey]
            ['logs']) {
          final Map<String, dynamic> buildLog = <String, dynamic>{
            EthereumConstants.ethResultKey: log
          };
          final EthereumLog entry = EthereumLog.fromMap(buildLog);
          _logs.add(entry);
        }
      }
    }
  }

  @override
  String toString() {
    final String ret = 'Ethereum Transaction Receipt:'
        '\n'
        '  Transaction Hash : $transactionHash'
        '\n'
        '  Block Number: $blockNumber'
        '\n'
        '  Block Hash : $blockHash'
        '\n'
        '  Transaction Index : $transactionIndex'
        '\n'
        '  Contract Address : $contractAddress'
        '\n'
        '  Gas used : $gasUsed'
        '\n';

    return ret;
  }
}
