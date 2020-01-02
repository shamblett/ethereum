/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 08/01/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of ethereum;

// ignore_for_file: omit_local_variable_types
// ignore_for_file: unnecessary_final
// ignore_for_file: avoid_annotating_with_dynamic

/// Ethereum log message
class EthereumLog {
  /// Construction
  EthereumLog();

  /// From map
  EthereumLog.fromMap(Map<String, dynamic> result) {
    construct(result);
  }

  /// From list
  static List<EthereumLog> fromList(dynamic res) {
    final List<EthereumLog> logs = <EthereumLog>[];
    for (final dynamic log in res) {
      final Map<String, dynamic> buildLog = <String, dynamic>{
        EthereumConstants.ethResultKey: log
      };
      final EthereumLog entry = EthereumLog.fromMap(buildLog);
      logs.add(entry);
    }
    return logs;
  }

  bool _removed;

  /// Removed. True when the log was removed, due to a chain
  /// reorganization. false if its a valid log.
  bool get removed => _removed;

  int _logIndex;

  /// Log index. The log index position in the block.
  /// Null when the log is pending.
  int get logIndex => _logIndex;

  int _transactionIndex;

  /// Transaction index. The transactions index position the log was
  /// created from. Null when the log is pending.
  int get transactionIndex => _transactionIndex;

  EthereumData _transactionHash;

  /// Transaction hash. Hash of the transactions this log was created
  /// from. Null when the log is pending.
  EthereumData get transactionHash => _transactionHash;

  EthereumData _blockHash;

  /// Block hash. Hash of the block where this log was in.
  /// Null when the log is pending.
  EthereumData get blockHash => _blockHash;

  int _blockNumber;

  /// Block number. The block number of this log. Null when the log is pending.
  int get blockNumber => _blockNumber;

  EthereumAddress _address;

  /// Address. Address from which this log originated.
  EthereumAddress get address => _address;

  EthereumData _data;

  /// Data. Contains one or more 32 Bytes non-indexed arguments of the log.
  EthereumData get data => _data;

  List<EthereumData> _topics;

  /// Topics. List of 0 to 4 32 of indexed log arguments. (In solidity:
  /// The first topic is the hash of the signature of the event
  /// (e.g. Deposit(address,bytes32,uint256)),
  /// except you declared the event with the anonymous specifier.)
  List<EthereumData> get topics => _topics;

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
          data[EthereumConstants.ethResultKey]['logIndex']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('transactionIndex')) {
      _transactionIndex = EthereumUtilities.hexToInt(
          data[EthereumConstants.ethResultKey]['transactionIndex']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('transactionHash')) {
      _transactionHash = EthereumData.fromString(
          data[EthereumConstants.ethResultKey]['transactionHash']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('blockHash')) {
      _blockHash = EthereumData.fromString(
          data[EthereumConstants.ethResultKey]['blockHash']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('blockNumber')) {
      _blockNumber = EthereumUtilities.hexToInt(
          data[EthereumConstants.ethResultKey]['blockNumber']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('address')) {
      _address = EthereumAddress.fromString(
          data[EthereumConstants.ethResultKey]['address']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('data')) {
      _data =
          EthereumData.fromString(data[EthereumConstants.ethResultKey]['data']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('topics')) {
      if ((data[EthereumConstants.ethResultKey]['topics'] != null) &&
          (data[EthereumConstants.ethResultKey]['topics'].isNotEmpty)) {
        _topics =
            EthereumData.toList(data[EthereumConstants.ethResultKey]['topics']);
      }
    }
  }

  @override
  String toString() {
    final String ret = 'Ethereum Log :'
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
    return ret;
  }
}
