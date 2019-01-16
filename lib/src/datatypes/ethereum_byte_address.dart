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
