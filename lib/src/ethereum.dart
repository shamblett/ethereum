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
/// Further details of this interface and its Dapp API specification can be found at
/// https://github.com/ethereum/wiki/wiki/JSON-RPC#web3_clientversion.
/// The API calls return null if an ethereum error occurred.
class Ethereum {
  Ethereum(this._networkAdapter) {
    rpcClient = EthereumRpcClient(_networkAdapter);
    this._dapp = new EthereumApiDapp(this);
  }

  Ethereum.withConnectionParameters(
      EthereumINetworkAdapter adapter, String hostname, String scheme,
      [port = defaultHttpPort])
      : _networkAdapter = adapter {
    Ethereum(_networkAdapter);
    connectParameters(scheme, hostname, port);
  }

  /// Constants
  static const String rpcHttpScheme = 'http';
  static const String rpcWsScheme = 'ws';

  /// Defaults
  static const int defaultHttpPort = 8545;
  static const int defaultWsPort = 8546;

  /// Connection parameters
  int port = defaultHttpPort;
  String host;
  Uri _uri;

  Uri get uri => _uri;

  /// HTTP Adapter
  EthereumINetworkAdapter _networkAdapter;

  set httpAdapter(EthereumINetworkAdapter adapter) => _networkAdapter = adapter;

  /// Json RPC client
  EthereumRpcClient rpcClient;

  /// Last error
  EthereumError lastError = EthereumError();

  /// Transmission id
  set id(int value) => rpcClient.resetTransmissionId(value);

  int get id => rpcClient.id;

  /// Connection methods

  //// Connect using a host string of the form http://thehost.com:1234,
  /// port is optional. Scheme must be http or ws
  void connectString(String hostname) {
    if (hostname == null) {
      throw ArgumentError.notNull("Ethereum::connectString - hostname");
    }
    final Uri uri = Uri.parse(hostname);
    _validateUri(uri);
  }

  /// Connect using a URI, port is optional
  void connectUri(Uri uri) {
    if (uri == null) {
      throw ArgumentError.notNull("Ethereum::connectUri - uri");
    }
    _validateUri(uri);
  }

  /// Connect by explicitly setting the connection parameters.
  /// Scheme must be either rpcScheme or rpcWsScheme
  void connectParameters(String scheme, String hostname, [int port]) {
    if (hostname == null) {
      throw ArgumentError.notNull("Ethereum::connectParameters - hostname");
    }
    if ((scheme != rpcHttpScheme) && (scheme != rpcWsScheme)) {
      throw FormatException(
          "Ethereum::connectParameters - invalid scheme $scheme");
    }
    int uriPort;
    if (port != null) {
      uriPort = port;
    }
    final Uri uri = Uri(scheme: scheme, host: hostname, port: uriPort);
    _validateUri(uri);
  }

  void _validateUri(Uri puri) {
    // Must have a valid scheme which must be http, host and port
    if (puri.hasAuthority && (puri.host.isNotEmpty)) {
      host = puri.host;
    } else {
      throw ArgumentError.value(
          puri.host, "Ethereum::_validateUri - invalid host");
    }
    Uri newUri = puri;
    if (!puri.hasPort) {
      if (puri.scheme == rpcHttpScheme) {
        newUri = puri.replace(port: defaultHttpPort);
      } else {
        newUri = puri.replace(port: defaultWsPort);
      }
    }
    port = newUri.port;
    _uri = newUri;
    rpcClient.uri = _uri;
  }

  /// Print errors, default is off
  bool printError = false;

  /// Error processing helper
  void processError(String method, Map res) {
    if (res == null) {
      if (printError) {
        print("ERROR:: Result from RPC call is null");
      }
      return;
    }
    final Map error = res[ethErrorKey];
    lastError.updateError(error['code'], error['message'], rpcClient.id);
    if (printError) {
      print("ERROR::$method - ${lastError.toString()}");
    }
  }

  /// Dapp API
  EthereumApiDapp _dapp;

  EthereumApiDapp get dapp => _dapp;
}
