/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 08/01/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of '../../ethereum.dart';

/// Filter message
/// For filters created with newBlockFilter the object contains block hashes.
/// For filters created with pendingTransactionFilter the class
/// contains transaction hashes.
/// For filters created with newFilter or getFilterChanges the
/// class contains logs which are are Ethereum Log objects.
class EthereumFilter {
  /// Construction
  EthereumFilter();

  /// From map
  EthereumFilter.fromMap(Map<String, dynamic> result) {
    construct(result);
  }

  List<EthereumData>? _hashes;

  /// Hashes, block or transaction
  List<EthereumData>? get hashes => _hashes;

  List<EthereumLog>? _logs;

  /// Logs
  List<EthereumLog>? get logs => _logs;

  /// Ethereum log objects, returned by
  /// Construct from the supplied Map, only check for the keys we need.
  void construct(Map<String, dynamic> data) {
    if (data[EthereumConstants.ethResultKey] == null) {
      return;
    }
    if (data[EthereumConstants.ethResultKey].isNotEmpty) {
      if (data[EthereumConstants.ethResultKey][0] is String) {
        // Hashes
        _hashes = EthereumData.toList(data[EthereumConstants.ethResultKey]);
      } else {
        // Logs
        _logs = <EthereumLog>[];
        for (final Map<String, dynamic> log
            in data[EthereumConstants.ethResultKey]) {
          final buildLog = <String, dynamic>{
            EthereumConstants.ethResultKey: log
          };
          final entry = EthereumLog.fromMap(buildLog);
          _logs!.add(entry);
        }
      }
    }
  }
}
