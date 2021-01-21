/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 08/012/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of ethereum;

/// Manages Ethereum client errors
class EthereumError {
  /// Constructor
  EthereumError();

  /// No error
  static const String noError = 'No Error';

  /// No transaction id
  static const int noId = -1;

  int? _code = 0;

  /// Error code
  int? get code => _code;

  String? _message = noError;

  /// Error message
  String? get message => _message;

  int _id = noId;

  /// Error transaction id
  int get id => _id;

  DateTime? _timestamp;

  /// Error timestamp
  DateTime? get timestamp => _timestamp;

  /// Update the error details
  void updateError(int? errorCode, String? errorMessage, int errorId) {
    _code = errorCode;
    _message = errorMessage;
    _id = errorId;
    _timestamp = DateTime.now();
  }

  @override
  String toString() => 'Code : $_code <> Message : $_message <> Id : $_id';
}
