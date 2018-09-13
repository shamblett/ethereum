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
}
