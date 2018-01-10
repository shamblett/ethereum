/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

@TestOn("vm")
import 'package:ethereum/ethereum_server_client.dart';
import 'package:ethereum/ethereum.dart';
import 'package:bignum/bignum.dart';
import 'package:test/test.dart';

/// These test are common to both server and client, we use the server client for convenience.

void main() {
  group("Utilities", () {
    test("Int to hex", () {
      final int testInt = 0xabcdef123450;
      final String val = EthereumUtilities.intToHex(testInt);
      expect(val, "0xabcdef123450");
    });
    test("Int to hex - pad", () {
      final int testInt = 0x1;
      final String val = EthereumUtilities.intToHex(testInt, 8);
      expect(val, "0x0000000000000001");
    });
    test("Int to hex  - pad negative", () {
      bool thrown = false;
      try {
        EthereumUtilities.intToHex(1, -2);
      } catch (e) {
        expect((e is FormatException), isTrue);
        expect(e.toString(),
            "FormatException: EthereumUtilities:: intToHex - invalid pad value, -2");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Int to hex  - pad odd", () {
      bool thrown = false;
      try {
        EthereumUtilities.intToHex(1, 3);
      } catch (e) {
        expect((e is FormatException), isTrue);
        expect(e.toString(),
            "FormatException: EthereumUtilities:: intToHex - invalid pad value, 3");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Hex to int - valid", () {
      final String testString = "0xabcdef12345";
      final int val = EthereumUtilities.hexToInt(testString);
      expect(val, 0xabcdef12345);
    });
    test("Hex to int - invalid", () {
      final String testString = "abcdef12345";
      final int val = EthereumUtilities.hexToInt(testString);
      expect(val, isNull);
    });
  });

  group("Connection tests", () {
    final EthereumServerClient client = new EthereumServerClient();
    test("connectString - Null", () {
      bool thrown = false;
      try {
        client.connectString(null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::connectString - hostname): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });

    test("connectString - OK with port", () {
      client.connectString("http://localhost:2000");
      expect(client.host, "localhost");
      expect(client.port, 2000);
    });

    test("connectString - OK no port", () {
      client.connectString("http://localhost1");
      expect(client.host, "localhost1");
      expect(client.port, Ethereum.defaultHttpPort);
    });

    test("connectUri - Null", () {
      bool thrown = false;
      try {
        client.connectUri(null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::connectUri - uri): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });

    test("connectUri - OK with port", () {
      final Uri uri = Uri.parse("http://localhost:2000");
      client.connectUri(uri);
      expect(client.host, "localhost");
      expect(client.port, 2000);
    });

    test("connectUri - OK no port", () {
      final Uri uri = Uri.parse("http://localhost");
      client.connectUri(uri);
      expect(client.host, "localhost");
      expect(client.port, Ethereum.defaultHttpPort);
    });

    test("connectParameters - Hostname Null", () {
      bool thrown = false;
      try {
        client.connectParameters(Ethereum.rpcHttpScheme, null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::connectParameters - hostname): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });

    test("connectParameters - Invalid scheme", () {
      bool thrown = false;
      try {
        client.connectParameters("Billy", "localhost");
      } catch (e) {
        expect((e is FormatException), isTrue);
        expect(e.toString(),
            "FormatException: Ethereum::connectParameters - invalid scheme Billy");
        thrown = true;
      }
      expect(thrown, isTrue);
    });

    test("connectParameters - OK with port", () {
      client.connectParameters(Ethereum.rpcHttpScheme, "localhost", 3000);
      expect(client.host, "localhost");
      expect(client.port, 3000);
    });

    test("connectParameters - OK no port - http", () {
      client.connectParameters(Ethereum.rpcHttpScheme, "localhost");
      expect(client.host, "localhost");
      expect(client.port, Ethereum.defaultHttpPort);
    });
    test("connectParameters - OK no port - ws", () {
      client.connectParameters(Ethereum.rpcWsScheme, "localhost");
      expect(client.host, "localhost");
      expect(client.port, Ethereum.defaultWsPort);
    });
  });

  group("Null parameter tests", () {
    final EthereumServerClient client = new EthereumServerClient();
    test("Sha3 - data", () async {
      bool thrown = false;
      try {
        await client.sha3(null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::sha3 - data): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Balance - account number", () async {
      bool thrown = false;
      try {
        await client.getBalance(null, "");
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getBalance - accountNumber): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Balance - block", () async {
      bool thrown = false;
      try {
        await client.getBalance(BigInteger.ZERO, null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getBalance - block): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Storage at - block", () async {
      bool thrown = false;
      try {
        await client.getStorageAt(BigInteger.ONE, 2, null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getStorageAt - block): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Storage at - pos", () async {
      bool thrown = false;
      try {
        await client.getStorageAt(BigInteger.ONE, null, "");
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getStorageAt - pos): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Storage at - address", () async {
      bool thrown = false;
      try {
        await client.getStorageAt(null, 1, "");
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getStorageAt - address): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Block transaction count - address", () async {
      bool thrown = false;
      try {
        await client.getTransactionCount(null, "");
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getTransactionCount - address): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Block transaction count - block", () async {
      bool thrown = false;
      try {
        await client.getTransactionCount(1, null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getTransactionCount - block): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Block transaction count by hash", () async {
      bool thrown = false;
      try {
        await client.getBlockTransactionCountByHash(null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getBlockTransactionCountByHash - blockHash): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Block transaction count by number", () async {
      bool thrown = false;
      try {
        await client.getBlockTransactionCountByNumber(null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getBlockTransactionCountByNumber - blockNumber): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Block uncle count by hash", () async {
      bool thrown = false;
      try {
        await client.getUncleCountByHash(null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getUncleCountByHash - blockHash): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Block uncle count by number", () async {
      bool thrown = false;
      try {
        await client.getUncleCountByNumber(null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getUncleCountByNumber - blockNumber): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Code - address", () async {
      bool thrown = false;
      try {
        await client.getCode(null, "");
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getCode - address): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Code - block", () async {
      bool thrown = false;
      try {
        await client.getCode(2, null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getCode - block): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Sign - account", () async {
      bool thrown = false;
      try {
        await client.sign(null, 0);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::sign - account): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Sign - message", () async {
      bool thrown = false;
      try {
        await client.sign(0, null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::sign - message): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Send transaction - address", () async {
      bool thrown = false;
      try {
        await client.sendTransaction(null, 0);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::sendTransaction - address): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Send transaction - data", () async {
      bool thrown = false;
      try {
        await client.sendTransaction(0, null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::sendTransaction - data): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Send raw transaction", () async {
      bool thrown = false;
      try {
        await client.sendRawTransaction(null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::sendRawTransaction - signedTransaction): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Call - address", () async {
      bool thrown = false;
      try {
        await client.call(null, "");
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::call - address): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Call - block", () async {
      bool thrown = false;
      try {
        await client.call(0, null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::call - block): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Get block by hash", () async {
      bool thrown = false;
      try {
        await client.getBlockByHash(null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getBlockByHash - blockHash): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Get block by number", () async {
      bool thrown = false;
      try {
        await client.getBlockByNumber(null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getBlockByNumber - blockNumber): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Get transaction by hash", () async {
      bool thrown = false;
      try {
        await client.getTransactionByHash(null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getTransactionByHash - hash): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Get transaction by block hash and index - block hash", () async {
      bool thrown = false;
      try {
        await client.getTransactionByBlockHashAndIndex(null, 0);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getTransactionByBlockHashAndIndex - blockHash): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Get transaction by block hash and index - index", () async {
      bool thrown = false;
      try {
        await client.getTransactionByBlockHashAndIndex(0, null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getTransactionByBlockHashAndIndex - index): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Get transaction by block number and index - block number", () async {
      bool thrown = false;
      try {
        await client.getTransactionByBlockNumberAndIndex(null, 0);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getTransactionByBlockNumberAndIndex - blockNumber): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Get transaction by block number and index - index", () async {
      bool thrown = false;
      try {
        await client.getTransactionByBlockNumberAndIndex(0, null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getTransactionByBlockNumberAndIndex - index): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Get transaction receipt", () async {
      bool thrown = false;
      try {
        await client.getTransactionReceipt(null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getTransactionReceipt - transactionHash): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Get uncle by block hash and index - block hash", () async {
      bool thrown = false;
      try {
        await client.getUncleByBlockHashAndIndex(null, 0);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getUncleByBlockHashAndIndex - blockHash): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Get uncle by block hash and index - index", () async {
      bool thrown = false;
      try {
        await client.getUncleByBlockHashAndIndex(0, null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getUncleByBlockHashAndIndex - index): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Get uncle by block number and index - block number", () async {
      bool thrown = false;
      try {
        await client.getUncleByBlockNumberAndIndex(null, 0);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getUncleByBlockNumberAndIndex - blockNumber): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Get uncle by block number and index - index", () async {
      bool thrown = false;
      try {
        await client.getUncleByBlockNumberAndIndex(0, null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getUncleByBlockNumberAndIndex - index): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Uninstall filter", () async {
      bool thrown = false;
      try {
        await client.uninstallFilter(null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::uninstallFilter - filterId): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Get filter changes", () async {
      bool thrown = false;
      try {
        await client.getFilterChanges(null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getFilterChanges - filterId): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Get filter logs", () async {
      bool thrown = false;
      try {
        await client.getFilterLogs(null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getFilterLogs - filterId): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Submit work - nonce", () async {
      bool thrown = false;
      try {
        await client.submitWork(null, 1, 2);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::submitWork - nonce): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Submit work - powHash", () async {
      bool thrown = false;
      try {
        await client.submitWork(1, null, 2);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::submitWork - powHash): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Submit work - digest", () async {
      bool thrown = false;
      try {
        await client.submitWork(1, 1, null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::submitWork - digest): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Submit hash rate - hash rate", () async {
      bool thrown = false;
      try {
        await client.submitHashrate(null, 2);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::submitHashRate - hashRate): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Submit hash rate - id", () async {
      bool thrown = false;
      try {
        await client.submitHashrate(1, null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::submitHashRate - id): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Shh Post - topics", () async {
      bool thrown = false;
      try {
        await client.shhPost(null, 1, 2, 3);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::shhPost - topics): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Shh Post - payload", () async {
      bool thrown = false;
      try {
        await client.shhPost([1], null, 2, 3);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::shhPost - payload): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Shh Post - priority", () async {
      bool thrown = false;
      try {
        await client.shhPost([1], 1, null, 3);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::shhPost - priority): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
    test("Shh Post - ttl", () async {
      bool thrown = false;
      try {
        await client.shhPost([1], 1, 2, null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::shhPost - ttl): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
  });

  group("Message tests", () {
    test("Sync status - no sync", () {
      final Map nosync = {"result": false};
      final EthereumSyncStatus message = new EthereumSyncStatus.fromMap(nosync);
      expect(message.syncing, isFalse);
      expect(message.currentBlock, isNull);
      expect(message.highestBlock, isNull);
      expect(message.startingBlock, isNull);
    });
    test("Sync status - sync", () {
      final Map sync = {
        'startingBlock': '0x384',
        'currentBlock': '0x386',
        'highestBlock': '0x454'
      };
      final EthereumSyncStatus message = new EthereumSyncStatus.fromMap(sync);
      expect(message.syncing, isTrue);
      expect(message.currentBlock, 0x386);
      expect(message.highestBlock, 0x454);
      expect(message.startingBlock, 0x384);
    });
    test("Transaction - null", () {
      final Map transaction = {"result": null};

      final EthereumTransaction message =
      new EthereumTransaction.fromMap(transaction);
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
    });

    test("Transaction", () {
      final Map transaction = {
        "result": {
          "hash":
          "0xc6ef2fc5426d6ad6fd9e2a26abeab0aa2411b7ab17f30a99d3cb96aed1d1055b",
          "nonce": "0x0",
          "blockHash":
          "0xbeab0aa2411b7ab17f30a99d3cb9c6ef2fc5426d6ad6fd9e2a26a6aed1d1055b",
          "blockNumber": "0x15df", // 5599
          "transactionIndex": "0x1", // 1
          "from": "0x407d73d8a49eeb85d32cf465507dd71d507100c1",
          "to": "0x85a43d8a49eeb85d32cf465507dd71d507100c1",
          "value": "0x7f110", // 520464
          "gas": "0x7f111", // 520465
          "gasPrice": "0x09184e72a000",
          "input":
          "0x603880600c6000396000f300603880600c6000396000f3603880600c6000396000f360"
        }
      };

      final EthereumTransaction message =
      new EthereumTransaction.fromMap(transaction);
      expect(message.hash.intValue(),
          0xc6ef2fc5426d6ad6fd9e2a26abeab0aa2411b7ab17f30a99d3cb96aed1d1055b);
      expect(message.nonce, 0);
      expect(message.blockHash.intValue(),
          0xbeab0aa2411b7ab17f30a99d3cb9c6ef2fc5426d6ad6fd9e2a26a6aed1d1055b);
      expect(message.blockNumber, 5599);
      expect(message.transactionIndex, 1);
      expect(
          message.from.intValue(), 0x407d73d8a49eeb85d32cf465507dd71d507100c1);
      expect(message.to.intValue(), 0x85a43d8a49eeb85d32cf465507dd71d507100c1);
      expect(message.value, 520464);
      expect(message.gas, 520465);
      expect(message.gasPrice, 0x09184e72a000);
      expect(message.input.intValue(),
          0x603880600c6000396000f300603880600c6000396000f3603880600c6000396000f360);
    });
    test("Block - null", () {
      final Map block = {"result": null};

      final EthereumBlock message = new EthereumBlock.fromMap(block);
      expect(message.number, isNull);
      expect(message.hash, isNull);
      expect(message.parentHash, isNull);
      expect(message.nonce, isNull);
      expect(message.sha3Uncles, isNull);
      expect(message.logsBloom, isNull);
      expect(message.transactionsRoot, isNull);
      expect(message.stateRoot, isNull);
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
    });
    test("Block - transactions are hashes", () {
      final Map block = {
        "result": {
          "number": "0x1b4", // 436
          "hash":
          "0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331",
          "parentHash":
          "0x9646252be9520f6e71339a8df9c55e4d7619deeb018d2a3f2d21fc165dde5eb5",
          "nonce":
          "0xe04d296d2460cfb8472af2c5fd05b5a214109c25688d3704aed5484f9a7792f2",
          "sha3Uncles":
          "0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347",
          "logsBloom":
          "0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331",
          "transactionsRoot":
          "0x56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421",
          "stateRoot":
          "0xd5855eb08b3387c0af375e9cdb6acfc05eb8f519e419b874b6ff2ffda7ed1dff",
          "miner": "0x4e65fda2159562a496f9f3522f89122a3088497a",
          "difficulty": "0x027f07", // 163591
          "totalDifficulty": "0x027f07", // 163591
          "extraData":
          "0x0000000000000000000000000000000000000000000000000000000000000000",
          "size": "0x027f07", // 163591
          "gasLimit": "0x9f759", // 653145
          "gasUsed": "0x9f759", // 653145
          "timestamp": "0x54e34e8e", // 1424182926
          "transactions": [
            "0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527332",
            "0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527333"
          ],
          "uncles": [
            "0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527334",
            "0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527335"
          ]
        }
      };
      final EthereumBlock message = new EthereumBlock.fromMap(block);
      expect(message.number, 436);
      expect(message.hash.intValue(),
          0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331);
      expect(message.parentHash.intValue(),
          0x9646252be9520f6e71339a8df9c55e4d7619deeb018d2a3f2d21fc165dde5eb5);
      expect(message.nonce.intValue(),
          0xe04d296d2460cfb8472af2c5fd05b5a214109c25688d3704aed5484f9a7792f2);
      expect(message.sha3Uncles.intValue(),
          0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347);
      expect(message.logsBloom.intValue(),
          0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331);
      expect(message.transactionsRoot.intValue(),
          0x56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421);
      expect(message.stateRoot.intValue(),
          0xd5855eb08b3387c0af375e9cdb6acfc05eb8f519e419b874b6ff2ffda7ed1dff);
      expect(
          message.miner.intValue(), 0x4e65fda2159562a496f9f3522f89122a3088497a);
      expect(message.difficulty, 163591);
      expect(message.totalDifficulty, 163591);
      expect(message.extraData.intValue(), 0);
      expect(message.size, 163591);
      expect(message.gasLimit, 653145);
      expect(message.gasUsed, 653145);
      expect(message.timestamp.millisecondsSinceEpoch, 1424182926);
      expect(message.transactions[0].intValue(),
          0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527332);
      expect(message.transactions[1].intValue(),
          0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527333);
      expect(message.uncles[0].intValue(),
          0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527334);
      expect(message.uncles[1].intValue(),
          0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527335);
      expect(message.transactionsAreHashes, isTrue);
    });
    test("Block - transactions are objects", () {
      final Map block = {
        "result": {
          "number": "0x1b4", // 436
          "hash":
          "0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331",
          "parentHash":
          "0x9646252be9520f6e71339a8df9c55e4d7619deeb018d2a3f2d21fc165dde5eb5",
          "nonce":
          "0xe04d296d2460cfb8472af2c5fd05b5a214109c25688d3704aed5484f9a7792f2",
          "sha3Uncles":
          "0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347",
          "logsBloom":
          "0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331",
          "transactionsRoot":
          "0x56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421",
          "stateRoot":
          "0xd5855eb08b3387c0af375e9cdb6acfc05eb8f519e419b874b6ff2ffda7ed1dff",
          "miner": "0x4e65fda2159562a496f9f3522f89122a3088497a",
          "difficulty": "0x027f07", // 163591
          "totalDifficulty": "0x027f07", // 163591
          "extraData":
          "0x0000000000000000000000000000000000000000000000000000000000000000",
          "size": "0x027f07", // 163591
          "gasLimit": "0x9f759", // 653145
          "gasUsed": "0x9f759", // 653145
          "timestamp": "0x54e34e8e", // 1424182926
          "transactions": [
            {
              "hash":
              "0xc6ef2fc5426d6ad6fd9e2a26abeab0aa2411b7ab17f30a99d3cb96aed1d1055b",
              "nonce": "0x0",
              "blockHash":
              "0xbeab0aa2411b7ab17f30a99d3cb9c6ef2fc5426d6ad6fd9e2a26a6aed1d1055b",
              "blockNumber": "0x15df", // 5599
              "transactionIndex": "0x1", // 1
              "from": "0x407d73d8a49eeb85d32cf465507dd71d507100c1",
              "to": "0x85a43d8a49eeb85d32cf465507dd71d507100c1",
              "value": "0x7f110", // 520464
              "gas": "0x7f111", // 520465
              "gasPrice": "0x09184e72a000",
              "input":
              "0x603880600c6000396000f300603880600c6000396000f3603880600c6000396000f360"
            },
            {
              "hash":
              "0xc6ef2fc5426d6ad6fd9e2a26abeab0aa2411b7ab17f30a99d3cb96aed1d1055b",
              "nonce": "0x1",
              "blockHash":
              "0xbeab0aa2411b7ab17f30a99d3cb9c6ef2fc5426d6ad6fd9e2a26a6aed1d1055b",
              "blockNumber": "0x15df", // 5599
              "transactionIndex": "0x1", // 1
              "from": "0x407d73d8a49eeb85d32cf465507dd71d507100c1",
              "to": "0x85a43d8a49eeb85d32cf465507dd71d507100c1",
              "value": "0x7f110", // 520464
              "gas": "0x7f111", // 520465
              "gasPrice": "0x09184e72a000",
              "input":
              "0x603880600c6000396000f300603880600c6000396000f3603880600c6000396000f360"
            }
          ],
          "uncles": [
            "0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527334",
            "0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527335"
          ]
        }
      };
      final EthereumBlock message = new EthereumBlock.fromMap(block);
      expect(message.number, 436);
      expect(message.hash.intValue(),
          0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331);
      expect(message.parentHash.intValue(),
          0x9646252be9520f6e71339a8df9c55e4d7619deeb018d2a3f2d21fc165dde5eb5);
      expect(message.nonce.intValue(),
          0xe04d296d2460cfb8472af2c5fd05b5a214109c25688d3704aed5484f9a7792f2);
      expect(message.sha3Uncles.intValue(),
          0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347);
      expect(message.logsBloom.intValue(),
          0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331);
      expect(message.transactionsRoot.intValue(),
          0x56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421);
      expect(message.stateRoot.intValue(),
          0xd5855eb08b3387c0af375e9cdb6acfc05eb8f519e419b874b6ff2ffda7ed1dff);
      expect(
          message.miner.intValue(), 0x4e65fda2159562a496f9f3522f89122a3088497a);
      expect(message.difficulty, 163591);
      expect(message.totalDifficulty, 163591);
      expect(message.extraData.intValue(), 0);
      expect(message.size, 163591);
      expect(message.gasLimit, 653145);
      expect(message.gasUsed, 653145);
      expect(message.timestamp.millisecondsSinceEpoch, 1424182926);
      expect(message.transactions.length, 2);
      expect(message.transactions[0].nonce, 0);
      expect(message.transactions[1].nonce, 1);
      expect(message.uncles[0].intValue(),
          0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527334);
      expect(message.uncles[1].intValue(),
          0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527335);
      expect(message.transactionsAreHashes, isFalse);
    });
  });
}
