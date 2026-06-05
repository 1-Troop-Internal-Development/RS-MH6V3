if (!hasInterface) exitWith {false};
if (!isNull curatorCamera) exitWith {false};

private _vehicle = vehicle player;
if (typeOf _vehicle != "RHS_MELB_AH6M") exitWith {false};
if !(player isEqualTo currentPilot _vehicle) exitWith {false};
if !(alive _vehicle && {isEngineOn _vehicle}) exitWith {false};

private _enabled = !(_vehicle getVariable ["RS_MH6V3_pilotIZLIDEnabled", false]);

if (_enabled && {!(_vehicle getVariable ["RS_MH6V3_izlidEnabled", false])}) then {
	[_vehicle, true] call RS_MH6V3_fnc_setIZLIDState;
};

_vehicle setVariable ["RS_MH6V3_pilotIZLIDEnabled", _enabled, true];

if (!_enabled) then {
	_vehicle setVariable ["RS_MH6V3_pilotIZLIDDirection", nil, true];
	player setVariable ["RS_MH6V3_pilotIZLIDLastDirection", nil, false];
	player setVariable ["RS_MH6V3_pilotIZLIDLastUpdate", nil, false];
};

playSound "ACE_Sound_Click";
[_vehicle] call RS_MH6V3_fnc_showExternalWeaponControl;
true
