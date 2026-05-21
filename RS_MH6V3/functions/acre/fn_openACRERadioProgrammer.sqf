params [
	["_vehicle", vehicle player]
];

if (!hasInterface) exitWith {};
if (isNull _vehicle || {!alive _vehicle}) exitWith {};
if !(_vehicle isKindOf "RHS_MELB_AH6M") exitWith {};
if !(player in [driver _vehicle, gunner _vehicle, _vehicle turretUnit [0]]) exitWith {};

private _acreReady = false;
if (!isNil "acre_api_fnc_isInitialized") then {
	_acreReady = [] call acre_api_fnc_isInitialized;
	if (isNil "_acreReady" || {!(_acreReady isEqualType true)}) then {
		_acreReady = false;
	};
};

if (!_acreReady || {isNil "acre_api_fnc_getCurrentRadioList"}) exitWith {
	systemChat "RS MH-6V3: ACRE2 is not available.";
};

uiNamespace setVariable ["RS_MH6V3_acreProgrammerVehicle", _vehicle];
createDialog "RS_MH6V3_ACRERadioProgrammer";
