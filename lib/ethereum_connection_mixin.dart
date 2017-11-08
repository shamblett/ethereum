/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/011/2017
 * Copyright :  S.Hamblett
 *
 * The Ethereum client package
 */

abstract class EthereumConnectionMixin {
  /// Default port
  static const int defaultPort = 8545;

  /// Connection parameters
  int port = defaultPort;
  String uri;
  String scheme;

  /// Connect using a host string of the form http://thehost.com:1234,
  /// port is optional.
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
  }

  /// Connect by explicitly setting the connection parameters
  void connectParameters(String scheme, String hostname, [int port]) {
    if (hostname == null) {
      throw new ArgumentError.notNull(
          "Ethereum::connectParameters - hostname is null");
    }
    if (scheme == null) {
      throw new ArgumentError.notNull(
          "Ethereum::connectParameters - scheme is null");
    }
    int uriPort = defaultPort;
    if (port != null) {
      uriPort = port;
    }
    final Uri uri = new Uri(scheme: scheme, host: hostname, port: uriPort);
    _validateUri(uri);
  }

  void _validateUri(Uri uri) {}

  /// Internal connect, must be overridden in a server/browser class
  void _connect();
}
