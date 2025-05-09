/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 08/01/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of '../../ethereum.dart';

/// Sync status message
class EthereumSyncStatus {
  /// Constructor
  EthereumSyncStatus();

  /// From map
  EthereumSyncStatus.fromMap(Map<String, dynamic> result) {
    construct(result);
  }

  bool _syncing = false;

  /// Syncing indicator, true if syncing
  bool get syncing => _syncing;

  int? _startingBlock;

  /// Starting block, only valid if syncing
  int? get startingBlock => _startingBlock;

  int? _currentBlock;

  /// Current block, only valid if syncing
  int? get currentBlock => _currentBlock;

  int? _highestBlock;

  /// Highest block, only valid if syncing
  int? get highestBlock => _highestBlock;

  /// Construct from the supplied Map, only check for the keys we need.
  void construct(Map<String, dynamic> data) {
    if (data[EthereumConstants.ethResultKey] is! bool) {
      _syncing = true;
      if (data.containsKey('startingBlock')) {
        _startingBlock = EthereumUtilities.hexToInt(data['startingBlock']);
      }
      if (data.containsKey('currentBlock')) {
        _currentBlock = EthereumUtilities.hexToInt(data['currentBlock']);
      }
      if (data.containsKey('highestBlock')) {
        _highestBlock = EthereumUtilities.hexToInt(data['highestBlock']);
      }
    }
  }

  @override
  String toString() {
    var ret =
        'Ethereum Sync Status :'
        '\n'
        '  Syncing : $syncing'
        '\n';
    if (syncing) {
      ret +=
          '  Starting Block : $startingBlock'
          '\n'
          '  Current Block : $currentBlock'
          '\n'
          '  Highest Block : $highestBlock'
          '\n';
    }

    return ret;
  }
}
