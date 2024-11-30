/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/011/2017
 * Copyright :  S.Hamblett
 *
 * An instance of Ethereum specialised for use in the browser.
 */

library;

import 'dart:async';
import 'dart:convert';
import 'ethereum.dart';

import 'package:web/web.dart';
import 'package:http/browser_client.dart';
part 'src/adapters/ethereum_browser_http_adapter.dart';

/// The browser HTTP client
class EthereumBrowserHTTPClient extends Ethereum {
  /// Construction
  EthereumBrowserHTTPClient() : super(browserHttpAdapter);

  /// With connection parameters
  EthereumBrowserHTTPClient.withConnectionParameters(String hostname,
      [int? port])
      : super.withConnectionParameters(
            browserHttpAdapter, hostname, Ethereum.rpcHttpScheme, port);

  /// The adapter
  static EthereumBrowserHTTPAdapter browserHttpAdapter =
      EthereumBrowserHTTPAdapter();
}
