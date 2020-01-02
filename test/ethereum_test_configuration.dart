/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

// ignore_for_file: omit_local_variable_types
// ignore_for_file: unnecessary_final
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: avoid_catching_errors
// ignore_for_file: avoid_print
// ignore_for_file: cascade_invocations

// ignore: avoid_classes_with_only_static_members
/// Start geth as follows for server testing :-
/// geth --rpc --rpcapi='db,eth,net,web3,personal,admin' --shh
/// If using websockets add '--ws --rpcapi='db,eth,net,web3,personal,admin'  --wsorigins='*'' for CORS
/// If running the HTTP tests add '--rpccorsdomain='localhost''
/// The account above is the test account defined below, you must first create this account,
/// see the geth documentation for details.
///
/// Test configuration options
class EthereumTestConfiguration {
  static String defaultAccount = '0xad52b73690c35b9211a18c9293e805d792474168';

  /// True runs the browser HTTP tests, you will need CORS support for this as above
  static bool runBrowserHttp = false;

  /// True runs the browser WS tests, you should be OK with --wsorigins as above
  static bool runBrowserWS = true;

  /// True runs the server tests
  static bool runServer = true;
}
