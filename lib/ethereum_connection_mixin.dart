/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/011/2017
 * Copyright :  S.Hamblett
 *
 * The Ethereum client package
 */

abstract class EthereumConnectionMixin {
  /// Constants
  static const String rpcScheme = 'http';

  /// Defaults
  static const int defaultPort = 8545;

  /// Connection parameters
  int port = defaultPort;
  String host;

  /// Connected indicator
  bool connected = false;

  /// Connect using a host string of the form http://thehost.com:1234,
  /// port is optional. Scheme must be http
  void connectString(String hostname) {
    if (hostname == null) {
      throw new ArgumentError.notNull(
          "Ethereum::connectString - hostname is null");
    }
    final Uri uri = new Uri.dataFromString(hostname);
    _validateUri(uri);
  }

  /// Connect using a URI, port is optional
  void connectUri(Uri uri) {
    if (uri == null) {
      throw new ArgumentError.notNull("Ethereum::connectUri - uri is null");
    }
    _validateUri(uri);
    _connect();
  }

  /// Connect by explicitly setting the connection parameters
  void connectParameters(String hostname, [int port]) {
    if (hostname == null) {
      throw new ArgumentError.notNull(
          "Ethereum::connectParameters - hostname is null");
    }
    int uriPort = defaultPort;
    if (port != null) {
      uriPort = port;
    }
    final Uri uri = new Uri(scheme: rpcScheme, host: hostname, port: uriPort);
    _validateUri(uri);
    _connect();
  }

  void _validateUri(Uri uri) {
    // Must have a valid scheme which must be http, host and port
    if (uri.hasAuthority && (uri.host.isNotEmpty)) {
      host = uri.host;
    } else {
      throw new ArgumentError.value(
          uri.host, "Ethereum::_validateUri - invalid host");
    }
    uri.replace(scheme: rpcScheme);
    if (!uri.hasPort) {
      uri.replace(port: defaultPort);
    }
  }

  /// Internal connect, must be overridden in a server/browser client class
  void _connect();
}
