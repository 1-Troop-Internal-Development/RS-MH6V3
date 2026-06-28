if (!hasInterface) exitWith {};
if !([] call RS_MH6V3_fnc_isACREAvailable) exitWith {};

[] spawn {
	if !([] call RS_MH6V3_fnc_isACREAvailable) exitWith {};

	waitUntil {!isNull findDisplay 46};

	private _display = findDisplay 46;
	if (!isNil "RS_MH6V3_acreKeyDownEh") then {
		_display displayRemoveEventHandler ["KeyDown", RS_MH6V3_acreKeyDownEh];
	};
	if (!isNil "RS_MH6V3_acreKeyUpEh") then {
		_display displayRemoveEventHandler ["KeyUp", RS_MH6V3_acreKeyUpEh];
	};

	RS_MH6V3_acreKeyDownEh = _display displayAddEventHandler ["KeyDown", {
		private _broadcasting = false;
		if (!isNil "acre_api_fnc_isBroadcasting") then {
			_broadcasting = [player] call acre_api_fnc_isBroadcasting;
			if (isNil "_broadcasting" || {!(_broadcasting isEqualType true)}) then {
				_broadcasting = false;
			};
		};
		missionNamespace setVariable ["RS_MH6V3_acrePTTHeld", _broadcasting];
		if (_broadcasting) then {
			missionNamespace setVariable ["RS_MH6V3_acreForceStatus", true];
			missionNamespace setVariable ["RS_MH6V3_acrePTTNonce", (missionNamespace getVariable ["RS_MH6V3_acrePTTNonce", 0]) + 1];
		};
		false
	}];
	RS_MH6V3_acreKeyUpEh = _display displayAddEventHandler ["KeyUp", {
		missionNamespace setVariable ["RS_MH6V3_acrePTTHeld", false];
		false
	}];

	if (isNil "RS_MH6V3_acreSpeakingHandlersAdded" && {!isNil "CBA_fnc_addEventHandler"}) then {
		RS_MH6V3_acreSpeakingHandlersAdded = true;

		["acre_startedSpeaking", {
			params [
				"_unit",
				["_onRadio", false],
				["_radioId", ""],
				["_speakingType", ""]
			];
			if (!(_unit isEqualTo player)) exitWith {};
			private _radioSpeech = (_onRadio isEqualType true && {_onRadio}) && {_radioId isEqualType ""} && {_radioId isNotEqualTo ""};
			if (!_radioSpeech) exitWith {};
			private _broadcasting = false;
			if (!isNil "acre_api_fnc_isBroadcasting") then {
				_broadcasting = [player] call acre_api_fnc_isBroadcasting;
				if (isNil "_broadcasting" || {!(_broadcasting isEqualType true)}) then {
					_broadcasting = false;
				};
			};
			if (!_broadcasting) exitWith {};

			missionNamespace setVariable ["RS_MH6V3_acrePTTHeld", true];
			missionNamespace setVariable ["RS_MH6V3_acreForceStatus", true];
			missionNamespace setVariable ["RS_MH6V3_acrePTTNonce", (missionNamespace getVariable ["RS_MH6V3_acrePTTNonce", 0]) + 1];
		}] call CBA_fnc_addEventHandler;

		["acre_stoppedSpeaking", {
			params [
				"_unit",
				["_onRadio", false],
				["_radioId", ""],
				["_speakingType", ""]
			];
			if (!(_unit isEqualTo player)) exitWith {};
			if (!(missionNamespace getVariable ["RS_MH6V3_acrePTTHeld", false])) exitWith {};

			missionNamespace setVariable ["RS_MH6V3_acrePTTHeld", false];
			missionNamespace setVariable ["RS_MH6V3_acreForceStatus", true];
			missionNamespace setVariable ["RS_MH6V3_acrePTTNonce", (missionNamespace getVariable ["RS_MH6V3_acrePTTNonce", 0]) + 1];
		}] call CBA_fnc_addEventHandler;
	};

	RS_MH6V3_acreCanShowRadioStatus = {
		if !([] call RS_MH6V3_fnc_isACREAvailable) exitWith {false};

		private _vehicle = vehicle player;
		(missionNamespace getVariable ["RS_MH6V3_acreStatusOverlayEnabled", true]) &&
			{!isNull _vehicle} &&
			{_vehicle isKindOf "RHS_MELB_AH6M"} &&
			{player in [driver _vehicle, gunner _vehicle, _vehicle turretUnit [0]]}
	};

	RS_MH6V3_acreBuildRadioStatusSignature = {
		params ["_vehicle"];

		private _acreReady = false;
		if (!isNil "acre_api_fnc_isInitialized") then {
			_acreReady = [] call acre_api_fnc_isInitialized;
			if (isNil "_acreReady" || {!(_acreReady isEqualType true)}) then {
				_acreReady = false;
			};
		};
		if (!_acreReady) exitWith {""};

		private _currentRadio = [] call acre_api_fnc_getCurrentRadio;
		if (isNil "_currentRadio" || {!(_currentRadio isEqualType "")}) then {
			_currentRadio = "";
		};

		private _lists = [_vehicle] call RS_MH6V3_fnc_getACRERadioLists;
		uiNamespace setVariable ["RS_MH6V3_acreRadioStatusListCache", _lists];
		private _radios = [_currentRadio] + (_lists get "all");
		_radios = _radios select {_x isEqualType "" && {_x isNotEqualTo ""}};
		_radios = _radios arrayIntersect _radios;
		private _radioInfoCache = createHashMap;

		private _parts = [format ["ACTIVE:%1", _currentRadio]];
		private _radioInUse = missionNamespace getVariable ["RS_MH6V3_acrePTTHeld", false];
		_parts pushBack format ["SPEAKING:%1", _radioInUse];
		_parts pushBack format ["PTT_NONCE:%1", missionNamespace getVariable ["RS_MH6V3_acrePTTNonce", 0]];
		_parts pushBack format ["SELECTION:%1:%2", missionNamespace getVariable ["RS_MH6V3_acreSelectedRadioId", ""], missionNamespace getVariable ["RS_MH6V3_acreSelectionNonce", 0]];
		private _accessibleRackRadios = if (isNil "ACRE_ACCESSIBLE_RACK_RADIOS") then {[]} else {+ACRE_ACCESSIBLE_RACK_RADIOS};
		private _hearableRackRadios = if (isNil "ACRE_HEARABLE_RACK_RADIOS") then {[]} else {+ACRE_HEARABLE_RACK_RADIOS};
		_parts pushBack format ["RACKS:%1:%2", _accessibleRackRadios, _hearableRackRadios];
		if (!isNil "acre_api_fnc_isBroadcasting") then {
			private _broadcasting = [player] call acre_api_fnc_isBroadcasting;
			if (isNil "_broadcasting" || {!(_broadcasting isEqualType true)}) then {
				_broadcasting = false;
			};
			_radioInUse = _radioInUse || {_broadcasting};
			_parts pushBack format ["BROADCASTING:%1", _broadcasting];
		};
		{
			private _info = [_x, _x isEqualTo _currentRadio] call RS_MH6V3_fnc_getACRERadioInfo;
			_radioInfoCache set [_x, _info];
			_radioInUse = _radioInUse || {_info get "incoming"} || {_info get "ptt"};
			_parts pushBack format [
				"%1:%2:%3:%4:%5:%6",
				_x,
				_info get "channel",
				_info get "channelName",
				_info get "on",
				_info get "incoming",
				_info get "ptt"
			];
		} forEach _radios;

		missionNamespace setVariable ["RS_MH6V3_acreRadioStatusInUse", _radioInUse];
		uiNamespace setVariable ["RS_MH6V3_acreRadioStatusInfoCache", _radioInfoCache];
		_parts joinString "|"
	};

	RS_MH6V3_acreStopRadioStatus = {
		RS_MH6V3_acreRadioStatusToken = (missionNamespace getVariable ["RS_MH6V3_acreRadioStatusToken", 0]) + 1;
		if (missionNamespace getVariable ["RS_MH6V3_acreRadioStatusVisible", false]) then {
			"RS_MH6V3_ACRERadioStatusLayer" cutText ["", "PLAIN"];
		};
		missionNamespace setVariable ["RS_MH6V3_acreRadioStatusRunning", false];
		missionNamespace setVariable ["RS_MH6V3_acreRadioStatusVisible", false];
	};

	RS_MH6V3_acreStartRadioStatus = {
		if !([] call RS_MH6V3_fnc_isACREAvailable) exitWith {};
		if !(call RS_MH6V3_acreCanShowRadioStatus) exitWith {};
		if (missionNamespace getVariable ["RS_MH6V3_acreRadioStatusRunning", false]) exitWith {};

		RS_MH6V3_acreRadioStatusToken = (missionNamespace getVariable ["RS_MH6V3_acreRadioStatusToken", 0]) + 1;
		private _token = RS_MH6V3_acreRadioStatusToken;
		missionNamespace setVariable ["RS_MH6V3_acreRadioStatusRunning", true];

		[_token] spawn {
			params ["_token"];

			private _wasVisible = false;
			private _visibleUntil = 0;
			private _lastSignature = "";
			private _wasRadioInUse = false;

			while {
				_token isEqualTo (missionNamespace getVariable ["RS_MH6V3_acreRadioStatusToken", -1]) &&
				{call RS_MH6V3_acreCanShowRadioStatus}
			} do {
				private _vehicle = vehicle player;
				private _signature = [_vehicle] call RS_MH6V3_acreBuildRadioStatusSignature;
				private _radioInUse = missionNamespace getVariable ["RS_MH6V3_acreRadioStatusInUse", false];
				private _delayedHide = missionNamespace getVariable ["RS_MH6V3_acreStatusOverlayDelayedHide", true];
				private _forceStatus = missionNamespace getVariable ["RS_MH6V3_acreForceStatus", false];
				if (_signature isNotEqualTo "" && {(_signature isNotEqualTo _lastSignature) || {_forceStatus}}) then {
					missionNamespace setVariable ["RS_MH6V3_acreForceStatus", false];
					_lastSignature = _signature;
					if (_radioInUse || {_forceStatus} || {_wasVisible}) then {
						_visibleUntil = [diag_tickTime + 3, 1e39] select (!_delayedHide && {_radioInUse});
						if (!_wasVisible) then {
							"RS_MH6V3_ACRERadioStatusLayer" cutRsc ["RS_MH6V3_ACRERadioStatus", "PLAIN", 0, false];
						};
						_wasVisible = true;
					};
				};

				if (_wasVisible && {!_delayedHide} && {!_radioInUse} && {_wasRadioInUse || {diag_tickTime >= _visibleUntil}}) then {
					"RS_MH6V3_ACRERadioStatusLayer" cutText ["", "PLAIN"];
					_wasVisible = false;
				};

				if (_wasVisible && {diag_tickTime < _visibleUntil}) then {
					[_vehicle] call RS_MH6V3_fnc_updateACRERadioStatus;
				};

				if (_wasVisible && {diag_tickTime >= _visibleUntil}) then {
					"RS_MH6V3_ACRERadioStatusLayer" cutText ["", "PLAIN"];
					_wasVisible = false;
				};

				_wasRadioInUse = _radioInUse;
				missionNamespace setVariable ["RS_MH6V3_acreRadioStatusVisible", _wasVisible];
				uiSleep ([0.5, 0.2] select (_wasVisible || {_radioInUse}));
			};

			if (_wasVisible) then {
				"RS_MH6V3_ACRERadioStatusLayer" cutText ["", "PLAIN"];
			};
			if (_token isEqualTo (missionNamespace getVariable ["RS_MH6V3_acreRadioStatusToken", -1])) then {
				missionNamespace setVariable ["RS_MH6V3_acreRadioStatusRunning", false];
			};
			missionNamespace setVariable ["RS_MH6V3_acreRadioStatusVisible", false];
		};
	};

	private _refreshStatusWorker = {
		if (call RS_MH6V3_acreCanShowRadioStatus) then {
			[] call RS_MH6V3_acreStartRadioStatus;
		} else {
			[] call RS_MH6V3_acreStopRadioStatus;
		};
	};

	if (!isNil "RS_MH6V3_acreStatusGetInEh") then {
		player removeEventHandler ["GetInMan", RS_MH6V3_acreStatusGetInEh];
	};
	if (!isNil "RS_MH6V3_acreStatusGetOutEh") then {
		player removeEventHandler ["GetOutMan", RS_MH6V3_acreStatusGetOutEh];
	};
	if (!isNil "RS_MH6V3_acreStatusSeatSwitchedEh") then {
		player removeEventHandler ["SeatSwitchedMan", RS_MH6V3_acreStatusSeatSwitchedEh];
	};

	RS_MH6V3_acreStatusGetInEh = player addEventHandler ["GetInMan", {
		[] call RS_MH6V3_acreStartRadioStatus;
	}];
	RS_MH6V3_acreStatusGetOutEh = player addEventHandler ["GetOutMan", {
		[] call RS_MH6V3_acreStopRadioStatus;
	}];
	RS_MH6V3_acreStatusSeatSwitchedEh = player addEventHandler ["SeatSwitchedMan", {
		if (call RS_MH6V3_acreCanShowRadioStatus) then {
			[] call RS_MH6V3_acreStartRadioStatus;
		} else {
			[] call RS_MH6V3_acreStopRadioStatus;
		};
	}];

	call _refreshStatusWorker;
};
