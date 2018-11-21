/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

@TestOn('vm')
import 'package:ethereum/ethereum_server_client.dart';
import 'package:ethereum/ethereum.dart';
import 'package:test/test.dart';

/// These test are common to both server and client, we use the server client for convenience.

void main() {
  group('Utilities', () {
    test('Int to hex', () {
      const int testInt = 0xabcdef123450;
      final String val = EthereumUtilities.intToHex(testInt);
      expect(val, '0xabcdef123450');
    });
    test('Int to hex - pad', () {
      const int testInt = 0x1;
      final String val = EthereumUtilities.intToHex(testInt, 8);
      expect(val, '0x0000000000000001');
    });
    test('Int to hex  - pad negative', () {
      bool thrown = false;
      try {
        EthereumUtilities.intToHex(1, -2);
      } on Exception catch (e) {
        expect(e is FormatException, isTrue);
        expect(e.toString(),
            'FormatException: EthereumUtilities:: intToHex - invalid pad value, -2');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Int to hex  - pad odd', () {
      bool thrown = false;
      try {
        EthereumUtilities.intToHex(1, 3);
      } on Exception catch (e) {
        expect(e is FormatException, isTrue);
        expect(e.toString(),
            'FormatException: EthereumUtilities:: intToHex - invalid pad value, 3');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Hex to int - valid', () {
      const String testString = '0xabcdef12345';
      final int val = EthereumUtilities.hexToInt(testString);
      expect(val, 0xabcdef12345);
    });
    test('Hex to int - invalid', () {
      const String testString = 'abcdef12345';
      final int val = EthereumUtilities.hexToInt(testString);
      expect(val, isNull);
    });
    test('Hex to int list', () {
      final List<String> testString = <String>['0xabcdef12345', '0xaabbcc'];
      final List<int> val = EthereumUtilities.hexToIntList(testString);
      expect(val, <int>[0xabcdef12345, 0xaabbcc]);
    });
    test('Int to hex list', () {
      final List<int> testList = <int>[0xabcdef12345, 0xaabbcc];
      final List<String> val = EthereumUtilities.intToHexList(testList);
      expect(val, <String>['0xabcdef12345', '0xaabbcc']);
    });
  });

  group('Connection tests', () {
    final EthereumServerClient client = EthereumServerClient();
    test('connectString - Null', () {
      bool thrown = false;
      try {
        client.connectString(null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::connectString - hostname): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });

    test('connectString - OK with port', () {
      client.connectString('http://localhost:2000');
      expect(client.host, 'localhost');
      expect(client.port, 2000);
    });

    test('connectString - OK no port', () {
      client.connectString('http://localhost1');
      expect(client.host, 'localhost1');
      expect(client.port, Ethereum.defaultHttpPort);
    });

    test('connectUri - Null', () {
      bool thrown = false;
      try {
        client.connectUri(null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::connectUri - uri): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });

    test('connectUri - OK with port', () {
      final Uri uri = Uri.parse('http://localhost:2000');
      client.connectUri(uri);
      expect(client.host, 'localhost');
      expect(client.port, 2000);
    });

    test('connectUri - OK no port', () {
      final Uri uri = Uri.parse('http://localhost');
      client.connectUri(uri);
      expect(client.host, 'localhost');
      expect(client.port, Ethereum.defaultHttpPort);
    });

    test('connectParameters - Hostname Null', () {
      bool thrown = false;
      try {
        client.connectParameters(Ethereum.rpcHttpScheme, null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::connectParameters - hostname): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });

    test('connectParameters - Invalid scheme', () {
      bool thrown = false;
      try {
        client.connectParameters('Billy', 'localhost');
      } on Exception catch (e) {
        expect(e is FormatException, isTrue);
        expect(e.toString(),
            'FormatException: Ethereum::connectParameters - invalid scheme Billy');
        thrown = true;
      }
      expect(thrown, isTrue);
    });

    test('connectParameters - OK with port', () {
      client.connectParameters(Ethereum.rpcHttpScheme, 'localhost', 3000);
      expect(client.host, 'localhost');
      expect(client.port, 3000);
    });

    test('connectParameters - OK no port - http', () {
      client.connectParameters(Ethereum.rpcHttpScheme, 'localhost');
      expect(client.host, 'localhost');
      expect(client.port, Ethereum.defaultHttpPort);
    });
    test('connectParameters - OK no port - ws', () {
      client.connectParameters(Ethereum.rpcWsScheme, 'localhost');
      expect(client.host, 'localhost');
      expect(client.port, Ethereum.defaultWsPort);
    });
    test('Transmission id', () {
      expect(client.id, 0);
      client.id = 5;
      expect(client.id, 5);
      client.id = null;
      expect(client.id, 0);
    });
  });

  group('Null parameter tests - eth', () {
    final EthereumServerClient client = EthereumServerClient();
    test('Sha3 - data', () async {
      bool thrown = false;
      try {
        await client.eth.sha3(null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::sha3 - data): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Balance - account number', () async {
      bool thrown = false;
      try {
        await client.eth.getBalance(null, null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getBalance - accountNumber): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Balance - block', () async {
      bool thrown = false;
      try {
        await client.eth.getBalance(BigInt.zero, null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getBalance - block): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Storage at - block', () async {
      bool thrown = false;
      try {
        await client.eth.getStorageAt(BigInt.one, 2, null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getStorageAt - block): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Storage at - pos', () async {
      bool thrown = false;
      try {
        await client.eth.getStorageAt(BigInt.one, null, EthereumDefaultBlock());
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getStorageAt - pos): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Storage at - address', () async {
      bool thrown = false;
      try {
        await client.eth.getStorageAt(null, 1, EthereumDefaultBlock());
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getStorageAt - address): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Block transaction count - address', () async {
      bool thrown = false;
      try {
        await client.eth.getTransactionCount(null, EthereumDefaultBlock());
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getTransactionCount - address): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Block transaction count - block', () async {
      bool thrown = false;
      try {
        await client.eth.getTransactionCount(BigInt.one, null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getTransactionCount - block): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Block transaction count by hash', () async {
      bool thrown = false;
      try {
        await client.eth.getBlockTransactionCountByHash(null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getBlockTransactionCountByHash - blockHash): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Block transaction count by number', () async {
      bool thrown = false;
      try {
        await client.eth.getBlockTransactionCountByNumber(null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getBlockTransactionCountByNumber - blockNumber): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Block uncle count by hash', () async {
      bool thrown = false;
      try {
        await client.eth.getUncleCountByHash(null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getUncleCountByHash - blockHash): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Block uncle count by number', () async {
      bool thrown = false;
      try {
        await client.eth.getUncleCountByNumber(null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getUncleCountByNumber - blockNumber): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Code - address', () async {
      bool thrown = false;
      try {
        await client.eth.getCode(null, EthereumDefaultBlock());
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getCode - address): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Code - block', () async {
      bool thrown = false;
      try {
        await client.eth.getCode(BigInt.two, null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getCode - block): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Sign - account', () async {
      bool thrown = false;
      try {
        await client.eth.sign(null, 0);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::sign - account): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Sign - message', () async {
      bool thrown = false;
      try {
        await client.eth.sign(BigInt.zero, null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::sign - message): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Send transaction - address', () async {
      bool thrown = false;
      try {
        await client.eth.sendTransaction(null, BigInt.zero);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::sendTransaction - address): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Send transaction - data', () async {
      bool thrown = false;
      try {
        await client.eth.sendTransaction(BigInt.zero, null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::sendTransaction - data): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Send raw transaction', () async {
      bool thrown = false;
      try {
        await client.eth.sendRawTransaction(null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::sendRawTransaction - signedTransaction): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Call - address', () async {
      bool thrown = false;
      try {
        await client.eth.call(null, null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::call - address): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Call - block', () async {
      bool thrown = false;
      try {
        await client.eth.call(BigInt.zero, null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::call - block): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Get block by hash', () async {
      bool thrown = false;
      try {
        await client.eth.getBlockByHash(null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getBlockByHash - blockHash): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Get block by number', () async {
      bool thrown = false;
      try {
        await client.eth.getBlockByNumber(null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getBlockByNumber - blockNumber): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Get transaction by hash', () async {
      bool thrown = false;
      try {
        await client.eth.getTransactionByHash(null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getTransactionByHash - hash): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Get transaction by block hash and index - block hash', () async {
      bool thrown = false;
      try {
        await client.eth.getTransactionByBlockHashAndIndex(null, 0);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getTransactionByBlockHashAndIndex - blockHash): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Get transaction by block hash and index - index', () async {
      bool thrown = false;
      try {
        await client.eth.getTransactionByBlockHashAndIndex(BigInt.zero, null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getTransactionByBlockHashAndIndex - index): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Get transaction by block number and index - block number', () async {
      bool thrown = false;
      try {
        await client.eth.getTransactionByBlockNumberAndIndex(null, 0);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getTransactionByBlockNumberAndIndex - blockNumber): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Get transaction by block number and index - index', () async {
      bool thrown = false;
      try {
        await client.eth
            .getTransactionByBlockNumberAndIndex(EthereumDefaultBlock(), null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getTransactionByBlockNumberAndIndex - index): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Get transaction receipt', () async {
      bool thrown = false;
      try {
        await client.eth.getTransactionReceipt(null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getTransactionReceipt - transactionHash): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Get uncle by block hash and index - block hash', () async {
      bool thrown = false;
      try {
        await client.eth.getUncleByBlockHashAndIndex(null, 0);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getUncleByBlockHashAndIndex - blockHash): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Get uncle by block hash and index - index', () async {
      bool thrown = false;
      try {
        await client.eth.getUncleByBlockHashAndIndex(BigInt.zero, null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getUncleByBlockHashAndIndex - index): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Get uncle by block number and index - block number', () async {
      bool thrown = false;
      try {
        await client.eth.getUncleByBlockNumberAndIndex(null, 0);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getUncleByBlockNumberAndIndex - blockNumber): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Get uncle by block number and index - index', () async {
      bool thrown = false;
      try {
        await client.eth
            .getUncleByBlockNumberAndIndex(EthereumDefaultBlock(), null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getUncleByBlockNumberAndIndex - index): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Uninstall filter', () async {
      bool thrown = false;
      try {
        await client.eth.uninstallFilter(null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::uninstallFilter - filterId): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Get filter changes', () async {
      bool thrown = false;
      try {
        await client.eth.getFilterChanges(null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getFilterChanges - filterId): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Get filter logs', () async {
      bool thrown = false;
      try {
        await client.eth.getFilterLogs(null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::getFilterLogs - filterId): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Submit work - nonce', () async {
      bool thrown = false;
      try {
        await client.eth.submitWork(null, BigInt.one, BigInt.two);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::submitWork - nonce): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Submit work - powHash', () async {
      bool thrown = false;
      try {
        await client.eth.submitWork(BigInt.one, null, BigInt.two);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::submitWork - powHash): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Submit work - digest', () async {
      bool thrown = false;
      try {
        await client.eth.submitWork(BigInt.one, BigInt.two, null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::submitWork - digest): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Submit hash rate - hash rate', () async {
      bool thrown = false;
      try {
        await client.eth.submitHashrate(null, 'id');
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::submitHashRate - hashRate): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Submit hash rate - id', () async {
      bool thrown = false;
      try {
        await client.eth.submitHashrate(BigInt.one, null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::submitHashRate - id): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Shh Post - topics', () async {
      bool thrown = false;
      try {
        await client.eth.shhPost(null, BigInt.one, 2, 3);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::shhPost - topics): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Shh Post - payload', () async {
      bool thrown = false;
      try {
        await client.eth.shhPost(<BigInt>[BigInt.one], null, 2, 3);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::shhPost - payload): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Shh Post - priority', () async {
      bool thrown = false;
      try {
        await client.eth.shhPost(<BigInt>[BigInt.one], BigInt.one, null, 3);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::shhPost - priority): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('Shh Post - ttl', () async {
      bool thrown = false;
      try {
        await client.eth.shhPost(<BigInt>[BigInt.one], BigInt.one, 2, null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::shhPost - ttl): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
  });

  group('Message tests', () {
    test('Sync status - no sync', () {
      final Map<String, bool> nosync = <String, bool>{'result': false};
      final EthereumSyncStatus message = EthereumSyncStatus.fromMap(nosync);
      expect(message.syncing, isFalse);
      expect(message.currentBlock, isNull);
      expect(message.highestBlock, isNull);
      expect(message.startingBlock, isNull);
      print(message);
      final EthereumSyncStatus message1 = EthereumSyncStatus();
      print(message1);
    });
    test('Sync status - sync', () {
      final Map<String, String> sync = <String, String>{
        'startingBlock': '0x384',
        'currentBlock': '0x386',
        'highestBlock': '0x454'
      };
      final EthereumSyncStatus message = EthereumSyncStatus.fromMap(sync);
      expect(message.syncing, isTrue);
      expect(message.currentBlock, 0x386);
      expect(message.highestBlock, 0x454);
      expect(message.startingBlock, 0x384);
      print(message);
    });
    test('Transaction - null', () {
      final Map<String, bool> transaction = <String, bool>{'result': null};

      final EthereumTransaction message =
          EthereumTransaction.fromMap(transaction);
      expect(message.hash, isNull);
      expect(message.nonce, isNull);
      expect(message.blockHash, isNull);
      expect(message.blockNumber, isNull);
      expect(message.transactionIndex, isNull);
      expect(message.from, isNull);
      expect(message.to, isNull);
      expect(message.value, isNull);
      expect(message.gas, isNull);
      expect(message.gasPrice, isNull);
      expect(message.input, isNull);
      final EthereumTransaction message1 = EthereumTransaction();
      print(message1);
    });

    test('Transaction', () {
      final Map<String, Map<String, String>> transaction =
          <String, Map<String, String>>{
        'result': <String, String>{
          'hash':
              '0xc6ef2fc5426d6ad6fd9e2a26abeab0aa2411b7ab17f30a99d3cb96aed1d1055b',
          'nonce': '0x0',
          'blockHash':
              '0xbeab0aa2411b7ab17f30a99d3cb9c6ef2fc5426d6ad6fd9e2a26a6aed1d1055b',
          'blockNumber': '0x15df', // 5599
          'transactionIndex': '0x1', // 1
          'from': '0x407d73d8a49eeb85d32cf465507dd71d507100c1',
          'to': '0x85a43d8a49eeb85d32cf465507dd71d507100c1',
          'value': '0x7f110', // 520464
          'gas': '0x7f111', // 520465
          'gasPrice': '0x09184e72a000',
          'input':
              '0x603880600c6000396000f300603880600c6000396000f3603880600c6000396000f360'
        }
      };

      final EthereumTransaction message =
          EthereumTransaction.fromMap(transaction);
      expect(
          message.hash,
          EthereumUtilities.safeParse(
              '0xc6ef2fc5426d6ad6fd9e2a26abeab0aa2411b7ab17f30a99d3cb96aed1d1055b'));
      expect(message.nonce, 0);
      expect(
          message.blockHash,
          EthereumUtilities.safeParse(
              '0xbeab0aa2411b7ab17f30a99d3cb9c6ef2fc5426d6ad6fd9e2a26a6aed1d1055b'));
      expect(message.blockNumber, 5599);
      expect(message.transactionIndex, 1);
      expect(
          message.from,
          EthereumUtilities.safeParse(
              '0x407d73d8a49eeb85d32cf465507dd71d507100c1'));
      expect(
          message.to,
          EthereumUtilities.safeParse(
              '0x85a43d8a49eeb85d32cf465507dd71d507100c1'));
      expect(message.value, 520464);
      expect(message.gas, 520465);
      expect(message.gasPrice, 0x09184e72a000);
      expect(
          message.input,
          EthereumUtilities.safeParse(
              '0x603880600c6000396000f300603880600c6000396000f3603880600c6000396000f360'));
      print(message);
    });
    test('Block - null', () {
      final Map<String, dynamic> block = <String, dynamic>{
        'result': <dynamic, dynamic>{}
      };
      final EthereumBlock message = EthereumBlock.fromMap(block);
      expect(message.number, isNull);
      expect(message.hash, isNull);
      expect(message.parentHash, isNull);
      expect(message.nonce, isNull);
      expect(message.sha3Uncles, isNull);
      expect(message.logsBloom, isNull);
      expect(message.transactionsRoot, isNull);
      expect(message.stateRoot, isNull);
      expect(message.receiptsRoot, isNull);
      expect(message.miner, isNull);
      expect(message.difficulty, isNull);
      expect(message.totalDifficulty, isNull);
      expect(message.extraData, isNull);
      expect(message.size, isNull);
      expect(message.gasLimit, isNull);
      expect(message.gasUsed, isNull);
      expect(message.timestamp, isNull);
      expect(message.transactions, isNull);
      expect(message.uncles, isNull);
      expect(message.transactionsAreHashes, isFalse);
      final EthereumBlock messageDefault = EthereumBlock();
      print(messageDefault);
    });
    test('Block - transactions are hashes', () {
      final Map<String, Map<String, dynamic>> block =
          <String, Map<String, dynamic>>{
        'result': <String, dynamic>{
          'number': '0x1b4', // 436
          'hash':
              '0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331',
          'parentHash':
              '0x9646252be9520f6e71339a8df9c55e4d7619deeb018d2a3f2d21fc165dde5eb5',
          'nonce':
              '0xe04d296d2460cfb8472af2c5fd05b5a214109c25688d3704aed5484f9a7792f2',
          'sha3Uncles':
              '0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347',
          'logsBloom':
              '0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331',
          'transactionsRoot':
              '0x56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421',
          'stateRoot':
              '0xd5855eb08b3387c0af375e9cdb6acfc05eb8f519e419b874b6ff2ffda7ed1dff',
          'receiptsRoot':
              '0xd5855eb08b3387c0af375e9cdb6acfc05eb8f519e419b874b6ff2ffda7ed1dff',
          'miner': '0x4e65fda2159562a496f9f3522f89122a3088497a',
          'difficulty': '0x027f07', // 163591
          'totalDifficulty': '0x027f07', // 163591
          'extraData':
              '0x0000000000000000000000000000000000000000000000000000000000000000',
          'size': '0x027f07', // 163591
          'gasLimit': '0x9f759', // 653145
          'gasUsed': '0x9f759', // 653145
          'timestamp': '0x54e34e8e', // 1424182926
          'transactions': <String>[
            '0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527332',
            '0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527333'
          ],
          'uncles': <String>[
            '0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527334',
            '0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527335'
          ]
        }
      };
      final EthereumBlock message = EthereumBlock.fromMap(block);
      expect(message.number, 436);
      expect(
          message.hash,
          EthereumUtilities.safeParse(
              '0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331'));
      expect(
          message.parentHash,
          EthereumUtilities.safeParse(
              '0x9646252be9520f6e71339a8df9c55e4d7619deeb018d2a3f2d21fc165dde5eb5'));
      expect(
          message.nonce,
          EthereumUtilities.safeParse(
              '0xe04d296d2460cfb8472af2c5fd05b5a214109c25688d3704aed5484f9a7792f2'));
      expect(
          message.sha3Uncles,
          EthereumUtilities.safeParse(
              '0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347'));
      expect(
          message.logsBloom,
          EthereumUtilities.safeParse(
              '0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331'));
      expect(
          message.transactionsRoot,
          EthereumUtilities.safeParse(
              '0x56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421'));
      expect(
          message.stateRoot,
          EthereumUtilities.safeParse(
              '0xd5855eb08b3387c0af375e9cdb6acfc05eb8f519e419b874b6ff2ffda7ed1dff'));
      expect(
          message.receiptsRoot,
          EthereumUtilities.safeParse(
              '0xd5855eb08b3387c0af375e9cdb6acfc05eb8f519e419b874b6ff2ffda7ed1dff'));
      expect(
          message.miner,
          EthereumUtilities.safeParse(
              '0x4e65fda2159562a496f9f3522f89122a3088497a'));
      expect(message.difficulty, 163591);
      expect(message.totalDifficulty, 163591);
      expect(message.extraData, BigInt.zero);
      expect(message.size, 163591);
      expect(message.gasLimit, 653145);
      expect(message.gasUsed, 653145);
      expect(message.timestamp.millisecondsSinceEpoch, 1424182926);
      expect(
          message.transactions[0],
          EthereumUtilities.safeParse(
              '0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527332'));
      expect(
          message.transactions[1],
          EthereumUtilities.safeParse(
              '0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527333'));
      expect(
          message.uncles[0],
          EthereumUtilities.safeParse(
              '0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527334'));
      expect(
          message.uncles[1],
          EthereumUtilities.safeParse(
              '0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527335'));
      expect(message.transactionsAreHashes, isTrue);
      print(message);
    });
    test('Block - transactions are objects', () {
      final Map<String, dynamic> block = <String, dynamic>{
        'result': <String, dynamic>{
          'number': '0x1b4', // 436
          'hash':
              '0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331',
          'parentHash':
              '0x9646252be9520f6e71339a8df9c55e4d7619deeb018d2a3f2d21fc165dde5eb5',
          'nonce':
              '0xe04d296d2460cfb8472af2c5fd05b5a214109c25688d3704aed5484f9a7792f2',
          'sha3Uncles':
              '0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347',
          'logsBloom':
              '0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331',
          'transactionsRoot':
              '0x56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421',
          'stateRoot':
              '0xd5855eb08b3387c0af375e9cdb6acfc05eb8f519e419b874b6ff2ffda7ed1dff',
          'miner': '0x4e65fda2159562a496f9f3522f89122a3088497a',
          'difficulty': '0x027f07', // 163591
          'totalDifficulty': '0x027f07', // 163591
          'extraData':
              '0x0000000000000000000000000000000000000000000000000000000000000000',
          'size': '0x027f07', // 163591
          'gasLimit': '0x9f759', // 653145
          'gasUsed': '0x9f759', // 653145
          'timestamp': '0x54e34e8e', // 1424182926
          'transactions': <dynamic>[
            <String, dynamic>{
              'hash':
                  '0xc6ef2fc5426d6ad6fd9e2a26abeab0aa2411b7ab17f30a99d3cb96aed1d1055b',
              'nonce': '0x0',
              'blockHash':
                  '0xbeab0aa2411b7ab17f30a99d3cb9c6ef2fc5426d6ad6fd9e2a26a6aed1d1055b',
              'blockNumber': '0x15df', // 5599
              'transactionIndex': '0x1', // 1
              'from': '0x407d73d8a49eeb85d32cf465507dd71d507100c1',
              'to': '0x85a43d8a49eeb85d32cf465507dd71d507100c1',
              'value': '0x7f110', // 520464
              'gas': '0x7f111', // 520465
              'gasPrice': '0x09184e72a000',
              'input':
                  '0x603880600c6000396000f300603880600c6000396000f3603880600c6000396000f360'
            },
            <String, dynamic>{
              'hash':
                  '0xc6ef2fc5426d6ad6fd9e2a26abeab0aa2411b7ab17f30a99d3cb96aed1d1055b',
              'nonce': '0x1',
              'blockHash':
                  '0xbeab0aa2411b7ab17f30a99d3cb9c6ef2fc5426d6ad6fd9e2a26a6aed1d1055b',
              'blockNumber': '0x15df', // 5599
              'transactionIndex': '0x1', // 1
              'from': '0x407d73d8a49eeb85d32cf465507dd71d507100c1',
              'to': '0x85a43d8a49eeb85d32cf465507dd71d507100c1',
              'value': '0x7f110', // 520464
              'gas': '0x7f111', // 520465
              'gasPrice': '0x09184e72a000',
              'input':
                  '0x603880600c6000396000f300603880600c6000396000f3603880600c6000396000f360'
            }
          ],
          'uncles': <String>[
            '0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527334',
            '0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527335'
          ]
        }
      };
      final EthereumBlock message = EthereumBlock.fromMap(block);
      expect(message.number, 436);
      expect(
          message.hash,
          EthereumUtilities.safeParse(
              '0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331'));
      expect(
          message.parentHash,
          EthereumUtilities.safeParse(
              '0x9646252be9520f6e71339a8df9c55e4d7619deeb018d2a3f2d21fc165dde5eb5'));
      expect(
          message.nonce,
          EthereumUtilities.safeParse(
              '0xe04d296d2460cfb8472af2c5fd05b5a214109c25688d3704aed5484f9a7792f2'));
      expect(
          message.sha3Uncles,
          EthereumUtilities.safeParse(
              '0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347'));
      expect(
          message.logsBloom,
          EthereumUtilities.safeParse(
              '0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331'));
      expect(
          message.transactionsRoot,
          EthereumUtilities.safeParse(
              '0x56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421'));
      expect(
          message.stateRoot,
          EthereumUtilities.safeParse(
              '0xd5855eb08b3387c0af375e9cdb6acfc05eb8f519e419b874b6ff2ffda7ed1dff'));
      expect(
          message.miner,
          EthereumUtilities.safeParse(
              '0x4e65fda2159562a496f9f3522f89122a3088497a'));
      expect(message.difficulty, 163591);
      expect(message.totalDifficulty, 163591);
      expect(message.extraData, BigInt.zero);
      expect(message.size, 163591);
      expect(message.gasLimit, 653145);
      expect(message.gasUsed, 653145);
      expect(message.timestamp.millisecondsSinceEpoch, 1424182926);
      expect(message.transactions.length, 2);
      expect(message.transactions[0].nonce, 0);
      expect(message.transactions[1].nonce, 1);
      expect(
          message.uncles[0],
          EthereumUtilities.safeParse(
              '0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527334'));
      expect(
          message.uncles[1],
          EthereumUtilities.safeParse(
              '0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527335'));
      expect(message.transactionsAreHashes, isFalse);
    });
    test('Log - null', () {
      final Map<String, dynamic> log = <String, dynamic>{
        'result': <String, dynamic>{}
      };
      final EthereumLog message = EthereumLog.fromMap(log);
      expect(message.logIndex, isNull);
      expect(message.blockNumber, isNull);
      expect(message.blockHash, isNull);
      expect(message.transactionHash, isNull);
      expect(message.transactionIndex, isNull);
      expect(message.address, isNull);
      expect(message.data, isNull);
      expect(message.topics, isNull);
      final EthereumLog message1 = EthereumLog();
      print(message1);
    });
    test('Log', () {
      final Map<String, dynamic> log = <String, dynamic>{
        'result': <String, dynamic>{
          'removed': false,
          'logIndex': '0x1', // 1
          'blockNumber': '0x1b4', // 436
          'blockHash':
              '0x8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcfdf829c5a142f1fccd7d',
          'transactionHash':
              '0xdf829c5a142f1fccd7d8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcf',
          'transactionIndex': '0x0', // 0
          'address': '0x16c5785ac562ff41e2dcfdf829c5a142f1fccd7d',
          'data':
              '0x0000000000000000000000000000000000000000000000000000000000000000',
          'topics': <String>[
            '0x59ebeb90bc63057b6515673c3ecf9438e5058bca0f92585014eced636878c9a5'
          ]
        }
      };
      final EthereumLog message = EthereumLog.fromMap(log);
      expect(message.removed, false);
      expect(message.logIndex, 1);
      expect(message.blockNumber, 436);
      expect(
          message.blockHash,
          EthereumUtilities.safeParse(
              '0x8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcfdf829c5a142f1fccd7d'));
      expect(
          message.transactionHash,
          EthereumUtilities.safeParse(
              '0xdf829c5a142f1fccd7d8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcf'));
      expect(message.transactionIndex, 0);
      expect(
          message.address,
          EthereumUtilities.safeParse(
              '0x16c5785ac562ff41e2dcfdf829c5a142f1fccd7d'));
      expect(message.data, BigInt.zero);
      expect(message.topics, isNotNull);
      expect(message.topics.length, 1);
      expect(
          message.topics[0],
          EthereumUtilities.safeParse(
              '0x59ebeb90bc63057b6515673c3ecf9438e5058bca0f92585014eced636878c9a5'));
      print(message);
    });
    test('Transaction receipt - null', () {
      final Map<String, dynamic> tr = <String, dynamic>{
        'result': <String, dynamic>{}
      };
      final EthereumTransactionReceipt message =
          EthereumTransactionReceipt.fromMap(tr);
      expect(message.transactionHash, isNull);
      expect(message.transactionIndex, isNull);
      expect(message.blockNumber, isNull);
      expect(message.blockHash, isNull);
      expect(message.cumulativeGasUsed, isNull);
      expect(message.gasUsed, isNull);
      expect(message.contractAddress, isNull);
      expect(message.logs, isNull);
      expect(message.logsBloom, isNull);
      expect(message.root, isNull);
      expect(message.status, isNull);
    });
    test('Transaction receipt - status', () {
      final Map<String, dynamic> tr = <String, dynamic>{
        'result': <String, dynamic>{
          'transactionHash':
              '0xb903239f8543d04b5dc1ba6579132b143087c68db1b2168786408fcbce568238',
          'transactionIndex': '0x1',
          // 1
          'blockNumber': '0xb',
          // 11
          'blockHash':
              '0xc6ef2fc5426d6ad6fd9e2a26abeab0aa2411b7ab17f30a99d3cb96aed1d1055b',
          'cumulativeGasUsed': '0x33bc',
          // 13244
          'gasUsed': '0x4dc',
          // 1244
          'contractAddress': '0xb60e8dd61c5d32be8058bb8eb970870f07233155',
          // or null, if none was created
          'logs': <dynamic>[
            <String, dynamic>{
              'logIndex': '0x1', // 1
              'blockNumber': '0x1b4', // 436
              'blockHash':
                  '0x8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcfdf829c5a142f1fccd7d',
              'transactionHash':
                  '0xdf829c5a142f1fccd7d8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcf',
              'transactionIndex': '0x0', // 0
              'address': '0x16c5785ac562ff41e2dcfdf829c5a142f1fccd7d',
              'data':
                  '0x0000000000000000000000000000000000000000000000000000000000000000',
              'topics': <String>[
                '0x59ebeb90bc63057b6515673c3ecf9438e5058bca0f92585014eced636878c9a5'
              ]
            },
            <String, dynamic>{
              'logIndex': '0x2', // 1
              'blockNumber': '0x1b4', // 436
              'blockHash':
                  '0x8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcfdf829c5a142f1fccd7d',
              'transactionHash':
                  '0xdf829c5a142f1fccd7d8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcf',
              'transactionIndex': '0x0', // 0
              'address': '0x16c5785ac562ff41e2dcfdf829c5a142f1fccd7d',
              'data':
                  '0x0000000000000000000000000000000000000000000000000000000000000000',
              'topics': <String>[
                '0x59ebeb90bc63057b6515673c3ecf9438e5058bca0f92585014eced636878c9a5'
              ]
            }
          ],
          'logsBloom': '0x0',
          // 256 byte bloom filter
          'status': '0x1'
        }
      };
      final EthereumTransactionReceipt message =
          EthereumTransactionReceipt.fromMap(tr);
      expect(
          message.transactionHash,
          EthereumUtilities.safeParse(
              '0xb903239f8543d04b5dc1ba6579132b143087c68db1b2168786408fcbce568238'));
      expect(message.transactionIndex, 1);
      expect(message.blockNumber, 11);
      expect(
          message.blockHash,
          EthereumUtilities.safeParse(
              '0xc6ef2fc5426d6ad6fd9e2a26abeab0aa2411b7ab17f30a99d3cb96aed1d1055b'));
      expect(message.cumulativeGasUsed, 13244);
      expect(message.gasUsed, 1244);
      expect(
          message.contractAddress,
          EthereumUtilities.safeParse(
              '0xb60e8dd61c5d32be8058bb8eb970870f07233155'));
      expect(message.logs, isNotNull);
      expect(message.logs.length, 2);
      expect(message.logs[0].logIndex, 1);
      expect(message.logs[1].logIndex, 2);
      expect(message.logsBloom, BigInt.zero);
      expect(message.status, 1);
      expect(message.root, isNull);
      print(message);
      final EthereumTransactionReceipt message1 = EthereumTransactionReceipt();
      print(message1);
    });
    test('Transaction receipt - root', () {
      final Map<String, dynamic> tr = <String, dynamic>{
        'result': <String, dynamic>{
          'transactionHash':
              '0xb903239f8543d04b5dc1ba6579132b143087c68db1b2168786408fcbce568238',
          'transactionIndex': '0x1',
          // 1
          'blockNumber': '0xb',
          // 11
          'blockHash':
              '0xc6ef2fc5426d6ad6fd9e2a26abeab0aa2411b7ab17f30a99d3cb96aed1d1055b',
          'cumulativeGasUsed': '0x33bc',
          // 13244
          'gasUsed': '0x4dc',
          // 1244
          'contractAddress': '0xb60e8dd61c5d32be8058bb8eb970870f07233155',
          // or null, if none was created
          'logs': <dynamic>[
            <String, dynamic>{
              'logIndex': '0x1', // 1
              'blockNumber': '0x1b4', // 436
              'blockHash':
                  '0x8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcfdf829c5a142f1fccd7d',
              'transactionHash':
                  '0xdf829c5a142f1fccd7d8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcf',
              'transactionIndex': '0x0', // 0
              'address': '0x16c5785ac562ff41e2dcfdf829c5a142f1fccd7d',
              'data':
                  '0x0000000000000000000000000000000000000000000000000000000000000000',
              'topics': <String>[
                '0x59ebeb90bc63057b6515673c3ecf9438e5058bca0f92585014eced636878c9a5'
              ]
            },
            <String, dynamic>{
              'logIndex': '0x2', // 1
              'blockNumber': '0x1b4', // 436
              'blockHash':
                  '0x8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcfdf829c5a142f1fccd7d',
              'transactionHash':
                  '0xdf829c5a142f1fccd7d8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcf',
              'transactionIndex': '0x0', // 0
              'address': '0x16c5785ac562ff41e2dcfdf829c5a142f1fccd7d',
              'data':
                  '0x0000000000000000000000000000000000000000000000000000000000000000',
              'topics': <String>[
                '0x59ebeb90bc63057b6515673c3ecf9438e5058bca0f92585014eced636878c9a5'
              ]
            }
          ],
          'logsBloom': '0x0',
          // 256 byte bloom filter
          'root':
              '0x59ebeb90bc63057b6515673c3ecf9438e5058bca0f92585014eced636878c9a5'
        }
      };
      final EthereumTransactionReceipt message =
          EthereumTransactionReceipt.fromMap(tr);
      expect(
          message.transactionHash,
          EthereumUtilities.safeParse(
              '0xb903239f8543d04b5dc1ba6579132b143087c68db1b2168786408fcbce568238'));
      expect(message.transactionIndex, 1);
      expect(message.blockNumber, 11);
      expect(
          message.blockHash,
          EthereumUtilities.safeParse(
              '0xc6ef2fc5426d6ad6fd9e2a26abeab0aa2411b7ab17f30a99d3cb96aed1d1055b'));
      expect(message.cumulativeGasUsed, 13244);
      expect(message.gasUsed, 1244);
      expect(
          message.contractAddress,
          EthereumUtilities.safeParse(
              '0xb60e8dd61c5d32be8058bb8eb970870f07233155'));
      expect(message.logs, isNotNull);
      expect(message.logs.length, 2);
      expect(message.logs[0].logIndex, 1);
      expect(message.logs[1].logIndex, 2);
      expect(message.logsBloom, BigInt.zero);
      expect(
          message.root,
          EthereumUtilities.safeParse(
              '0x59ebeb90bc63057b6515673c3ecf9438e5058bca0f92585014eced636878c9a5'));
      expect(message.status, isNull);
    });
  });
  test('Filter - null', () {
    final Map<String, dynamic> filter = <String, dynamic>{
      'result': <String, dynamic>{}
    };
    final EthereumFilter message = EthereumFilter.fromMap(filter);
    expect(message.logs, isNull);
    expect(message.hashes, isNull);
    final EthereumFilter message1 = EthereumFilter();
    print(message1);
  });
  test('Filter - hashes', () {
    final Map<String, dynamic> filter = <String, dynamic>{
      'result': <String>[
        '0x8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcfdf829c5a142f1fccd7d',
        '0x8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcfdf829c5a142f1fccd7e'
      ]
    };
    final EthereumFilter message = EthereumFilter.fromMap(filter);
    expect(message.logs, isNull);
    expect(message.hashes, isNotNull);
    expect(message.hashes.length, 2);
    expect(
        message.hashes[0],
        EthereumUtilities.safeParse(
            '0x8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcfdf829c5a142f1fccd7d'));
    expect(
        message.hashes[1],
        EthereumUtilities.safeParse(
            '0x8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcfdf829c5a142f1fccd7e'));
  });
  test('Filter - logs', () {
    final Map<String, dynamic> filter = <String, dynamic>{
      'result': <dynamic>[
        <String, dynamic>{
          'logIndex': '0x1', // 1
          'blockNumber': '0x1b4', // 436
          'blockHash':
              '0x8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcfdf829c5a142f1fccd7d',
          'transactionHash':
              '0xdf829c5a142f1fccd7d8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcf',
          'transactionIndex': '0x0', // 0
          'address': '0x16c5785ac562ff41e2dcfdf829c5a142f1fccd7d',
          'data':
              '0x0000000000000000000000000000000000000000000000000000000000000000',
          'topics': <String>[
            '0x59ebeb90bc63057b6515673c3ecf9438e5058bca0f92585014eced636878c9a5'
          ]
        },
        <String, dynamic>{
          'logIndex': '0x2', // 1
          'blockNumber': '0x1b4', // 436
          'blockHash':
              '0x8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcfdf829c5a142f1fccd7d',
          'transactionHash':
              '0xdf829c5a142f1fccd7d8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcf',
          'transactionIndex': '0x0', // 0
          'address': '0x16c5785ac562ff41e2dcfdf829c5a142f1fccd7d',
          'data':
              '0x0000000000000000000000000000000000000000000000000000000000000000',
          'topics': <String>[
            '0x59ebeb90bc63057b6515673c3ecf9438e5058bca0f92585014eced636878c9a5'
          ]
        }
      ]
    };
    final EthereumFilter message = EthereumFilter.fromMap(filter);
    expect(message.hashes, isNull);
    expect(message.logs, isNotNull);
    expect(message.logs.length, 2);
    expect(message.logs[0].logIndex, 1);
    expect(message.logs[1].logIndex, 2);
  });
  test('Work - null', () {
    final List<String> work = <String>[];
    final EthereumWork message = EthereumWork.fromList(work);
    expect(message.powHash, isNull);
    expect(message.seedHash, isNull);
    expect(message.boundaryCondition, isNull);
  });
  test('Work', () {
    final List<String> work = <String>[
      '0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef',
      '0x5EED00000000000000000000000000005EED0000000000000000000000000000',
      '0xd1ff1c01710000000000000000000000d1ff1c01710000000000000000000000'
    ];
    final EthereumWork message = EthereumWork.fromList(work);
    expect(
        message.powHash,
        EthereumUtilities.safeParse(
            '0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef'));
    expect(
        message.seedHash,
        EthereumUtilities.safeParse(
            '0x5EED00000000000000000000000000005EED0000000000000000000000000000'));
    expect(
        message.boundaryCondition,
        EthereumUtilities.safeParse(
            '0xd1ff1c01710000000000000000000000d1ff1c01710000000000000000000000'));
    print(message);
    final EthereumWork message1 = EthereumWork();
    print(message1);
  });
  test('Work - insufficient elements', () {
    final List<String> work = <String>[
      '0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef',
      '0x5EED00000000000000000000000000005EED0000000000000000000000000000'
    ];
    final EthereumWork message = EthereumWork.fromList(work);
    expect(message.powHash, isNull);
    expect(message.seedHash, isNull);
    expect(message.boundaryCondition, isNull);
  });

  group('Parameter tests', () {
    test('Default block - default', () {
      final EthereumDefaultBlock block = EthereumDefaultBlock();
      expect(block.earliest, isFalse);
      expect(block.latest, isTrue);
      expect(block.pending, isFalse);
      expect(block.number, isNull);
      expect(block.getSelection(), EthereumDefaultBlock.ethLatest);
    });
    test('Default block - earliest', () {
      final EthereumDefaultBlock block = EthereumDefaultBlock();
      block.earliest = false;
      expect(block.earliest, isTrue);
      expect(block.latest, isFalse);
      expect(block.pending, isFalse);
      expect(block.number, isNull);
      expect(block.getSelection(), EthereumDefaultBlock.ethEarliest);
    });
    test('Default block - latest', () {
      final EthereumDefaultBlock block = EthereumDefaultBlock();
      block.latest = false;
      expect(block.earliest, isFalse);
      expect(block.latest, isTrue);
      expect(block.pending, isFalse);
      expect(block.number, isNull);
      expect(block.getSelection(), EthereumDefaultBlock.ethLatest);
    });
    test('Default block - pending', () {
      final EthereumDefaultBlock block = EthereumDefaultBlock();
      block.pending = false;
      expect(block.earliest, isFalse);
      expect(block.latest, isFalse);
      expect(block.pending, isTrue);
      expect(block.number, isNull);
      expect(block.getSelection(), EthereumDefaultBlock.ethPending);
    });
    test('Default block - blockNumber', () {
      final EthereumDefaultBlock block = EthereumDefaultBlock();
      block.number = 0x1b4;
      expect(block.earliest, isFalse);
      expect(block.latest, isFalse);
      expect(block.pending, isFalse);
      expect(block.number, 0x1b4);
      expect(block.getSelection(), '0x1b4');
    });
  });

  group('Error tests', () {
    test('Default', () {
      final EthereumError error = EthereumError();
      expect(error.code, 0);
      expect(error.message, EthereumError.noError);
      expect(error.id, EthereumError.noId);
      expect(error.timestamp, isNull);
      expect(error.toString(), 'Code : 0 <> Message : No Error <> Id : -1');
    });
    test('Update', () {
      final EthereumError error = EthereumError();
      error.updateError(10, 'An Error', 50);
      expect(error.code, 10);
      expect(error.message, 'An Error');
      expect(error.id, 50);
      expect(
          error.timestamp.millisecondsSinceEpoch <=
              DateTime.now().millisecondsSinceEpoch,
          isTrue);
      expect(error.toString(), 'Code : 10 <> Message : An Error <> Id : 50');
    });
  });

  group('Null parameter tests - admin', () {
    final EthereumServerClient client = EthereumServerClient();
    test('personalImportRawKey - keydata', () async {
      bool thrown = false;
      try {
        await client.admin.personalImportRawKey(null, '');
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::personalImportRawKey - keydata): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('personalImportRawKey - passphrase', () async {
      bool thrown = false;
      try {
        await client.admin.personalImportRawKey('', null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::personalImportRawKey - passphrase): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('personalLockAccount - address', () async {
      bool thrown = false;
      try {
        await client.admin.personalLockAccount(null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::personalLockAccount - address): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('personalNewAccount - passphrase', () async {
      bool thrown = false;
      try {
        await client.admin.personalNewAccount(null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::personalNewAccount - passphrase): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('personalUnlockAccount - address', () async {
      bool thrown = false;
      try {
        await client.admin.personalUnlockAccount(null, '');
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::personalUnlockAccount - address): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('personalUnlockAccount - passphrase', () async {
      bool thrown = false;
      try {
        await client.admin.personalUnlockAccount(BigInt.zero, null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::personalUnlockAccount - passphrase): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('personalSendTransaction - address', () async {
      bool thrown = false;
      try {
        await client.admin
            .personalSendTransaction(null, BigInt.zero, 'password');
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::personalSendTransaction - address): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('personalSendTransaction - to', () async {
      bool thrown = false;
      try {
        await client.admin
            .personalSendTransaction(BigInt.zero, null, 'password');
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::personalSendTransaction - to): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('personalSendTransaction - passphrase', () async {
      bool thrown = false;
      try {
        await client.admin
            .personalSendTransaction(BigInt.zero, BigInt.zero, null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::personalSendTransaction - passphrase): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('personalSign - message', () async {
      bool thrown = false;
      try {
        await client.admin.personalSign(null, BigInt.zero, 'password');
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::personalSign - message): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('personalSign - address', () async {
      bool thrown = false;
      try {
        await client.admin.personalSign(BigInt.zero, null, 'password');
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::personalSign - address): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('personalEcRecover - message', () async {
      bool thrown = false;
      try {
        await client.admin.personalEcRecover(null, BigInt.zero);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::personalEcRecover - message): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test('personalEcRecover - signature', () async {
      bool thrown = false;
      try {
        await client.admin.personalEcRecover(BigInt.zero, null);
      } on Error catch (e) {
        expect(e is ArgumentError, isTrue);
        expect(e.toString(),
            'Invalid argument(s) (Ethereum::personalEcRecover - signature): Must not be null');
        thrown = true;
      }
      expect(thrown, isTrue);
    });
  });
}
