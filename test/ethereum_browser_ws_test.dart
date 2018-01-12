/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

@TestOn("browser")
import 'package:ethereum/ethereum_browser_ws_client.dart';
import 'package:test/test.dart';
import 'ethereum_common.dart';
import 'ethereum_test_configuration.dart';
import 'dart:io';

/// Don't run browser tests on Travis
bool skipIfTravis() {
  bool ret = false;
  final Map<String, String> envVars = Platform.environment;
  if (envVars['TRAVIS'] == 'true') {
    // Skip
    ret = true;
  }
  return ret;
}

void main() {
  if (!skipIfTravis()) {
    if (EthereumTestConfiguration.runBrowserWS) {
      // Run the common API tests
      final EthereumBrowserWSClient client =
      new EthereumBrowserWSClient.withConnectionParameters(
          "localhost", 8546);
      // Print errors
      client.printError = true;
      EthereumCommon.run(client);
    } else {
      print("WS browser tests not selected");
    }
  } else {
    print("On Travis - skipping");
  }
}
