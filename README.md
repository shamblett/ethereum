# ethereum
[![Build Status](https://github.com/shamblett/ethereum/actions/workflows/ci.yml/badge.svg)](https://github.com/shamblett/ethereum/actions/workflows/ci.yml)

An ethereum RPC 2 client for Dart.

This package provides a client to access the Ethereum JSON RPC API documented [here](https://github.com/ethereum/wiki/wiki/JSON-RPC)
It uses the JSON RPC2 interface and can be configured to use any of the endpoints described except ipc. The client runs on the server using HTTP, and in
the browser using both HTTP and web sockets.

The package currently implements most of the eth API and some of the admin API. 
Work is ongoing to complete the implementation of the admin API.

The mapping of Ethereum RPC data types to Dart types is as follows :-

* boolean   - bool 
* string    - String
* quantity  - int
* data      - BigInt

Examples can be found in the examples directory, also the unit test suite contains examples of calling every API interface.

The package was tested against a geth client.

