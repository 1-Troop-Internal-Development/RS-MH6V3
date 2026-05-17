if (!hasInterface) exitWith {false};
if (!isNull curatorCamera) exitWith {false};

private _vehicle = vehicle player;
if !(_vehicle isKindOf "RHS_MELB_AH6M") exitWith {false};
if !(player in _vehicle) exitWith {false};

if !(player isEqualTo driver _vehicle || {player isEqualTo (_vehicle turretUnit [0])}) exitWith {
	false
};

if (_vehicle getVariable ["RS_MH6V3_izlidEnabled", false]) exitWith {
	[_vehicle, false] call RS_MH6V3_fnc_setIZLIDState;
	playSound "ACE_Sound_Click";
	hintSilent "IZLID OFF";
	true
};

[_vehicle, true] call RS_MH6V3_fnc_setIZLIDState;
playSound "ACE_Sound_Click";
hintSilent "IZLID ON";
true
