params ["_vehicle", "_enabled"];

if (isNull _vehicle || {!(_vehicle isKindOf "RHS_MELB_AH6M")}) exitWith {false};

_enabled = [_enabled] param [0, false, [false]];

if (!local _vehicle) exitWith {
	_vehicle setVariable ["RS_MH6V3_izlidEnabled", _enabled, false];
	[_vehicle, _enabled] remoteExecCall ["RS_MH6V3_fnc_setIZLIDState", _vehicle];
	true
};

_vehicle setVariable ["RS_MH6V3_izlidEnabled", _enabled, true];
true
