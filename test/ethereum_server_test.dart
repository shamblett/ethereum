/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

@TestOn('vm')
import 'package:ethereum/ethereum_server_client.dart';
import 'package:test/test.dart';
import 'ethereum_common.dart';
import 'ethereum_test_configuration.dart';

void main() {
  if (EthereumTestConfiguration.runServer) {
    // Run the common API tests
    final EthereumServerClient client =
        EthereumServerClient.withConnectionParameters('localhost');
    // Print errors
    client.printError = true;
    EthereumCommon.run(client);
  } else {
    print('Server tests not selected in configuration file');
  }
}
