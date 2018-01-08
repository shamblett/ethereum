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
  /// Common pad values for intToHex
  static const int pad4 = 4;
  static const int pad8 = 8;
  static const int pad16 = 16;
  static const int pad32 = 32;

  /// Integer to hex string with leading 0x, lowercase.
  /// The optional pad value pads the string out to the number of bytes
  /// specified, i.e if 8 is specified the string 0x1 becomes 0x0000000000000001
  /// default is 0, no padding.The pad value must be even and positive.
  static String intToHex(int val, [int pad = 0]) {
    String ret = val.toRadixString(16);
    if (pad != 0) {
      if (pad.isNegative || pad.isOdd) {
        throw new FormatException(
            "EthereumUtilities:: intToHex - invalid pad value, $pad");
      }
      if (ret.length.isOdd) {
        ret = '0' + ret;
      }
      final int bytes = (ret.length / 2).round();
      if (bytes != pad) {
        final int zeroNum = (pad - bytes);
        for (int i = 0; i < zeroNum; i++) {
          ret = '00' + ret;
        }
      }
    }
    return '0x' + ret;
  }

  /// BigInteger to hex string
  static String bigIntegerToHex(BigInteger val) {
    return '0x' + val.toRadix(16);
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

  /// Hex String list to BigInteger list
  static List<BigInteger> hexToBigIntegerList(List<String> val) {
    return new List<BigInteger>.generate(
        val.length, (int index) => new BigInteger(val[index]));
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
