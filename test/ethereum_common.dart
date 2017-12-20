/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

import 'dart:typed_data';
import 'package:ethereum/ethereum.dart';
import 'package:json_object_lite/json_object_lite.dart';
import 'package:test/test.dart';
import 'test_configuration.dart';

/// Class to run the common Ethereum API tests
class EthereumCommon {
  static void run(Ethereum client) {
    int id = 0;
    test("Protocol version 1", () async {
      final String version = await client.protocolVersion();
      expect(version, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Protocol Version is $version");
    });
    test("Protocol version 2", () async {
      final String version = await client.protocolVersion();
      expect(version, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Protocol Version is $version");
    });
    test("Client version", () async {
      final String version = await client.clientVersion();
      expect(version, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Client Version is $version");
    });
    test("SHA3", () async {
      final int data = 0x68656c6c6f20776f726c64;
      final int hash = await client.sha3(data);
      expect(hash, isNotNull);
      expect(hash,
          0x47173285a8d7341e5e972fc677286384f802f8ef42a5ec5f03bbfa254cb01fad);
      expect(client.rpcClient.id, ++id);
    });
    test("Net version", () async {
      final String version = await client.netVersion();
      expect(version, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Net Version is $version");
    });
    test("Net listening", () async {
      final bool listening = await client.netListening();
      expect(listening, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Net Listening is $listening");
    });
    test("Net peer count", () async {
      final int count = await client.netPeerCount();
      expect(count, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Net peer count is $count");
    });
    test("Sync status", () async {
      final JsonObjectLite res = await client.syncStatus();
      expect(res, isNotNull);
      expect(client.rpcClient.id, ++id);
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
      final int address = await client.coinbaseAddress();
      expect(client.rpcClient.id, ++id);
      if (address != null) {
        print("Coinbase address is ${EthereumUtilities.intToHex(address)}");
      } else {
        expect(client.lastError.code, -32000);
        expect(client.lastError.message,
            "etherbase address must be explicitly specified");
      }
    });
    test("Mining", () async {
      final bool mining = await client.mining();
      expect(mining, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Mining is $mining");
    });
    test("Hashrate", () async {
      final int rate = await client.hashrate();
      expect(rate, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Hashrate is $rate");
    });
    test("Gas price", () async {
      final int price = await client.gasPrice();
      expect(price, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Gas price is $price");
    });
    test("Accounts", () async {
      final List<int> accounts = await client.accounts();
      expect(accounts, isNotNull);
      final List<String> accountsStr = EthereumUtilities.intToHexList(accounts);
      expect(client.rpcClient.id, ++id);
      if (accounts.length != 0) {
        print("Accounts are $accountsStr");
        expect(accounts[0], TestConfiguration.defaultAccount);
      } else {
        print("There are no accounts");
      }
    });
    test("Block number", () async {
      final int num = await client.blockNumber();
      expect(num, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Block number is $num");
    });
    test("Balance - number", () async {
      final int balance = await client.getBalance(
          0x407d73d8a49eeb85d32cf465507dd71d507100c1, 0);
      expect(balance, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Balance number is $balance");
    });
    test("Balance - latest", () async {
      final int balance = await client.getBalance(
          0x407d73d8a49eeb85d32cf465507dd71d507100c1, Ethereum.ethLatest);
      expect(balance, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Balance latest is $balance");
    });
    test("Balance - earliest", () async {
      final int balance = await client.getBalance(
          0x407d73d8a49eeb85d32cf465507dd71d507100c1, Ethereum.ethEarliest);
      expect(balance, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Balance earliest is $balance");
    });
    test("Balance - pending", () async {
      final int balance = await client.getBalance(
          0x407d73d8a49eeb85d32cf465507dd71d507100c1, Ethereum.ethPending);
      expect(balance, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Balance pending is $balance");
    });
    test("Get storage at - latest", () async {
      final int storage = await client.getStorageAt(
          0x295a70b2de5e3953354a6a8344e616ed314d7251, 0x0, Ethereum.ethLatest);
      expect(storage, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Storage at latest is $storage");
    });
    test("Get storage at - earliest", () async {
      final int storage = await client.getStorageAt(
          0x295a70b2de5e3953354a6a8344e616ed314d7251,
          0x0,
          Ethereum.ethEarliest);
      expect(storage, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Storage at earliest is $storage");
    });
    test("Get storage at - pending", () async {
      final int storage = await client.getStorageAt(
          0x295a70b2de5e3953354a6a8344e616ed314d7251, 0x0, Ethereum.ethPending);
      expect(storage, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Storage at pending is $storage");
    });
    test("Get storage at - block", () async {
      final int storage = await client.getStorageAt(
          0x295a70b2de5e3953354a6a8344e616ed314d7251, 0x0, 0x4b7);
      expect(storage, isNull);
      expect(client.rpcClient.id, ++id);
      print("Storage at block is $storage");
    });
    test("Transaction count - number", () async {
      final int count = await client.getTransactionCount(
          0x407d73d8a49eeb85d32cf465507dd71d507100c1, 0x0);
      expect(count, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Transaction count is $count");
    });
    test("Transaction count - earliest", () async {
      final int count = await client.getTransactionCount(
          0x407d73d8a49eeb85d32cf465507dd71d507100c1, Ethereum.ethEarliest);
      expect(count, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Transaction count  is $count");
    });
    test("Transaction count - pending", () async {
      final int count = await client.getTransactionCount(
          0x407d73d8a49eeb85d32cf465507dd71d507100c1, Ethereum.ethPending);
      expect(count, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Transaction count  is $count");
    });
    test("Transaction count - latest", () async {
      final int count = await client.getTransactionCount(
          0x407d73d8a49eeb85d32cf465507dd71d507100c1, Ethereum.ethLatest);
      expect(count, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Transaction count  is $count");
    });
    test("Block transaction count by hash", () async {
      final int count = await client.getBlockTransactionCountByHash(
          0xb903239f8543d04b5dc1ba6579132b143087c68db1b2168786408fcbce568238);
      expect(count, 0);
      expect(client.rpcClient.id, ++id);
    });
    test("Block transaction count by number - number", () async {
      final int count = await client.getBlockTransactionCountByNumber(0xe8);
      expect(count, isNotNull);
      expect(client.rpcClient.id, ++id);
    });
    test("Block transaction count by number - latest", () async {
      final int count =
      await client.getBlockTransactionCountByNumber(Ethereum.ethLatest);
      expect(count, isNotNull);
      expect(client.rpcClient.id, ++id);
    });
    test("Block transaction count by number - pending", () async {
      final int count =
      await client.getBlockTransactionCountByNumber(Ethereum.ethPending);
      expect(count, isNotNull);
      expect(client.rpcClient.id, ++id);
    });
    test("Block transaction count by number - earliest", () async {
      final int count =
      await client.getBlockTransactionCountByNumber(Ethereum.ethEarliest);
      expect(count, isNotNull);
      expect(client.rpcClient.id, ++id);
    });
    test("Block uncle count by hash", () async {
      final int count = await client.getUncleCountByHash(
          0xb903239f8543d04b5dc1ba6579132b143087c68db1b2168786408fcbce568238);
      expect(count, 0);
      expect(client.rpcClient.id, ++id);
    });
    test("Uncle count by number - number", () async {
      final int count = await client.getUncleCountByNumber(0xe8);
      expect(count, isNotNull);
      expect(client.rpcClient.id, ++id);
    });
    test("Block uncle count by number - latest", () async {
      final int count = await client.getUncleCountByNumber(Ethereum.ethLatest);
      expect(count, isNotNull);
      expect(client.rpcClient.id, ++id);
    });
    test("Block uncle count by number - pending", () async {
      final int count = await client.getUncleCountByNumber(Ethereum.ethPending);
      expect(count, isNotNull);
      expect(client.rpcClient.id, ++id);
    });
    test("Block uncle count by number - earliest", () async {
      final int count =
      await client.getUncleCountByNumber(Ethereum.ethEarliest);
      expect(count, isNotNull);
      expect(client.rpcClient.id, ++id);
    });
    test("Code - address", () async {
      final int code =
      await client.getCode(0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b, 0);
      expect(code, isNull);
      expect(client.rpcClient.id, ++id);
      print("Code is $code");
    });
    test("Code - latest", () async {
      final int code = await client.getCode(
          0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b, Ethereum.ethLatest);
      expect(code, isNull);
      expect(client.rpcClient.id, ++id);
      print("Code is $code");
    });
    test("Code - pending", () async {
      final int code = await client.getCode(
          0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b, Ethereum.ethPending);
      expect(code, isNull);
      expect(client.rpcClient.id, ++id);
      print("Code is $code");
    });
    test("Code - earliest", () async {
      final int code = await client.getCode(
          0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b, Ethereum.ethEarliest);
      expect(code, isNull);
      expect(client.rpcClient.id, ++id);
      print("Code is $code");
    });
    test("Sign", () async {
      final int signature =
      await client.sign(TestConfiguration.defaultAccount, 0xdeadbeaf);
      if (signature != null) {
        print(signature);
      } else {
        print("You must unlock your account for this method to work");
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Send transaction", () async {
      final int hash = await client.sendTransaction(
          TestConfiguration.defaultAccount,
          0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675,
          to: 0xd46e8dd67c5d32be8058bb8eb970870f07244567,
          gas: 0x100,
          gasPrice: 0x1000,
          value: 0x2000,
          nonce: 2);
      if (hash != null) {
        print(hash);
      }
      expect(client.rpcClient.id, ++id);
      expect(client.lastError.id, id);
    });
    test("Send transaction - some null", () async {
      final int hash = await client.sendTransaction(
          TestConfiguration.defaultAccount,
          0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675,
          to: 0xd46e8dd67c5d32be8058bb8eb970870f07244567,
          nonce: 2);
      if (hash != null) {
        print(hash);
      }
      expect(client.rpcClient.id, ++id);
      expect(client.lastError.id, id);
    });
    test("Send raw transaction", () async {
      final int hash = await client.sendRawTransaction(
          0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675);
      if (hash != null) {
        print(hash);
      }
      expect(client.rpcClient.id, ++id);
      expect(client.lastError.id, id);
    });
    test("Call ", () async {
      final int ret = await client.call(TestConfiguration.defaultAccount, 0x10,
          from: 0xd10de988e845d33859c3f96c7f1fc723b7b56f4c,
          gas: 0x2000,
          gasPrice: 0x1000,
          value: 0x2000,
          data:
          0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Call - some null", () async {
      final int ret = await client.call(
          TestConfiguration.defaultAccount, "latest",
          from: 0xd10de988e845d33859c3f96c7f1fc723b7b56f4c,
          gasPrice: 0x1000,
          data:
          0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Estimate gas", () async {
      final int ret = await client.estimateGas(
          address: TestConfiguration.defaultAccount,
          from: 0xd10de988e845d33859c3f96c7f1fc723b7b56f4c,
          gas: 0x2000,
          gasPrice: 0x1000,
          value: 0x2000,
          data:
          0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Estimate gas - some null", () async {
      final int ret = await client.estimateGas(
          address: TestConfiguration.defaultAccount,
          from: 0xd10de988e845d33859c3f96c7f1fc723b7b56f4c,
          gas: 0x2000,
          gasPrice: 0x1000);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get block by hash", () async {
      final JsonObjectLite ret = await client.getBlockByHash(
          0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get block by number", () async {
      final JsonObjectLite ret = await client.getBlockByNumber(0x01);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get transaction by hash", () async {
      final JsonObjectLite ret = await client.getTransactionByHash(
          0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get transaction by block hash and index", () async {
      final JsonObjectLite ret = await client.getTransactionByBlockHashAndIndex(
          0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8,
          0);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get transaction by block number and index", () async {
      final JsonObjectLite ret =
      await client.getTransactionByBlockNumberAndIndex(0x100, 0);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get transaction receipt", () async {
      final JsonObjectLite ret = await client.getTransactionReceipt(
          0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get uncle by block hash and index", () async {
      final JsonObjectLite ret = await client.getUncleByBlockHashAndIndex(
          0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8,
          0);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get uncle by block number and index", () async {
      final JsonObjectLite ret =
      await client.getUncleByBlockNumberAndIndex(0x100, 0);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    int filterId = 0;
    test("New filter", () async {
      filterId = await client.newFilter(
          fromBlock: 0x1,
          toBlock: 0x2,
          address: 0x8888f1f195afa192cfee860698584c030f4c9db1,
          topics: [
            "0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b",
            null,
            [
              "0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b",
              "0x 0000000000000000000000000aff3454fce5edbc8cca8697c15331677e6ebccc"
            ]
          ]);
      if (filterId != null) {
        print(filterId);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("New block filter", () async {
      final int filterId = await client.newBlockFilter();
      if (filterId != null) {
        print(filterId);
      }
      expect(client.rpcClient.id, ++id);
    });
    int pendFilterId = 0;
    test("New pending transaction filter", () async {
      pendFilterId = await client.newPendingTransactionFilter();
      if (filterId != null) {
        print(filterId);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Uninstall filter", () async {
      final bool res = await client.uninstallFilter(pendFilterId);
      expect(res, isTrue);
      expect(client.rpcClient.id, ++id);
    });
    test("Get filter changes", () async {
      final dynamic ret = await client.getFilterChanges(filterId);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get filter logs", () async {
      final dynamic ret = await client.getFilterLogs(filterId);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get logs", () async {
      final List ret = await client.getLogs(topics: [
        "0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b"
      ]);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get work", () async {
      final List ret = await client.getWork();
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Submit work", () async {
      final bool ret = await client.submitWork(
          0x1,
          0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef,
          0xD1FE5700000000000000000000000000D1FE5700000000000000000000000000);
      expect(ret, isFalse);
      expect(client.rpcClient.id, ++id);
    });
  }
}
