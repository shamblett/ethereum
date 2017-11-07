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
import 'package:ethereum/ethereum.dart';
import 'package:ethereum/ethereum_connector_mixin.dart';

class EthereumServerClient extends Ethereum implements EthereumConnectorMixin {

  EthereumServerClient() :super();

  /// Overridden internal connect
  void _connect() {

  }
}