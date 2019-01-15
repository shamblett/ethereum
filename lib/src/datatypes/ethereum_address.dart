/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 14/01/2019
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of ethereum;

/// Ethereum address as a byte array, 20 bytes long
class EthereumByteAddress {
  /// If the length is greater than addressByteLength then only addressByteLength
  /// are taken. If the length is less than addressByteLength the size is padded
  /// to addressByteLength with 0's
  EthereumByteAddress(ByteData data) {
    _setData(data);
  }

  /// If the length is greater than addressByteLength then addressByteLength
  /// are taken. If the length is less than addressByteLength the size is padded
  /// to addressByteLength with 0's. Each int must be < 255, if not it is discarded
  /// and the value set to 0.
  EthereumByteAddress.fromIntList(List<int> data) {
    final ByteData tmp = ByteData(data.length);
    for (int i = 0; i < tmp.lengthInBytes; i++) {
      if (data[i] <= 255) {
        tmp.setUint8(i, data[i]);
      }
    }
    _setData(tmp);
  }

  /// The length of an Ethereum address in bytes
  static const int addressByteLength = 20;

  ByteData _data;

  /// The raw byte data
  ByteData get byteData => _data;

  /// To integer list
  List<int> toList() {
    final List<int> tmp = List<int>(addressByteLength);
    for (int i = 0; i <= addressByteLength - 1; i++) {
      tmp[i] = _data.getUint8(i);
    }
    return tmp;
  }

  /// As an address string, i.e 40 hex chars with a leading 0x
  String get asString {
    const HexEncoder encoder = HexEncoder();
    final String hex = encoder.convert(toList());
    return '0x$hex';
  }

  @override
  String toString() => toList().toString();

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      other.runtimeType == runtimeType && _isEqual(other._data);

  @override
  int get hashCode => _data.hashCode;

  bool _isEqual(ByteData data) {
    for (int i = 0; i <= _data.lengthInBytes - 1; i++) {
      if (data.getUint8(i) != _data.getUint8(i)) {
        return false;
      }
    }
    return true;
  }

  void _setData(ByteData data) {
    if (data.lengthInBytes == addressByteLength) {
      _data = data;
    } else {
      if (data.lengthInBytes > addressByteLength) {
        _data = data.buffer.asByteData(0, addressByteLength);
      } else {
        _data = ByteData(addressByteLength);
        for (int i = 0; i < data.lengthInBytes; i++) {
          _data.setUint8(i, data.getUint8(i));
        }
      }
    }
  }
}

/// The address data type. If any supplied value cannot be safely represented as
/// an Ethereum address FormatException will be thrown.
class EthereumAddress {
  /// From a BigInt. The value must be convertible into the standard Ethereum address
  /// format of 20 bytes, however unlike the string constructor smaller values will be
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

  /// The leading hex indicator
  static const String leadingHexString = '0x';

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

  String _bigIntToHexString(BigInt val) {
    String hexString = val.toRadixString(16);
    // A Hex digit string must be composed of two characters per byte, so must be even
    // if the length is odd even it out.
    if (hexString.length.isOdd) {
      hexString = '0$hexString';
    }

    // We have an even sized hex string, if the string is > 40 characters
    // its not an Ethereum address, if its less then it needs to be padded with 00
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
    return '$leadingHexString$hexString';
  }

  BigInt _safeParse(String val) => BigInt.parse(val);

  void _checkString(String val) {
    // Check for a leading 0x and a total length of 42 characters
    if (!val.startsWith(leadingHexString) ||
        val.length != addressCharacterLength + 2) {
      throw const FormatException(
          'EthereumAddress - address string is badly formed');
    }
  }
}
