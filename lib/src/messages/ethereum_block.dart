/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 08/01/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of ethereum;

/// An ethereum block descriptor message
class EthereumBlock {
  /// Constructor
  EthereumBlock();

  /// From map
  EthereumBlock.fromMap(Map<String, dynamic> result) {
    construct(result);
  }

  int _number;

  /// The block number. Null when its a pending block.
  int get number => _number;

  EthereumData _hash;

  /// Hash of the block. Null when its a pending block.
  EthereumData get hash => _hash;

  EthereumData _parentHash;

  /// Parent hash. Hash of the parent block.
  EthereumData get parentHash => _parentHash;

  EthereumData _nonce;

  /// Nonce. Hash of the generated proof-of-work. Null when its pending block.
  EthereumData get nonce => _nonce;

  EthereumData _sha3Uncles;

  /// Sha3 Uncles. SHA3 of the uncles data in the block.
  EthereumData get sha3Uncles => _sha3Uncles;

  EthereumData _logsBloom;

  /// Logs bloom. The bloom filter for the logs of the block. Null when its pending block.
  EthereumData get logsBloom => _logsBloom;

  EthereumData _transactionsRoot;

  /// Transactions root. The root of the transaction tree of the block.
  EthereumData get transactionsRoot => _transactionsRoot;

  EthereumData _stateRoot;

  /// State root. The root of the final state tree of the block.
  EthereumData get stateRoot => _stateRoot;

  EthereumData _receiptsRoot;

  /// Receipts root. The root of the receipts tree of the block.
  EthereumData get receiptsRoot => _receiptsRoot;

  EthereumData _miner;

  /// Miner. The address of the beneficiary to whom the mining rewards were given.
  EthereumData get miner => _miner;

  int _difficulty;

  /// Difficulty. Integer of the difficulty for this block.
  int get difficulty => _difficulty;

  int _totalDifficulty;

  /// Total difficulty. Integer of the total difficulty of the chain until this block.
  int get totalDifficulty => _totalDifficulty;

  EthereumData _extraData;

  /// Extra data. The 'extra data' field of this block.
  EthereumData get extraData => _extraData;

  int _size;

  /// Size. Integer the size of this block in bytes.
  int get size => _size;

  int _gasLimit;

  /// Gas limit. The maximum gas allowed in this block.
  int get gasLimit => _gasLimit;

  int _gasUsed;

  /// Gas used. The total used gas by all transactions in this block.
  int get gasUsed => _gasUsed;

  DateTime _timestamp;

  /// Timestamp. The unix timestamp for when the block was collated.
  DateTime get timestamp => _timestamp;

  List<dynamic> _transactions;

  /// Transactions. A list of transaction objects, or 32 Bytes transaction hashes
  /// depending on the last given parameter.
  List<dynamic> get transactions => _transactions;

  bool _transactionsAreHashes = false;

  /// Indicates if the transactions are hashes or transaction objects
  bool get transactionsAreHashes => _transactionsAreHashes;

  List<EthereumData> _uncles;

  /// Uncles. A list of uncle hashes.
  List<EthereumData> get uncles => _uncles;

  /// Construct from the supplied Map, only check for the keys we need.
  void construct(Map<String, dynamic> data) {
    if ((data == null) || (data[EthereumConstants.ethResultKey] == null)) {
      return;
    }
    if (data[EthereumConstants.ethResultKey].containsKey('number')) {
      _number = EthereumUtilities.hexToInt(
          data[EthereumConstants.ethResultKey]['number']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('hash')) {
      _hash =
          EthereumData.fromString(data[EthereumConstants.ethResultKey]['hash']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('parentHash')) {
      _parentHash = EthereumData.fromString(
          data[EthereumConstants.ethResultKey]['parentHash']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('nonce')) {
      _nonce = EthereumData.fromString(
          data[EthereumConstants.ethResultKey]['nonce']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('sha3Uncles')) {
      _sha3Uncles = EthereumData.fromString(
          data[EthereumConstants.ethResultKey]['sha3Uncles']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('logsBloom')) {
      _logsBloom = EthereumData.fromString(
          data[EthereumConstants.ethResultKey]['logsBloom']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('transactionsRoot')) {
      _transactionsRoot = EthereumData.fromString(
          data[EthereumConstants.ethResultKey]['transactionsRoot']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('stateRoot')) {
      _stateRoot = EthereumData.fromString(
          data[EthereumConstants.ethResultKey]['stateRoot']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('receiptsRoot')) {
      _receiptsRoot = EthereumData.fromString(
          data[EthereumConstants.ethResultKey]['receiptsRoot']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('miner')) {
      _miner = EthereumData.fromString(
          data[EthereumConstants.ethResultKey]['miner']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('difficulty')) {
      _difficulty = EthereumUtilities.hexToInt(
          data[EthereumConstants.ethResultKey]['difficulty']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('totalDifficulty')) {
      _totalDifficulty = EthereumUtilities.hexToInt(
          data[EthereumConstants.ethResultKey]['totalDifficulty']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('extraData')) {
      _extraData = EthereumData.fromString(
          data[EthereumConstants.ethResultKey]['extraData']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('size')) {
      _size = EthereumUtilities.hexToInt(
          data[EthereumConstants.ethResultKey]['size']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('gasLimit')) {
      _gasLimit = EthereumUtilities.hexToInt(
          data[EthereumConstants.ethResultKey]['gasLimit']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('gasUsed')) {
      _gasUsed = EthereumUtilities.hexToInt(
          data[EthereumConstants.ethResultKey]['gasUsed']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('timestamp')) {
      _timestamp = DateTime.fromMillisecondsSinceEpoch(
          EthereumUtilities.hexToInt(
              data[EthereumConstants.ethResultKey]['timestamp']));
    }
    if (data[EthereumConstants.ethResultKey].containsKey('uncles')) {
      _uncles =
          EthereumData.toList(data[EthereumConstants.ethResultKey]['uncles']);
    }
    if (data[EthereumConstants.ethResultKey].containsKey('transactions')) {
      if ((data[EthereumConstants.ethResultKey]['transactions'] != null) &&
          (data[EthereumConstants.ethResultKey]['transactions'].isNotEmpty)) {
        if (data[EthereumConstants.ethResultKey]['transactions'][0] is String) {
          // Hashes
          _transactionsAreHashes = true;
          _transactions = EthereumUtilities.hexToBigIntList(
              data[EthereumConstants.ethResultKey]['transactions']);
        } else {
          // Transaction objects
          _transactions = List<EthereumTransaction>();
          for (Map<dynamic, dynamic> transaction
              in data[EthereumConstants.ethResultKey]['transactions']) {
            final Map<String, dynamic> buildTrans = <String, dynamic>{
              EthereumConstants.ethResultKey: transaction
            };
            final EthereumTransaction entry =
                EthereumTransaction.fromMap(buildTrans);
            _transactions.add(entry);
          }
        }
      }
    }
  }

  @override
  String toString() {
    final String ret = 'Ethereum Block :'
        '\n'
        '  Number : $number'
        '\n'
        '  Hash : $hash'
        '\n'
        '  Parent Hash : $parentHash'
        '\n'
        '  Miner : $miner'
        '\n'
        '  Difficulty : $difficulty'
        '\n'
        '  Gas Used : $gasUsed'
        '\n'
        '  Time : $timestamp'
        '\n';
    return ret;
  }
}
