/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/011/2017
 * Copyright :  S.Hamblett
 *
 * The Ethereum client package
 */

part of ethereum;

/// The Ethereum JSON-RPC client class. This implements the Ethereum RPC interface for a
/// pre-supplied channel(socket).
class Ethereum {
  Ethereum(this._httpAdapter);

  Ethereum.withConnectionParameters(EthereumIHTTPAdapter adapter,
      String hostname,
      [port = defaultPort]) {
    _httpAdapter = adapter;
    connectParameters(hostname, port);
    //rpcClient = new rpc.Client(channel);
  }

  /// Constants
  static const String rpcScheme = 'http';

  /// Defaults
  static const int defaultPort = 8545;

  /// Connection parameters
  int port = defaultPort;
  String host;
  Uri _uri;

  Uri get uri => _uri;

  /// HTTP Adapter
  EthereumIHTTPAdapter _httpAdapter;

  set httpAdapter(EthereumIHTTPAdapter adapter) => _httpAdapter = adapter;

  /// Json RPC
  ///rpc.Client rpcClient;

  /// Connection methods

  //// Connect using a host string of the form http://thehost.com:1234,
  /// port is optional. Scheme must be http
  void connectString(String hostname) {
    if (hostname == null) {
      throw new ArgumentError.notNull("Ethereum::connectString - hostname");
    }
    final Uri uri = Uri.parse(hostname);
    _validateUri(uri);
  }

  /// Connect using a URI, port is optional
  void connectUri(Uri uri) {
    if (uri == null) {
      throw new ArgumentError.notNull("Ethereum::connectUri - uri");
    }
    _validateUri(uri);
  }

  /// Connect by explicitly setting the connection parameters
  void connectParameters(String hostname, [int port]) {
    if (hostname == null) {
      throw new ArgumentError.notNull("Ethereum::connectParameters - hostname");
    }
    int uriPort = defaultPort;
    if (port != null) {
      uriPort = port;
    }
    final Uri uri = new Uri(scheme: rpcScheme, host: hostname, port: uriPort);
    _validateUri(uri);
  }

  void _validateUri(Uri puri) {
    // Must have a valid scheme which must be http, host and port
    if (puri.hasAuthority && (puri.host.isNotEmpty)) {
      host = puri.host;
    } else {
      throw new ArgumentError.value(
          puri.host, "Ethereum::_validateUri - invalid host");
    }
    Uri newUri = puri.replace(scheme: rpcScheme);
    if (!puri.hasPort) {
      newUri = newUri.replace(port: defaultPort);
    }
    port = newUri.port;
    _uri = newUri;
  }

/// API methods

/// Protocol version
//Future<String> protocolVersion() async {
//var res = await rpcClient.sendRequest('eth_protocolVersion');
//return res;
//}
}
