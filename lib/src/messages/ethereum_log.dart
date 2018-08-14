/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 08/01/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of ethereum;

/// Ethereum log message
class EthereumLog {
  EthereumLog();

  EthereumLog.fromMap(Map result) {
    construct(result);
  }

  /// Removed. True when the log was removed, due to a chain reorganization. false if its a valid log.
  bool _removed;

  bool get removed => _removed;

  /// Log index. The log index position in the block. Null when the log is pending.
  int _logIndex;

  int get logIndex => _logIndex;

  /// Transaction index. The transactions index position the log was created from. Null when the log is pending.
  int _transactionIndex;

  int get transactionIndex => _transactionIndex;

  /// Transaction hash. Hash of the transactions this log was created from. Null when the log is pending.
  BigInt _transactionHash;

  BigInt get transactionHash => _transactionHash;

  /// Block hash. Hash of the block where this log was in. Null when the log is pending.
  BigInt _blockHash;

  BigInt get blockHash => _blockHash;

  /// Block number. The block number of this log. Null when the log is pending.
  int _blockNumber;

  int get blockNumber => _blockNumber;

  /// Address. Address from which this log originated.
  BigInt _address;

  BigInt get address => _address;

  /// Data. Contains one or more 32 Bytes non-indexed arguments of the log.
  BigInt _data;

  BigInt get data => _data;

  /// Topics. List of 0 to 4 32 of indexed log arguments. (In solidity:
  /// The first topic is the hash of the signature of the event (e.g. Deposit(address,bytes32,uint256)),
  /// except you declared the event with the anonymous specifier.)
  List<BigInt> _topics;

  List<BigInt> get topics => _topics;

  /// Construct from the supplied Map, only check for the keys we need.
  void construct(Map data) {
    if (data[ethResultKey] == null) {
      return;
    }
    if (data[ethResultKey].containsKey('removed')) {
      _removed = data[ethResultKey]['removed'];
    }
    if (data[ethResultKey].containsKey('logIndex')) {
      _logIndex = EthereumUtilities.hexToInt(data[ethResultKey]['logIndex']);
    }
    if (data[ethResultKey].containsKey('transactionIndex')) {
      _transactionIndex =
          EthereumUtilities.hexToInt(data[ethResultKey]['transactionIndex']);
    }
    if (data[ethResultKey].containsKey('transactionHash')) {
      _transactionHash =
          EthereumUtilities.safeParse(data[ethResultKey]['transactionHash']);
    }
    if (data[ethResultKey].containsKey('blockHash')) {
      _blockHash = EthereumUtilities.safeParse(data[ethResultKey]['blockHash']);
    }
    if (data[ethResultKey].containsKey('blockNumber')) {
      _blockNumber =
          EthereumUtilities.hexToInt(data[ethResultKey]['blockNumber']);
    }
    if (data[ethResultKey].containsKey('address')) {
      _address = EthereumUtilities.safeParse(data[ethResultKey]['address']);
    }
    if (data[ethResultKey].containsKey('data')) {
      _data = EthereumUtilities.safeParse(data[ethResultKey]['data']);
    }
    if (data[ethResultKey].containsKey('topics')) {
      if ((data[ethResultKey]['topics'] != null) &&
          (data[ethResultKey]['topics'].isNotEmpty)) {
        _topics = List<BigInt>();
        for (String topic in data[ethResultKey]['topics']) {
          final BigInt entry = EthereumUtilities.safeParse(topic);
          _topics.add(entry);
        }
      }
    }
  }

  // To string
  String toString() {
    final String ret = "Ethereum Log :" +
        "\n" +
        "  Removed : $removed" +
        "\n" +
        "  Log Index : $logIndex" +
        "\n" +
        "  Transaction Index : $transactionIndex" +
        "\n" +
        "  Transaction Hash: $transactionHash" +
        "\n" +
        "  Block Number: $blockNumber" +
        "\n" +
        "  Block Hash : $blockHash" +
        "\n" +
        "  Address : $address" +
        "\n";
    return ret;
  }
}
