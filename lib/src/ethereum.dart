/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/011/2017
 * Copyright :  S.Hamblett
 *
 * The Ethereum client package
 */

part of '../ethereum.dart';

/// The Ethereum JSON-RPC client class.
/// Further details of this interface and its Dapp API specification
/// can be found at https://github.com/ethereum/wiki/wiki/JSON-RPC#web3_clientversion.
/// The API calls return null if an ethereum error occurred.
class Ethereum {
  /// Constants
  /// HTTP scheme
  static const String rpcHttpScheme = 'http';

  /// Web socket scheme
  static const String rpcWsScheme = 'ws';

  /// Defaults
  /// HTTP port
  static const int defaultHttpPort = 8545;

  /// Web socket port
  static const int defaultWsPort = 8546;

  /// Connection parameters
  /// Port
  int port = defaultHttpPort;

  /// Host
  String? host;

  /// Json RPC client
  late EthereumRpcClient rpcClient;

  /// Print errors, default is off
  bool printError = false;

  /// Last error
  EthereumError lastError = EthereumError();

  late Uri _uri;

  // Network adaptor
  EthereumINetworkAdapter _networkAdapter;

  // Admin API
  EthereumApiAdmin? _admin;

  // Eth API
  EthereumApiEth? _eth;

  /// Uri
  Uri get uri => _uri;

  /// Transmission id
  int get id => rpcClient.id;

  /// The ETH API
  EthereumApiEth? get eth => _eth;

  /// The Admin API
  EthereumApiAdmin? get admin => _admin;

  /// HTTP Adapter
  set httpAdapter(EthereumINetworkAdapter adapter) => _networkAdapter = adapter;

  set id(int? value) => rpcClient.resetTransmissionId(value);

  /// Default constructor
  Ethereum(this._networkAdapter) {
    rpcClient = EthereumRpcClient(_networkAdapter);

    /// Construct the API classes
    _eth = EthereumApiEth(this);
    _admin = EthereumApiAdmin(this);
  }

  /// With connection parameters
  Ethereum.withConnectionParameters(
    EthereumINetworkAdapter adapter,
    String hostname,
    String scheme, [
    int? port = defaultHttpPort,
  ]) : _networkAdapter = adapter {
    rpcClient = EthereumRpcClient(_networkAdapter);

    /// Construct the API classes
    _eth = EthereumApiEth(this);
    _admin = EthereumApiAdmin(this);
    connectParameters(scheme, hostname, port);
  }

  //// Connect using a host string of the form http://thehost.com:1234,
  /// port is optional. Scheme must be http or ws
  void connectString(String? hostname) {
    if (hostname == null) {
      throw ArgumentError.notNull('Ethereum::connectString - hostname');
    }
    final uri = Uri.parse(hostname);
    _validateUri(uri);
  }

  /// Connect using a URI, port is optional
  void connectUri(Uri? uri) {
    if (uri == null) {
      throw ArgumentError.notNull('Ethereum::connectUri - uri');
    }
    _validateUri(uri);
  }

  /// Connect by explicitly setting the connection parameters.
  /// Scheme must be either rpcScheme or rpcWsScheme
  void connectParameters(String scheme, String? hostname, [int? port]) {
    if (hostname == null) {
      throw ArgumentError.notNull('Ethereum::connectParameters - hostname');
    }
    if ((scheme != rpcHttpScheme) && (scheme != rpcWsScheme)) {
      throw FormatException(
        'Ethereum::connectParameters - invalid scheme $scheme',
      );
    }
    int? uriPort;
    if (port != null) {
      uriPort = port;
    }
    final uri = Uri(scheme: scheme, host: hostname, port: uriPort);
    _validateUri(uri);
  }

  /// Error processing helper
  void processError(String method, Map<String, dynamic> res) {
    if (res.isEmpty) {
      if (printError) {
        print('ERROR::$method - No status returned - Protocol failure}');
      }
    } else {
      final error = res[EthereumConstants.ethErrorKey];
      lastError.updateError(error['code'], error['message'], rpcClient.id);
      if (printError) {
        print('ERROR::$method - ${lastError.toString()}');
      }
    }
  }

  void _validateUri(Uri puri) {
    // Must have a valid scheme which must be http, host and port
    if (puri.hasAuthority && (puri.host.isNotEmpty)) {
      host = puri.host;
    } else {
      throw ArgumentError.value(
        puri.host,
        'Ethereum::_validateUri - invalid host',
      );
    }
    var newUri = puri;
    if (!puri.hasPort) {
      newUri =
          puri.scheme == rpcHttpScheme
              ? puri.replace(port: defaultHttpPort)
              : puri.replace(port: defaultWsPort);
    }
    port = newUri.port;
    _uri = newUri;
    rpcClient.uri = _uri;
  }
}
