params [
	["_requester", objNull],
	["_vehicle", objNull],
	["_radioId", ""],
	["_channel", -1]
];

if (!hasInterface) exitWith {};
if (isNull _requester || {!isPlayer _requester}) exitWith {};
if (isNull _vehicle || {!alive _vehicle} || {!(_vehicle isKindOf "RHS_MELB_AH6M")}) exitWith {};
if (_radioId isEqualTo "" || {_channel < 1}) exitWith {};
if (isNil "acre_api_fnc_setRadioChannel") exitWith {};

private _crew = [driver _vehicle, gunner _vehicle, _vehicle turretUnit [0]];
if (!(player in _crew) || {!(_requester in _crew)}) exitWith {};

private _lists = [_vehicle] call RS_MH6V3_fnc_getACRERadioLists;
if !(_radioId in (_lists get "all")) exitWith {};

private _infoBefore = [_radioId, false] call RS_MH6V3_fnc_getACRERadioInfo;
private _oldChannel = _infoBefore get "channel";
if (_oldChannel isEqualTo "") then {
	_oldChannel = "CH -";
};

private _success = [_radioId, _channel] call acre_api_fnc_setRadioChannel;
if (isNil "_success" || {!(_success isEqualTo false)}) then {
	playSound "RS_MH6V3_ACRETune";
	systemChat format [
		"RS MH-6V3: %1 changed your %2 from %3 to CH %4.",
		name _requester,
		_infoBefore get "name",
		_oldChannel,
		_channel
	];
	missionNamespace setVariable ["RS_MH6V3_acreSelectedRadioId", _radioId];
	missionNamespace setVariable ["RS_MH6V3_acreForceStatus", true];
	missionNamespace setVariable ["RS_MH6V3_acreSelectionNonce", (missionNamespace getVariable ["RS_MH6V3_acreSelectionNonce", 0]) + 1];
	[_requester, _vehicle] call RS_MH6V3_fnc_publishACRERadioSnapshot;
};
