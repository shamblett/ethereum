/*
 * Package : Ethereum
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/11/2017
 * Copyright :  S.Hamblett
 */

library ethereum;

import "package:json_rpc_2/json_rpc_2.dart" as rpc;
import "package:json_rpc_2/error_code.dart" as rpc_error;
import 'package:stream_channel/stream_channel.dart';

part 'src/ethereum.dart';