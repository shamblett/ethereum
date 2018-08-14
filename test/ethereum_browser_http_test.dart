/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

@TestOn("browser")
import 'package:ethereum/ethereum_browser_http_client.dart';
import 'package:test/test.dart';
import 'ethereum_common.dart';
import 'ethereum_test_configuration.dart';

void main() {
  if (EthereumTestConfiguration.runBrowserHttp) {
    // Run the common API tests
    final EthereumBrowserHTTPClient client =
    EthereumBrowserHTTPClient.withConnectionParameters("localhost");
    // Print errors
    client.printError = true;
    EthereumCommon.run(client);
  } else {
    print("HTTP browser tests not selected");
  }
}
