/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 12/09/2018
 * Copyright :  S.Hamblett
 *
 * The Ethereum client package
 */

part of ethereum;

/// This class implements the Ethereuum Admin API
class EthereumApiAdmin extends EthereumApi {
  EthereumApiAdmin(Ethereum client) : super(client);

  /// Imports the given unencrypted private key (byte string) into the key store,
  /// encrypting it with the passphrase.
  Future<BigInt> personalImportRawKey(String keydata, String passphrase) async {
    if (keydata == null) {
      throw ArgumentError.notNull("Ethereum::personalImportRawKey - keydata");
    }
    if (passphrase == null) {
      throw ArgumentError.notNull(
          "Ethereum::personalImportRawKey - passphrase");
    }
    final String method = EthereumRpcMethods.importRawKey;
    final List params = [keydata, passphrase];
    final res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(ethResultKey)) {
      return EthereumUtilities.safeParse(res[ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Returns all the Ethereum account addresses of all keys in the key store.
  Future<List<BigInt>> personalListAccounts() async {
    final String method = EthereumRpcMethods.listAccounts;
    final res = await _client.rpcClient.request(method);
    if (res != null && res.containsKey(ethResultKey)) {
      return EthereumUtilities.hexToBigIntList(res[ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Removes the private key with given address from memory.
  /// The account can no longer be used to send transactions.
  Future<bool> personalLockAccount(BigInt address) async {
    if (address == null) {
      throw ArgumentError.notNull("Ethereum::personalLockAccount - address");
    }
    final String method = EthereumRpcMethods.lockAccount;
    final List params = [EthereumUtilities.bigIntegerToHex(address)];
    final res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(ethResultKey)) {
      return true;
    }
    _client.processError(method, res);
    return false;
  }

  /// Generates a new private key and stores it in the key store directory.
  /// The key file is encrypted with the given passphrase.
  /// Returns the address of the new account.
  Future<BigInt> personalNewAccount(String passphrase) async {
    if (passphrase == null) {
      throw ArgumentError.notNull("Ethereum::personalNewAccount - passphrase");
    }
    final String method = EthereumRpcMethods.newAccount;
    final List params = [passphrase];
    final res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(ethResultKey)) {
      return EthereumUtilities.safeParse(res[ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Decrypts the key with the given address from the key store.
  /// The unencrypted key will be held in memory until the unlock duration expires.
  /// The unlock duration defaults to 300 seconds. An explicit duration of zero seconds
  /// unlocks the key until geth exits.
  /// The account can be used with eth_sign and eth_sendTransaction while it is unlocked.
  Future<bool> personalUnlockAccount(BigInt address, String passphrase,
      [int duration = 300]) async {
    if (address == null) {
      throw ArgumentError.notNull("Ethereum::personalUnlockAccount - address");
    }
    if (passphrase == null) {
      throw ArgumentError.notNull(
          "Ethereum::personalUnlockAccount - passphrase");
    }
    final int paramDuration = duration == null ? 300 : duration;
    final String method = EthereumRpcMethods.unlockAccount;
    final List params = [
      EthereumUtilities.bigIntegerToHex(address),
      passphrase,
      paramDuration
    ];
    final res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(ethResultKey)) {
      return true;
    }
    _client.processError(method, res);
    return false;
  }

  /// Validate the given passphrase and submit transaction.
  /// The transaction is the same argument as for eth.sendTransaction and contains the from address.
  /// If the passphrase can be used to decrypt the private key belogging to tx.from the transaction is verified,
  /// signed and send onto the network. The account is not unlocked globally in the node and cannot be
  /// used in other RPC calls.
  Future<bool> personalSendTransaction(BigInt address, BigInt to,
      String passphrase) async {
    if (address == null) {
      throw ArgumentError.notNull(
          "Ethereum::personalSendTransaction - address");
    }
    if (to == null) {
      throw ArgumentError.notNull("Ethereum::personalSendTransaction - to");
    }
    if (passphrase == null) {
      throw ArgumentError.notNull(
          "Ethereum::personalSendTransaction - passphrase");
    }
    final String method = EthereumRpcMethods.psendTransaction;
    final Map<String, String> paramBlock = {
      "from": EthereumUtilities.bigIntegerToHex(address),
      "to": EthereumUtilities.bigIntegerToHex(to)
    };
    final dynamic params = [paramBlock, passphrase];
    final res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(ethResultKey)) {
      return true;
    }
    _client.processError(method, res);
    return false;
  }

  /// The sign method calculates an Ethereum specific signature with:
  /// sign(keccack256("\x19Ethereum Signed Message:\n" + len(message) + message))).
  /// By adding a prefix to the message makes the calculated signature recognisable as an Ethereum
  /// specific signature. This prevents misuse where a malicious DApp can sign arbitrary data
  /// (e.g. transaction) and use the signature to impersonate the victim.
  /// See personalEcRecover to verify the signature.
  Future<BigInt> personalSign(BigInt message, BigInt address,
      [String password = ""]) async {
    if (message == null) {
      throw ArgumentError.notNull("Ethereum::personalSign - message");
    }
    if (address == null) {
      throw ArgumentError.notNull("Ethereum::personalSign - address");
    }
    final String method = EthereumRpcMethods.pSign;
    final List params = [
      EthereumUtilities.bigIntegerToHex(message),
      EthereumUtilities.bigIntegerToHex(address),
      password
    ];
    final res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(ethResultKey)) {
      return EthereumUtilities.safeParse(res[ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }
}
