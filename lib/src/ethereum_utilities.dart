/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/011/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of ethereum;

/// General client support utilities
class EthereumUtilities {

  /// Integer to hex string with leading 0x, lowercase
  static String intToHex(int val) {
    return "0x" + val.toRadixString(16);
  }

  /// Hex string to integer, a value of null indicates an error.
  /// The string must start with 0x
  static int hexToInt(String val) {
    return int.parse(val, onError: (val) => null);
  }
}
