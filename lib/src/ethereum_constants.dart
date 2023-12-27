/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 08/012/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of '../ethereum.dart';

/// Package wide constants
class EthereumConstants {
  /// Result key
  static const String ethResultKey = 'result';

  /// Error key
  static const String ethErrorKey = 'error';

  /// The leading hex indicator
  static const String leadingHexString = '0x';
}
