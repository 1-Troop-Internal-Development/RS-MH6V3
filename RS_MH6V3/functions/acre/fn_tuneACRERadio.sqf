if (!hasInterface) exitWith {};

private _display = uiNamespace getVariable ["RS_MH6V3_acreProgrammerDisplay", displayNull];
if (isNull _display) exitWith {};

if (isNil "acre_api_fnc_setRadioChannel") exitWith {
	systemChat "RS MH-6V3: ACRE2 radio channel API is not available.";
};

private _radioCombo = _display displayCtrl 86321;
private _channelEdit = _display displayCtrl 86322;
private _selected = lbCurSel _radioCombo;
if (_selected < 0) exitWith {
	systemChat "RS MH-6V3: select a radio to tune.";
};

private _radioId = _radioCombo lbData _selected;
if (_radioId isEqualTo "") exitWith {
	systemChat "RS MH-6V3: selected radio is invalid.";
};

private _channelText = ctrlText _channelEdit;
private _channel = parseNumber _channelText;
if (_channel < 1) exitWith {
	systemChat "RS MH-6V3: enter a channel number of 1 or higher.";
};

private _success = [_radioId, _channel] call acre_api_fnc_setRadioChannel;
if (isNil "_success" || {!(_success isEqualTo false)}) then {
	playSound "RS_MH6V3_ACRETune";
	systemChat format ["RS MH-6V3: tuned radio to channel %1.", _channel];
} else {
	systemChat "RS MH-6V3: radio tune failed.";
};

[true] call RS_MH6V3_fnc_populateACRERadioProgrammer;
