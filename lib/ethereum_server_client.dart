/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/011/2017
 * Copyright :  S.Hamblett
 *
 * An instance of Ethereum specialised for use in the server.
 */

library ethereum_server_client;

import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:ethereum/ethereum.dart';

part 'src/adapters/ethereum_server_http_adapter.dart';

class EthereumServerClient extends Ethereum {
  static EthereumServerHTTPAdapter serverHttpAdapter =
  new EthereumServerHTTPAdapter();

  EthereumServerClient() : super(serverHttpAdapter);

  EthereumServerClient.withConnectionParameters(hostname, [port])
      : super.withConnectionParameters(
      serverHttpAdapter, hostname, Ethereum.rpcHttpScheme, port);
}
