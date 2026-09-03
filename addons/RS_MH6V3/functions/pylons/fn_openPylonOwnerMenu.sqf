params [
	["_vehicle", vehicle player]
];

if (!hasInterface) exitWith {false};
if (isNull _vehicle || {!alive _vehicle} || {typeOf _vehicle != "RHS_MELB_AH6M"}) exitWith {false};
if !(vehicle player isEqualTo _vehicle && {currentPilot _vehicle isEqualTo player}) exitWith {
	systemChat "RS MH-6V3: only the active pilot can configure pylon ownership.";
	false
};

if ((getPylonMagazines _vehicle) isEqualTo []) exitWith {
	systemChat "RS MH-6V3: no pylons are installed.";
	false
};

uiNamespace setVariable ["RS_MH6V3_pylonOwnerMenuVehicle", _vehicle];

createDialog "RS_MH6V3_PylonOwnerMenu"
