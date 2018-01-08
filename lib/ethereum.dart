/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

library ethereum;

import 'dart:async';

part 'src/ethereum.dart';

part 'src/ethereum_rpc_methods.dart';
part 'src/ethereum_rpc_client.dart';

part 'src/ethereum_error.dart';
part 'src/ethereum_utilities.dart';

part 'src/adapters/ethereum_inetwork_adapter.dart';

part 'src/messages/ethereum_sync_status.dart';

/// Constants
const String ethResultKey = "result";
const String ethErrorKey = "error";