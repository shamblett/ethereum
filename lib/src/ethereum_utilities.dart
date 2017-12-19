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

  /// Hex String list to Integer list
  static List<int> hexToIntList(List<String> val) {
    return new List<int>.generate(
        val.length, (int index) => hexToInt(val[index]));
  }

  /// Integer list to Hex String list
  static List<String> intToHexList(List<int> val) {
    return new List<String>.generate(
        val.length, (int index) => intToHex(val[index]));
  }

  /// Remove null values from a map
  static Map removeNull(Map theMap) {
    final List values = theMap.values.toList();
    final List keys = theMap.keys.toList();
    int index = 0;
    for (dynamic val in values) {
      if (val == null) {
        theMap.remove(keys[index]);
      }
      index++;
    }
    return theMap;
  }
}
