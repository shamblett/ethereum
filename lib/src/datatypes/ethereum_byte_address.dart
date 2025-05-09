/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 14/01/2019
 * Copyright :  S.Hamblett
 *
 * A JSON RPC 2.0 client for Ethereum
 */

part of '../../ethereum.dart';

/// Ethereum address as a byte array, 20 bytes long
class EthereumByteAddress {
  static const maxIntValue = 255;

  /// The length of an Ethereum address in bytes
  static const int addressByteLength = 20;

  ByteData? _data;

  /// The raw byte data
  ByteData? get byteData => _data;

  @override
  int get hashCode => _data.hashCode;

  /// As an address string, i.e 40 hex chars with a leading 0x
  String get asString {
    const encoder = HexEncoder();
    final hex = encoder.convert(toList() as List<int>);
    return '0x$hex';
  }

  /// If the length is greater than addressByteLength then only
  /// addressByteLength are taken.
  /// If the length is less than addressByteLength the size is padded
  /// to addressByteLength with 0's
  EthereumByteAddress(ByteData data) {
    _setData(data);
  }

  /// If the length is greater than addressByteLength then addressByteLength
  /// are taken. If the length is less than addressByteLength the size is padded
  /// to addressByteLength with 0's. Each int must be < 255,
  /// if not it is discarded and the value set to 0.
  EthereumByteAddress.fromIntList(List<int> data) {
    final tmp = ByteData(data.length);
    for (var i = 0; i < tmp.lengthInBytes; i++) {
      if (data[i] <= maxIntValue) {
        tmp.setUint8(i, data[i]);
      }
    }
    _setData(tmp);
  }

  /// To integer list
  List<int?> toList() {
    final tmp = List<int>.filled(addressByteLength, 0);
    for (var i = 0; i <= addressByteLength - 1; i++) {
      tmp[i] = _data!.getUint8(i);
    }
    return tmp;
  }

  @override
  String toString() => toList().toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other.runtimeType == runtimeType &&
          _isEqual((other as EthereumByteAddress)._data);

  bool _isEqual(ByteData? data) {
    for (var i = 0; i <= _data!.lengthInBytes - 1; i++) {
      if (data!.getUint8(i) != _data!.getUint8(i)) {
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
        for (var i = 0; i < data.lengthInBytes; i++) {
          _data!.setUint8(i, data.getUint8(i));
        }
      }
    }
  }
}
