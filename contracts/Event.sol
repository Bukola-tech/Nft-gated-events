// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
// import "hardhat/console.sol";
import {Errors, Events} from "./Library.sol";

contract EventManager {
    enum EventType {
        Entertainment,
        Tech,
        Religious
    }
    uint256 public eventCount;

    struct EventObj {
        uint256 id;
        address manager;
        address nftAddress;
        string eventName;
        uint256 dateCreated;
        EventType eventType;
        uint256 numberOfRegisteredPersons;
        uint256 maxNumberOfRegistrations;
        uint256 numberOfAttendees;
        bool isDone;
        bool hasCanceled;
    }
    EventObj[] events;

    struct User {
        uint256 id;
        string name;
        uint256[] registeredEventIds;
    }
    // keeps track of all users
    User[] users;

    mapping(uint => EventObj) eventObjects;
    // hasRegistered[userAddress][eventId] -> bool
    mapping(address => mapping(uint => bool)) hasRegisteredForEvent;
    mapping(address => mapping(uint => bool)) hasAttendedEvent;

    // internal functions

    function sanityCheck(address _user) private pure {
        if (_user == address(0)) {
            revert Errors.ZeroAddressNotAllowed();
        }
    }

    function zeroValueCheck(uint256 _amount) private pure {
        if (_amount == 0) {
            revert Errors.ZeroValueNotAllowed();
        }
    }

    // creates an event
    function _createEvent(
        uint256 _id,
        address _nftAddress,
        string memory _eventName,
        EventType _eventType,
        uint256 _maxRegistrations
    ) private view returns (EventObj memory) {
        EventObj memory eventObj = EventObj({
            id: _id,
            eventName: _eventName,
            manager: msg.sender,
            nftAddress: _nftAddress,
            dateCreated: block.timestamp,
            eventType: _eventType,
            numberOfRegisteredPersons: 0,
            numberOfAttendees: 0,
            maxNumberOfRegistrations: _maxRegistrations,
            isDone: false,
            hasCanceled: false
        });
        return eventObj;
    }

    // external functions

    function createEvent(
        address _nftAddress,
        string memory _eventName,
        EventType _eventType,
        uint256 _maxRegistrations
    ) external {
        sanityCheck(msg.sender);
        sanityCheck(_nftAddress);
        zeroValueCheck(_maxRegistrations);

        uint _eventCount = eventCount + 1;
        EventObj memory eventObj = _createEvent(
            _eventCount,
            _nftAddress,
            _eventName,
            _eventType,
            _maxRegistrations
        );

        eventObjects[_eventCount] = eventObj;
        eventCount += 1;

        emit Events.EventCreatedSuccessfully(
            _eventName,
            msg.sender,
            _nftAddress
        );
    }

    function createEvent(
        address _nftAddress,
        string memory _eventName,
        EventType _eventType
    ) external {
        sanityCheck(msg.sender);
        sanityCheck(_nftAddress);

        uint _eventCount = eventCount + 1;
        EventObj memory eventObj =  _createEvent(
            _eventCount,
            _nftAddress,
            _eventName,
            _eventType,
            type(uint).max
        );
        events.push(eventObj);
        eventObjects[_eventCount] = eventObj;
        eventCount += 1;

        emit Events.EventCreatedSuccessfully(
            _eventName,
            msg.sender,
            _nftAddress
        );
    }

    // function updateEvent() external {

    //}

    function registerForEvent(string memory _name, uint256 _eventId) external {
        sanityCheck(msg.sender);
        zeroValueCheck(_eventId);
        EventObj memory _event = eventObjects[_eventId];
        if (_event.id < 1) {
            revert Errors.InvalidEventId();
        }
        if (hasRegisteredForEvent[msg.sender][_eventId]) {
            revert Errors.CannotRegisterTwice();
        }
        // check if user has nft
        // register the user
    }

    function signInForEvent() external {}
}
