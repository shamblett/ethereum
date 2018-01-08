/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 08/01/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of ethereum;

/// Sync status return message
class EthereumSyncStatus {
  EthereumSyncStatus();

  EthereumSyncStatus.fromMap(Map result) {
    convert(result);
  }

  /// Syncing indicator, true if syncing
  bool _syncing = false;

  bool get syncing => _syncing;

  /// Starting block, only valid if syncing
  int _startingBlock;

  int get startingBlock => _startingBlock;

  /// Current block, only valid if syncing
  int _currentBlock;

  int get currentBlock => _currentBlock;

  /// Highest block, only valid if syncing
  int _highestBlock;

  int get highestBlock => _highestBlock;

  /// Convert from the supplied Map, only check for the keys we need.
  void convert(Map data) {
    if ((data[ethResultKey] is bool) && (data[ethResultKey])) {
      _syncing = true;
      Map resultBlock = data[ethResultKey];
      if (resultBlock.containsKey('startingBlock')) {
        _startingBlock =
            EthereumUtilities.hexToInt(resultBlock['startingBlock']);
      }
      if (resultBlock.containsKey('currentBlock')) {
        _currentBlock = EthereumUtilities.hexToInt(resultBlock['currentBlock']);
      }
      if (resultBlock.containsKey('highestBlock')) {
        _highestBlock = EthereumUtilities.hexToInt(resultBlock['highestBlock']);
      }
    }
  }
}
