import 'package:ethereum/ethereum_server_client.dart';

class CreateBottleScreenState {
  final EthereumServerClient client =
      EthereumServerClient.withConnectionParameters('localhost', 8545);
  String protocolVersion;
  Future<String> protocolVersionFuture() async {
    String protocolVersion = await client.eth.protocolVersion();
  }
}
