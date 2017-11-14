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
    test("Gas price", () async {
      final String price = await client.gasPrice();
      expect(price, isNotNull);
      expect(client.rpcClient.id, 12);
      print("Gas price is $price");
    });
    test("Accounts", () async {
      final List<String> accounts = await client.accounts();
      expect(accounts, isNotNull);
      expect(client.rpcClient.id, 13);
      if (accounts.length != 0) {
        print("Accounts are $accounts");
      } else {
        print("There are no accounts");
      }
    });
    test("Block number", () async {
      final String num = await client.blockNumber();
      expect(num, isNotNull);
      expect(client.rpcClient.id, 14);
      print("Block number is $num");
    });
    test("Balance - number", () async {
      final String balance = await client.getBalance(
          "0x407d73d8a49eeb85d32cf465507dd71d507100c1", "0x0");
      expect(balance, isNotNull);
      expect(client.rpcClient.id, 15);
      print("Balance number is $balance");
    });
    test("Balance - latest", () async {
      final String balance = await client.getBalance(
          "0x407d73d8a49eeb85d32cf465507dd71d507100c1", Ethereum.ethLatest);
      expect(balance, isNotNull);
      expect(client.rpcClient.id, 16);
      print("Balance latest is $balance");
    });
    test("Balance - earliest", () async {
      final String balance = await client.getBalance(
          "0x407d73d8a49eeb85d32cf465507dd71d507100c1", Ethereum.ethEarliest);
      expect(balance, isNotNull);
      expect(client.rpcClient.id, 17);
      print("Balance earliest is $balance");
    });
    test("Balance - pending", () async {
      final String balance = await client.getBalance(
          "0x407d73d8a49eeb85d32cf465507dd71d507100c1", Ethereum.ethPending);
      expect(balance, isNotNull);
      expect(client.rpcClient.id, 18);
      print("Balance pending is $balance");
    });
    test("Get storage at - latest", () async {
      final String storage = await client.getStorageAt(
          "0x295a70b2de5e3953354a6a8344e616ed314d7251",
          "0x0",
          Ethereum.ethLatest);
      expect(storage, isNotNull);
      expect(client.rpcClient.id, 19);
      print("Storage at latest is $storage");
    });
    test("Get storage at - earliest", () async {
      final String storage = await client.getStorageAt(
          "0x295a70b2de5e3953354a6a8344e616ed314d7251",
          "0x0",
          Ethereum.ethEarliest);
      expect(storage, isNotNull);
      expect(client.rpcClient.id, 20);
      print("Storage at earliest is $storage");
    });
    test("Get storage at - pending", () async {
      final String storage = await client.getStorageAt(
          "0x295a70b2de5e3953354a6a8344e616ed314d7251",
          "0x0",
          Ethereum.ethPending);
      expect(storage, isNotNull);
      expect(client.rpcClient.id, 21);
      print("Storage at pending is $storage");
    });
    test("Get storage at - block", () async {
      final String storage = await client.getStorageAt(
          "0x295a70b2de5e3953354a6a8344e616ed314d7251", "0x0", "0x4b7");
      expect(storage, isNotNull);
      expect(client.rpcClient.id, 22);
      print("Storage at block is $storage");
    });
  }
}
