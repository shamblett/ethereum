/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

@TestOn("browser")
import 'package:ethereum/ethereum_browser_http_client.dart';
import 'package:ethereum/ethereum.dart';
import 'package:test/test.dart';
import 'ethereum_common.dart';

void main() {
  // Run the common API tests
  final EthereumBrowserHTTPClient client =
  new EthereumBrowserHTTPClient.withConnectionParameters("localhost");
  // Print errors
  client.printError = true;
  EthereumCommon.run(client);
}
