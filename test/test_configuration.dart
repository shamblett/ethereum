/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

/// Start geth as follows :-
/// geth --unlock 0xd10de988e845d33859c3f96c7f1fc723b7b56f4c --rpc --shh
/// If using websockets add --ws and --wsorigins="*" for CORS
/// The account above is the test account defined below, you must first create this account,
/// see the geth documentation for details.
///
/// Test configuration options
class TestConfiguration {
  static const int defaultAccount = 0xd10de988e845d33859c3f96c7f1fc723b7b56f4c;
}
