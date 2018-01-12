# ethereum
[![Build Status](https://travis-ci.org/shamblett/ethereum.svg?branch=master)](https://travis-ci.org/shamblett/ethereum)

An ethereum RPC 2 client for Dart.

This package provides a client to access the Ethereum JSON RPC API documented [here](https://github.com/ethereum/wiki/wiki/JSON-RPC)
It uses the JSON RPC2 interface and can be configured to use any of the endpoints described.

The package currently implements 55 of the API calls documented, the main omissions being ones documented but no longer 
implemented in the latest version of geth.
This encompasses the Solidity interface and most of the SHH whisper interface. As this Ethereum API is updated the package will
be updated to suit.

The mapping of Ethereum RPC data types to Dart types is as follows :-

* boolean   - bool 
* string    - String
* quantity  - int
* data      - BigInt(see below)

Examples can be found in the examples directory, also the unit test suite contains examples of calling every API interface.

The package was tested against a geth client, version 1.7.2. The API provided should work on older geth clients
but be aware some calls may return an error of not implemented.
 
The package currently depends on the BigNum package, this package is not currently Dart 2.0 ready and may be 
superceded by a new BigInt implementation in Dart. This package will be updated approprately as and when any changes are 
needed.

