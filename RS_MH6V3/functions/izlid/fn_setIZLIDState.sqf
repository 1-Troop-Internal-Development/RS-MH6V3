params ["_vehicle", "_enabled"];

if (isNull _vehicle || {!(_vehicle isKindOf "RHS_MELB_AH6M")}) exitWith {false};

_enabled = [_enabled] param [0, false, [false]];

if (isNil {_vehicle getVariable "RS_MH6V3_izlidMode"}) then {
	_vehicle setVariable ["RS_MH6V3_izlidMode", 3, true];
};

if (!local _vehicle) exitWith {
	_vehicle setVariable ["RS_MH6V3_izlidEnabled", _enabled, true];
	[_vehicle, _enabled] remoteExecCall ["RS_MH6V3_fnc_setIZLIDState", _vehicle];
	true
};

_vehicle setVariable ["RS_MH6V3_izlidEnabled", _enabled, true];
true
