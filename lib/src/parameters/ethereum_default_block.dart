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
/// Note that the setters ignore the passed state value and
/// simply set the property to true.
class EthereumDefaultBlock {
  /// Constants
  /// Earliest
  static const String ethEarliest = 'earliest';

  /// Latest
  static const String ethLatest = 'latest';

  /// Pending
  static const String ethPending = 'pending';

  bool _latest = true;

  /// Latest indicator. Default
  bool get latest => _latest;

  set latest(bool state) {
    _latest = true;
    _earliest = false;
    _pending = false;
    _number = null;
  }

  bool _earliest = false;

  /// Earliest indicator
  bool get earliest => _earliest;

  set earliest(bool state) {
    _earliest = true;
    _latest = false;
    _pending = false;
    _number = null;
  }

  bool _pending = false;

  /// Pending indicator
  bool get pending => _pending;

  set pending(bool state) {
    _pending = true;
    _earliest = false;
    _latest = false;
    _number = null;
  }

  int _number;

  /// Block number
  int get number => _number;

  set number(int value) {
    _number = value;
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
    if (_number != null) {
      return EthereumUtilities.intToHex(_number);
    }
    return null;
  }
}
