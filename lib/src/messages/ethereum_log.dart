/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 08/01/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of '../../ethereum.dart';

/// Ethereum log message
class EthereumLog {
  bool? _removed;

  int? _logIndex;

  int? _transactionIndex;

  EthereumData? _transactionHash;

  EthereumData? _blockHash;

  int? _blockNumber;

  EthereumAddress? _address;

  EthereumData? _data;

  List<EthereumData>? _topics;

  /// Topics. List of 0 to 4 32 of indexed log arguments. (In solidity:
  /// The first topic is the hash of the signature of the event
  /// (e.g. Deposit(address,bytes32,uint256)),
  /// except you declared the event with the anonymous specifier.)
  List<EthereumData>? get topics => _topics;

  /// Removed. True when the log was removed, due to a chain
  /// reorganization. false if its a valid log.
  bool? get removed => _removed;

  /// Log index. The log index position in the block.
  /// Null when the log is pending.
  int? get logIndex => _logIndex;

  /// Transaction index. The transactions index position the log was
  /// created from. Null when the log is pending.
  int? get transactionIndex => _transactionIndex;

  /// Transaction hash. Hash of the transactions this log was created
  /// from. Null when the log is pending.
  EthereumData? get transactionHash => _transactionHash;

  /// Block hash. Hash of the block where this log was in.
  /// Null when the log is pending.
  EthereumData? get blockHash => _blockHash;

  /// Block number. The block number of this log. Null when the log is pending.
  int? get blockNumber => _blockNumber;

  /// Address. Address from which this log originated.
  EthereumAddress? get address => _address;

  /// Data. Contains one or more 32 Bytes non-indexed arguments of the log.
  EthereumData? get data => _data;

  /// Construction
  EthereumLog();

  /// From map
  EthereumLog.fromMap(Map<String, dynamic> result) {
    construct(result);
  }

  /// From list
  static List<EthereumLog> fromList(dynamic res) {
    final logs = <EthereumLog>[];
    for (final dynamic log in res) {
      final buildLog = <String, dynamic>{EthereumConstants.ethResultKey: log};
      final entry = EthereumLog.fromMap(buildLog);
      logs.add(entry);
    }
    return logs;
  }

  /// Construct from the supplied Map, only check for the keys we need.
  void construct(Map<String, dynamic> data) {
    if (data[EthereumConstants.ethResultKey] == null) {
      return;
    }
    if (data[EthereumConstants.ethResultKey].containsKey('removed')) {
      _removed = data[EthereumConstants.ethResultKey]['removed'];
    }
    if (data[EthereumConstants.ethResultKey].containsKey('logIndex')) {
      _logIndex = EthereumUtilities.hexToInt(
        data[EthereumConstants.ethResultKey]['logIndex'],
      );
    }
    if (data[EthereumConstants.ethResultKey].containsKey('transactionIndex')) {
      _transactionIndex = EthereumUtilities.hexToInt(
        data[EthereumConstants.ethResultKey]['transactionIndex'],
      );
    }
    if (data[EthereumConstants.ethResultKey].containsKey('transactionHash')) {
      _transactionHash = EthereumData.fromString(
        data[EthereumConstants.ethResultKey]['transactionHash'],
      );
    }
    if (data[EthereumConstants.ethResultKey].containsKey('blockHash')) {
      _blockHash = EthereumData.fromString(
        data[EthereumConstants.ethResultKey]['blockHash'],
      );
    }
    if (data[EthereumConstants.ethResultKey].containsKey('blockNumber')) {
      _blockNumber = EthereumUtilities.hexToInt(
        data[EthereumConstants.ethResultKey]['blockNumber'],
      );
    }
    if (data[EthereumConstants.ethResultKey].containsKey('address')) {
      _address = EthereumAddress.fromString(
        data[EthereumConstants.ethResultKey]['address'],
      );
    }
    if (data[EthereumConstants.ethResultKey].containsKey('data')) {
      _data = EthereumData.fromString(
        data[EthereumConstants.ethResultKey]['data'],
      );
    }
    if (data[EthereumConstants.ethResultKey].containsKey('topics')) {
      if ((data[EthereumConstants.ethResultKey]['topics'] != null) &&
          (data[EthereumConstants.ethResultKey]['topics'].isNotEmpty)) {
        _topics = EthereumData.toList(
          data[EthereumConstants.ethResultKey]['topics'],
        );
      }
    }
  }

  @override
  String toString() {
    return 'Ethereum Log :'
        '\n'
        '  Removed : $removed'
        '\n'
        '  Log Index : $logIndex'
        '\n'
        '  Transaction Index : $transactionIndex'
        '\n'
        '  Transaction Hash: $transactionHash'
        '\n'
        '  Block Number: $blockNumber'
        '\n'
        '  Block Hash : $blockHash'
        '\n'
        '  Address : $address'
        '\n';
  }
}
