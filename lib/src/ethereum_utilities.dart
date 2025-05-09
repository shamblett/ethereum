/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/011/2017
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of '../ethereum.dart';

/// General client support utilities
class EthereumUtilities {
  /// Common pad values for intToHex
  /// 4
  static const int pad4 = 4;

  /// 8
  static const int pad8 = 8;

  /// 16
  static const int pad16 = 16;

  /// 32
  static const int pad32 = 32;

  /// Address character length
  static const int addressCharacterLength = 40;

  /// Integer to hex string with leading 0x, lowercase.
  /// The optional pad value pads the string out to the number of bytes
  /// specified, i.e if 8 is specified the string 0x1 becomes 0x0000000000000001
  /// default is 0, no padding.The pad value must be even and positive.
  static String intToHex(int val, [int pad = 0]) {
    var ret = val.toRadixString(16);
    if (pad != 0) {
      if (pad.isNegative || pad.isOdd) {
        throw FormatException(
          'EthereumUtilities:: intToHex - invalid pad value, $pad',
        );
      }
      if (ret.length.isOdd) {
        ret = '0$ret';
      }
      final bytes = (ret.length / 2).round();
      if (bytes != pad) {
        final zeroNum = pad - bytes;
        for (var i = 0; i < zeroNum; i++) {
          ret = '00$ret';
        }
      }
    }
    return '0x$ret';
  }

  /// Hex string to integer, a value of null indicates an error.
  /// The string must start with 0x
  static int? hexToInt(String val) {
    final temp = int.tryParse(val);
    if (temp == null) {
      return null;
    }
    return temp;
  }

  /// Remove null values from a map
  static Map<dynamic, dynamic> removeNull(Map<dynamic, dynamic> theMap) {
    final values = theMap.values.toList();
    final keys = theMap.keys.toList();
    var index = 0;
    for (final dynamic val in values) {
      if (val == null) {
        theMap.remove(keys[index]);
      }
      index++;
    }
    return theMap;
  }

  /// Safe parser for BigInt, returns BigInt.zero if the parse fails
  /// Geth sometimes returns '0x' rather than '0x00'
  static BigInt safeParse(String val) {
    final temp = BigInt.tryParse(val);
    if (temp == null) {
      return BigInt.zero;
    }
    return temp;
  }
}
