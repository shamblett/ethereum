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
/// https://github.com/ethereum/wiki/wiki/JSON-RPC#web3_clientversion.
/// The API calls return null if an ethereum error occurred.
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

  /// Last error code and message
  int lastErrorCode = 0;
  String lastErrorMessage = "No Error";

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

  /// Print errors, default is off
  bool printError = false;

  /// Error processing helper
  void _processError(String method, JsonObjectLite res) {
    lastErrorCode = res.error.code;
    lastErrorMessage = res.error.message;
    if (printError) {
      print("ERROR::$method - Code: ${res.error.code} Message :  ${res.error
          .message}");
    }
  }

  /// API constants
  static const String ethEarliest = "earliest";
  static const String ethLatest = "latest";
  static const String ethPending = "pending";
  static const String ethResultKey = "result";

  /// API methods

  //// Client version
  Future<String> clientVersion() async {
    final String method = EthereumRpcMethods.web3ClientVersion;
    final res = await rpcClient.request(method);
    if (res.containsKey(ethResultKey)) {
      return res.result;
    }
    _processError(method, res);
    return null;
  }

  /// Returns Keccak-256 (not the standardized SHA3-256) of the given data.
  Future<String> sha3(String hexString) async {
    final String method = EthereumRpcMethods.web3Sha3;
    final List<String> params = new List<String>(1);
    params[0] = hexString;
    final res = await rpcClient.request(method, params);
    if (res.containsKey(ethResultKey)) {
      return res.result;
    }
    _processError(method, res);
    return null;
  }

  /// Net version
  Future<String> netVersion() async {
    final String method = EthereumRpcMethods.netVersion;
    final res = await rpcClient.request(method);
    if (res.containsKey(ethResultKey)) {
      return res.result;
    }
    _processError(method, res);
    return null;
  }

  /// Net listening, true when listening
  Future<bool> netListening() async {
    final String method = EthereumRpcMethods.netListening;
    final res = await rpcClient.request(method);
    if (res.containsKey(ethResultKey)) {
      return res.result;
    }
    _processError(method, res);
    return null;
  }

  /// Net peer count,
  Future<int> netPeerCount() async {
    final String method = EthereumRpcMethods.netPeerCount;
    final res = await rpcClient.request(method);
    if (res.containsKey(ethResultKey)) {
      return int.parse(res.result);
    }
    _processError(method, res);
    return null;
  }

  /// Protocol version
  Future<String> protocolVersion() async {
    final String method = EthereumRpcMethods.protocolVersion;
    final res = await rpcClient.request(method);
    if (res.containsKey(ethResultKey)) {
      return res.result;
    }
    _processError(method, res);
    return null;
  }

  /// Eth syncing, an object with data about the sync status if syncing or false if not.
  /// Encoded as a JsonObject with a syncStatus, if true the sync status data is valid.
  Future<JsonObjectLite> ethSyncing() async {
    final String method = EthereumRpcMethods.syncing;
    final res = await rpcClient.request(method);
    if (res.containsKey(ethResultKey)) {
      final JsonObjectLite resp = new JsonObjectLite();
      resp.syncStatus = false;
      if (!(res.result is bool) && (res.result.containsKey('startingBlock'))) {
        resp.syncStatus = true;
        resp.startingBlock = res.result.startingBlock;
        resp.currentBlock = res.result.currentBlock;
        resp.highestBlock = res.result.highestBlock;
      }
      return resp;
    }
    _processError(method, res);
    return null;
  }

  /// The client coinbase address.
  Future<String> coinbaseAddress() async {
    final String method = EthereumRpcMethods.coinbaseAddress;
    final res = await rpcClient.request(method);
    if (res.containsKey(ethResultKey)) {
      return res.result;
    }
    _processError(method, res);
    return null;
  }

  /// Mining, true when mining
  Future<bool> mining() async {
    final String method = EthereumRpcMethods.mining;
    final res = await rpcClient.request(method);
    if (res.containsKey(ethResultKey)) {
      return res.result;
    }
    _processError(method, res);
    return null;
  }

  /// Hashrate, returns the number of hashes per second that the node is mining with.
  Future<String> hashrate() async {
    final String method = EthereumRpcMethods.hashrate;
    final res = await rpcClient.request(method);
    if (res.containsKey(ethResultKey)) {
      return res.result;
    }
    _processError(method, res);
    return null;
  }

  /// The current price per gas in wei.
  Future<String> gasPrice() async {
    final String method = EthereumRpcMethods.gasPrice;
    final res = await rpcClient.request(method);
    if (res.containsKey(ethResultKey)) {
      return res.result;
    }
    _processError(method, res);
    return null;
  }

  /// Accounts,  a list of addresses owned by client.
  Future<List<String>> accounts() async {
    final String method = EthereumRpcMethods.accounts;
    final res = await rpcClient.request(method);
    if (res.containsKey(ethResultKey)) {
      return res.result;
    }
    _processError(method, res);
    return null;
  }

  /// Block number, the number of most recent block.
  Future<String> blockNumber() async {
    final String method = EthereumRpcMethods.blockNumber;
    final res = await rpcClient.request(method);
    if (res.containsKey(ethResultKey)) {
      return res.result;
    }
    _processError(method, res);
    return null;
  }

  /// Get balance, the balance of the account of the given address.
  /// The block can be an integer block number or the one of the strings
  /// "latest", "earliest" or "pending.
  Future<String> getBalance(String accountNumber, String block) async {
    if (accountNumber == null) {
      throw new ArgumentError.notNull("Ethereum::getBalance - accountNumber");
    }
    if (block == null) {
      throw new ArgumentError.notNull("Ethereum::getBalance - block");
    }
    final String method = EthereumRpcMethods.balance;
    final List params = [accountNumber, block];
    final res = await rpcClient.request(method, params);
    if (res.containsKey(ethResultKey)) {
      return res.result;
    }
    _processError(method, res);
    return null;
  }

  /// Get Storage at, the value from a storage position at a given address.
  /// Parameters are the address of the storage, the integer position of the storage and
  /// the block number, or the string "latest", "earliest" or "pending.
  Future<String> getStorageAt(String address, String pos, String block) async {
    if (address == null) {
      throw new ArgumentError.notNull("Ethereum::getStorageAt - address");
    }
    if (pos == null) {
      throw new ArgumentError.notNull("Ethereum::getStorageAt - pos");
    }
    if (block == null) {
      throw new ArgumentError.notNull("Ethereum::getStorageAt - block");
    }
    final String method = EthereumRpcMethods.storageAt;
    final List params = [address, pos, block];
    final res = await rpcClient.request(method, params);
    if (res.containsKey(ethResultKey)) {
      return res.result;
    }
    _processError(method, res);
    return null;
  }

  /// Transaction count, returns the number of transactions sent from an address.
  /// The block can be an integer block number or the one of the strings
  /// "latest", "earliest" or "pending.
  Future<String> getTransactionCount(String address, String block) async {
    if (address == null) {
      throw new ArgumentError.notNull(
          "Ethereum::getTransactionCount - address");
    }
    if (block == null) {
      throw new ArgumentError.notNull("Ethereum::getTransactionCount - block");
    }
    final String method = EthereumRpcMethods.transactionCount;
    final List params = [address, block];
    final res = await rpcClient.request(method, params);
    if (res.containsKey(ethResultKey)) {
      return res.result;
    }
    _processError(method, res);
    return null;
  }

  /// Block Transaction Count By Hash
  /// The number of transactions in a block from a block matching the given block hash.
  /// If the method returns null a count of 0 is returned, this is to distinguish between
  /// this and an error.
  Future<String> getBlockTransactionCountByHash(String blockHash) async {
    if (blockHash == null) {
      throw new ArgumentError.notNull(
          "Ethereum::getBlockTransactionCountByHash - blockHash");
    }
    final String method = EthereumRpcMethods.blockTransactionCountByHash;
    final List params = [blockHash];
    final res = await rpcClient.request(method, params);
    if (res.containsKey(ethResultKey)) {
      if (res.result != null) {
        return res.result;
      } else {
        return "0";
      }
    }
    _processError(method, res);
    return null;
  }

  /// Block Transaction Count By Number
  /// The number of transactions in a block matching the given block number.
  /// The block can be an integer block number or the one of the strings
  /// "latest", "earliest" or "pending.
  /// If the method returns null a count of 0 is returned, this is to distinguish between
  /// this and an error.
  Future<String> getBlockTransactionCountByNumber(String blockNumber) async {
    if (blockNumber == null) {
      throw new ArgumentError.notNull(
          "Ethereum::getBlockTransactionCountByNumber - blockNumber");
    }
    final String method = EthereumRpcMethods.blockTransactionCountByNumber;
    final List params = [blockNumber];
    final res = await rpcClient.request(method, params);
    if (res.containsKey(ethResultKey)) {
      if (res.result != null) {
        return res.result;
      } else {
        return "0";
      }
    }
    _processError(method, res);
    return null;
  }

  /// Block Uncle Count By Hash
  /// The number of uncles in a block from a block matching the given block hash.
  /// If the method returns null a count of 0 is returned, this is to distinguish between
  /// this and an error.
  Future<String> getUncleCountByHash(String blockHash) async {
    if (blockHash == null) {
      throw new ArgumentError.notNull(
          "Ethereum::getUncleCountByHash - blockHash");
    }
    final String method = EthereumRpcMethods.blockUncleCountByHash;
    final List params = [blockHash];
    final res = await rpcClient.request(method, params);
    if (res.containsKey(ethResultKey)) {
      if (res.result != null) {
        return res.result;
      } else {
        return "0";
      }
    }
    _processError(method, res);
    return null;
  }

  /// Block Uncle Count By Number
  /// The number of uncles in a block matching the given block number.
  /// The block can be an integer block number or the one of the strings
  /// "latest", "earliest" or "pending.
  /// If the method returns null a count of 0 is returned, this is to distinguish between
  /// this and an error.
  Future<String> getUncleCountByNumber(String blockNumber) async {
    if (blockNumber == null) {
      throw new ArgumentError.notNull(
          "Ethereum::getUncleCountByNumber - blockNumber");
    }
    final String method = EthereumRpcMethods.blockUncleCountByNumber;
    final List params = [blockNumber];
    final res = await rpcClient.request(method, params);
    if (res.containsKey(ethResultKey)) {
      if (res.result != null) {
        return res.result;
      } else {
        return "0";
      }
    }
    _processError(method, res);
    return null;
  }

  /// Get code, the code at the given address.
  /// The block can be an integer block number or the one of the strings
  /// "latest", "earliest" or "pending.
  Future<String> getCode(String address, String block) async {
    if (address == null) {
      throw new ArgumentError.notNull("Ethereum::getCode - address");
    }
    if (block == null) {
      throw new ArgumentError.notNull("Ethereum::getCode - block");
    }
    final String method = EthereumRpcMethods.code;
    final List params = [address, block];
    final res = await rpcClient.request(method, params);
    if (res.containsKey(ethResultKey)) {
      return res.result;
    }
    _processError(method, res);
    return null;
  }

  /// Sign
  /// The sign method calculates an Ethereum specific signature with:
  /// sign(keccak256("\x19Ethereum Signed Message:\n" + len(message) + message))).
  /// Note the address to sign with must be unlocked.
  Future<String> sign(String account, String message) async {
    if (account == null) {
      throw new ArgumentError.notNull("Ethereum::sign - account");
    }
    if (message == null) {
      throw new ArgumentError.notNull("Ethereum::sign - message");
    }
    final String method = EthereumRpcMethods.sign;
    final List params = [account, message];
    final res = await rpcClient.request(method, params);
    if (res.containsKey(ethResultKey)) {
      return res.result;
    }
    _processError(method, res);
    return null;
  }
}
