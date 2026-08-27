params [
	["_enabled", false, [false]]
];

if (!hasInterface) exitWith {false};
if (!isNull curatorCamera) exitWith {false};

private _vehicle = vehicle player;

if (!_enabled) exitWith {
	private _holdVehicle = player getVariable ["RS_MH6V3_izlidHoldVehicle", objNull];
	private _restoreState = player getVariable ["RS_MH6V3_izlidHoldPreviousState", false];

	player setVariable ["RS_MH6V3_izlidHoldVehicle", objNull, false];
	player setVariable ["RS_MH6V3_izlidHoldPreviousState", false, false];

	if (isNull _holdVehicle || {!(_holdVehicle isKindOf "RHS_MELB_AH6M")}) exitWith {false};

	[_holdVehicle, _restoreState] call RS_MH6V3_fnc_setIZLIDState;
	[_holdVehicle] call RS_MH6V3_fnc_showExternalWeaponControl;
	true
};

if !(_vehicle isKindOf "RHS_MELB_AH6M") exitWith {false};
if !(player in _vehicle) exitWith {false};
if !(alive _vehicle && {isEngineOn _vehicle}) exitWith {false};

if !(player isEqualTo driver _vehicle || {player isEqualTo (_vehicle turretUnit [0])}) exitWith {
	false
};

if (typeOf _vehicle != "RHS_MELB_AH6M") exitWith {
	[_vehicle, false] call RS_MH6V3_fnc_setIZLIDState;
	_vehicle setVariable ["RS_MH6V3_izlidUnavailableNotice", diag_tickTime, false];
	[_vehicle] call RS_MH6V3_fnc_showExternalWeaponControl;
	true
};

if ((player getVariable ["RS_MH6V3_izlidHoldVehicle", objNull]) isEqualTo _vehicle) exitWith {true};

player setVariable ["RS_MH6V3_izlidHoldVehicle", _vehicle, false];
player setVariable ["RS_MH6V3_izlidHoldPreviousState", _vehicle getVariable ["RS_MH6V3_izlidEnabled", false], false];

[_vehicle, true] call RS_MH6V3_fnc_setIZLIDState;
[_vehicle] call RS_MH6V3_fnc_showExternalWeaponControl;
true
