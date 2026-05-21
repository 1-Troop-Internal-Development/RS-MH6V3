if (!hasInterface) exitWith {};

[] spawn {
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
			params ["_unit", ["_onRadio", false], ["_radioId", ""], ["_speakingType", ""]];
			if (!(_unit isEqualTo player)) exitWith {};
			if (!((_onRadio isEqualType true && {_onRadio}) || {_radioId isEqualType "" && {_radioId isNotEqualTo ""}})) exitWith {};

			missionNamespace setVariable ["RS_MH6V3_acrePTTHeld", true];
			missionNamespace setVariable ["RS_MH6V3_acreForceStatus", true];
			missionNamespace setVariable ["RS_MH6V3_acrePTTNonce", (missionNamespace getVariable ["RS_MH6V3_acrePTTNonce", 0]) + 1];
		}] call CBA_fnc_addEventHandler;

		["acre_stoppedSpeaking", {
			params ["_unit", ["_onRadio", false]];
			if (!(_unit isEqualTo player)) exitWith {};

			missionNamespace setVariable ["RS_MH6V3_acrePTTHeld", false];
			missionNamespace setVariable ["RS_MH6V3_acreForceStatus", true];
			missionNamespace setVariable ["RS_MH6V3_acrePTTNonce", (missionNamespace getVariable ["RS_MH6V3_acrePTTNonce", 0]) + 1];
		}] call CBA_fnc_addEventHandler;
	};

	private _wasVisible = false;
	private _visibleUntil = 0;
	private _lastSignature = "";

	private _buildSignature = {
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
		private _radios = [_currentRadio] + (_lists get "all");
		_radios = _radios select {_x isEqualType "" && {_x isNotEqualTo ""}};
		_radios = _radios arrayIntersect _radios;

		private _parts = [format ["ACTIVE:%1", _currentRadio]];
		_parts pushBack format ["SPEAKING:%1", missionNamespace getVariable ["RS_MH6V3_acrePTTHeld", false]];
		_parts pushBack format ["PTT_NONCE:%1", missionNamespace getVariable ["RS_MH6V3_acrePTTNonce", 0]];
		if (!isNil "acre_api_fnc_isBroadcasting") then {
			private _broadcasting = [player] call acre_api_fnc_isBroadcasting;
			if (isNil "_broadcasting" || {!(_broadcasting isEqualType true)}) then {
				_broadcasting = false;
			};
			_parts pushBack format ["BROADCASTING:%1", _broadcasting];
		};
		{
			private _info = [_x, _x isEqualTo _currentRadio] call RS_MH6V3_fnc_getACRERadioInfo;
			_parts pushBack format [
				"%1:%2:%3:%4:%5",
				_x,
				_info get "channel",
				_info get "channelName",
				_info get "on",
				_info get "incoming",
				_info get "ptt"
			];
		} forEach _radios;

		_parts joinString "|"
	};

	while {true} do {
		private _vehicle = vehicle player;
		private _canShow = !isNull _vehicle &&
			{_vehicle isKindOf "RHS_MELB_AH6M"} &&
			{player in [driver _vehicle, gunner _vehicle, _vehicle turretUnit [0]]} &&
			{!isNil "acre_api_fnc_isInitialized"} &&
			{!isNil "acre_api_fnc_getCurrentRadio"} &&
			{!isNil "acre_api_fnc_getCurrentRadioList"};

		if (_canShow) then {
			private _signature = [_vehicle] call _buildSignature;
			private _forceStatus = missionNamespace getVariable ["RS_MH6V3_acreForceStatus", false];
			if (_signature isNotEqualTo "" && {(_signature isNotEqualTo _lastSignature) || {_forceStatus}}) then {
				missionNamespace setVariable ["RS_MH6V3_acreForceStatus", false];
				_lastSignature = _signature;
				_visibleUntil = diag_tickTime + 3;
				"RS_MH6V3_ACRERadioStatusLayer" cutRsc ["RS_MH6V3_ACRERadioStatus", "PLAIN", 0, false];
				_wasVisible = true;
			};

			if (_wasVisible && {diag_tickTime < _visibleUntil}) then {
				[_vehicle] call RS_MH6V3_fnc_updateACRERadioStatus;
			};

			if (_wasVisible && {diag_tickTime >= _visibleUntil}) then {
				"RS_MH6V3_ACRERadioStatusLayer" cutText ["", "PLAIN"];
				_wasVisible = false;
			};
		} else {
			if (_wasVisible) then {
				"RS_MH6V3_ACRERadioStatusLayer" cutText ["", "PLAIN"];
				_wasVisible = false;
			};
			_lastSignature = "";
			_visibleUntil = 0;
		};

		uiSleep 0.12;
	};
};
