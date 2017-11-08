/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/011/2017
 * Copyright :  S.Hamblett
 *
 * The Ethereum client package
 */

abstract class EthereumConnectionMixin {

  /// Connection parameters
  int port = 8545;
  String uri;
  String scheme;

  /// Connect using a host string of the form http://thehost.com:1234,
  /// port is otional.
  void connectString(String uri) {

  }

  /// Connect using a URI, port is optional
  void connectUri(Uri uri) {

  }

  /// Connect by explicitly setting the connection parameters
  void connectParameters() {

  }

  void _validateUri(dynamic uri) {


  }

  /// Internal connect, must be overridden in a server/browser class
  void _connect();

}