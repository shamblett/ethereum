/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

import 'package:ethereum/ethereum.dart';
import 'package:bignum/bignum.dart';
import 'package:test/test.dart';
import 'ethereum_test_configuration.dart';

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
      final BigInteger data = new BigInteger(0x68656c6c6f20776f726c64);
      final BigInteger hash = await client.sha3(data);
      expect(hash, isNotNull);
      print(hash);
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
      final EthereumSyncStatus res = await client.syncStatus();
      expect(res, isNotNull);
      expect(client.rpcClient.id, ++id);
      if (res.syncing) {
        print("Sync status is syncing");
        print("Starting Block is ${res.startingBlock}");
        print("Current Block is ${res.currentBlock}");
        print("Highest Block is ${res.highestBlock}");
      } else {
        print("Sync status is not syncing");
      }
    });
    test("Coinbase address", () async {
      final BigInteger address = await client.coinbaseAddress();
      expect(client.rpcClient.id, ++id);
      if (address != null) {
        print("Coinbase address is $address");
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
      final List<BigInteger> accounts = await client.accounts();
      expect(accounts, isNotNull);
      final List<String> accountsStr =
      EthereumUtilities.bigIntegerToHexList(accounts);
      expect(client.rpcClient.id, ++id);
      if (accounts.length != 0) {
        print("Accounts are $accountsStr");
        expect(
            accounts[0].intValue(), EthereumTestConfiguration.defaultAccount);
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
          new BigInteger(0x407d73d8a49eeb85d32cf465507dd71d507100c1), 0);
      expect(balance, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Balance number is $balance");
    });
    test("Balance - latest", () async {
      final int balance = await client.getBalance(
          new BigInteger(0x407d73d8a49eeb85d32cf465507dd71d507100c1),
          Ethereum.ethLatest);
      expect(balance, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Balance latest is $balance");
    });
    test("Balance - earliest", () async {
      final int balance = await client.getBalance(
          new BigInteger(0x407d73d8a49eeb85d32cf465507dd71d507100c1),
          Ethereum.ethEarliest);
      expect(balance, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Balance earliest is $balance");
    });
    test("Balance - pending", () async {
      final int balance = await client.getBalance(
          new BigInteger(0x407d73d8a49eeb85d32cf465507dd71d507100c1),
          Ethereum.ethPending);
      expect(balance, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Balance pending is $balance");
    });
    test("Get storage at - latest", () async {
      final BigInteger storage = await client.getStorageAt(
          new BigInteger(0x295a70b2de5e3953354a6a8344e616ed314d7251),
          0x0,
          Ethereum.ethLatest);
      expect(storage, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Storage at latest is $storage");
    });
    test("Get storage at - earliest", () async {
      final BigInteger storage = await client.getStorageAt(
          new BigInteger(0x295a70b2de5e3953354a6a8344e616ed314d7251),
          0x0,
          Ethereum.ethEarliest);
      expect(storage, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Storage at earliest is $storage");
    });
    test("Get storage at - pending", () async {
      final BigInteger storage = await client.getStorageAt(
          new BigInteger(0x295a70b2de5e3953354a6a8344e616ed314d7251),
          0x0,
          Ethereum.ethPending);
      expect(storage, isNotNull);
      expect(client.rpcClient.id, ++id);
      print("Storage at pending is $storage");
    });
    test("Get storage at - block", () async {
      final BigInteger storage = await client.getStorageAt(
          new BigInteger(0x295a70b2de5e3953354a6a8344e616ed314d7251),
          0x0,
          0x4b7);
      expect(storage.intValue(), 0);
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
      final int signature = await client.sign(
          EthereumTestConfiguration.defaultAccount, 0xdeadbeaf);
      if (signature != null) {
        print(signature);
      } else {
        print("You must unlock your account for this method to work");
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Send transaction", () async {
      final int hash = await client.sendTransaction(
          EthereumTestConfiguration.defaultAccount,
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
          EthereumTestConfiguration.defaultAccount,
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
      final int ret = await client.call(
          EthereumTestConfiguration.defaultAccount, 0x10,
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
          EthereumTestConfiguration.defaultAccount, "latest",
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
          address: EthereumTestConfiguration.defaultAccount,
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
          address: EthereumTestConfiguration.defaultAccount,
          from: 0xd10de988e845d33859c3f96c7f1fc723b7b56f4c,
          gas: 0x2000,
          gasPrice: 0x1000);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get block by hash", () async {
      final EthereumBlock ret = await client.getBlockByHash(new BigInteger(
          0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8));
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get block by number", () async {
      final EthereumBlock ret = await client.getBlockByNumber(0x01);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get transaction by hash", () async {
      final EthereumTransaction ret = await client.getTransactionByHash(
          new BigInteger(
              0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8));
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get transaction by block hash and index", () async {
      final EthereumTransaction ret =
      await client.getTransactionByBlockHashAndIndex(
          new BigInteger(
              0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8),
          0);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get transaction by block number and index", () async {
      final EthereumTransaction ret =
      await client.getTransactionByBlockNumberAndIndex(0x100, 0);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get transaction receipt", () async {
      final EthereumTransactionReceipt ret = await client.getTransactionReceipt(
          new BigInteger(
              0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8));
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get uncle by block hash and index", () async {
      final EthereumBlock ret = await client.getUncleByBlockHashAndIndex(
          new BigInteger(
              0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8),
          0);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get uncle by block number and index", () async {
      final EthereumBlock ret =
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
          address: new BigInteger(0x8888f1f195afa192cfee860698584c030f4c9db1),
          topics: [
            new BigInteger(
                0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b),
            new BigInteger(
                0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b)
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
      expect(res, isNotNull);
      expect(client.rpcClient.id, ++id);
    });
    test("Get filter changes", () async {
      final dynamic ret = await client.getFilterChanges(0);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get filter logs", () async {
      final dynamic ret = await client.getFilterLogs(0);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get logs", () async {
      final EthereumFilter ret = await client.getLogs(topics: [
        new BigInteger(
            0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b)
      ]);
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Get work", () async {
      final EthereumWork ret = await client.getWork();
      if (ret != null) {
        print(ret);
      }
      expect(client.rpcClient.id, ++id);
    });
    test("Submit work", () async {
      final bool ret = await client.submitWork(
          new BigInteger(0x123456789abcdef0),
          new BigInteger(
              0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef),
          new BigInteger(
              0xD1FE5700000000000000000000000000D1FE5700000000000000000000000000));
      expect(ret, isFalse);
      expect(client.rpcClient.id, ++id);
    });
    test("Submit hash rate", () async {
      final bool ret = await client.submitHashrate(new BigInteger(0x500000),
          "0x59daa26581d0acd1fce254fb7e85952f4c09d0915afd33d3886cd914bc7d283c");
      expect(ret, isTrue);
      expect(client.rpcClient.id, ++id);
    });
    test("SHH version", () async {
      final String version = await client.shhVersion();
      expect(version, isNotNull);
      expect(version, "5.0");
      print("SHH version is $version");
      expect(client.rpcClient.id, ++id);
    });
    test("SHH post", () async {
      final bool ret = await client.shhPost([
        new BigInteger(0x776869737065722d636861742d636c69656e74),
        new BigInteger(0x4d5a695276454c39425154466b61693532)
      ], new BigInteger(0x7b2274797065223a226d60), 0x64, 0x64,
          to: new BigInteger(
              0x3e245533f97284d442460f2998cd41858798ddf04f96a5e25610293e42a73908e93ccc8c4d4dc0edcfa9fa872f50cb214e08ebf61a0d4d661997d3940272b717b1),
          from: new BigInteger(
              0x04f96a5e25610293e42a73908e93ccc8c4d4dc0edcfa9fa872f50cb214e08ebf61a03e245533f97284d442460f2998cd41858798ddfd4d661997d3940272b717b1));
      expect(ret, isNull);
      expect(client.rpcClient.id, ++id);
    });
  }
}
