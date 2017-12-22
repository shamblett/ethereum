/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/011/2017
 * Copyright :  S.Hamblett
 *
 * An instance of Ethereum specialised for use in the browser.
 */

library ethereum_browser_ws_client;

import 'dart:html';
import 'dart:async';
import 'package:ethereum/ethereum.dart';
import 'package:json_object_lite/json_object_lite.dart';

part 'src/adapters/ethereum_browser_ws_adapter.dart';

class EthereumBrowserWSClient extends Ethereum {
  static EthereumBrowserWSAdapter browserWSAdapter =
      new EthereumBrowserWSAdapter();

  EthereumBrowserWSClient() : super(browserWSAdapter);

  EthereumBrowserWSClient.withConnectionParameters(hostname, [port])
      : super.withConnectionParameters(
      browserWSAdapter, hostname, Ethereum.rpcWsScheme, port);
}
