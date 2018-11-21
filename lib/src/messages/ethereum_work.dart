/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 08/01/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of ethereum;

/// An ethereum work message.
/// All elements of the work message must be present.
class EthereumWork {
  /// Construction
  EthereumWork();

  /// From list
  EthereumWork.fromList(List<String> result) {
    construct(result);
  }

  BigInt _powHash;

  /// Current block header pow-hash
  BigInt get powHash => _powHash;

  BigInt _seedHash;

  /// Seed hash used for the DAG.
  BigInt get seedHash => _seedHash;

  BigInt _boundaryCondition;

  /// The boundary condition ('target'), 2^256 / difficulty.
  BigInt get boundaryCondition => _boundaryCondition;

  /// Construct from the supplied list.
  void construct(List<String> data) {
    if (data == null) {
      return;
    }
    if (data.length != 3) {
      return;
    }
    _powHash = EthereumUtilities.safeParse(data[0]);
    _seedHash = EthereumUtilities.safeParse(data[1]);
    _boundaryCondition = EthereumUtilities.safeParse(data[2]);
  }

  @override
  String toString() {
    final String ret = 'Ethereum Work :'
        '\n'
        '  Pow Hash : $powHash'
        '\n'
        '  Seed Hash : $seedHash'
        '\n'
        '  Boundary Condition : $boundaryCondition'
        '\n';

    return ret;
  }
}
