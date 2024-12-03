/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

/// Start geth(v1.10.1) as follows for server testing :-
/// geth --rpc --rpcapi='db,eth,net,web3,personal,admin'
/// If using websockets add '--ws --rpcapi='db,eth,net,web3,personal,admin'  --ws.origins='*'' for CORS
/// If running the HTTP tests add '--rpccorsdomain='*''
/// The account above is the test account defined below, you must first create this account,
/// see the geth documentation for details.
///
/// Test configuration options
class EthereumTestConfiguration {
  static String defaultAccount = '0x12890d2cce102216644c59dae5baed380d84830c';

  /// True runs the browser HTTP tests, you will need CORS support for this as above
  static bool runBrowserHttp = true;

  /// True runs the browser WS tests, you should be OK with --wsorigins as above
  static bool runBrowserWS = true;

  /// True runs the server tests
  static bool runServer = true;
}
