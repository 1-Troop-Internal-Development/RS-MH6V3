params [
	["_vehicle", vehicle player]
];

if (!hasInterface) exitWith {};
if (isNull _vehicle || {!alive _vehicle}) exitWith {};
if !(_vehicle isKindOf "RHS_MELB_AH6M") exitWith {};
if !(player in [driver _vehicle, gunner _vehicle, _vehicle turretUnit [0]]) exitWith {};

if !([] call RS_MH6V3_fnc_isACREAvailable) exitWith {};

uiNamespace setVariable ["RS_MH6V3_acreProgrammerVehicle", _vehicle];
createDialog "RS_MH6V3_ACRERadioProgrammer";
