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
  /// to addressByteLength with 0's. Each int must be < 255, if not it is discarded.
  EthereumByteAddress.fromIntList(List<int> data) {
    final ByteData tmp = ByteData(data.length);
    for (int i = 0; i < tmp.lengthInBytes; i++) {
      tmp.setUint8(i, data[i]);
    }
    _setData(tmp);
  }

  /// The length of an Ethereum address in bytes
  static const int addressByteLength = 20;

  ByteData _data;

  @override
  String toString() => _data.toString();

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      other.runtimeType == runtimeType && other._data == _data;

  @override
  int get hashCode => _data.hashCode;

  void _setData(ByteData data) {
    if (data.lengthInBytes == addressByteLength) {
      _data = data;
    } else {
      if (data.lengthInBytes > addressByteLength) {
        _data = data.buffer.asByteData(0, addressByteLength - 1);
      } else {
        _data = ByteData(addressByteLength);
        for (int i = 0; i < data.lengthInBytes; i++) {
          _data.setUint8(i, data.getUint8(i));
        }
      }
    }
  }
}

/// The address data type
class EthereumAddress {
  /// From a BigInt
  EthereumAddress.fromBigInt(BigInt val) {
    _bigint = val;
    _string = _convertToString(val);
  }

  /// From a string
  EthereumAddress.fromString(String val) {
    _checkString(val);
    _convertToBigInt(val);
  }

  /// From a byte address
  EthereumAddress.fromByteAddress(EthereumByteAddress val) {}

  /// From a
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

  String _convertToString(BigInt val) {}

  void _checkString(String val) {}

  BigInt _convertToBigInt(String val) {}
}
