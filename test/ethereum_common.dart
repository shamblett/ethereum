/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

import 'package:ethereum/ethereum.dart';
import 'package:test/test.dart';
import 'ethereum_test_configuration.dart';

/// Class to run the common Ethereum API tests
class EthereumCommon {
  static void run(Ethereum client) {
    int id = 0;
    group("Dapp", () {
      test("Protocol version 1", () async {
        final String version = await client.dapp.protocolVersion();
        expect(version, isNotNull);
        expect(client.dapp.id, ++id);
        print("Protocol Version is $version");
      });
      test("Protocol version 2", () async {
        final String version = await client.dapp.protocolVersion();
        expect(version, isNotNull);
        expect(client.dapp.id, ++id);
        print("Protocol Version is $version");
      });
      test("Client version", () async {
        final String version = await client.dapp.clientVersion();
        expect(version, isNotNull);
        expect(client.dapp.id, ++id);
        print("Client Version is $version");
      });
      test("SHA3", () async {
        final BigInt data =
        EthereumUtilities.safeParse("0x68656c6c6f20776f726c64");
        final BigInt hash = await client.dapp.sha3(data);
        expect(hash, isNotNull);
        print(hash);
        expect(client.dapp.id, ++id);
      });
      test("Net version", () async {
        final String version = await client.dapp.netVersion();
        expect(version, isNotNull);
        expect(client.dapp.id, ++id);
        print("Net Version is $version");
      });
      test("Net listening", () async {
        final bool listening = await client.dapp.netListening();
        expect(listening, isNotNull);
        expect(client.dapp.id, ++id);
        print("Net Listening is $listening");
      });
      test("Net peer count", () async {
        final int count = await client.dapp.netPeerCount();
        expect(count, isNotNull);
        expect(client.dapp.id, ++id);
        print("Net peer count is $count");
      });
      test("Sync status", () async {
        final EthereumSyncStatus res = await client.dapp.syncStatus();
        expect(res, isNotNull);
        expect(client.dapp.id, ++id);
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
        final BigInt address = await client.dapp.coinbaseAddress();
        expect(client.dapp.id, ++id);
        if (address != null) {
          print("Coinbase address is $address");
        } else {
          expect(client.dapp.lastError.code, -32000);
          expect(client.dapp.lastError.message,
              "etherbase address must be explicitly specified");
        }
      });
      test("Mining", () async {
        final bool mining = await client.dapp.mining();
        expect(mining, isNotNull);
        expect(client.dapp.id, ++id);
        print("Mining is $mining");
      });
      test("Hashrate", () async {
        final int rate = await client.dapp.hashrate();
        expect(rate, isNotNull);
        expect(client.dapp.id, ++id);
        print("Hashrate is $rate");
      });
      test("Gas price", () async {
        final int price = await client.dapp.gasPrice();
        expect(price, isNotNull);
        expect(client.dapp.id, ++id);
        print("Gas price is $price");
      });
      test("Accounts", () async {
        final List<BigInt> accounts = await client.dapp.accounts();
        expect(accounts, isNotNull);
        final List<String> accountsStr =
        EthereumUtilities.bigIntegerToHexList(accounts);
        expect(client.dapp.id, ++id);
        if (accounts.length != 0) {
          print("Accounts are $accountsStr");
          expect(accounts[0], EthereumTestConfiguration.defaultAccount);
        } else {
          print("There are no accounts");
        }
      });
      test("Block number", () async {
        final int num = await client.dapp.blockNumber();
        expect(num, isNotNull);
        expect(client.dapp.id, ++id);
        print("Block number is $num");
      });
      test("Balance - number", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.number = 0;
        final int balance = await client.dapp.getBalance(
            EthereumUtilities.safeParse(
                "0x407d73d8a49eeb85d32cf465507dd71d507100c1"),
            block);
        expect(balance, isNotNull);
        expect(client.dapp.id, ++id);
        print("Balance number is $balance");
      });
      test("Balance - latest", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.latest = true;
        final int balance = await client.dapp.getBalance(
            EthereumUtilities.safeParse(
                "0x407d73d8a49eeb85d32cf465507dd71d507100c1"),
            block);
        expect(balance, isNotNull);
        expect(client.dapp.id, ++id);
        print("Balance latest is $balance");
      });
      test("Balance - earliest", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.earliest = true;
        final int balance = await client.dapp.getBalance(
            EthereumUtilities.safeParse(
                "0x407d73d8a49eeb85d32cf465507dd71d507100c1"),
            block);
        expect(balance, isNotNull);
        expect(client.dapp.id, ++id);
        print("Balance earliest is $balance");
      });
      test("Balance - pending", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.pending = true;
        final int balance = await client.dapp.getBalance(
            EthereumUtilities.safeParse(
                "0x407d73d8a49eeb85d32cf465507dd71d507100c1"),
            block);
        expect(balance, isNotNull);
        expect(client.dapp.id, ++id);
        print("Balance pending is $balance");
      });
      test("Get storage at - latest", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.latest = true;
        final BigInt storage = await client.dapp.getStorageAt(
            EthereumUtilities.safeParse(
                "0x295a70b2de5e3953354a6a8344e616ed314d7251"),
            0x0,
            block);
        expect(storage, isNotNull);
        expect(client.dapp.id, ++id);
        print("Storage at latest is $storage");
      });
      test("Get storage at - earliest", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.earliest = true;
        final BigInt storage = await client.dapp.getStorageAt(
            EthereumUtilities.safeParse(
                "0x295a70b2de5e3953354a6a8344e616ed314d7251"),
            0x0,
            block);
        expect(storage, isNotNull);
        expect(client.dapp.id, ++id);
        print("Storage at earliest is $storage");
      });
      test("Get storage at - pending", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.pending = true;
        final BigInt storage = await client.dapp.getStorageAt(
            EthereumUtilities.safeParse(
                "0x295a70b2de5e3953354a6a8344e616ed314d7251"),
            0x0,
            block);
        expect(storage, isNotNull);
        expect(client.dapp.id, ++id);
        print("Storage at pending is $storage");
      });
      test("Get storage at - block", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.number = 0x4b7;
        final BigInt storage = await client.dapp.getStorageAt(
            EthereumUtilities.safeParse(
                "0x295a70b2de5e3953354a6a8344e616ed314d7251"),
            0x0,
            block);
        if (storage != null) {
          expect(storage, BigInt.zero);
        }
        expect(client.dapp.id, ++id);
        print("Storage at block is $storage");
      });
      test("Transaction count - number", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.number = 0;
        final int count = await client.dapp.getTransactionCount(
            EthereumUtilities.safeParse(
                "0x407d73d8a49eeb85d32cf465507dd71d507100c1"),
            block);
        expect(count, isNotNull);
        expect(client.dapp.id, ++id);
        print("Transaction count is $count");
      });
      test("Transaction count - earliest", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.earliest = true;
        final int count = await client.dapp.getTransactionCount(
            EthereumUtilities.safeParse(
                "0x407d73d8a49eeb85d32cf465507dd71d507100c1"),
            block);
        expect(count, isNotNull);
        expect(client.dapp.id, ++id);
        print("Transaction count  is $count");
      });
      test("Transaction count - pending", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.pending = true;
        final int count = await client.dapp.getTransactionCount(
            EthereumUtilities.safeParse(
                "0x407d73d8a49eeb85d32cf465507dd71d507100c1"),
            block);
        expect(count, isNotNull);
        expect(client.dapp.id, ++id);
        print("Transaction count  is $count");
      });
      test("Transaction count - latest", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.latest = true;
        final int count = await client.dapp.getTransactionCount(
            EthereumUtilities.safeParse(
                "0x407d73d8a49eeb85d32cf465507dd71d507100c1"),
            block);
        expect(count, isNotNull);
        expect(client.dapp.id, ++id);
        print("Transaction count  is $count");
      });
      test("Block transaction count by hash", () async {
        final int count = await client.dapp.getBlockTransactionCountByHash(
            EthereumUtilities.safeParse(
                "0xb903239f8543d04b5dc1ba6579132b143087c68db1b2168786408fcbce568238"));
        expect(count, 0);
        expect(client.dapp.id, ++id);
      });
      test("Block transaction count by number - number", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.number = 0xe8;
        final int count =
        await client.dapp.getBlockTransactionCountByNumber(block);
        expect(count, isNotNull);
        expect(client.dapp.id, ++id);
      });
      test("Block transaction count by number - latest", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.latest = true;
        final int count =
        await client.dapp.getBlockTransactionCountByNumber(block);
        expect(count, isNotNull);
        expect(client.dapp.id, ++id);
      });
      test("Block transaction count by number - pending", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.pending = true;
        final int count =
        await client.dapp.getBlockTransactionCountByNumber(block);
        expect(count, isNotNull);
        expect(client.dapp.id, ++id);
      });
      test("Block transaction count by number - earliest", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.earliest = true;
        final int count =
        await client.dapp.getBlockTransactionCountByNumber(block);
        expect(count, isNotNull);
        expect(client.dapp.id, ++id);
      });
      test("Block uncle count by hash", () async {
        final int count = await client.dapp.getUncleCountByHash(
            EthereumUtilities.safeParse(
                "0xb903239f8543d04b5dc1ba6579132b143087c68db1b2168786408fcbce568238"));
        expect(count, 0);
        expect(client.dapp.id, ++id);
      });
      test("Uncle count by number - number", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.number = 0xe8;
        final int count = await client.dapp.getUncleCountByNumber(block);
        expect(count, isNotNull);
        expect(client.dapp.id, ++id);
      });
      test("Block uncle count by number - latest", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.latest = true;
        final int count = await client.dapp.getUncleCountByNumber(block);
        expect(count, isNotNull);
        expect(client.dapp.id, ++id);
      });
      test("Block uncle count by number - pending", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.pending = true;
        final int count = await client.dapp.getUncleCountByNumber(block);
        expect(count, isNotNull);
        expect(client.dapp.id, ++id);
      });
      test("Block uncle count by number - earliest", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.earliest = true;
        final int count = await client.dapp.getUncleCountByNumber(block);
        expect(count, isNotNull);
        expect(client.dapp.id, ++id);
      });
      test("Code - address", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.number = 0;
        final int code = await client.dapp.getCode(
            EthereumUtilities.safeParse(
                "0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b"),
            block);
        expect(code, isNull);
        expect(client.dapp.id, ++id);
        print("Code is $code");
      });
      test("Code - latest", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.latest = true;
        final int code = await client.dapp.getCode(
            EthereumUtilities.safeParse(
                "0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b"),
            block);
        expect(code, isNull);
        expect(client.dapp.id, ++id);
        print("Code is $code");
      });
      test("Code - pending", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.pending = true;
        final int code = await client.dapp.getCode(
            EthereumUtilities.safeParse(
                "0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b"),
            block);
        expect(code, isNull);
        expect(client.dapp.id, ++id);
        print("Code is $code");
      });
      test("Code - earliest", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.earliest = true;
        final int code = await client.dapp.getCode(
            EthereumUtilities.safeParse(
                "0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b"),
            block);
        expect(code, isNull);
        expect(client.dapp.id, ++id);
        print("Code is $code");
      });
      test("Sign", () async {
        final int signature = await client.dapp
            .sign(EthereumTestConfiguration.defaultAccount, 0xdeadbeaf);
        if (signature != null) {
          print(signature);
        } else {
          print("You must unlock your account for this method to work");
        }
        expect(client.dapp.id, ++id);
      });
      test("Send transaction", () async {
        final int hash = await client.dapp.sendTransaction(
            EthereumTestConfiguration.defaultAccount,
            EthereumUtilities.safeParse(
                "0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675"),
            to: EthereumUtilities.safeParse(
                "0xd46e8dd67c5d32be8058bb8eb970870f07244567"),
            gas: 0x100,
            gasPrice: 0x1000,
            value: 0x2000,
            nonce: 2);
        if (hash != null) {
          print(hash);
        }
        expect(client.dapp.id, ++id);
        expect(client.dapp.lastError.id, id);
      });
      test("Send transaction - some null", () async {
        final int hash = await client.dapp.sendTransaction(
            EthereumTestConfiguration.defaultAccount,
            EthereumUtilities.safeParse(
                "0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675"),
            to: EthereumUtilities.safeParse(
                "0xd46e8dd67c5d32be8058bb8eb970870f07244567"),
            nonce: 2);
        if (hash != null) {
          print(hash);
        }
        expect(client.dapp.id, ++id);
        expect(client.dapp.lastError.id, id);
      });
      test("Send raw transaction", () async {
        final int hash = await client.dapp.sendRawTransaction(
            EthereumUtilities.safeParse(
                "0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675"));
        if (hash != null) {
          print(hash);
        }
        expect(client.dapp.id, ++id);
        expect(client.dapp.lastError.id, id);
      });
      test("Call ", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.number = 0x10;
        final int ret = await client.dapp.call(
            EthereumTestConfiguration.defaultAccount, block,
            from: EthereumUtilities.safeParse(
                "0xd10de988e845d33859c3f96c7f1fc723b7b56f4c"),
            gas: 0x2000,
            gasPrice: 0x1000,
            value: 0x2000,
            data: EthereumUtilities.safeParse(
                "0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675"));
        if (ret != null) {
          print(ret);
        }
        expect(client.dapp.id, ++id);
      });
      test("Call - some null", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.latest = true;
        final int ret = await client.dapp.call(
            EthereumTestConfiguration.defaultAccount, block,
            from: EthereumUtilities.safeParse(
                "0xd10de988e845d33859c3f96c7f1fc723b7b56f4c"),
            gasPrice: 0x1000,
            data: EthereumUtilities.safeParse(
                "0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675"));
        if (ret != null) {
          print(ret);
        }
        expect(client.dapp.id, ++id);
      });
      test("Estimate gas", () async {
        final int ret = await client.dapp.estimateGas(
            address: EthereumTestConfiguration.defaultAccount,
            from: EthereumUtilities.safeParse(
                "0xd10de988e845d33859c3f96c7f1fc723b7b56f4c"),
            gas: 0x2000,
            gasPrice: 0x1000,
            value: 0x2000,
            data: EthereumUtilities.safeParse(
                "0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675"));
        if (ret != null) {
          print(ret);
        }
        expect(client.dapp.id, ++id);
      });
      test("Estimate gas - some null", () async {
        final int ret = await client.dapp.estimateGas(
            address: EthereumTestConfiguration.defaultAccount,
            from: EthereumUtilities.safeParse(
                "0xd10de988e845d33859c3f96c7f1fc723b7b56f4c"),
            gas: 0x2000,
            gasPrice: 0x1000);
        if (ret != null) {
          print(ret);
        }
        expect(client.dapp.id, ++id);
      });
      test("Get block by hash", () async {
        final EthereumBlock ret = await client.dapp.getBlockByHash(
            EthereumUtilities.safeParse(
                "0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8"));
        if (ret != null) {
          print(ret);
        }
        expect(client.dapp.id, ++id);
      });
      test("Get block by number", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.number = 0x01;
        final EthereumBlock ret = await client.dapp.getBlockByNumber(block);
        if (ret != null) {
          print(ret);
        }
        expect(client.dapp.id, ++id);
      });
      test("Get transaction by hash", () async {
        final EthereumTransaction ret = await client.dapp.getTransactionByHash(
            EthereumUtilities.safeParse(
                "0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8"));
        if (ret != null) {
          print(ret);
        }
        expect(client.dapp.id, ++id);
      });
      test("Get transaction by block hash and index", () async {
        final EthereumTransaction ret = await client.dapp
            .getTransactionByBlockHashAndIndex(
            EthereumUtilities.safeParse(
                "0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8"),
            0);
        if (ret != null) {
          print(ret);
        }
        expect(client.dapp.id, ++id);
      });
      test("Get transaction by block number and index", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.number = 0x100;
        final EthereumTransaction ret =
        await client.dapp.getTransactionByBlockNumberAndIndex(block, 0);
        if (ret != null) {
          print(ret);
        }
        expect(client.dapp.id, ++id);
      });
      test("Get transaction receipt", () async {
        final EthereumTransactionReceipt ret = await client.dapp
            .getTransactionReceipt(EthereumUtilities.safeParse(
            "0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8"));
        if (ret != null) {
          print(ret);
        }
        expect(client.dapp.id, ++id);
      });
      test("Get uncle by block hash and index", () async {
        final EthereumBlock ret = await client.dapp.getUncleByBlockHashAndIndex(
            EthereumUtilities.safeParse(
                "0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8"),
            0);
        if (ret != null) {
          print(ret);
        }
        expect(client.dapp.id, ++id);
      });
      test("Get uncle by block number and index", () async {
        final EthereumDefaultBlock block = EthereumDefaultBlock();
        block.number = 0x100;
        final EthereumBlock ret =
        await client.dapp.getUncleByBlockNumberAndIndex(block, 0);
        if (ret != null) {
          print(ret);
        }
        expect(client.dapp.id, ++id);
      });
      int filterId = 0;
      test("New filter - address", () async {
        final EthereumDefaultBlock from = EthereumDefaultBlock();
        from.number = 1;
        final EthereumDefaultBlock to = EthereumDefaultBlock();
        from.number = 2;
        filterId = await client.dapp.newFilter(
            fromBlock: from,
            toBlock: to,
            address: EthereumUtilities.safeParse(
                "0x8888f1f195afa192cfee860698584c030f4c9db1"),
            topics: [
              EthereumUtilities.safeParse(
                  "0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b"),
              EthereumUtilities.safeParse(
                  "0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b")
            ]);
        if (filterId != null) {
          print(filterId);
        }
        expect(client.dapp.id, ++id);
      });
      test("New filter - address list", () async {
        final EthereumDefaultBlock from = EthereumDefaultBlock();
        from.number = 1;
        final EthereumDefaultBlock to = EthereumDefaultBlock();
        from.number = 2;
        filterId =
        await client.dapp.newFilter(fromBlock: from, toBlock: to, address: [
          EthereumUtilities.safeParse(
              "0x8888f1f195afa192cfee860698584c030f4c9db1"),
          EthereumUtilities.safeParse(
              "0x8888f1f195afa192cfee860698584c030f4c9db2")
        ], topics: [
          EthereumUtilities.safeParse(
              "0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b"),
          EthereumUtilities.safeParse(
              "0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b")
        ]);
        if (filterId != null) {
          print(filterId);
        }
        expect(client.dapp.id, ++id);
      });
      test("New block filter", () async {
        final int filterId = await client.dapp.newBlockFilter();
        if (filterId != null) {
          print(filterId);
        }
        expect(client.dapp.id, ++id);
      });
      int pendFilterId = 0;
      test("New pending transaction filter", () async {
        pendFilterId = await client.dapp.newPendingTransactionFilter();
        if (filterId != null) {
          print(filterId);
        }
        expect(client.dapp.id, ++id);
      });
      test("Uninstall filter", () async {
        if (pendFilterId == null) {
          return;
        }
        final bool res = await client.dapp.uninstallFilter(pendFilterId);
        expect(res, isNotNull);
        expect(client.dapp.id, ++id);
      });
      test("Get filter changes", () async {
        final dynamic ret = await client.dapp.getFilterChanges(0);
        if (ret != null) {
          print(ret);
        }
        expect(client.dapp.id, ++id);
      });
      test("Get filter logs", () async {
        final dynamic ret = await client.dapp.getFilterLogs(0);
        if (ret != null) {
          print(ret);
        }
        expect(client.dapp.id, ++id);
      });
      test("Get logs", () async {
        final EthereumDefaultBlock from = EthereumDefaultBlock();
        final EthereumDefaultBlock to = EthereumDefaultBlock();
        to.earliest = true;
        final EthereumFilter ret = await client.dapp.getLogs(
            fromBlock: from,
            toBlock: to,
            address: EthereumUtilities.safeParse(
                "0x8888f1f195afa192cfee860698584c030f4c9db2"),
            topics: [
              EthereumUtilities.safeParse(
                  "0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b")
            ]);
        if (ret != null) {
          print(ret);
        }
        expect(client.dapp.id, ++id);
      });
      test("Get work", () async {
        final EthereumWork ret = await client.dapp.getWork();
        if (ret != null) {
          print(ret);
        }
        expect(client.dapp.id, ++id);
      });
      test("Submit work", () async {
        final bool ret = await client.dapp.submitWork(
            EthereumUtilities.safeParse("0x123456789abcdef0"),
            EthereumUtilities.safeParse(
                "0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef"),
            EthereumUtilities.safeParse(
                "0xD1FE5700000000000000000000000000D1FE5700000000000000000000000000"));
        expect(ret, isFalse);
        expect(client.dapp.id, ++id);
      });
      test("Submit hash rate", () async {
        final bool ret = await client.dapp.submitHashrate(BigInt.from(0x500000),
            "0x59daa26581d0acd1fce254fb7e85952f4c09d0915afd33d3886cd914bc7d283c");
        expect(ret, isTrue);
        expect(client.dapp.id, ++id);
      });
      test("SHH version", () async {
        final String version = await client.dapp.shhVersion();
        expect(version, isNotNull);
        expect(version, "5.0");
        print("SHH version is $version");
        expect(client.dapp.id, ++id);
      });
      test("SHH post", () async {
        final bool ret = await client.dapp.shhPost([
          EthereumUtilities.safeParse(
              "0x776869737065722d636861742d636c69656e74"),
          EthereumUtilities.safeParse("0x4d5a695276454c39425154466b61693532")
        ], EthereumUtilities.safeParse("0x7b2274797065223a226d60"), 0x64, 0x64,
            to: EthereumUtilities.safeParse(
                "0x3e245533f97284d442460f2998cd41858798ddf04f96a5e25610293e42a73908e93ccc8c4d4dc0edcfa9fa872f50cb214e08ebf61a0d4d661997d3940272b717b1"),
            from: EthereumUtilities.safeParse(
                "0x04f96a5e25610293e42a73908e93ccc8c4d4dc0edcfa9fa872f50cb214e08ebf61a03e245533f97284d442460f2998cd41858798ddfd4d661997d3940272b717b1"));
        expect(ret, isNull);
        expect(client.dapp.id, ++id);
      });
    });
  }
}
