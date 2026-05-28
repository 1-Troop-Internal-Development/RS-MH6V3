params [
	["_radioId", ""],
	["_isActiveRadio", false]
];

private _info = createHashMapFromArray [
	["id", _radioId],
	["name", _radioId],
	["channel", ""],
	["channelNumber", -1],
	["channelName", ""],
	["on", false],
	["monitoring", false],
	["incoming", false],
	["ptt", false]
];

if (_radioId isEqualTo "") exitWith {_info};

private _displayNameCache = uiNamespace getVariable ["RS_MH6V3_acreDisplayNameCache", createHashMap];
private _name = _displayNameCache getOrDefault [_radioId, ""];
if (_name isEqualTo "") then {
	_name = _radioId;
	if (!isNil "acre_api_fnc_getDisplayName") then {
		_name = [_radioId] call acre_api_fnc_getDisplayName;
	};
	if (isNil "_name") then {
		_name = _radioId;
	};
	if !(_name isEqualType "") then {
		_name = str _name;
	};
	_displayNameCache set [_radioId, _name];
	uiNamespace setVariable ["RS_MH6V3_acreDisplayNameCache", _displayNameCache];
};
_info set ["name", _name];

private _channel = -1;
if (_isActiveRadio && {!isNil "acre_api_fnc_getCurrentRadioChannelNumber"}) then {
	_channel = [] call acre_api_fnc_getCurrentRadioChannelNumber;
} else {
	if (!isNil "acre_api_fnc_getRadioChannel") then {
		_channel = [_radioId] call acre_api_fnc_getRadioChannel;
	};
};
if (isNil "_channel") then {
	_channel = -1;
};
if (_channel isEqualType 0) then {
	private _channelNumber = _channel max 1;
	_info set ["channelNumber", _channelNumber];
	_info set ["channel", format ["CH %1", _channelNumber]];
} else {
	if (_channel isEqualType "") then {
		_info set ["channel", _channel];
	};
};

private _channelNumber = _info get "channelNumber";
if (_channelNumber > 0 && {!isNil "acre_api_fnc_getBaseRadio"} && {!isNil "acre_api_fnc_getPreset"} && {!isNil "acre_api_fnc_getPresetChannelField"}) then {
	private _baseRadio = [_radioId] call acre_api_fnc_getBaseRadio;
	if (!isNil "_baseRadio" && {_baseRadio isEqualType ""} && {_baseRadio isNotEqualTo ""}) then {
		private _preset = [_baseRadio] call acre_api_fnc_getPreset;
		if (!isNil "_preset" && {_preset isEqualType ""} && {_preset isNotEqualTo ""}) then {
			private _channelNameCache = uiNamespace getVariable ["RS_MH6V3_acreChannelNameCache", createHashMap];
			private _channelNameKey = format ["%1|%2|%3", _baseRadio, _preset, _channelNumber];
			private _channelName = _channelNameCache getOrDefault [_channelNameKey, ""];
			if (_channelName isEqualTo "") then {
				_channelName = [_baseRadio, _preset, _channelNumber, "label"] call acre_api_fnc_getPresetChannelField;
				if (isNil "_channelName" || {!(_channelName isEqualType "")} || {_channelName isEqualTo ""}) then {
					_channelName = [_baseRadio, _preset, _channelNumber, "description"] call acre_api_fnc_getPresetChannelField;
				};
				if (!isNil "_channelName" && {_channelName isEqualType ""} && {_channelName isNotEqualTo ""}) then {
					_channelNameCache set [_channelNameKey, _channelName];
					uiNamespace setVariable ["RS_MH6V3_acreChannelNameCache", _channelNameCache];
				};
			};
			if (!isNil "_channelName" && {_channelName isEqualType ""} && {_channelName isNotEqualTo ""}) then {
				_info set ["channelName", _channelName];
			};
		};
	};
};

private _on = true;
if (!isNil "acre_api_fnc_getRadioOnOffState") then {
	_on = [_radioId] call acre_api_fnc_getRadioOnOffState;
};
if (isNil "_on") then {
	_on = true;
};
if !(_on isEqualType true) then {
	_on = _on isEqualTo 1;
};
_info set ["on", _on];
_info set ["monitoring", _on && {(_info get "channel") isNotEqualTo ""}];

private _broadcasting = false;
if (!isNil "acre_api_fnc_isBroadcasting") then {
	_broadcasting = [player] call acre_api_fnc_isBroadcasting;
	if (isNil "_broadcasting" || {!(_broadcasting isEqualType true)}) then {
		_broadcasting = false;
	};
};

if (!isNil "acre_sys_data_fnc_getScratchData") then {
	private _currentTransmissions = [_radioId, "currentTransmissions", []] call acre_sys_data_fnc_getScratchData;
	if (!isNil "_currentTransmissions" && {_currentTransmissions isEqualType []}) then {
		_info set ["incoming", count _currentTransmissions > 0];
	};

	private _pttDown = [_radioId, "PTTDown", false] call acre_sys_data_fnc_getScratchData;
	if (!isNil "_pttDown" && {_pttDown isEqualType true}) then {
		_info set ["ptt", _pttDown && {_broadcasting}];
	};
};

if (!(_info get "ptt") && {_isActiveRadio} && {_broadcasting}) then {
	_info set ["ptt", true];
};

if (!(_info get "ptt") && {_isActiveRadio} && {missionNamespace getVariable ["RS_MH6V3_acrePTTHeld", false]}) then {
	_info set ["ptt", true];
};

_info
