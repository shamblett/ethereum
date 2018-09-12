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

part 'src/messages/ethereum_block.dart';

part 'src/messages/ethereum_transaction.dart';

part 'src/messages/ethereum_transaction_receipt.dart';

part 'src/messages/ethereum_log.dart';

part 'src/messages/ethereum_filter.dart';

part 'src/messages/ethereum_work.dart';

part 'src/parameters/ethereum_default_block.dart';

part 'src/api/ethereum_api_dapp.dart';

/// Constants
const String ethResultKey = "result";
const String ethErrorKey = "error";
