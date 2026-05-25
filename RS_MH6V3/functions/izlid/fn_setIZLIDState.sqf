params [
	"_vehicle",
	"_enabled"
];

if (isNull _vehicle || {!(_vehicle isKindOf "RHS_MELB_AH6M")}) exitWith {false};

_enabled = [_enabled] param [0, false, [false]];

if (_enabled && {typeOf _vehicle != "RHS_MELB_AH6M"}) exitWith {
	_vehicle setVariable ["RS_MH6V3_izlidEnabled", false, true];
	_vehicle setVariable ["RS_MH6V3_irIlluminatorBrightnessActive", nil, true];
	[_vehicle, false] remoteExecCall ["RS_MH6V3_fnc_trackIZLIDVehicle", 0];
	false
};

if (isNil {_vehicle getVariable "RS_MH6V3_izlidMode"}) then {
	_vehicle setVariable ["RS_MH6V3_izlidMode", 3, true];
};

if (isNil {_vehicle getVariable "RS_MH6V3_izlidConeMode"}) then {
	_vehicle setVariable ["RS_MH6V3_izlidConeMode", 1, true];
};

if (!_enabled) then {
	_vehicle setVariable ["RS_MH6V3_irIlluminatorBrightnessActive", nil, true];
};

_vehicle setVariable ["RS_MH6V3_izlidEnabled", _enabled, true];
[_vehicle, _enabled] remoteExecCall ["RS_MH6V3_fnc_trackIZLIDVehicle", 0];
true
