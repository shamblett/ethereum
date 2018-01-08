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
  int _blockNumber;

  int get blockNumber => _blockNumber;

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

  /// Timestamp: - the timestamp for when the block was collated.
  DateTime _timestamp;

  DateTime get timestamp => _timestamp;

  /// Transactions. A list of transaction objects, or 32 Bytes transaction hashes depending on the last given parameter.
  List<dynamic> _transactions;

  List<dynamic> get transactions => _transactions;

  /// Uncles. A list of uncle hashes.
  List<BigInteger> _uncles;

  List<BigInteger> get uncles => _uncles;

  /// Construct from the supplied Map, only check for the keys we need.
  void construct(Map data) {}
}
