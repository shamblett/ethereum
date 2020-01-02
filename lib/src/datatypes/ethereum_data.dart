/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 14/01/2019
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of ethereum;

// ignore_for_file: omit_local_variable_types
// ignore_for_file: unnecessary_final
// ignore_for_file: avoid_types_on_closure_parameters
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

/// The Ethereum data type. This is not as constrained as the address type.
class EthereumData {
  /// From a BigInt.
  EthereumData.fromBigInt(BigInt val) {
    _bigint = val;
    _string = _bigIntToHexString(val);
  }

  /// From a string, must be a valid Ethereum data string, i.e have
  /// a leading 0x
  EthereumData.fromString(String val) {
    _checkString(val);
    _string = val;
    _bigint = _safeParse(_string);
  }

  /// The BigInt
  BigInt _bigint;

  /// The string
  String _string;

  /// Get as a BigInt
  BigInt get asBigInt => _bigint;

  /// Get as a String, includes the 0x prefix
  String get asString => _string;

  @override
  String toString() => asString;

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      other.runtimeType == runtimeType && _bigint == other._bigint;

  @override
  int get hashCode => _bigint.hashCode;

  /// Data string list to EthereumAddress list
  static List<EthereumData> toList(List<String> val) =>
      List<EthereumData>.generate(
          val.length, (int index) => EthereumData.fromString(val[index]));

  /// EthereumData list to string list
  static List<String> toStringList(List<EthereumData> val) =>
      List<String>.generate(val.length, (int index) => val[index].asString);

  String _bigIntToHexString(BigInt val) {
    String hexString = val.toRadixString(16);
    // A Hex digit string must be composed of two characters
    // per byte, so must be even if the length is odd even it out.
    if (hexString.length.isOdd) {
      hexString = '0$hexString';
    }

    return EthereumConstants.leadingHexString + hexString;
  }

  BigInt _safeParse(String val) {
    // If the string is zero trap this
    if (val.contains(RegExp(r'[1-9]'))) {
      return BigInt.parse(val);
    } else {
      return BigInt.zero;
    }
  }

  void _checkString(String val) {
    // Check for a leading 0x and a total length of 42 characters
    if (!val.startsWith(EthereumConstants.leadingHexString)) {
      throw const FormatException('EthereumData - data string is badly formed');
    }
  }
}
