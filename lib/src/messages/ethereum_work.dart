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
  EthereumWork();

  EthereumWork.fromList(List result) {
    construct(result);
  }

  /// Current block header pow-hash
  BigInteger _powHash;

  BigInteger get powHash => _powHash;

  /// Seed hash used for the DAG.
  BigInteger _seedHash;

  BigInteger get seedHash => _seedHash;

  /// The boundary condition ("target"), 2^256 / difficulty.
  BigInteger _boundaryCondition;

  BigInteger get boundaryCondition => _boundaryCondition;

  /// Construct from the supplied Map, only check for the keys we need.
  void construct(List data) {
    if (data == null) {
      return;
    }
    if (data.length != 3) {
      return;
    }
    _powHash = new BigInteger(data[0]);
    _seedHash = new BigInteger(data[1]);
    _boundaryCondition = new BigInteger(data[2]);
  }

  // To string
  String toString() {
    final String ret = "Ethereum Work :" +
        "\n" +
        "  Pow Hash : $powHash" +
        "\n" +
        "  Seed Hash : $seedHash" +
        "\n" +
        "  Boundary Condition : $boundaryCondition" +
        "\n";

    return ret;
  }
}
