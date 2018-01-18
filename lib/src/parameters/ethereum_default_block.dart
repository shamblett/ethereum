/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 18/01/2018
 * Copyright :  S.Hamblett
 *
 * The Ethereum client package
 */

part of ethereum;

/// The Default Block parameter.
/// The parameter selections are mutually exclusive.
/// Note that the setters ignore the passed state value and simply set the property to true.
class EthereumDefaultBlock {
  /// Constants
  static const String ethEarliest = "earliest";
  static const String ethLatest = "latest";
  static const String ethPending = "pending";

  /// Latest indicator. Default
  bool _latest = true;

  bool get latest => _latest;

  set latest(bool state) {
    _latest = true;
    _earliest = false;
    _pending = false;
    _blockNumber = null;
  }

  /// Earliest indicator
  bool _earliest = false;

  bool get earliest => _earliest;

  set earliest(bool state) {
    _earliest = true;
    _latest = false;
    _pending = false;
    _blockNumber = null;
  }

  /// Pending indicator
  bool _pending = false;

  bool get pending => _pending;

  set pending(bool state) {
    _pending = true;
    _earliest = false;
    _latest = false;
    _blockNumber = null;
  }

  /// Block number
  int _blockNumber;

  int get blockNumber => _blockNumber;

  set blockNumber(int value) {
    _blockNumber = value;
    _earliest = false;
    _latest = false;
    _pending = false;
  }

  /// Get the selected parameter as a string
  String getSelection() {
    if (_latest) {
      return ethLatest;
    }
    if (_earliest) {
      return ethEarliest;
    }
    if (_pending) {
      return ethPending;
    }
    if (_blockNumber != null) {
      return EthereumUtilities.intToHex(_blockNumber);
    }
  }
}
