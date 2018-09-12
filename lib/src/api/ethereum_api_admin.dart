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
    final String method = EthereumRpcMethods.personalmportRawKey;
    final List params = [keydata, passphrase];
    final res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(ethResultKey)) {
      return EthereumUtilities.safeParse(res[ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }



}
