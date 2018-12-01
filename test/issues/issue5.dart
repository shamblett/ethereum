/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

@TestOn('vm')
import 'package:ethereum/ethereum.dart';
import 'package:test/test.dart';

class EthereumBigInt {
  EthereumBigInt(this._raw) {
    _val = EthereumUtilities.safeParse(_raw);
  }

  BigInt _val;
  BigInt get val => _val;
  String _raw;
  String get raw => _raw;
}

/// Tests for issue 5, safeParse tests
void main() {
  test('Safe parse reversability', () {
    const String str = '0x01';
    final EthereumBigInt b = EthereumBigInt(str);
    expect(b.raw, '0x01');
    expect(b.val.toInt(), 1);
  });
}
