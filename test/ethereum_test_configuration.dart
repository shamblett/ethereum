/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

/// Start geth as follows for server testing :-
/// geth --rpc --rpcapi='db,eth,net,web3,personal,admin' --shh
/// If using websockets add '--ws --rpcapi='db,eth,net,web3,personal,admin'  --wsorigins='*'' for CORS
/// If running the HTTP tests add '--rpccorsdomain='localhost''
/// The account above is the test account defined below, you must first create this account,
/// see the geth documentation for details.
///
/// Test configuration options
class EthereumTestConfiguration {
  static BigInt defaultAccount =
      BigInt.parse('0x12890d2cce102216644c59dae5baed380d84830c');

  /// True runs the browser HTTP tests, you will need CORS support for this as above
  static bool runBrowserHttp = false;

  /// True runs the browser WS tests, you should be OK with --wsorigins as above
  static bool runBrowserWS = true;

  /// True runs the server tests
  static bool runServer = true;
}
