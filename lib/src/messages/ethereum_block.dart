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
  EthereumBlock();

  EthereumBlock.fromMap(Map result) {
    construct(result);
  }

  /// The block number. Null when its a pending block.
  int _number;

  int get number => _number;

  /// Hash of the block. Null when its a pending block.
  BigInteger _hash;

  BigInteger get hash => _hash;

  /// Parent hash. Hash of the parent block.
  BigInteger _parentHash;

  BigInteger get parentHash => _parentHash;

  /// nonce. Hash of the generated proof-of-work. Null when its pending block.
  BigInteger _nonce;

  BigInteger get nonce => _nonce;

  /// Sha3 Uncles. SHA3 of the uncles data in the block.
  BigInteger _sha3Uncles;

  BigInteger get sha3Uncles => _sha3Uncles;

  /// Logs bloom. The bloom filter for the logs of the block. Null when its pending block.
  BigInteger _logsBloom;

  BigInteger get logsBloom => _logsBloom;

  /// Transactions root. The root of the transaction tree of the block.
  BigInteger _transactionsRoot;

  BigInteger get transactionsRoot => _transactionsRoot;

  /// State root. The root of the final state tree of the block.
  BigInteger _stateRoot;

  BigInteger get stateRoot => _stateRoot;

  /// Receipts root. The root of the receipts tree of the block.
  BigInteger _receiptsRoot;

  BigInteger get receiptsRoot => _receiptsRoot;

  /// Miner. The address of the beneficiary to whom the mining rewards were given.
  BigInteger _miner;

  BigInteger get miner => _miner;

  /// Difficulty. Integer of the difficulty for this block.
  int _difficulty;

  int get difficulty => _difficulty;

  /// Total difficulty. Integer of the total difficulty of the chain until this block.
  int _totalDifficulty;

  int get totalDifficulty => _totalDifficulty;

  /// Extra data. The "extra data" field of this block.
  BigInteger _extraData;

  BigInteger get extraData => _extraData;

  /// Size. Integer the size of this block in bytes.
  int _size;

  int get size => _size;

  /// Gas limit. The maximum gas allowed in this block.
  int _gasLimit;

  int get gasLimit => _gasLimit;

  /// Gas used. The total used gas by all transactions in this block.
  int _gasUsed;

  int get gasUsed => _gasUsed;

  /// Timestamp. The unix timestamp for when the block was collated.
  DateTime _timestamp;

  DateTime get timestamp => _timestamp;

  /// Transactions. A list of transaction objects, or 32 Bytes transaction hashes
  /// depending on the last given parameter.
  List<dynamic> _transactions;

  List<dynamic> get transactions => _transactions;

  /// Indicates if the transactions are hashes or transaction objects
  bool _transactionsAreHashes = false;

  bool get transactionsAreHashes => _transactionsAreHashes;

  /// Uncles. A list of uncle hashes.
  List<BigInteger> _uncles;

  List<BigInteger> get uncles => _uncles;

  /// Construct from the supplied Map, only check for the keys we need.
  void construct(Map data) {
    if (data[ethResultKey] == null) {
      return;
    }
    if (data[ethResultKey].containsKey('number')) {
      _number = EthereumUtilities.hexToInt(data[ethResultKey]['number']);
    }
    if (data[ethResultKey].containsKey('hash')) {
      _hash = new BigInteger(data[ethResultKey]['hash']);
    }
    if (data[ethResultKey].containsKey('parentHash')) {
      _parentHash = new BigInteger(data[ethResultKey]['parentHash']);
    }
    if (data[ethResultKey].containsKey('nonce')) {
      _nonce = new BigInteger(data[ethResultKey]['nonce']);
    }
    if (data[ethResultKey].containsKey('sha3Uncles')) {
      _sha3Uncles = new BigInteger(data[ethResultKey]['sha3Uncles']);
    }
    if (data[ethResultKey].containsKey('logsBloom')) {
      _logsBloom = new BigInteger(data[ethResultKey]['logsBloom']);
    }
    if (data[ethResultKey].containsKey('transactionsRoot')) {
      _transactionsRoot =
      new BigInteger(data[ethResultKey]['transactionsRoot']);
    }
    if (data[ethResultKey].containsKey('stateRoot')) {
      _stateRoot = new BigInteger(data[ethResultKey]['stateRoot']);
    }
    if (data[ethResultKey].containsKey('receiptsRoot')) {
      _receiptsRoot = new BigInteger(data[ethResultKey]['receiptsRoot']);
    }
    if (data[ethResultKey].containsKey('miner')) {
      _miner = new BigInteger(data[ethResultKey]['miner']);
    }
    if (data[ethResultKey].containsKey('difficulty')) {
      _difficulty =
          EthereumUtilities.hexToInt(data[ethResultKey]['difficulty']);
    }
    if (data[ethResultKey].containsKey('totalDifficulty')) {
      _totalDifficulty =
          EthereumUtilities.hexToInt(data[ethResultKey]['totalDifficulty']);
    }
    if (data[ethResultKey].containsKey('extraData')) {
      _extraData = new BigInteger(data[ethResultKey]['extraData']);
    }
    if (data[ethResultKey].containsKey('size')) {
      _size = EthereumUtilities.hexToInt(data[ethResultKey]['size']);
    }
    if (data[ethResultKey].containsKey('gasLimit')) {
      _gasLimit = EthereumUtilities.hexToInt(data[ethResultKey]['gasLimit']);
    }
    if (data[ethResultKey].containsKey('gasUsed')) {
      _gasUsed = EthereumUtilities.hexToInt(data[ethResultKey]['gasUsed']);
    }
    if (data[ethResultKey].containsKey('timestamp')) {
      _timestamp = new DateTime.fromMillisecondsSinceEpoch(
          EthereumUtilities.hexToInt(data[ethResultKey]['timestamp']));
    }
    if (data[ethResultKey].containsKey('uncles')) {
      _uncles =
          EthereumUtilities.hexToBigIntegerList(data[ethResultKey]['uncles']);
    }
    if (data[ethResultKey].containsKey('transactions')) {
      if ((data[ethResultKey]['transactions'] != null) &&
          (data[ethResultKey]['transactions'].isNotEmpty)) {
        if (data[ethResultKey]['transactions'][0] is String) {
          // Hashes
          _transactionsAreHashes = true;
          _transactions = EthereumUtilities
              .hexToBigIntegerList(data[ethResultKey]['transactions']);
        } else {
          // Transaction objects
          _transactions = new List<EthereumTransaction>();
          for (Map transaction in data[ethResultKey]['transactions']) {
            Map buildTrans = { "result": transaction};
            final EthereumTransaction entry =
            new EthereumTransaction.fromMap(buildTrans);
            _transactions.add(entry);
          }
        }
      }
    }
  }
}
