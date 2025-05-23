/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 08/012/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of '../ethereum.dart';

/// Manages Ethereum client errors
class EthereumError {
  /// No error
  static const String noError = 'No Error';

  /// No transaction id
  static const int noId = -1;

  int? _code = 0;

  int _id = noId;

  DateTime? _timestamp;

  String? _message = noError;

  /// Error message
  String? get message => _message;

  /// Error code
  int? get code => _code;

  /// Error transaction id
  int get id => _id;

  /// Error timestamp
  DateTime? get timestamp => _timestamp;

  /// Constructor
  EthereumError();

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
