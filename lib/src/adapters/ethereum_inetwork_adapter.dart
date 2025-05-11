/*
 * Packge : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 10/011/2017
 * Copyright :  S.Hamblett
 *
 * Provides a common interface for Ethereum to connect over HTTP,
 * allowing for different HTTP adapters to be used.
 */

part of '../../ethereum.dart';

/// Base class for all network adapters
abstract class EthereumINetworkAdapter {
  /// Construction
  EthereumINetworkAdapter();

  /// Processes the HTTP request returning the  HTTP response as
  /// a map
  Future<Map<dynamic, dynamic>> httpRequest(
    Uri uri,
    Map<String, dynamic> request,
  );
}
