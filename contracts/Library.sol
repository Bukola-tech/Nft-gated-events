// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

library Errors {
    error ZeroAddressNotAllowed();
    error ZeroValueNotAllowed();
    error OnlyManager();
    error InvalidEventId();
    error CannotRegisterTwice();
}

library Events {
    event EventCreatedSuccessfully(
        string indexed _eventName,
        address indexed _manager,
        address indexed _nftAddress
    );
}
