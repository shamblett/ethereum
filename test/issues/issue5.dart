/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

@TestOn('vm')
import 'package:ethereum/ethereum.dart';
import 'package:test/test.dart';

/// Tests for issue 5, safeParse tests
void main() {
  test('Safe parse reversability 1', () {
    const String str = '0x01';
    final BigInt b = EthereumUtilities.safeParse(str);
    expect(b.toInt(), 1);
  });

  test('Safe parse reversability 2', () {
    const String str = '0x0472ec0185ebb8202f3d4ddb0226998889663cf2 ';
    final BigInt b = EthereumUtilities.safeParse(str);
    expect(b.toInt(), 9223372036854775807);
    expect(EthereumUtilities.bigIntegerToHex(b),
        '0x0472ec0185ebb8202f3d4ddb0226998889663cf2');
  });
}
