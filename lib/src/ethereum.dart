/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/011/2017
 * Copyright :  S.Hamblett
 *
 * The Ethereum client package
 */

part of ethereum;

/// The Ethereum JSON-RPC client class.
/// Further details of this interface and its API specification can be found at
/// https://github.com/ethereum/wiki/wiki/JSON-RPC#web3_clientversion
class Ethereum {
  Ethereum(this._httpAdapter) {
    rpcClient = new EthereumRpcClient(_httpAdapter);
  }

  Ethereum.withConnectionParameters(EthereumIHTTPAdapter adapter,
      String hostname,
      [port = defaultPort])
      : _httpAdapter = adapter {
    rpcClient = new EthereumRpcClient(_httpAdapter);
    connectParameters(hostname, port);
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

  /// Json RPC client
  EthereumRpcClient rpcClient;

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
    rpcClient.uri = _uri;
  }

  /// API methods

  //// Client version
  Future<String> clientVersion() async {
    final String method = 'web3_clientVersion';
    final res = await rpcClient.request(method);
    if (res.containsKey('result')) {
      return res.result;
    }
    print("ERROR::$method - Code: ${res.error.code} Message ${res.error
            .message}");
    return null;
  }

  /// Returns Keccak-256 (not the standardized SHA3-256) of the given data.
  Future<String> sha3(String hexString) async {
    final String method = 'web3_sha3';
    final List<String> params = new List<String>(1);
    params[0] = hexString;
    final res = await rpcClient.request(method, params);
    if (res.containsKey('result')) {
      return res.result;
    }
    print("ERROR::$method - Code: ${res.error.code} Message ${res.error
        .message}");
    return null;
  }

  /// Net version
  Future<String> netVersion() async {
    final String method = 'net_version';
    final res = await rpcClient.request(method);
    if (res.containsKey('result')) {
      return res.result;
    }
    print("ERROR::$method - Code: ${res.error.code} Message ${res.error
        .message}");
    return null;
  }

  /// Net listening, true when listening
  Future<bool> netListening() async {
    final String method = 'net_listening';
    final res = await rpcClient.request(method);
    if (res.containsKey('result')) {
      return res.result;
    }
    print("ERROR::$method - Code: ${res.error.code} Message ${res.error
            .message}");
    return null;
  }

  /// Net peer count,
  Future<int> netPeerCount() async {
    final String method = 'net_peerCount';
    final res = await rpcClient.request(method);
    if (res.containsKey('result')) {
      return int.parse(res.result);
    }
    print("ERROR::$method - Code: ${res.error.code} Message ${res.error
        .message}");
    return null;
  }

  /// Protocol version
  Future<String> protocolVersion() async {
    final String method = 'eth_protocolVersion';
    final res = await rpcClient.request(method);
    if (res.containsKey('result')) {
      return res.result;
    }
    print("ERROR::$method - Code: ${res.error.code} Message ${res.error
            .message}");
    return null;
  }
}
