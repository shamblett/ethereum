/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

import 'package:ethereum/ethereum.dart';
import 'package:json_object_lite/json_object_lite.dart';
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
    test("Net version", () async {
      final String version = await client.netVersion();
      expect(version, isNotNull);
      expect(client.rpcClient.id, 5);
      print("Net Version is $version");
    });
    test("Net listening", () async {
      final bool listening = await client.netListening();
      expect(listening, isNotNull);
      expect(client.rpcClient.id, 6);
      print("Net Listening is $listening");
    });
    test("Net peer count", () async {
      final int count = await client.netPeerCount();
      expect(count, isNotNull);
      expect(client.rpcClient.id, 7);
      print("Net peer count is $count");
    });
    test("Sync status", () async {
      final JsonObjectLite res = await client.ethSyncing();
      expect(res, isNotNull);
      expect(client.rpcClient.id, 8);
      if (res.syncStatus) {
        print("Sync status is syncing");
        print("Starting Block is ${res.startingBlock}");
        print("Current Block is ${res.currentBlock}");
        print("Highest Block is ${res.highestBlock}");
      } else {
        print("Sync status is not syncing");
      }
    });
    test("Coinbase address", () async {
      final String address = await client.coinbaseAddress();
      expect(client.rpcClient.id, 9);
      if (address != null) {
        print("Coinbase address is $address");
      } else {
        expect(client.lastErrorCode, -32000);
        expect(client.lastErrorMessage,
            "etherbase address must be explicitly specified");
      }
    });
    test("Mining", () async {
      final bool mining = await client.mining();
      expect(mining, isNotNull);
      expect(client.rpcClient.id, 10);
      print("Mining is $mining");
    });
    test("Hashrate", () async {
      final String rate = await client.hashrate();
      expect(rate, isNotNull);
      expect(client.rpcClient.id, 11);
      print("Hashrate is $rate");
    });
  }
}
