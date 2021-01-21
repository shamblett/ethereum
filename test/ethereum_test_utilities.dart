/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 20/02/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

import 'package:ethereum/ethereum.dart';

/// General client test support utilities
class EthereumTestUtilities {
  /// Hex String list to Integer list
  static List<int?> hexToIntList(List<String> val) => List<int?>.generate(
      val.length, (int index) => EthereumUtilities.hexToInt(val[index]));

  /// Integer list to Hex String list
  static List<String> intToHexList(List<int> val) => List<String>.generate(
      val.length, (int index) => EthereumUtilities.intToHex(val[index]));
}
