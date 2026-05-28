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
private _radioOwner = _radioCombo lbValue _selected;
if (_radioOwner isEqualTo 0) then {
	missionNamespace setVariable ["RS_MH6V3_acreSelectedRadioId", _radioId];
};

private _channelText = ctrlText _channelEdit;
private _channel = parseNumber _channelText;
if (_channel < 1) exitWith {
	systemChat "RS MH-6V3: enter a channel number of 1 or higher.";
};

if (_radioOwner isEqualTo 1) exitWith {
	private _vehicle = uiNamespace getVariable ["RS_MH6V3_acreProgrammerVehicle", vehicle player];
	private _otherUnit = uiNamespace getVariable ["RS_MH6V3_acreProgrammerOtherUnit", objNull];
	private _crew = [driver _vehicle, gunner _vehicle, _vehicle turretUnit [0]];
	if (isNull _otherUnit || {!isPlayer _otherUnit}) exitWith {
		systemChat "RS MH-6V3: other seat radio owner is unavailable.";
	};
	if (isNull _vehicle || {!alive _vehicle} || {!(_vehicle isKindOf "RHS_MELB_AH6M")} || {!(player in _crew)} || {!(_otherUnit in _crew)}) exitWith {
		systemChat "RS MH-6V3: other seat radio owner is no longer in this aircraft.";
	};

	[player, _vehicle, _radioId, _channel] remoteExecCall ["RS_MH6V3_fnc_applyACRERadioTune", owner _otherUnit];
	systemChat format ["RS MH-6V3: requested other seat radio channel %1.", _channel];
	[true] call RS_MH6V3_fnc_populateACRERadioProgrammer;
};

private _success = [_radioId, _channel] call acre_api_fnc_setRadioChannel;
if (isNil "_success" || {!(_success isEqualTo false)}) then {
	playSound "RS_MH6V3_ACRETune";
	private _radioOwnerText = ["radio", "other seat AI radio"] select (_radioOwner isEqualTo 2);
	systemChat format ["RS MH-6V3: tuned %1 to channel %2.", _radioOwnerText, _channel];
} else {
	systemChat "RS MH-6V3: radio tune failed.";
};

[true] call RS_MH6V3_fnc_populateACRERadioProgrammer;
