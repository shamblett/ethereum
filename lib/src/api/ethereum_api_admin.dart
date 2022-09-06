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
  /// Construction
  EthereumApiAdmin(Ethereum client) : super(client);

  /// Imports the given unencrypted private key (byte string)
  /// into the key store, encrypting it with the passphrase.
  Future<EthereumData?> personalImportRawKey(
      String? keydata, String? passphrase) async {
    if (keydata == null) {
      throw ArgumentError.notNull('Ethereum::personalImportRawKey - keydata');
    }
    if (passphrase == null) {
      throw ArgumentError.notNull(
          'Ethereum::personalImportRawKey - passphrase');
    }
    const method = EthereumRpcMethods.importRawKey;
    final params = <String>[keydata, passphrase];
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumData.fromString(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Returns all the Ethereum account addresses of all keys in the key store.
  Future<List<EthereumAddress>?> personalListAccounts() async {
    const method = EthereumRpcMethods.listAccounts;
    final dynamic res = await _client.rpcClient.request(method);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumAddress.toList(
          res[EthereumConstants.ethResultKey].cast<String>());
    }
    _client.processError(method, res);
    return null;
  }

  /// Removes the private key with given address from memory.
  /// The account can no longer be used to send transactions.
  Future<bool> personalLockAccount(EthereumAddress? address) async {
    if (address == null) {
      throw ArgumentError.notNull('Ethereum::personalLockAccount - address');
    }
    const method = EthereumRpcMethods.lockAccount;
    final params = <String?>[address.asString];
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return true;
    }
    _client.processError(method, res);
    return false;
  }

  /// Generates a new private key and stores it in the key store directory.
  /// The key file is encrypted with the given passphrase.
  /// Returns the address of the new account.
  Future<EthereumData?> personalNewAccount(String? passphrase) async {
    if (passphrase == null) {
      throw ArgumentError.notNull('Ethereum::personalNewAccount - passphrase');
    }
    const method = EthereumRpcMethods.newAccount;
    final params = <String>[passphrase];
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumData.fromString(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Decrypts the key with the given address from the key store.
  /// The unencrypted key will be held in memory until the unlock
  /// duration expires.
  /// The unlock duration defaults to 300 seconds.
  /// An explicit duration of zero seconds unlocks the key until geth exits.
  /// The account can be used with eth_sign and eth_sendTransaction
  /// while it is unlocked.
  Future<bool> personalUnlockAccount(
      EthereumAddress? address, String? passphrase,
      [int duration = 300]) async {
    if (address == null) {
      throw ArgumentError.notNull('Ethereum::personalUnlockAccount - address');
    }
    if (passphrase == null) {
      throw ArgumentError.notNull(
          'Ethereum::personalUnlockAccount - passphrase');
    }
    final paramDuration = duration;
    const method = EthereumRpcMethods.unlockAccount;
    final params = <dynamic>[address.asString, passphrase, paramDuration];
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return true;
    }
    _client.processError(method, res);
    return false;
  }

  /// Validate the given passphrase and submit transaction.
  /// The transaction is the same argument as for eth.sendTransaction and
  /// contains the from address.
  ///
  /// Note that an extra parameter is condition :-
  /// Conditional submission of the transaction. Can be either an integer
  /// block number { block: 1 } or UTC timestamp (in seconds)
  /// { time: 1491290692 } or null.
  ///
  /// If the passphrase can be used to decrypt the private key belonging to
  /// tx.from the transaction is verified, signed and send onto the network.
  /// The account is not unlocked globally in the node and cannot be
  /// used in other RPC calls.
  Future<EthereumData?> personalSendTransaction(
      EthereumAddress? address, String? passphrase,
      {EthereumAddress? to,
      EthereumAddress? data,
      int? gas,
      int? gasPrice,
      int? value,
      int? nonce,
      int? condition,
      bool conditionIsTimestamp = false}) async {
    if (address == null) {
      throw ArgumentError.notNull(
          'Ethereum::personalSendTransaction - address');
    }
    if (passphrase == null) {
      throw ArgumentError.notNull(
          'Ethereum::personalSendTransaction - passphrase');
    }
    Map<String, String>? conditionObject = <String, String>{};
    if (condition == null) {
      conditionObject = null;
    } else {
      if (conditionIsTimestamp) {
        conditionObject = <String, String>{
          'timestamp': EthereumUtilities.intToHex(condition)
        };
      } else {
        conditionObject = <String, String>{
          'block': EthereumUtilities.intToHex(condition)
        };
      }
    }
    final paramBlock = <String, dynamic>{
      'from': address.asString,
      'to': to?.asString,
      'gas': gas == null ? null : EthereumUtilities.intToHex(gas),
      'gasPrice':
          gasPrice == null ? null : EthereumUtilities.intToHex(gasPrice),
      'value': value == null ? null : EthereumUtilities.intToHex(value),
      'data': data?.asString,
      'nonce': nonce == null ? null : EthereumUtilities.intToHex(nonce),
      'condition': conditionObject
    };
    const method = EthereumRpcMethods.psendTransaction;
    final dynamic params = <dynamic>[paramBlock, passphrase];
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumData.fromString(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// The sign method calculates an Ethereum specific signature with:
  /// sign(keccack256('\x19Ethereum Signed Message:\n' + len(message) + message))).
  /// By adding a prefix to the message makes the calculated signature
  /// recognisable as an Ethereum specific signature.
  /// This prevents misuse where a malicious DApp can sign arbitrary data
  /// (e.g. transaction) and use the signature to impersonate the victim.
  /// See personalEcRecover to verify the signature.
  Future<EthereumData?> personalSign(
      EthereumData? message, EthereumAddress? address,
      [String password = '']) async {
    if (message == null) {
      throw ArgumentError.notNull('Ethereum::personalSign - message');
    }
    if (address == null) {
      throw ArgumentError.notNull('Ethereum::personalSign - address');
    }
    const method = EthereumRpcMethods.pSign;
    final params = <String?>[message.asString, address.asString, password];
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumData.fromString(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Returns the address associated with the private key that was used to
  /// calculate the signature in personal_sign.
  Future<EthereumAddress?> personalEcRecover(
      EthereumData? message, EthereumData? signature) async {
    if (message == null) {
      throw ArgumentError.notNull('Ethereum::personalEcRecover - message');
    }
    if (signature == null) {
      throw ArgumentError.notNull('Ethereum::personalEcRecover - signature');
    }
    const method = EthereumRpcMethods.ecRecover;
    final params = <String?>[message.asString, signature.asString];
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumAddress.fromString(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }
}
