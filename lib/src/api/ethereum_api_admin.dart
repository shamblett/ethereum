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
    final String method = EthereumRpcMethods.personalmportRawKey;
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
    final String method = EthereumRpcMethods.personalListAccounts;
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
    final String method = EthereumRpcMethods.personalLockAccount;
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
    final String method = EthereumRpcMethods.personalNewAccount;
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
  /// If the unlock duration defaults to 300 seconds. An explicit duration of zero seconds
  /// unlocks the key until geth exits.
  /// The account can be used with eth_sign and eth_sendTransaction while it is unlocked.
  Future personalUnlockAccount(BigInt address, String passphrase,
      [int duration = 300]) {

  }
}
