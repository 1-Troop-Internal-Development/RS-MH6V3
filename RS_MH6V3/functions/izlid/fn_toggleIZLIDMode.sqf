if (!hasInterface) exitWith {false};
if (!isNull curatorCamera) exitWith {false};

private _vehicle = vehicle player;
if !(_vehicle isKindOf "RHS_MELB_AH6M") exitWith {false};
if !(player in _vehicle) exitWith {false};

if !(player isEqualTo driver _vehicle || {player isEqualTo (_vehicle turretUnit [0])}) exitWith {
	false
};

private _mode = _vehicle getVariable ["RS_MH6V3_izlidMode", 3];
private _nextMode = switch (_mode) do {
	case 1: {2};
	case 2: {3};
	default {1};
};

_vehicle setVariable ["RS_MH6V3_izlidMode", _nextMode, true];
playSound "ACE_Sound_Click";
[_vehicle] call RS_MH6V3_fnc_showExternalWeaponControl;
true
