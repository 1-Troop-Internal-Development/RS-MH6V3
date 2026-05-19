params ["_vehicle", ["_engineOn", true]];

if (isNull _vehicle || {!(_vehicle isKindOf "RHS_MELB_AH6M")}) exitWith {false};

if (!_engineOn || {!alive _vehicle}) then {
	[_vehicle, false] call RS_MH6V3_fnc_setIZLIDState;
	[_vehicle] remoteExecCall ["RS_MH6V3_fnc_cleanupIlluminator", 0];
};

true
