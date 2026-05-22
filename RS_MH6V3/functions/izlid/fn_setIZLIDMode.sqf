params [
	["_vehicle", objNull],
	["_mode", 3, [0]],
	["_coneMode", 1, [0]]
];

if (!hasInterface) exitWith {false};
if (isNull _vehicle || {!alive _vehicle}) exitWith {false};
if !(_vehicle isKindOf "RHS_MELB_AH6M") exitWith {false};
if !(player in [driver _vehicle, _vehicle turretUnit [0]]) exitWith {false};
if !(_mode in [1, 2, 3]) exitWith {false};

if (_mode == 1) then {
	_coneMode = 1;
};

if !(_coneMode in [1, 2, 3]) exitWith {false};

_vehicle setVariable ["RS_MH6V3_izlidMode", _mode, true];
_vehicle setVariable ["RS_MH6V3_izlidConeMode", _coneMode, true];

playSound "ACE_Sound_Click";
[_vehicle] call RS_MH6V3_fnc_showExternalWeaponControl;
true
