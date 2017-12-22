/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/011/2017
 * Copyright :  S.Hamblett
 *
 * An instance of Ethereum specialised for use in the browser.
 */

library ethereum_browser_client;

import 'dart:html';
import 'dart:async';
import 'package:ethereum/ethereum.dart';
import 'package:json_object_lite/json_object_lite.dart';

part 'src/adapters/ethereum_browser_http_adapter.dart';

class EthereumBrowserHTTPClient extends Ethereum {
  static EthereumBrowserHTTPAdapter browserHttpAdapter =
  new EthereumBrowserHTTPAdapter();

  EthereumBrowserHTTPClient() : super(browserHttpAdapter);

  EthereumBrowserHTTPClient.withConnectionParameters(hostname, [port])
      : super.withConnectionParameters(
      browserHttpAdapter, hostname, Ethereum.rpcHttpScheme, port);
}
