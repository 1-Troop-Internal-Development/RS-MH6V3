params [
	"_vehicle",
	["_engineOn", true]
];

if (isNull _vehicle || {!(typeOf _vehicle in ["RHS_MELB_H6M", "RHS_MELB_MH6M", "RHS_MELB_AH6M"])}) exitWith {false};

if (!alive _vehicle) then {
	_vehicle setVariable ["RS_MH6V3_pilotIZLIDEnabled", false, true];
	_vehicle setVariable ["RS_MH6V3_pilotIZLIDDirection", nil, true];

	if (typeOf _vehicle == "RHS_MELB_AH6M") then {
		[_vehicle, false] call RS_MH6V3_fnc_setIZLIDState;
		["RS_MH6V3_cleanupIlluminator", [_vehicle]] call CBA_fnc_globalEvent;
	} else {
		["RS_MH6V3_trackIZLIDVehicle", [_vehicle, false]] call CBA_fnc_globalEvent;
	};
};

if (typeOf _vehicle == "RHS_MELB_AH6M" && {!_engineOn}) then {
	[_vehicle, false] call RS_MH6V3_fnc_setIZLIDState;
	["RS_MH6V3_cleanupIlluminator", [_vehicle]] call CBA_fnc_globalEvent;
};

true
