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
  EthereumError();

  /// Error code
  int _code = 0;

  int get code => _code;

  /// Error message
  String _message = "No Error";

  String get message => _message;

  /// Error transaction id
  int _id = -1;

  int get id => _id;

  /// Error timestamp
  DateTime _timestamp;

  DateTime get timestamp => _timestamp;

  void updateError(int errorCode, String errorMessage, int errorId) {
    _code = errorCode;
    _message = errorMessage;
    _id = errorId;
    _timestamp = new DateTime.now();
  }

  String toString() {
    return "Code : $_code Message : $_message Id : $_id";
  }
}
