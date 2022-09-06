/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

import 'package:ethereum/ethereum.dart';
import 'package:test/test.dart';
import 'ethereum_test_configuration.dart';
import 'ethereum_test_utilities.dart';

/// Class to run the common Ethereum API tests
class EthereumCommon {
  static void run(Ethereum client) {
    var id = 0;
    group('Dapp', () {
      test('Protocol version 1', () async {
        final version = await client.eth!.protocolVersion();
        expect(version, isNotNull);
        expect(client.eth!.id, ++id);
        print('Protocol Version is $version');
      });
      test('Protocol version 2', () async {
        final version = await client.eth!.protocolVersion();
        expect(version, isNotNull);
        expect(client.eth!.id, ++id);
        print('Protocol Version is $version');
      });
      test('Client version', () async {
        final version = await client.eth!.clientVersion();
        expect(version, isNotNull);
        expect(client.eth!.id, ++id);
        print('Client Version is $version');
      });
      test('SHA3', () async {
        final data = EthereumData.fromString('0x68656c6c6f20776f726c64');
        final hash = await client.eth!.sha3(data);
        expect(hash, isNotNull);
        print(hash);
        expect(client.eth!.id, ++id);
      });
      test('Net version', () async {
        final version = await client.eth!.netVersion();
        expect(version, isNotNull);
        expect(client.eth!.id, ++id);
        print('Net Version is $version');
      });
      test('Net listening', () async {
        final listening = await client.eth!.netListening();
        expect(listening, isNotNull);
        expect(client.eth!.id, ++id);
        print('Net Listening is $listening');
      });
      test('Net peer count', () async {
        final count = await client.eth!.netPeerCount();
        expect(count, isNotNull);
        expect(client.eth!.id, ++id);
        print('Net peer count is $count');
      });
      test('Sync status', () async {
        final res = await (client.eth!.syncStatus());
        expect(res, isNotNull);
        expect(client.eth!.id, ++id);
        if (res!.syncing) {
          print('Sync status is syncing');
          print('Starting Block is ${res.startingBlock}');
          print('Current Block is ${res.currentBlock}');
          print('Highest Block is ${res.highestBlock}');
        } else {
          print('Sync status is not syncing');
        }
      });
      test('Coinbase address', () async {
        final address = await client.eth!.coinbaseAddress();
        expect(client.eth!.id, ++id);
        if (address != null) {
          print('Coinbase address is $address');
        } else {
          expect(client.eth!.lastError.code, -32000);
          expect(client.eth!.lastError.message,
              'etherbase must be explicitly specified');
        }
      });
      test('Mining', () async {
        final mining = await client.eth!.mining();
        expect(mining, isNotNull);
        expect(client.eth!.id, ++id);
        print('Mining is $mining');
      });
      test('Hashrate', () async {
        final rate = await client.eth!.hashrate();
        expect(rate, isNotNull);
        expect(client.eth!.id, ++id);
        print('Hashrate is $rate');
      });
      test('Gas price', () async {
        final price = await client.eth!.gasPrice();
        expect(price, isNotNull);
        expect(client.eth!.id, ++id);
        print('Gas price is $price');
      });
      test('Accounts', () async {
        final accounts = await (client.eth!.accounts());
        expect(accounts, isNotNull);
        final accountsStr = EthereumAddress.toStringList(accounts!);
        expect(client.eth!.id, ++id);
        if (accounts.isNotEmpty) {
          print('Accounts are $accountsStr');
          expect(
              accounts[0].asString, EthereumTestConfiguration.defaultAccount);
        } else {
          print('There are no accounts');
        }
      });
      test('Block number', () async {
        final num = await client.eth!.blockNumber();
        expect(num, isNotNull);
        expect(client.eth!.id, ++id);
        print('Block number is $num');
      });
      test('Balance - number', () async {
        final block = EthereumDefaultBlock();
        block.number = 0;
        final balance = await client.eth!.getBalance(
            EthereumAddress.fromString(
                '0x407d73d8a49eeb85d32cf465507dd71d507100c1'),
            block);
        expect(balance, isNotNull);
        expect(client.eth!.id, ++id);
        print('Balance number is $balance');
      });
      test('Balance - latest', () async {
        final block = EthereumDefaultBlock();
        block.latest = true;
        final balance = await client.eth!.getBalance(
            EthereumAddress.fromString(
                '0x407d73d8a49eeb85d32cf465507dd71d507100c1'),
            block);
        expect(balance, isNotNull);
        expect(client.eth!.id, ++id);
        print('Balance latest is $balance');
      });
      test('Balance - earliest', () async {
        final block = EthereumDefaultBlock();
        block.earliest = true;
        final balance = await client.eth!.getBalance(
            EthereumAddress.fromString(
                '0x407d73d8a49eeb85d32cf465507dd71d507100c1'),
            block);
        expect(balance, isNotNull);
        expect(client.eth!.id, ++id);
        print('Balance earliest is $balance');
      });
      test('Balance - pending', () async {
        final block = EthereumDefaultBlock();
        block.pending = true;
        final balance = await client.eth!.getBalance(
            EthereumAddress.fromString(
                '0x407d73d8a49eeb85d32cf465507dd71d507100c1'),
            block);
        expect(balance, isNotNull);
        expect(client.eth!.id, ++id);
        print('Balance pending is $balance');
      });
      test('Get storage at - latest', () async {
        final block = EthereumDefaultBlock();
        block.latest = true;
        final storage = await client.eth!.getStorageAt(
            EthereumAddress.fromString(
                '0x295a70b2de5e3953354a6a8344e616ed314d7251'),
            0x0,
            block);
        expect(storage, isNotNull);
        expect(client.eth!.id, ++id);
        print('Storage at latest is $storage');
      });
      test('Get storage at - earliest', () async {
        final block = EthereumDefaultBlock();
        block.earliest = true;
        final storage = await client.eth!.getStorageAt(
            EthereumAddress.fromString(
                '0x295a70b2de5e3953354a6a8344e616ed314d7251'),
            0x0,
            block);
        expect(storage, isNotNull);
        expect(client.eth!.id, ++id);
        print('Storage at earliest is $storage');
      });
      test('Get storage at - pending', () async {
        final block = EthereumDefaultBlock();
        block.pending = true;
        final storage = await client.eth!.getStorageAt(
            EthereumAddress.fromString(
                '0x295a70b2de5e3953354a6a8344e616ed314d7251'),
            0x0,
            block);
        expect(storage, isNotNull);
        expect(client.eth!.id, ++id);
        print('Storage at pending is $storage');
      });
      test('Get storage at - block', () async {
        final block = EthereumDefaultBlock();
        block.number = 0x4b7;
        final storage = await client.eth!.getStorageAt(
            EthereumAddress.fromString(
                '0x295a70b2de5e3953354a6a8344e616ed314d7251'),
            0x0,
            block);
        if (storage != null) {
          expect(storage.asBigInt, BigInt.zero);
        }
        expect(client.eth!.id, ++id);
        print('Storage at block is $storage');
      });
      test('Transaction count - number', () async {
        final block = EthereumDefaultBlock();
        block.number = 0;
        final count = await client.eth!.getTransactionCount(
            EthereumAddress.fromString(
                '0x407d73d8a49eeb85d32cf465507dd71d507100c1'),
            block);
        expect(count, isNotNull);
        expect(client.eth!.id, ++id);
        print('Transaction count is $count');
      });
      test('Transaction count - earliest', () async {
        final block = EthereumDefaultBlock();
        block.earliest = true;
        final count = await client.eth!.getTransactionCount(
            EthereumAddress.fromString(
                '0x407d73d8a49eeb85d32cf465507dd71d507100c1'),
            block);
        expect(count, isNotNull);
        expect(client.eth!.id, ++id);
        print('Transaction count  is $count');
      });
      test('Transaction count - pending', () async {
        final block = EthereumDefaultBlock();
        block.pending = true;
        final count = await client.eth!.getTransactionCount(
            EthereumAddress.fromString(
                '0x407d73d8a49eeb85d32cf465507dd71d507100c1'),
            block);
        expect(count, isNotNull);
        expect(client.eth!.id, ++id);
        print('Transaction count  is $count');
      });
      test('Transaction count - latest', () async {
        final block = EthereumDefaultBlock();
        block.latest = true;
        final count = await client.eth!.getTransactionCount(
            EthereumAddress.fromString(
                '0x407d73d8a49eeb85d32cf465507dd71d507100c1'),
            block);
        expect(count, isNotNull);
        expect(client.eth!.id, ++id);
        print('Transaction count  is $count');
      });
      test('Block transaction count by hash', () async {
        final count = await client.eth!.getBlockTransactionCountByHash(
            EthereumData.fromString(
                '0xb903239f8543d04b5dc1ba6579132b143087c68db1b2168786408fcbce568238'));
        expect(count, 0);
        expect(client.eth!.id, ++id);
      });
      test('Block transaction count by number - number', () async {
        final block = EthereumDefaultBlock();
        block.number = 0xe8;
        final count = await client.eth!.getBlockTransactionCountByNumber(block);
        expect(count, isNotNull);
        expect(client.eth!.id, ++id);
      });
      test('Block transaction count by number - latest', () async {
        final block = EthereumDefaultBlock();
        block.latest = true;
        final count = await client.eth!.getBlockTransactionCountByNumber(block);
        expect(count, isNotNull);
        expect(client.eth!.id, ++id);
      });
      test('Block transaction count by number - pending', () async {
        final block = EthereumDefaultBlock();
        block.pending = true;
        final count = await client.eth!.getBlockTransactionCountByNumber(block);
        expect(count, isNotNull);
        expect(client.eth!.id, ++id);
      });
      test('Block transaction count by number - earliest', () async {
        final block = EthereumDefaultBlock();
        block.earliest = true;
        final count = await client.eth!.getBlockTransactionCountByNumber(block);
        expect(count, isNotNull);
        expect(client.eth!.id, ++id);
      });
      test('Block uncle count by hash', () async {
        final count = await client.eth!.getUncleCountByHash(EthereumData.fromString(
            '0xb903239f8543d04b5dc1ba6579132b143087c68db1b2168786408fcbce568238'));
        expect(count, 0);
        expect(client.eth!.id, ++id);
      });
      test('Uncle count by number - number', () async {
        final block = EthereumDefaultBlock();
        block.number = 0xe8;
        final count = await client.eth!.getUncleCountByNumber(block);
        expect(count, isNotNull);
        expect(client.eth!.id, ++id);
      });
      test('Block uncle count by number - latest', () async {
        final block = EthereumDefaultBlock();
        block.latest = true;
        final count = await client.eth!.getUncleCountByNumber(block);
        expect(count, isNotNull);
        expect(client.eth!.id, ++id);
      });
      test('Block uncle count by number - pending', () async {
        final block = EthereumDefaultBlock();
        block.pending = true;
        final count = await client.eth!.getUncleCountByNumber(block);
        expect(count, isNotNull);
        expect(client.eth!.id, ++id);
      });
      test('Block uncle count by number - earliest', () async {
        final block = EthereumDefaultBlock();
        block.earliest = true;
        final count = await client.eth!.getUncleCountByNumber(block);
        expect(count, isNotNull);
        expect(client.eth!.id, ++id);
      });
      test('Code - address', () async {
        final block = EthereumDefaultBlock();
        block.number = 0;
        final code = await client.eth!.getCode(
            EthereumAddress.fromString(
                '0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b'),
            block);
        expect(code, isNull);
        expect(client.eth!.id, ++id);
        print('Code is $code');
      });
      test('Code - latest', () async {
        final block = EthereumDefaultBlock();
        block.latest = true;
        final code = await client.eth!.getCode(
            EthereumAddress.fromString(
                '0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b'),
            block);
        expect(code, isNull);
        expect(client.eth!.id, ++id);
        print('Code is $code');
      });
      test('Code - pending', () async {
        final block = EthereumDefaultBlock();
        block.pending = true;
        final code = await client.eth!.getCode(
            EthereumAddress.fromString(
                '0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b'),
            block);
        expect(code, isNull);
        expect(client.eth!.id, ++id);
        print('Code is $code');
      });
      test('Code - earliest', () async {
        final block = EthereumDefaultBlock();
        block.earliest = true;
        final code = await client.eth!.getCode(
            EthereumAddress.fromString(
                '0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b'),
            block);
        expect(code, isNull);
        expect(client.eth!.id, ++id);
        print('Code is $code');
      });
      test('Sign', () async {
        final signature = await client.eth!.sign(
            EthereumAddress.fromString(
                EthereumTestConfiguration.defaultAccount),
            EthereumData.fromString('0xdeadbeaf'));
        if (signature != null) {
          print(signature);
        } else {
          print('You must unlock your account for this method to work');
        }
        expect(client.eth!.id, ++id);
      });
      test('Send transaction', () async {
        final hash = await client.eth!.sendTransaction(
            EthereumAddress.fromString(
                EthereumTestConfiguration.defaultAccount),
            EthereumData.fromString(
                '0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675'),
            to: EthereumAddress.fromString(
                '0xd46e8dd67c5d32be8058bb8eb970870f07244567'),
            gas: 0x100,
            gasPrice: 0x1000,
            value: 0x2000,
            nonce: 2);
        if (hash != null) {
          print(hash);
        }
        expect(client.eth!.id, ++id);
        expect(client.eth!.lastError.id, id);
      });
      test('Send transaction - some null', () async {
        final hash = await client.eth!.sendTransaction(
            EthereumAddress.fromString(
                EthereumTestConfiguration.defaultAccount),
            EthereumData.fromString(
                '0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675'),
            to: EthereumAddress.fromString(
                '0xd46e8dd67c5d32be8058bb8eb970870f07244567'),
            nonce: 2);
        if (hash != null) {
          print(hash);
        }
        expect(client.eth!.id, ++id);
        expect(client.eth!.lastError.id, id);
      });
      test('Send raw transaction', () async {
        final hash = await client.eth!.sendRawTransaction(EthereumData.fromString(
            '0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675'));
        if (hash != null) {
          print(hash);
        }
        expect(client.eth!.id, ++id);
        expect(client.eth!.lastError.id, id);
      });
      test('Call ', () async {
        final block = EthereumDefaultBlock();
        block.number = 0x10;
        final ret = await client.eth!.call(
            EthereumAddress.fromString(
                EthereumTestConfiguration.defaultAccount),
            block,
            from: EthereumAddress.fromString(
                '0xd10de988e845d33859c3f96c7f1fc723b7b56f4c'),
            gas: 0x2000,
            gasPrice: 0x1000,
            value: 0x2000,
            data: EthereumData.fromString(
                '0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675'));
        if (ret != null) {
          print(ret);
        }
        expect(client.eth!.id, ++id);
      });
      test('Call - some null', () async {
        final block = EthereumDefaultBlock();
        block.latest = true;
        final ret = await client.eth!.call(
            EthereumAddress.fromString(
                EthereumTestConfiguration.defaultAccount),
            block,
            from: EthereumAddress.fromString(
                '0xd10de988e845d33859c3f96c7f1fc723b7b56f4c'),
            gasPrice: 0x1000,
            data: EthereumData.fromString(
                '0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675'));
        if (ret != null) {
          print(ret);
        }
        expect(client.eth!.id, ++id);
      });
      test('Estimate gas', () async {
        final ret = await client.eth!.estimateGas(
            address: EthereumAddress.fromString(
                EthereumTestConfiguration.defaultAccount),
            from: EthereumAddress.fromString(
                '0xd10de988e845d33859c3f96c7f1fc723b7b56f4c'),
            gas: 0x2000,
            gasPrice: 0x1000,
            value: 0x2000,
            data: EthereumData.fromString(
                '0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675'));
        if (ret != null) {
          print(ret);
        }
        expect(client.eth!.id, ++id);
      });
      test('Estimate gas - some null', () async {
        final ret = await client.eth!.estimateGas(
            address: EthereumAddress.fromString(
                EthereumTestConfiguration.defaultAccount),
            from: EthereumAddress.fromString(
                '0xd10de988e845d33859c3f96c7f1fc723b7b56f4c'),
            gas: 0x2000,
            gasPrice: 0x1000);
        if (ret != null) {
          print(ret);
        }
        expect(client.eth!.id, ++id);
      });
      test('Get block by hash', () async {
        final ret = await client.eth!.getBlockByHash(EthereumData.fromString(
            '0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8'));
        if (ret != null) {
          print(ret);
        }
        expect(client.eth!.id, ++id);
      });
      test('Get block by number', () async {
        final block = EthereumDefaultBlock();
        block.number = 0x01;
        final ret = await client.eth!.getBlockByNumber(block);
        if (ret != null) {
          print(ret);
        }
        expect(client.eth!.id, ++id);
      });
      test('Get transaction by hash', () async {
        final ret = await client.eth!.getTransactionByHash(EthereumData.fromString(
            '0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8'));
        if (ret != null) {
          print(ret);
        }
        expect(client.eth!.id, ++id);
      });
      test('Get transaction by block hash and index', () async {
        final ret = await client.eth!.getTransactionByBlockHashAndIndex(
            EthereumData.fromString(
                '0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8'),
            0);
        if (ret != null) {
          print(ret);
        }
        expect(client.eth!.id, ++id);
      });
      test('Get transaction by block number and index', () async {
        final block = EthereumDefaultBlock();
        block.number = 0x100;
        final ret =
            await client.eth!.getTransactionByBlockNumberAndIndex(block, 0);
        if (ret != null) {
          print(ret);
        }
        expect(client.eth!.id, ++id);
      });
      test('Get transaction receipt', () async {
        var ret = await client.eth!.getTransactionReceipt(EthereumData.fromString(
            '0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8'));
        if (ret != null) {
          print(ret);
        }
        expect(client.eth!.id, ++id);
      });
      test('Get uncle by block hash and index', () async {
        final ret = await client.eth!.getUncleByBlockHashAndIndex(
            EthereumData.fromString(
                '0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8'),
            0);
        if (ret != null) {
          print(ret);
        }
        expect(client.eth!.id, ++id);
      });
      test('Get uncle by block number and index', () async {
        final block = EthereumDefaultBlock();
        block.number = 0x100;
        final ret = await client.eth!.getUncleByBlockNumberAndIndex(block, 0);
        if (ret != null) {
          print(ret);
        }
        expect(client.eth!.id, ++id);
      });
      int? filterId = 0;
      test('New filter - address', () async {
        final from = EthereumDefaultBlock();
        from.number = 1;
        final to = EthereumDefaultBlock();
        from.number = 2;
        filterId = await client.eth!.newFilter(
            fromBlock: from,
            toBlock: to,
            address: EthereumAddress.fromString(
                '0x8888f1f195afa192cfee860698584c030f4c9db1'),
            topics: <EthereumData>[
              EthereumData.fromString(
                  '0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b'),
              EthereumData.fromString(
                  '0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b')
            ]);
        if (filterId != null) {
          print(filterId);
        }
        expect(client.eth!.id, ++id);
      });
      test('New filter - address list', () async {
        final from = EthereumDefaultBlock();
        from.number = 1;
        final to = EthereumDefaultBlock();
        from.number = 2;
        filterId = await client.eth!
            .newFilter(fromBlock: from, toBlock: to, address: <EthereumAddress>[
          EthereumAddress.fromString(
              '0x8888f1f195afa192cfee860698584c030f4c9db1'),
          EthereumAddress.fromString(
              '0x8888f1f195afa192cfee860698584c030f4c9db2')
        ], topics: <EthereumData>[
          EthereumData.fromString(
              '0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b'),
          EthereumData.fromString(
              '0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b')
        ]);
        if (filterId != null) {
          print(filterId);
        }
        expect(client.eth!.id, ++id);
      });
      test('New block filter', () async {
        final filterId = await client.eth!.newBlockFilter();
        if (filterId != null) {
          print(filterId);
        }
        expect(client.eth!.id, ++id);
      });
      int? pendFilterId = 0;
      test('New pending transaction filter', () async {
        pendFilterId = await client.eth!.newPendingTransactionFilter();
        if (filterId != null) {
          print(filterId);
        }
        expect(client.eth!.id, ++id);
      });
      test('Uninstall filter', () async {
        if (pendFilterId == null) {
          return;
        }
        final res = await client.eth!.uninstallFilter(pendFilterId);
        expect(res, isNotNull);
        expect(client.eth!.id, ++id);
      });
      test('Get filter changes', () async {
        final dynamic ret = await client.eth!.getFilterChanges(0);
        if (ret != null) {
          print(ret);
        }
        expect(client.eth!.id, ++id);
      });
      test('Get filter logs', () async {
        final dynamic ret = await client.eth!.getFilterLogs(0);
        if (ret != null) {
          print(ret);
        }
        expect(client.eth!.id, ++id);
      });
      test('Get logs', () async {
        final from = EthereumDefaultBlock();
        final to = EthereumDefaultBlock();
        to.earliest = true;
        final ret = await client.eth!.getLogs(
            fromBlock: from,
            toBlock: to,
            address: EthereumAddress.fromString(
                '0x8888f1f195afa192cfee860698584c030f4c9db2'),
            topics: <EthereumData>[
              EthereumData.fromString(
                  '0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b')
            ]);
        if (ret != null) {
          print(ret);
        }
        expect(client.eth!.id, ++id);
      });
      test('Get work', () async {
        final ret = await client.eth!.getWork();
        if (ret != null) {
          print(ret);
        }
        expect(client.eth!.id, ++id);
      });
      test('Submit work', () async {
        final ret = await client.eth!.submitWork(
            EthereumData.fromString('0x123456789abcdef0'),
            EthereumData.fromString(
                '0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef'),
            EthereumData.fromString(
                '0xD1FE5700000000000000000000000000D1FE5700000000000000000000000000'));
        expect(ret, isFalse);
        expect(client.eth!.id, ++id);
      });
      test('Submit hash rate', () async {
        final ret = await client.eth!.submitHashrate(
            EthereumData.fromString('0x500000'),
            '0x59daa26581d0acd1fce254fb7e85952f4c09d0915afd33d3886cd914bc7d283c');
        if (ret != null) {
          expect(ret, isTrue);
        } else {
          expect(client.eth!.lastError.code, -32601);
          expect(client.eth!.lastError.message,
              'The method eth_submitHashrate does not exist/is not available');
        }
        expect(client.eth!.id, ++id);
      });
      test('SHH version', () async {
        final version = await client.eth!.shhVersion();
        if (version != null) {
          var ok = false;
          if (version == '5.0' || version == '6.0') {
            ok = true;
          }
          expect(ok, isTrue);
        } else {
          expect(client.eth!.lastError.code, -32601);
          expect(client.eth!.lastError.message,
              'The method shh_version does not exist/is not available');
        }
        print('SHH version is $version');
        expect(client.eth!.id, ++id);
      });
      test('SHH post', () async {
        final ret = await client.eth!.shhPost(<EthereumData>[
          EthereumData.fromString('0x776869737065722d636861742d636c69656e74'),
          EthereumData.fromString('0x4d5a695276454c39425154466b61693532')
        ], EthereumData.fromString('0x7b2274797065223a226d60'), 0x64, 0x64,
            to: EthereumAddress.fromString(
                '0x8888f1f195afa192cfee860698584c030f4c9db2'),
            from: EthereumAddress.fromString(
                '0x8888f1f195afa192cfee860698584c030f4c9db2'));
        expect(ret, isNull);
        expect(client.eth!.id, ++id);
      });
    });

    group('Admin', () {
      EthereumAddress? lockAddress;
      EthereumData? signature;
      test('Personal ImportRawKey', () async {
        final key = await client.admin!.personalImportRawKey(
            'b5b1870957d373ef0eeffecc6e4812c0fd08f554b37b233526acc331bf1544f7',
            'password');
        if (key != null) {
          expect(key.asBigInt!.isValidInt, true);
        } else {
          expect(client.eth!.lastError.message, 'account already exists');
        }
        expect(client.admin!.id, ++id);
      });
      test('Personal List Accounts', () async {
        final ret = await (client.admin!.personalListAccounts());
        expect(ret, isNotNull);
        lockAddress = ret![0];
        print(ret);
        expect(client.admin!.id, ++id);
      });
      test('Personal Lock Account', () async {
        final ret = await client.admin!.personalLockAccount(lockAddress);
        expect(ret, isTrue);
        expect(client.admin!.id, ++id);
      });
      test('Personal New Account', () async {
        final ret = await client.admin!.personalNewAccount('password');
        expect(ret, isNotNull);
        print(ret);
        expect(client.admin!.id, ++id);
      });
      test('Personal Unlock Account', () async {
        await client.admin!.personalUnlockAccount(lockAddress, 'password');
        expect(client.admin!.id, ++id);
      });
      test('Personal Send Transaction', () async {
        await client.admin!.personalSendTransaction(lockAddress, 'password');
        expect(client.admin!.id, ++id);
      });
      test('Personal Sign', () async {
        final message = EthereumData.fromBigInt(BigInt.from(0xdeadbeaf));
        final ret = await (client.admin!
            .personalSign(message, lockAddress, 'password'));
        expect(ret, isNotNull);
        signature = ret;
        print(ret!.asString);
        expect(client.admin!.id, ++id);
      });
      test('Personal EcRecover', () async {
        final message = EthereumData.fromBigInt(BigInt.from(0xdeadbeaf));
        final ret = await client.admin!.personalEcRecover(message, signature);
        expect(ret, isNotNull);
        expect(ret, lockAddress);
        expect(client.admin!.id, ++id);
      });
    }, skip: EthereumTestUtilities.browserWsTestsRunning);
  }
}
