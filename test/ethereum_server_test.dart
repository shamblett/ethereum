/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

@TestOn("vm")
import 'package:ethereum/ethereum_server_client.dart';
import 'package:test/test.dart';

void main() {
  group("API tests", () {
    test("Normal connect", () async {
      final EthereumServerClient client = new EthereumServerClient();
      client.connectParameters("localhost");
      await client.connect();
      expect(client.connected, isTrue);
      expect(client.isClosed, isFalse);
      //TODO run common tests here
      await client.close();
      expect(client.connected, isFalse);
      expect(client.isClosed, isTrue);
    });
  });
}
