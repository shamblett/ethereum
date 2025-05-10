/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 08/01/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of '../../ethereum.dart';

/// An ethereum transaction message
class EthereumTransaction {
  EthereumData? _hash;

  int? _nonce;

  EthereumData? _blockHash;

  int? _blockNumber;

  int? _transactionIndex;

  EthereumAddress? _from;

  EthereumAddress? _to;

  int? _value;

  int? _gasPrice;

  int? _gas;

  EthereumData? _input;

  /// Input. Data sent with the transaction.
  EthereumData? get input => _input;

  /// Hash. hash of the transaction.
  EthereumData? get hash => _hash;

  /// Nonce. The number of transactions made by the sender prior to this one.
  int? get nonce => _nonce;

  /// Block hash. Hash of the block where this transaction was in.
  /// Null when the transaction is pending.
  EthereumData? get blockHash => _blockHash;

  /// Block number. Block number of this transaction.
  /// Null when the transaction is pending.
  int? get blockNumber => _blockNumber;

  /// Transaction index. The transactions index position in the block.
  /// Null when the transaction is pending.
  int? get transactionIndex => _transactionIndex;

  /// From. Address of the sender.
  EthereumAddress? get from => _from;

  /// To. Address of the receiver. Null when a contract creation transaction.
  EthereumAddress? get to => _to;

  /// Value. Value transferred in Wei.
  int? get value => _value;

  /// Gas price. Gas price provided by the sender in Wei.
  int? get gasPrice => _gasPrice;

  /// Gas. Gas provided by the sender.
  int? get gas => _gas;

  /// Constructor
  EthereumTransaction();

  /// From map
  EthereumTransaction.fromMap(Map<String, dynamic>? result) {
    construct(result);
  }

  /// Construct from the supplied Map, only check for the keys we need.
  void construct(Map<String, dynamic>? data) {
    if ((data == null) || (data[EthereumConstants.ethResultKey] == null)) {
      return;
    }
    if (data[EthereumConstants.ethResultKey].containsKey('hash')) {
      _hash = EthereumData.fromString(
        data[EthereumConstants.ethResultKey]['hash'],
      );
    }
    if (data[EthereumConstants.ethResultKey].containsKey('nonce')) {
      _nonce = EthereumUtilities.hexToInt(
        data[EthereumConstants.ethResultKey]['nonce'],
      );
    }
    if (data[EthereumConstants.ethResultKey].containsKey('blockHash')) {
      _blockHash = EthereumData.fromString(
        data[EthereumConstants.ethResultKey]['blockHash'],
      );
    }
    if (data[EthereumConstants.ethResultKey].containsKey('blockNumber')) {
      _blockNumber = EthereumUtilities.hexToInt(
        data[EthereumConstants.ethResultKey]['blockNumber'],
      );
    }
    if (data[EthereumConstants.ethResultKey].containsKey('transactionIndex')) {
      _transactionIndex = EthereumUtilities.hexToInt(
        data[EthereumConstants.ethResultKey]['transactionIndex'],
      );
    }
    if (data[EthereumConstants.ethResultKey].containsKey('from')) {
      _from = EthereumAddress.fromString(
        data[EthereumConstants.ethResultKey]['from'],
      );
    }
    if (data[EthereumConstants.ethResultKey].containsKey('to')) {
      _to = EthereumAddress.fromString(
        data[EthereumConstants.ethResultKey]['to'],
      );
    }
    if (data[EthereumConstants.ethResultKey].containsKey('value')) {
      _value = EthereumUtilities.hexToInt(
        data[EthereumConstants.ethResultKey]['value'],
      );
    }
    if (data[EthereumConstants.ethResultKey].containsKey('gasPrice')) {
      _gasPrice = EthereumUtilities.hexToInt(
        data[EthereumConstants.ethResultKey]['gasPrice'],
      );
    }
    if (data[EthereumConstants.ethResultKey].containsKey('gas')) {
      _gas = EthereumUtilities.hexToInt(
        data[EthereumConstants.ethResultKey]['gas'],
      );
    }
    if (data[EthereumConstants.ethResultKey].containsKey('input')) {
      _input = EthereumData.fromString(
        data[EthereumConstants.ethResultKey]['input'],
      );
    }
  }

  @override
  String toString() {
    return 'Ethereum Transaction :'
        '\n'
        '  Hash : $hash'
        '\n'
        '  Block Number: $blockNumber'
        '\n'
        '  Block Hash : $blockHash'
        '\n'
        '  Transaction Index : $transactionIndex'
        '\n'
        '  From : $from'
        '\n'
        '  To : $to '
        '\n'
        '  Value : $value'
        '\n'
        '  Gas : $gas'
        '\n';
  }
}
