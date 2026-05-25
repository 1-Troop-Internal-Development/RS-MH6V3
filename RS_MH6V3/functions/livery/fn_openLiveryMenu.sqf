params [
	["_vehicle", objNull]
];

if (!hasInterface) exitWith {};
if (isNull _vehicle || {!alive _vehicle}) exitWith {};
if !(typeOf _vehicle in ["RHS_MELB_H6M", "RHS_MELB_MH6M", "RHS_MELB_AH6M"]) exitWith {};

uiNamespace setVariable ["RS_MH6V3_liveryVehicle", _vehicle];
createDialog "RS_MH6V3_LiveryMenu";
