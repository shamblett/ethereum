/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 08/01/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of ethereum;

/// An ethereum transaction message
class EthereumTransaction {
  EthereumTransaction();

  EthereumTransaction.fromMap(Map result) {
    construct(result);
  }

  /// Hash. hash of the transaction.
  BigInteger _hash;

  BigInteger get hash => _hash;

  /// Nonce. The number of transactions made by the sender prior to this one.
  int _nonce;

  int get nonce => _nonce;

  /// Block hash. Hash of the block where this transaction was in.
  /// Null when the transaction is pending.
  BigInteger _blockHash;

  BigInteger get blockHash => _blockHash;

  /// Block number. Block number of this transaction.
  /// Null when the transaction is pending.
  int _blockNumber;

  int get blockNumber => _blockNumber;

  /// Transaction index. The transactions index position in the block.
  /// Null when the transaction is pending.
  int _transactionIndex;

  int get transactionIndex => _transactionIndex;

  /// From. Address of the sender.
  BigInteger _from;

  BigInteger get from => _from;

  /// To. Address of the receiver. Null when a contract creation transaction.
  BigInteger _to;

  BigInteger get to => _to;

  /// Value. Value transferred in Wei.
  int _value;

  int get value => _value;

  /// Gas price. Gas price provided by the sender in Wei.
  int _gasPrice;

  int get gasPrice => _gasPrice;

  /// Gas. Gas provided by the sender.
  int _gas;

  int get gas => _gas;

  /// Input. Data sent with the transaction.
  BigInteger _input;

  BigInteger get input => _input;

  /// Construct from the supplied Map, only check for the keys we need.
  void construct(Map data) {
    if (data[ethResultKey] == null) {
      return;
    }
    if (data[ethResultKey].containsKey('hash')) {
      _hash = new BigInteger(data[ethResultKey]['hash']);
    }
    if (data[ethResultKey].containsKey('nonce')) {
      _nonce = EthereumUtilities.hexToInt(data[ethResultKey]['nonce']);
    }
    if (data[ethResultKey].containsKey('blockHash')) {
      _blockHash = new BigInteger(data[ethResultKey]['blockHash']);
    }
    if (data[ethResultKey].containsKey('blockNumber')) {
      _blockNumber =
          EthereumUtilities.hexToInt(data[ethResultKey]['blockNumber']);
    }
    if (data[ethResultKey].containsKey('transactionIndex')) {
      _transactionIndex =
          EthereumUtilities.hexToInt(data[ethResultKey]['transactionIndex']);
    }
    if (data[ethResultKey].containsKey('from')) {
      _from = new BigInteger(data[ethResultKey]['from']);
    }
    if (data[ethResultKey].containsKey('to')) {
      _to = new BigInteger(data[ethResultKey]['to']);
    }
    if (data[ethResultKey].containsKey('value')) {
      _value = EthereumUtilities.hexToInt(data[ethResultKey]['value']);
    }
    if (data[ethResultKey].containsKey('gasPrice')) {
      _gasPrice = EthereumUtilities.hexToInt(data[ethResultKey]['gasPrice']);
    }
    if (data[ethResultKey].containsKey('gas')) {
      _gas = EthereumUtilities.hexToInt(data[ethResultKey]['gas']);
    }
    if (data[ethResultKey].containsKey('input')) {
      _input = new BigInteger(data[ethResultKey]['input']);
    }
  }
}
