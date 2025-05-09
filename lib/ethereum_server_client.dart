/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/011/2017
 * Copyright :  S.Hamblett
 *
 * An instance of Ethereum specialised for use in the server.
 */

library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'ethereum.dart';

part 'src/adapters/ethereum_server_http_adapter.dart';

/// The server HTTP client
class EthereumServerClient extends Ethereum {
  /// Default constructor
  EthereumServerClient() : super(serverHttpAdapter);

  /// With connection parameters
  EthereumServerClient.withConnectionParameters(String hostname, [int? port])
    : super.withConnectionParameters(
        serverHttpAdapter,
        hostname,
        Ethereum.rpcHttpScheme,
        port,
      );

  /// The adapter
  static EthereumServerHTTPAdapter serverHttpAdapter =
      EthereumServerHTTPAdapter();
}
