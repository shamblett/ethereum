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

void main() {
  // Run the common API tests
  final EthereumServerClient client =
  new EthereumServerClient.withConnectionParameters("localhost");
  EthereumCommon.run(client);
}
