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
  int _hash;

  int get hash => _hash;

  /// Parent hash. Hash of the parent block.
  int _parentHash;

  int get parentHash => _parentHash;

  /// nonce. Hash of the generated proof-of-work. Null when its pending block.
  int _nonce;

  int get nonce => _nonce;

  /// Sha3 Uncles. SHA3 of the uncles data in the block.
  int _sha3Uncles;

  int get sha3Uncles => _sha3Uncles;

  /// Logs bloom. The bloom filter for the logs of the block. Null when its pending block.
  int _logsBloom;

  int get logsBloom => _logsBloom;

  /// Transactions root. The root of the transaction tree of the block.
  int _transactionsRoot;

  int get transactionsRoot => _transactionsRoot;

  /// stateRoot: - the root of the final state trie of the block.
  /// receiptsRoot: - the root of the receipts trie of the block.
  /// miner: DATA, - the address of the beneficiary to whom the mining rewards were given.
  /// difficulty: - integer of the difficulty for this block.
  /// totalDifficulty: - integer of the total difficulty of the chain until this block.
  /// extraData: - the "extra data" field of this block.
  /// size: - integer the size of this block in bytes.
  /// gasLimit: - the maximum gas allowed in this block.
  /// gasUsed: - the total used gas by all transactions in this block.
  /// timestamp: - the unix timestamp for when the block was collated.
  /// transactions: - List of transaction objects, or 32 Bytes transaction hashes depending on the last given parameter.
  /// uncles: - List of uncle hashes.
  /// Construct from the supplied Map, only check for the keys we need.
  void construct(Map data) {}
}
