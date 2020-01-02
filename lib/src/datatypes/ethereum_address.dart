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

/// The address data type. If any supplied value cannot be safely represented as
/// an Ethereum address FormatException will be thrown.
class EthereumAddress {
  /// From a BigInt. The value must be convertible into the
  /// standard Ethereum address
  /// format of 20 bytes, however unlike the string constructor
  /// smaller values will be
  /// 00 padded to make up the 20 byte length.
  EthereumAddress.fromBigInt(BigInt val) {
    _bigint = val;
    _string = _bigIntToHexString(val);
  }

  /// From a string, must be a valid Ethereum address string, i.e 40 characters
  /// with a leading 0x
  EthereumAddress.fromString(String val) {
    _checkString(val);
    _string = val;
    _bigint = _safeParse(_string);
  }

  /// From a byte address
  EthereumAddress.fromByteAddress(EthereumByteAddress val) {
    // This is safe, a byte address is already validated.
    _string = val.asString;
    _bigint = _safeParse(_string);
  }

  /// The address length in characters
  static const int addressCharacterLength = 40;

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

  /// Address string list to EthereumAddress list
  static List<EthereumAddress> toList(List<String> val) =>
      List<EthereumAddress>.generate(
          val.length, (int index) => EthereumAddress.fromString(val[index]));

  /// EthereumAddress list to address string
  static List<String> toStringList(List<EthereumAddress> val) =>
      List<String>.generate(val.length, (int index) => val[index].asString);

  String _bigIntToHexString(BigInt val) {
    String hexString = val.toRadixString(16);
    // A Hex digit string must be composed of two characters
    // per byte, so must be even if the length is odd even it out.
    if (hexString.length.isOdd) {
      hexString = '0$hexString';
    }

    // We have an even sized hex string, if the string is > 40 characters
    // its not an Ethereum address, if its less then it needs
    // to be padded with 00
    if (hexString.length > addressCharacterLength) {
      throw const FormatException(
          'EthereumAddress - address has more than 40 characters');
    } else {
      if (hexString.length < addressCharacterLength) {
        // Must be even
        final int shortfall = (addressCharacterLength - hexString.length) ~/ 2;
        for (int i = 0; i < shortfall; i++) {
          hexString = '00$hexString';
        }
      }
    }
    return EthereumConstants.leadingHexString + hexString;
  }

  BigInt _safeParse(String val) => BigInt.parse(val);

  void _checkString(String val) {
    // Check for a leading 0x and a total length of 42 characters
    if (!val.startsWith(EthereumConstants.leadingHexString) ||
        val.length != addressCharacterLength + 2) {
      throw const FormatException(
          'EthereumAddress - address string is badly formed');
    }
  }
}
