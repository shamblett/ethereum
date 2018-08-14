/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 08/01/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of ethereum;

/// Filter message
/// For filters created with newBlockFilter the object contains block hashes.
/// For filters created with pendingTransactionFilter the class contains transaction hashes.
/// For filters created with newFilter or getFilterChanges the class contains logs
/// which are are EthereumLog objects.
class EthereumFilter {
  EthereumFilter();

  EthereumFilter.fromMap(Map result) {
    construct(result);
  }

  /// Hashes, block or transaction
  List<BigInt> _hashes;

  List<BigInt> get hashes => _hashes;

  /// Logs
  List<EthereumLog> _logs;

  List<EthereumLog> get logs => _logs;

  /// Ethereum log objects, returned by
  /// Construct from the supplied Map, only check for the keys we need.
  void construct(Map data) {
    if (data[ethResultKey] == null) {
      return;
    }
    if (data[ethResultKey].isNotEmpty) {
      if (data[ethResultKey][0] is String) {
        // Hashes
        _hashes = EthereumUtilities.hexToBigIntList(data[ethResultKey]);
      } else {
        // Logs
        _logs = List<EthereumLog>();
        for (Map log in data[ethResultKey]) {
          final Map buildLog = {ethResultKey: log};
          final EthereumLog entry = EthereumLog.fromMap(buildLog);
          _logs.add(entry);
        }
      }
    }
  }
}
