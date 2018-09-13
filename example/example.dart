/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

import 'dart:async';
import 'package:ethereum/ethereum_server_client.dart';

/// Example client usage
/// Please refer to https://github.com/ethereum/wiki/wiki/JSON-RPC for further details of ports etc.

Future main() async {
  // Create a client using default parameters
  final EthereumServerClient client =
      new EthereumServerClient.withConnectionParameters("localhost");

  // Or, with a specified port for WS working in the browser
  // new EthereumBrowserWSClient.withConnectionParameters("localhost", 8546);

  // Turn on error printing if needed.
  client.printError = true;

  // Make an API call, the client is stateless form a connection point of view.
  final String version = await client.eth.protocolVersion();

  // Check for an error if you think anything is wrong
  if (version == null) {
    print("We have errored -> ${client.lastError}");
  } else {
    print("We are OK -> ${client.lastError}");
  }

  // The transaction id increments every time, first call sets it to one
  print("Transaction Id is -->  ${client.rpcClient.id}");

  // You can have as many clients as you wish, this has its own transaction id
  final EthereumServerClient client2 =
      new EthereumServerClient.withConnectionParameters("localhost");

  client2.printError = true;
}
