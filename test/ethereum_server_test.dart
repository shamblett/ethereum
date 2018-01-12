/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

@TestOn("vm")
import 'package:ethereum/ethereum_server_client.dart';
import 'package:test/test.dart';
import 'ethereum_common.dart';
import 'ethereum_test_configuration.dart';
import 'dart:io';

/// Don't run server tests on Travis
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
    if (EthereumTestConfiguration.runServer) {
      // Run the common API tests
      final EthereumServerClient client =
      new EthereumServerClient.withConnectionParameters("localhost");
      // Print errors
      client.printError = true;
      EthereumCommon.run(client);
    } else {
      print("Server tests not selected");
    }
  } else {
    print("On Travis - skipping");
  }
}
