/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

import 'dart:async';
import 'package:ethereum/ethereum_server_client.dart';

/// Example client usage.
/// Please refer to https://github.com/ethereum/wiki/wiki/JSON-RPC for further details of ports etc.
/// Also see the ethereum_test_configuration.dart file for details on
/// how to run geth.
FutureOr<void> main() async {
  // Create a client using default parameters
  final client = EthereumServerClient.withConnectionParameters('localhost');

  // Or, with a specified port for WS working in the browser
  // new EthereumBrowserWSClient.withConnectionParameters('localhost', 8546);

  // Turn on error printing if needed.
  client.printError = true;

  // Make an API call, the client is stateless form a connection point of view.
  // Note that API methods are grouped under the logical ethereum rpc
  // namespace they belong to.
  final version = await client.eth.protocolVersion();

  // Check for an error if you think anything is wrong.
  // Methods that should return a value return null on failure,
  // methods that do not return a value from the RPC call return
  // true on success and false on failure.
  if (version == null) {
    print('We have errored -> ${client.lastError}');
  } else {
    print('We are OK -> ${client.lastError}');
  }

  // The transaction id increments every time, first call sets it to one
  print('Transaction Id is -->  ${client.rpcClient.id}');

  // You can have as many clients as you wish, this has its own transaction id
  final client2 = EthereumServerClient.withConnectionParameters('localhost');

  client2.printError = true;
}
