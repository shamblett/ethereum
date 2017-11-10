/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

import 'package:ethereum/ethereum.dart';
import 'package:test/test.dart';

/// Class to run the common Ethereum API tests
class EthereumCommon {
  static void run(Ethereum client) {
    test("Protocol version", () async {
      //final String version = await client.protocolVersion();
      //print("Version is $version");
    });
  }
}
