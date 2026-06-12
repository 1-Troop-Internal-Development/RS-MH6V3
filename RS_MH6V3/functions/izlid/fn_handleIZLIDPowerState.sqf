params [
	"_vehicle",
	["_engineOn", true]
];

if (isNull _vehicle || {!(_vehicle isKindOf "RHS_MELB_AH6M")}) exitWith {false};

if (typeOf _vehicle != "RHS_MELB_AH6M" || {!_engineOn} || {!alive _vehicle}) then {
	_vehicle setVariable ["RS_MH6V3_pilotIZLIDEnabled", false, true];
	_vehicle setVariable ["RS_MH6V3_pilotIZLIDDirection", nil, true];
	[_vehicle, false] call RS_MH6V3_fnc_setIZLIDState;
	[_vehicle] remoteExecCall ["RS_MH6V3_fnc_cleanupIlluminator", 0];
};

true
