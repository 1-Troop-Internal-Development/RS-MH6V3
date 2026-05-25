if (!hasInterface) exitWith {false};
if (!isNull curatorCamera) exitWith {false};

private _vehicle = vehicle player;
if !(_vehicle isKindOf "RHS_MELB_AH6M") exitWith {false};
if !(player in _vehicle) exitWith {false};
if !(alive _vehicle && {isEngineOn _vehicle}) exitWith {false};

if !(player isEqualTo driver _vehicle || {player isEqualTo (_vehicle turretUnit [0])}) exitWith {
	false
};

if (typeOf _vehicle != "RHS_MELB_AH6M") exitWith {
	[_vehicle, false] call RS_MH6V3_fnc_setIZLIDState;
	_vehicle setVariable ["RS_MH6V3_izlidUnavailableNotice", diag_tickTime, false];
	playSound "ACE_Sound_Click";
	[_vehicle] call RS_MH6V3_fnc_showExternalWeaponControl;
	true
};

if (_vehicle getVariable ["RS_MH6V3_izlidEnabled", false]) exitWith {
	[_vehicle, false] call RS_MH6V3_fnc_setIZLIDState;
	playSound "ACE_Sound_Click";
	[_vehicle] call RS_MH6V3_fnc_showExternalWeaponControl;
	true
};

[_vehicle, true] call RS_MH6V3_fnc_setIZLIDState;
playSound "ACE_Sound_Click";
[_vehicle] call RS_MH6V3_fnc_showExternalWeaponControl;
true
