/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 08/01/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of '../../ethereum.dart';

/// An ethereum work message.
/// All elements of the work message must be present.
class EthereumWork {
  static const workMessageLength = 3;

  EthereumData? _powHash;

  EthereumData? _seedHash;

  EthereumData? _boundaryCondition;

  /// The boundary condition ('target'), 2^256 / difficulty.
  EthereumData? get boundaryCondition => _boundaryCondition;

  /// Current block header pow-hash
  EthereumData? get powHash => _powHash;

  /// Seed hash used for the DAG.
  EthereumData? get seedHash => _seedHash;

  /// Construction
  EthereumWork();

  /// From list
  EthereumWork.fromList(List<String>? result) {
    construct(result);
  }

  /// Construct from the supplied list.
  void construct(List<String>? data) {
    if (data == null) {
      return;
    }
    if (data.length != workMessageLength) {
      return;
    }
    _powHash = EthereumData.fromString(data.first);
    _seedHash = EthereumData.fromString(data[1]);
    _boundaryCondition = EthereumData.fromString(data[2]);
  }

  @override
  String toString() {
    return 'Ethereum Work :'
        '\n'
        '  Pow Hash : $powHash'
        '\n'
        '  Seed Hash : $seedHash'
        '\n'
        '  Boundary Condition : $boundaryCondition'
        '\n';
  }
}
