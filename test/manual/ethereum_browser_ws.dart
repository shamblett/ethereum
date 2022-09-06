/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

@TestOn('browser')
import 'package:ethereum/ethereum_browser_ws_client.dart';
import 'package:test/test.dart';
import 'ethereum_common.dart';
import 'ethereum_test_configuration.dart';
import 'ethereum_test_utilities.dart';

void main() {
  if (EthereumTestConfiguration.runBrowserWS) {
    // Run the common API tests
    final client =
        EthereumBrowserWSClient.withConnectionParameters('localhost', 8546);
    // Print errors
    client.printError = true;
    EthereumTestUtilities.browserWsTestsRunning = true;
    EthereumCommon.run(client);
  } else {
    print('WS browser tests not selected in configuration file');
  }
}
