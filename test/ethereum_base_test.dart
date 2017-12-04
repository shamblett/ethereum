/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

@TestOn("vm")
import 'package:ethereum/ethereum_server_client.dart';
import 'package:ethereum/ethereum.dart';
import 'package:test/test.dart';

/// These test are common to both server and client, we use the server client for convenience.

void main() {
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
      expect(client.port, Ethereum.defaultPort);
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
      expect(client.port, Ethereum.defaultPort);
    });

    test("connectParameters - Null", () {
      bool thrown = false;
      try {
        client.connectParameters(null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::connectParameters - hostname): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });

    test("connectParameters - OK with port", () {
      client.connectParameters("localhost", 3000);
      expect(client.host, "localhost");
      expect(client.port, 3000);
    });

    test("connectParameters - OK no port", () {
      client.connectParameters("localhost");
      expect(client.host, "localhost");
      expect(client.port, Ethereum.defaultPort);
    });
  });

  group("Null parameter tests", () {
    final EthereumServerClient client = new EthereumServerClient();
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
        await client.getBalance("", null);
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
        await client.getStorageAt("", "", null);
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
        await client.getStorageAt("", null, "");
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
        await client.getStorageAt(null, "", "");
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::getStorageAt - address): Must not be null");
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
        await client.getCode("", null);
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
        await client.sign(null, "");
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
        await client.sign("", null);
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
        await client.sendTransaction(null, "");
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
        await client.sendTransaction("", null);
      } catch (e) {
        expect((e is ArgumentError), isTrue);
        expect(e.toString(),
            "Invalid argument(s) (Ethereum::sendTransaction - data): Must not be null");
        thrown = true;
      }
      expect(thrown, isTrue);
    });
  });
}
