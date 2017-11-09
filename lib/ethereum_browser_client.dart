/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 06/011/2017
 * Copyright :  S.Hamblett
 *
 * An instance of Ethereum specialised for use in the browser.
 */

library ethereum_browser_client;

import 'dart:html';
import 'dart:async';
import 'package:stream_channel/stream_channel.dart';
import "package:json_rpc_2/json_rpc_2.dart" as rpc;
import 'package:ethereum/ethereum.dart';
import 'package:ethereum/ethereum_connection_mixin.dart';

class EthereumBrowserClient extends Ethereum with EthereumConnectionMixin {
  /// Overridden connect
  Future connect() {
    final Completer completer = new Completer();
    final HttpRequest req = new HttpRequest();

//    Socket.connect(host, port)
//      ..then((Socket sock) {
//        channel = new StreamChannel.withGuarantees(sock, sock);
//        rpcClient = new rpc.Client(channel);
//        connected = true;
//        return completer.complete();
//      }, onError: (e) {
//        throw new SocketException("EthereumServerClient::" + e.toString());
//      });
    return completer.future;
  }

  /// Close the client
  Future close() {
    connected = false;
    return super.close();
  }
}