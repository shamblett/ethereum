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
import 'dart:js_interop';
import 'ethereum.dart';

import 'package:web/web.dart';

part 'src/adapters/ethereum_browser_ws_adapter.dart';

/// The browser web socket client
class EthereumBrowserWSClient extends Ethereum {
  /// Default construction
  EthereumBrowserWSClient() : super(browserWSAdapter);

  /// With connection parameters
  EthereumBrowserWSClient.withConnectionParameters(String hostname, [int? port])
    : super.withConnectionParameters(
        browserWSAdapter,
        hostname,
        Ethereum.rpcWsScheme,
        port,
      );

  /// The adapter
  static EthereumBrowserWSAdapter browserWSAdapter = EthereumBrowserWSAdapter();
}
