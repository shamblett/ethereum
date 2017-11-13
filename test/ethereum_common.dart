/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

import 'package:ethereum/ethereum.dart';
import 'package:test/test.dart';

/// Class to run the common Ethereum API tests
class EthereumCommon {
  static void run(Ethereum client) {
    test("Protocol version 1", () async {
      final String version = await client.protocolVersion();
      expect(version, isNotNull);
      expect(client.rpcClient.id, 1);
      print("Protocol Version is $version");
    });
    test("Protocol version 2", () async {
      final String version = await client.protocolVersion();
      expect(version, isNotNull);
      expect(client.rpcClient.id, 2);
      print("Protocol Version is $version");
    });
    test("Client version", () async {
      final String version = await client.clientVersion();
      expect(version, isNotNull);
      expect(client.rpcClient.id, 3);
      print("Client Version is $version");
    });
    test("SHA3", () async {
      final String hexString = "0x68656c6c6f20776f726c64";
      final String hash = await client.sha3(hexString);
      expect(hash, isNotNull);
      expect(hash,
          "0x47173285a8d7341e5e972fc677286384f802f8ef42a5ec5f03bbfa254cb01fad");
      expect(client.rpcClient.id, 4);
    });
  }
}
