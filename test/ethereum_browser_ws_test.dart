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

// ignore_for_file: omit_local_variable_types
// ignore_for_file: unnecessary_final
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: avoid_catching_errors
// ignore_for_file: avoid_print
// ignore_for_file: cascade_invocations

void main() {
  if (EthereumTestConfiguration.runBrowserWS) {
    // Run the common API tests
    final EthereumBrowserWSClient client =
        EthereumBrowserWSClient.withConnectionParameters('localhost', 8546);
    // Print errors
    client.printError = true;
    EthereumCommon.run(client);
  } else {
    print('WS browser tests not selected in configuration file');
  }
}
