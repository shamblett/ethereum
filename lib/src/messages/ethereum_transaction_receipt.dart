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
  BigInt _transactionHash;

  BigInt get transactionHash => _transactionHash;

  /// Transaction index. Ihe transactions index position in the block.
  int _transactionIndex;

  int get transactionIndex => _transactionIndex;

  /// Block hash. Hash of the block this transaction was in.
  BigInt _blockHash;

  BigInt get blockHash => _blockHash;

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
  BigInt _contractAddress;

  BigInt get contractAddress => _contractAddress;

  /// Logs. List of log objects, which this transaction generated.
  List<EthereumLog> _logs;

  List<EthereumLog> get logs => _logs;

  /// Logs bloom. Bloom filter for light clients to quickly retrieve related logs.
  BigInt _logsBloom;

  BigInt get logsBloom => _logsBloom;

  /// Root. Post-transaction stateroot (pre Byzantium)
  /// Null if status is present.
  BigInt _root;

  BigInt get root => _root;

  /// Status. Either 1 (success) or 0 (failure)
  /// Null if root is present
  int _status;

  int get status => _status;

  /// Construct from the supplied Map, only check for the keys we need.
  void construct(Map data) {
    if ((data == null) || (data[EthereumConstants.ethResultKey] == null)) {
      return;
    }
    if (data[EthereumConstants.ethResultKey].containsKey('transactionHash')) {
      _transactionHash =
          EthereumUtilities.safeParse(data[EthereumConstants.ethResultKey]['transactionHash']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('transactionIndex')) {
      _transactionIndex =
          EthereumUtilities.hexToInt(data[EthereumConstants.ethResultKey]['transactionIndex']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('blockHash')) {
      _blockHash = EthereumUtilities.safeParse(data[EthereumConstants.ethResultKey]['blockHash']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('blockNumber')) {
      _blockNumber =
          EthereumUtilities.hexToInt(data[EthereumConstants.ethResultKey]['blockNumber']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('cumulativeGasUsed')) {
      _cumulativeGasUsed =
          EthereumUtilities.hexToInt(data[EthereumConstants.ethResultKey]['cumulativeGasUsed']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('gasUsed')) {
      _gasUsed = EthereumUtilities.hexToInt(data[EthereumConstants.ethResultKey]['gasUsed']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('contractAddress')) {
      _contractAddress =
          EthereumUtilities.safeParse(data[EthereumConstants.ethResultKey]['contractAddress']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('logsBloom')) {
      _logsBloom = EthereumUtilities.safeParse(data[EthereumConstants.ethResultKey]['logsBloom']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('root')) {
      _root = EthereumUtilities.safeParse(data[EthereumConstants.ethResultKey]['root']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('status')) {
      _status = EthereumUtilities.hexToInt(data[EthereumConstants.ethResultKey]['status']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('logs')) {
      if ((data[EthereumConstants.ethResultKey]['logs'] != null) &&
          (data[EthereumConstants.ethResultKey]['logs'].isNotEmpty)) {
        _logs = List<EthereumLog>();
        for (Map log in data[EthereumConstants.ethResultKey]['logs']) {
          final Map buildLog = {EthereumConstants.ethResultKey: log};
          final EthereumLog entry = EthereumLog.fromMap(buildLog);
          _logs.add(entry);
        }
      }
    }
  }

  // To string
  String toString() {
    final String ret = "Ethereum Transaction Receipt:" +
        "\n" +
        "  Transaction Hash : $transactionHash" +
        "\n" +
        "  Block Number: $blockNumber" +
        "\n" +
        "  Block Hash : $blockHash" +
        "\n" +
        "  Transaction Index : $transactionIndex" +
        "\n" +
        "  Contract Address : $contractAddress" +
        "\n" +
        "  Gas used : $gasUsed" +
        "\n";

    return ret;
  }
}
