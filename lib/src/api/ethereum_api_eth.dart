/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 12/09/2018
 * Copyright :  S.Hamblett
 *
 * The Ethereum client package
 */

part of '../../ethereum.dart';

/// This class implements the Ethereuum eth API, sometimes referred to as DApp
class EthereumApiEth extends EthereumApi {
  /// Construction
  EthereumApiEth(super.client);

  //// Client version
  Future<String?> clientVersion() async {
    const method = EthereumRpcMethods.web3ClientVersion;
    final dynamic res = await _client.rpcClient.request(method);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return res[EthereumConstants.ethResultKey];
    }
    _client.processError(method, res);
    return null;
  }

  /// Returns Keccak-256 (not the standardized SHA3-256) of the given data.
  Future<BigInt?> sha3(EthereumData? data) async {
    if (data == null) {
      throw ArgumentError.notNull('Ethereum::sha3 - data');
    }
    const method = EthereumRpcMethods.web3Sha3;
    final params = <String?>[data.asString];
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumUtilities.safeParse(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Net version
  Future<String?> netVersion() async {
    const method = EthereumRpcMethods.netVersion;
    final dynamic res = await _client.rpcClient.request(method);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return res[EthereumConstants.ethResultKey];
    }
    _client.processError(method, res);
    return null;
  }

  /// Net listening, true when listening
  Future<bool?> netListening() async {
    const method = EthereumRpcMethods.netListening;
    final dynamic res = await _client.rpcClient.request(method);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return res[EthereumConstants.ethResultKey];
    }
    _client.processError(method, res);
    return null;
  }

  /// Net peer count,
  Future<int?> netPeerCount() async {
    const method = EthereumRpcMethods.netPeerCount;
    final dynamic res = await _client.rpcClient.request(method);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumUtilities.hexToInt(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Protocol version
  Future<String?> protocolVersion() async {
    const method = EthereumRpcMethods.protocolVersion;
    final dynamic res = await _client.rpcClient.request(method);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return res[EthereumConstants.ethResultKey];
    }
    _client.processError(method, res);
    return null;
  }

  /// Sync status, an object with data about the sync status
  /// if syncing or false if not.
  Future<EthereumSyncStatus?> syncStatus() async {
    const method = EthereumRpcMethods.syncing;
    final dynamic res = await _client.rpcClient.request(method);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumSyncStatus.fromMap(res);
    }
    _client.processError(method, res);
    return null;
  }

  /// The client coinbase address.
  Future<BigInt?> coinbaseAddress() async {
    const method = EthereumRpcMethods.coinbaseAddress;
    final dynamic res = await _client.rpcClient.request(method);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumUtilities.safeParse(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Mining, true when mining
  Future<bool?> mining() async {
    const method = EthereumRpcMethods.mining;
    final dynamic res = await _client.rpcClient.request(method);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return res[EthereumConstants.ethResultKey];
    }
    _client.processError(method, res);
    return null;
  }

  /// Hashrate, returns the number of hashes per second that
  /// the node is mining with.
  Future<int?> hashrate() async {
    const method = EthereumRpcMethods.hashrate;
    final dynamic res = await _client.rpcClient.request(method);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumUtilities.hexToInt(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// The current price per gas in wei.
  Future<int?> gasPrice() async {
    const method = EthereumRpcMethods.gasPrice;
    final dynamic res = await _client.rpcClient.request(method);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumUtilities.hexToInt(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Accounts,  a list of addresses owned by client.
  Future<List<EthereumAddress>?> accounts() async {
    const method = EthereumRpcMethods.accounts;
    final dynamic res = await _client.rpcClient.request(method);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumAddress.toList(
          res[EthereumConstants.ethResultKey].cast<String>());
    }
    _client.processError(method, res);
    return null;
  }

  /// Block number, the number of most recent block.
  Future<int?> blockNumber() async {
    const method = EthereumRpcMethods.blockNumber;
    final dynamic res = await _client.rpcClient.request(method);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumUtilities.hexToInt(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Get balance, the balance of the account of the given address.
  Future<BigInt?> getBalance(
      EthereumAddress? address, EthereumDefaultBlock? block) async {
    if (address == null) {
      throw ArgumentError.notNull('Ethereum::getBalance - address');
    }
    if (block == null) {
      throw ArgumentError.notNull('Ethereum::getBalance - block');
    }
    const method = EthereumRpcMethods.balance;
    final blockString = block.getSelection();
    final params = <String?>[address.asString, blockString];
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumUtilities.safeParse(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Get Storage at, the value from a storage position at a given address.
  /// Parameters are the address of the storage, the integer position
  /// of the storage and the default block parameter.
  Future<EthereumData?> getStorageAt(
      EthereumAddress? address, int? pos, EthereumDefaultBlock? block) async {
    if (address == null) {
      throw ArgumentError.notNull('Ethereum::getStorageAt - address');
    }
    if (pos == null) {
      throw ArgumentError.notNull('Ethereum::getStorageAt - pos');
    }
    if (block == null) {
      throw ArgumentError.notNull('Ethereum::getStorageAt - block');
    }
    const method = EthereumRpcMethods.storageAt;
    final blockString = block.getSelection();
    final params = <String?>[
      address.asString,
      EthereumUtilities.intToHex(pos),
      blockString
    ];
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumData.fromString(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Transaction count, returns the number of transactions sent
  /// from an address.
  Future<int?> getTransactionCount(
      EthereumAddress? address, EthereumDefaultBlock? block) async {
    if (address == null) {
      throw ArgumentError.notNull('Ethereum::getTransactionCount - address');
    }
    if (block == null) {
      throw ArgumentError.notNull('Ethereum::getTransactionCount - block');
    }
    const method = EthereumRpcMethods.transactionCount;
    final blockString = block.getSelection();
    final params = <String?>[address.asString, blockString];
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumUtilities.hexToInt(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Block Transaction Count By Hash
  /// The number of transactions in a block from a block matching
  /// the given block hash.
  /// If the method returns null a count of 0 is returned, this is to
  /// distinguish between this and an error.
  Future<int?> getBlockTransactionCountByHash(EthereumData? blockHash) async {
    if (blockHash == null) {
      throw ArgumentError.notNull(
          'Ethereum::getBlockTransactionCountByHash - blockHash');
    }
    const method = EthereumRpcMethods.blockTransactionCountByHash;
    final params = <String?>[blockHash.asString];
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      if (res[EthereumConstants.ethResultKey] != null) {
        return EthereumUtilities.hexToInt(res[EthereumConstants.ethResultKey]);
      } else {
        return 0;
      }
    }
    _client.processError(method, res);
    return null;
  }

  /// Block Transaction Count By Number
  /// The number of transactions in a block matching the given block number.
  /// If the method returns null a count of 0 is returned, this is to
  /// distinguish between this and an error.
  Future<int?> getBlockTransactionCountByNumber(
      EthereumDefaultBlock? blockNumber) async {
    if (blockNumber == null) {
      throw ArgumentError.notNull(
          'Ethereum::getBlockTransactionCountByNumber - blockNumber');
    }
    const method = EthereumRpcMethods.blockTransactionCountByNumber;
    final blockString = blockNumber.getSelection();
    final params = <String?>[blockString];
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      if (res[EthereumConstants.ethResultKey] != null) {
        return EthereumUtilities.hexToInt(res[EthereumConstants.ethResultKey]);
      } else {
        return 0;
      }
    }
    _client.processError(method, res);
    return null;
  }

  /// Block Uncle Count By Hash
  /// The number of uncles in a block from a block matching the
  /// given block hash.
  /// If the method returns null a count of 0 is returned, this is
  /// to distinguish between this and an error.
  Future<int?> getUncleCountByHash(EthereumData? blockHash) async {
    if (blockHash == null) {
      throw ArgumentError.notNull('Ethereum::getUncleCountByHash - blockHash');
    }
    const method = EthereumRpcMethods.blockUncleCountByBlockHash;
    final params = <String?>[blockHash.asString];
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      if (res[EthereumConstants.ethResultKey] != null) {
        return EthereumUtilities.hexToInt(res[EthereumConstants.ethResultKey]);
      } else {
        return 0;
      }
    }
    _client.processError(method, res);
    return null;
  }

  /// Block Uncle Count By Number
  /// The number of uncles in a block matching the given block number.
  /// If the method returns null a count of 0 is returned,
  /// this is to distinguish between this and an error.
  Future<int?> getUncleCountByNumber(EthereumDefaultBlock? blockNumber) async {
    if (blockNumber == null) {
      throw ArgumentError.notNull(
          'Ethereum::getUncleCountByNumber - blockNumber');
    }
    const method = EthereumRpcMethods.blockUncleCountByBlockNumber;
    final blockString = blockNumber.getSelection();
    final params = <String?>[blockString];
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      if (res[EthereumConstants.ethResultKey] != null) {
        return EthereumUtilities.hexToInt(res[EthereumConstants.ethResultKey]);
      } else {
        return 0;
      }
    }
    _client.processError(method, res);
    return null;
  }

  /// Get code, the code at the given address.
  Future<int?> getCode(
      EthereumAddress? address, EthereumDefaultBlock? block) async {
    if (address == null) {
      throw ArgumentError.notNull('Ethereum::getCode - address');
    }
    if (block == null) {
      throw ArgumentError.notNull('Ethereum::getCode - block');
    }
    const method = EthereumRpcMethods.code;
    final blockString = block.getSelection();
    final params = <String?>[address.asString, blockString];
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumUtilities.hexToInt(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Sign
  /// The sign method calculates an Ethereum specific signature with:
  /// sign(keccak256('\x19Ethereum Signed Message:\n' + len(message) + message))).
  /// Note the address to sign with must be unlocked.
  Future<EthereumData?> sign(
      EthereumAddress? account, EthereumData? message) async {
    if (account == null) {
      throw ArgumentError.notNull('Ethereum::sign - account');
    }
    if (message == null) {
      throw ArgumentError.notNull('Ethereum::sign - message');
    }
    const method = EthereumRpcMethods.sign;
    final params = <String?>[account.asString, message.asString];
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumData.fromString(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Send transaction
  /// Creates new message call transaction or a contract creation,
  /// if the data field contains code.
  /// address: The address the transaction is sent from.
  /// to: (optional when creating new contract)
  /// The address the transaction is directed to.
  /// gas: (optional, default: 90000)
  /// Integer of the gas provided for the transaction execution.
  /// It will return unused gas.
  /// gasPrice: (optional, default:
  /// To-Be-Determined) Integer of the gasPrice used for each paid gas
  /// value: (optional) Integer of the value send with this transaction
  /// data: The compiled code of a contract OR the hash of the invoked method
  /// signature and encoded parameters. For details see Ethereum Contract ABI
  /// nonce: (optional)
  /// Integer of a nonce. This allows to overwrite your own pending
  /// transactions that use the same nonce.
  /// Returns the transaction hash, or the zero hash if the
  /// transaction is not yet available.
  Future<EthereumData?> sendTransaction(
      EthereumAddress? address, EthereumData? data,
      {EthereumAddress? to,
      int gas = 9000,
      int? gasPrice,
      int? value,
      int? nonce}) async {
    if (address == null) {
      throw ArgumentError.notNull('Ethereum::sendTransaction - address');
    }
    if (data == null) {
      throw ArgumentError.notNull('Ethereum::sendTransaction - data');
    }
    const method = EthereumRpcMethods.sendTransaction;
    var paramBlock = <String, String?>{
      'from': address.asString,
      'to': to?.asString,
      'gas': EthereumUtilities.intToHex(gas),
      'gasPrice':
          gasPrice == null ? null : EthereumUtilities.intToHex(gasPrice),
      'value': value == null ? null : EthereumUtilities.intToHex(value),
      'data': data.asString,
      'nonce': nonce == null ? null : EthereumUtilities.intToHex(nonce)
    };
    paramBlock =
        EthereumUtilities.removeNull(paramBlock) as Map<String, String?>;
    final dynamic params = <dynamic>[paramBlock];
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumData.fromString(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Send raw transaction
  /// Creates new message call transaction or a contract creation
  /// for signed transactions.
  /// Takes the signed transaction data.
  /// Returns the transaction hash, or the zero hash if the transaction
  /// is not yet available.
  Future<EthereumData?> sendRawTransaction(
      EthereumData? signedTransaction) async {
    if (signedTransaction == null) {
      throw ArgumentError.notNull(
          'Ethereum::sendRawTransaction - signedTransaction');
    }
    const method = EthereumRpcMethods.sendRawTransaction;
    final dynamic params = <String?>[signedTransaction.asString];
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumData.fromString(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Call
  /// Executes a new message call immediately without creating a
  /// transaction on the block chain.
  /// address: The address the transaction is sent to.
  /// from: (optional) The address the transaction is sent from.
  /// gas: (optional)
  /// Integer of the gas provided for the transaction execution.
  /// eth_call consumes zero gas, but this parameter may be needed by
  /// some executions.
  /// gasPrice: (optional) Integer of the gasPrice used for each paid gas
  /// value: (optional) Integer of the value send with this transaction
  /// data: (optional) Hash of the method signature and encoded parameters.
  /// For details see Ethereum Contract ABI
  /// block: default block parameter
  /// Returns the return value of executed contract.
  Future<EthereumData?> call(
      EthereumAddress? address, EthereumDefaultBlock? block,
      {EthereumAddress? from,
      int? gas,
      int? gasPrice,
      int? value,
      EthereumData? data}) async {
    if (address == null) {
      throw ArgumentError.notNull('Ethereum::call - address');
    }
    if (block == null) {
      throw ArgumentError.notNull('Ethereum::call - block');
    }
    const method = EthereumRpcMethods.call;
    final blockString = block.getSelection();
    var paramBlock = <String, String?>{
      'from': from?.asString,
      'to': address.asString,
      'gas': gas == null ? null : EthereumUtilities.intToHex(gas),
      'gasPrice':
          gasPrice == null ? null : EthereumUtilities.intToHex(gasPrice),
      'value': value == null ? null : EthereumUtilities.intToHex(value),
      'data': data?.asString
    };
    paramBlock =
        EthereumUtilities.removeNull(paramBlock) as Map<String, String?>;
    final dynamic params = <dynamic>[paramBlock, blockString];
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumData.fromString(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Estimate gas
  /// Makes a call or transaction, which won't be added to the blockchain
  /// and returns the used gas,
  /// which can be used for estimating the used gas.
  /// See eth_call parameters, expect that all properties are optional.
  /// If no gas limit is specified geth uses the block gas limit from
  /// the pending block as an upper bound. As a result the returned estimate
  /// might not be enough to executed the call/transaction when the
  /// amount of gas is higher than the pending block gas limit.
  /// Returns the amount of gas used.
  Future<int?> estimateGas(
      {EthereumAddress? address,
      EthereumAddress? from,
      int? gas,
      int? gasPrice,
      int? value,
      EthereumData? data}) async {
    var paramBlock = <String, String?>{
      'from': from?.asString,
      'to': address?.asString,
      'gas': gas == null ? null : EthereumUtilities.intToHex(gas),
      'gasPrice':
          gasPrice == null ? null : EthereumUtilities.intToHex(gasPrice),
      'value': value == null ? null : EthereumUtilities.intToHex(value),
      'data': data?.asString
    };
    paramBlock =
        EthereumUtilities.removeNull(paramBlock) as Map<String, String?>;
    final dynamic params = <dynamic>[paramBlock];
    const method = EthereumRpcMethods.estimateGas;
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumUtilities.hexToInt(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Get block by hash
  /// Returns information about a block by hash
  /// Hash of a block and a boolean, if true it returns the
  /// full transaction objects,
  /// if false only the hashes of the transactions, defaults to true.
  /// Returns A block object, or null when no block was found :
  Future<EthereumBlock?> getBlockByHash(EthereumData? blockHash,
      {bool full = true}) async {
    if (blockHash == null) {
      throw ArgumentError.notNull('Ethereum::getBlockByHash - blockHash');
    }
    final dynamic params = <dynamic>[blockHash.asString, full];
    const method = EthereumRpcMethods.getBlockByHash;
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumBlock.fromMap(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Get block by number
  /// Returns information about a block by block number.
  /// blockNumber - defualt block parameter
  /// as in the default block parameter.
  /// A boolean, if true it returns the full transaction objects,
  /// if false only the hashes of the transactions, defaults to true.
  /// Returns See getBlockByHash
  Future<EthereumBlock?> getBlockByNumber(EthereumDefaultBlock? blockNumber,
      {bool full = true}) async {
    if (blockNumber == null) {
      throw ArgumentError.notNull('Ethereum::getBlockByNumber - blockNumber');
    }
    final blockString = blockNumber.getSelection();
    final dynamic params = <dynamic>[blockString, full];
    const method = EthereumRpcMethods.getBlockByNumber;
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumBlock.fromMap(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Get transaction by hash
  /// Returns the information about a transaction requested by transaction hash.
  /// Hash of a transaction
  /// Returns a transaction object, or null when no transaction was found:
  Future<EthereumTransaction?> getTransactionByHash(EthereumData? hash) async {
    if (hash == null) {
      throw ArgumentError.notNull('Ethereum::getTransactionByHash - hash');
    }
    final dynamic params = <String?>[hash.asString];
    const method = EthereumRpcMethods.getTransactionByHash;
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumTransaction.fromMap(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Get transaction by block hash and index.
  /// Returns information about a transaction by block hash and
  /// transaction index position.
  /// Hash of a block and integer of the transaction index position.
  /// Returns see getTransactionByHash.
  Future<EthereumTransaction?> getTransactionByBlockHashAndIndex(
      EthereumData? blockHash, int? index) async {
    if (blockHash == null) {
      throw ArgumentError.notNull(
          'Ethereum::getTransactionByBlockHashAndIndex - blockHash');
    }
    if (index == null) {
      throw ArgumentError.notNull(
          'Ethereum::getTransactionByBlockHashAndIndex - index');
    }
    final dynamic params = <dynamic>[
      blockHash.asString,
      EthereumUtilities.intToHex(index)
    ];
    const method = EthereumRpcMethods.getTransactionByBlockHashAndIndex;
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumTransaction.fromMap(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Get transaction by block number and index.
  /// Returns information about a transaction by block number
  /// and transaction index position.
  /// A block number as in the default block parameter.
  /// Returns see getTransactionByHash.
  Future<EthereumTransaction?> getTransactionByBlockNumberAndIndex(
      EthereumDefaultBlock? blockNumber, int? index) async {
    if (blockNumber == null) {
      throw ArgumentError.notNull(
          'Ethereum::getTransactionByBlockNumberAndIndex - blockNumber');
    }
    if (index == null) {
      throw ArgumentError.notNull(
          'Ethereum::getTransactionByBlockNumberAndIndex - index');
    }
    final blockNumberString = blockNumber.getSelection();
    final dynamic params = <dynamic>[
      blockNumberString,
      EthereumUtilities.intToHex(index)
    ];
    const method = EthereumRpcMethods.getTransactionByBlockNumberAndIndex;
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumTransaction.fromMap(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Get transaction receipt
  /// Returns the receipt of a transaction by transaction hash.
  /// Note That the receipt is not available for pending transactions.
  /// Hash of a transaction
  /// Returns a transaction receipt object, or null when no receipt was found:
  Future<EthereumTransactionReceipt?> getTransactionReceipt(
      EthereumData? transactionHash) async {
    if (transactionHash == null) {
      throw ArgumentError.notNull(
          'Ethereum::getTransactionReceipt - transactionHash');
    }
    final dynamic params = <String?>[transactionHash.asString];
    const method = EthereumRpcMethods.getTransactionReceipt;
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumTransactionReceipt.fromMap(
          res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Get uncle by block hash and index.
  /// Returns information about an uncle by block hash and uncle index position.
  /// Note: An uncle doesn't contain individual transactions.
  /// Hash of a block and integer of the uncle index position.
  /// Returns see getBlockByHash.
  Future<EthereumBlock?> getUncleByBlockHashAndIndex(
      EthereumData? blockHash, int? index) async {
    if (blockHash == null) {
      throw ArgumentError.notNull(
          'Ethereum::getUncleByBlockHashAndIndex - blockHash');
    }
    if (index == null) {
      throw ArgumentError.notNull(
          'Ethereum::getUncleByBlockHashAndIndex - index');
    }
    final dynamic params = <String?>[
      blockHash.asString,
      EthereumUtilities.intToHex(index)
    ];
    const method = EthereumRpcMethods.getUncleByBlockHashAndIndex;
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumBlock.fromMap(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Get uncle by block number and index.
  /// Returns information about an uncle by block number
  /// and uncle index position.
  /// Note: An uncle doesn't contain individual transactions.
  /// A block number as in the default block parameter.
  /// Returns see getBlockByHash.
  Future<EthereumBlock?> getUncleByBlockNumberAndIndex(
      EthereumDefaultBlock? blockNumber, int? index) async {
    if (blockNumber == null) {
      throw ArgumentError.notNull(
          'Ethereum::getUncleByBlockNumberAndIndex - blockNumber');
    }
    if (index == null) {
      throw ArgumentError.notNull(
          'Ethereum::getUncleByBlockNumberAndIndex - index');
    }
    final blockNumberString = blockNumber.getSelection();
    final dynamic params = <dynamic>[
      blockNumberString,
      EthereumUtilities.intToHex(index)
    ];
    const method = EthereumRpcMethods.getUncleByBlockNumberAndIndex;
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumBlock.fromMap(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// New filter
  /// Creates a filter object, based on filter options, to notify when
  /// the state changes (logs).
  /// To check if the state has changed, call getFilterChanges.
  /// note on specifying topic filters:
  /// Topics are order-dependent. A transaction with a log with topics [A, B]
  /// will be matched by the following topic filters:
  /// [] 'anything'
  /// ['A'] 'A in first position (and anything after)'
  /// [null, B] 'anything in first position AND B in second position
  /// (and anything after)'
  /// [A, B] 'A in first position AND B in second position (and anything after)'
  /// [[A, B], [A, B]] '(A OR B) in first position AND (A OR B)
  /// in second position (and anything after)'
  /// fromBlock: - (optional, default: 'latest')
  /// Integer block number, or 'latest' for the last mined block or 'pending',
  /// 'earliest' for not yet mined transactions.
  /// toBlock: - (optional, default: 'latest')
  /// Integer block number, or 'latest' for the last mined block or
  /// 'pending', 'earliest' for not yet mined transactions.
  /// address: - (optional) Contract address or a list of addresses
  /// from which logs should originate.
  /// topics: - (optional) topics. Topics are order-dependent.
  /// Note: the user must build this structure using the utilities in the
  /// [EthereumUtilities] class. See the Ethereum
  /// Wiki RPC page for examples.
  /// Returns a filter id.
  Future<int?> newFilter(
      {required EthereumDefaultBlock fromBlock,
      required EthereumDefaultBlock toBlock,
      dynamic address,
      List<EthereumData>? topics}) async {
    final fromBlockString = fromBlock.getSelection();
    final toBlockString = toBlock.getSelection();
    final params = <String, dynamic>{
      'toBlock': toBlockString,
      'fromBlock': fromBlockString
    };
    if (address != null) {
      if (address is List) {
        final addresses =
            EthereumAddress.toStringList(address as List<EthereumAddress>);
        params['address'] = addresses;
      } else {
        params['address'] = <String?>[address.asString];
      }
    }
    if (topics != null) {
      params['topics'] = EthereumData.toStringList(topics);
    }
    final paramBlock = <dynamic>[params];
    const method = EthereumRpcMethods.newFilter;
    final dynamic res = await _client.rpcClient.request(method, paramBlock);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumUtilities.hexToInt(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// New block filter
  /// Creates a filter in the node, to notify when a new block arrives.
  /// To check if the state has changed, call getFilterChanges.
  /// Returns a filter id.
  Future<int?> newBlockFilter() async {
    final params = <String>[];
    const method = EthereumRpcMethods.newBlockFilter;
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumUtilities.hexToInt(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// New pending transaction filter
  /// Creates a filter in the node, to notify when a new pending
  /// transaction arrives.
  /// To check if the state has changed, call getFilterChanges.
  /// Returns a filter id.
  Future<int?> newPendingTransactionFilter() async {
    final params = <String>[];
    const method = EthereumRpcMethods.newPendingTransactionFilter;
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumUtilities.hexToInt(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Uninstall filter
  /// Uninstalls a filter with given id. Should always be called when
  /// watch is no longer needed.
  /// Additionally Filters timeout when they aren't requested with
  /// getFilterChanges for a period of time.
  /// Filter id
  /// Returns true if the filter was successfully uninstalled, otherwise false.
  Future<bool?> uninstallFilter(int? filterId) async {
    if (filterId == null) {
      throw ArgumentError.notNull('Ethereum::uninstallFilter - filterId');
    }
    final params = <String>[EthereumUtilities.intToHex(filterId)];
    const method = EthereumRpcMethods.uninstallFilter;
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return res[EthereumConstants.ethResultKey];
    }
    _client.processError(method, res);
    return null;
  }

  /// Get filter changes
  /// Polling method for a filter, which returns an list of logs
  /// which occurred since last poll.
  /// Filter Id
  /// Returns an EthereumFilter object or null
  Future<EthereumFilter?> getFilterChanges(int? filterId) async {
    if (filterId == null) {
      throw ArgumentError.notNull('Ethereum::getFilterChanges - filterId');
    }
    final params = <String>[EthereumUtilities.intToHex(filterId)];
    const method = EthereumRpcMethods.getFilterChanges;
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumFilter.fromMap(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Get filter logs
  /// Filter Id
  /// Returns see getFilterChanges
  Future<EthereumFilter?> getFilterLogs(int? filterId) async {
    if (filterId == null) {
      throw ArgumentError.notNull('Ethereum::getFilterLogs - filterId');
    }
    final params = <String>[EthereumUtilities.intToHex(filterId)];
    const method = EthereumRpcMethods.getFilterLogs;
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumFilter.fromMap(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Get logs
  /// Returns an array of all logs matching a given filter object.
  /// The filter definition, see newFilter parameters.
  Future<List<EthereumLog>?> getLogs(
      {required EthereumDefaultBlock fromBlock,
      required EthereumDefaultBlock toBlock,
      dynamic address,
      List<EthereumData>? topics}) async {
    final fromBlockString = fromBlock.getSelection();
    final toBlockString = toBlock.getSelection();
    final params = <String, dynamic>{
      'toBlock': toBlockString,
      'fromBlock': fromBlockString
    };
    if (address != null) {
      if (address is List) {
        final addresses =
            EthereumData.toStringList(address as List<EthereumData>);
        params['address'] = addresses;
      } else {
        params['address'] = address.asString;
      }
    }
    if (topics != null) {
      params['topics'] = EthereumData.toStringList(topics);
    }
    final paramBlock = <dynamic>[params];
    const method = EthereumRpcMethods.getLogs;
    final dynamic res = await _client.rpcClient.request(method, paramBlock);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumLog.fromList(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Get work
  /// Returns the hash of the current block, the seedHash,
  /// and the boundary condition to be met ('target').
  /// Returns an EthereumWork object or null
  Future<EthereumWork?> getWork() async {
    final paramBlock = <dynamic>[];
    const method = EthereumRpcMethods.getWork;
    final dynamic res = await _client.rpcClient.request(method, paramBlock);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return EthereumWork.fromList(res[EthereumConstants.ethResultKey]);
    }
    _client.processError(method, res);
    return null;
  }

  /// Submit work
  /// Used for submitting a proof-of-work solution.
  /// The nonce found
  /// The header's pow-hash
  /// The mix digest
  /// Returns  true if the provided solution is valid, otherwise false.
  Future<bool?> submitWork(
      EthereumData? nonce, EthereumData? powHash, EthereumData? digest) async {
    if (nonce == null) {
      throw ArgumentError.notNull('Ethereum::submitWork - nonce');
    }
    if (powHash == null) {
      throw ArgumentError.notNull('Ethereum::submitWork - powHash');
    }
    if (digest == null) {
      throw ArgumentError.notNull('Ethereum::submitWork - digest');
    }
    final params = <String?>[nonce.asString, powHash.asString, digest.asString];
    const method = EthereumRpcMethods.submitWork;
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return res[EthereumConstants.ethResultKey];
    }
    _client.processError(method, res);
    return null;
  }

  /// Submit hash rate
  /// Used for submitting mining hashrate.
  /// Hash rate
  /// Id, a random hexadecimal(32 bytes) string identifying the client
  /// Returns true if submitting went through successfully and false otherwise.
  Future<bool?> submitHashrate(EthereumData? hashRate, String? id) async {
    if (hashRate == null) {
      throw ArgumentError.notNull('Ethereum::submitHashRate - hashRate');
    }
    if (id == null) {
      throw ArgumentError.notNull('Ethereum::submitHashRate - id');
    }
    final params = <String?>[hashRate.asString, id];
    const method = EthereumRpcMethods.submitHashrate;
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return res[EthereumConstants.ethResultKey];
    }
    _client.processError(method, res);
    return null;
  }

  /// SHH version
  /// Returns the current whisper protocol version.
  Future<String?> shhVersion() async {
    final params = <String>[];
    const method = EthereumRpcMethods.shhVersion;
    final dynamic res = await _client.rpcClient.request(method, params);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return res[EthereumConstants.ethResultKey];
    }
    _client.processError(method, res);
    return null;
  }

  /// SHH post
  /// Sends a whisper message
  /// from: - (optional) The identity of the sender.
  /// to: - (optional) The identity of the receiver.
  /// When present whisper will encrypt the message so that only
  ///  the receiver can decrypt it.
  /// topics: - List of topics, for the receiver to identify messages.
  /// payload: - The payload of the message.
  /// priority: - The integer of the priority in a range from ... (?).
  /// ttl: - integer of the time to live in seconds.
  /// Returns true if the message was send, otherwise false.
  Future<bool?> shhPost(List<EthereumData>? topics, EthereumData? payload,
      int? priority, int? ttl,
      {required EthereumAddress to, required EthereumAddress from}) async {
    if (topics == null) {
      throw ArgumentError.notNull('Ethereum::shhPost - topics');
    }
    if (payload == null) {
      throw ArgumentError.notNull('Ethereum::shhPost - payload');
    }
    if (priority == null) {
      throw ArgumentError.notNull('Ethereum::shhPost - priority');
    }
    if (ttl == null) {
      throw ArgumentError.notNull('Ethereum::shhPost - ttl');
    }
    var params = <String, dynamic>{
      'topics': EthereumData.toStringList(topics),
      'payload': payload.asString,
      'priority': EthereumUtilities.intToHex(priority),
      'ttl': ttl,
      'to': to.asString,
      'from': from.asString
    };
    params = EthereumUtilities.removeNull(params) as Map<String, dynamic>;
    final paramBlock = <dynamic>[params];
    const method = EthereumRpcMethods.shhPost;
    final dynamic res = await _client.rpcClient.request(method, paramBlock);
    if (res != null && res.containsKey(EthereumConstants.ethResultKey)) {
      return res[EthereumConstants.ethResultKey];
    }
    _client.processError(method, res);
    return null;
  }
}
