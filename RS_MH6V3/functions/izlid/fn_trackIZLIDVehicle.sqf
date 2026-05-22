params [
	["_vehicle", objNull],
	["_enabled", false, [false]]
];

if (!hasInterface) exitWith {[]};

private _activeVehicles = missionNamespace getVariable ["RS_MH6V3_activeIZLIDVehicles", []];
_activeVehicles = _activeVehicles select {
	!isNull _x &&
	{alive _x} &&
	{_x isKindOf "RHS_MELB_AH6M"} &&
	{_x getVariable ["RS_MH6V3_izlidEnabled", false]}
};

if (
	_enabled &&
	{!isNull _vehicle} &&
	{alive _vehicle} &&
	{_vehicle isKindOf "RHS_MELB_AH6M"}
) then {
	_activeVehicles pushBackUnique _vehicle;
} else {
	if (!isNull _vehicle) then {
		[_vehicle] call RS_MH6V3_fnc_cleanupIlluminator;
	};

	_activeVehicles = _activeVehicles - [_vehicle];
};

missionNamespace setVariable ["RS_MH6V3_activeIZLIDVehicles", _activeVehicles];
_activeVehicles
