if (!hasInterface) exitWith {false};
if (!isNull curatorCamera) exitWith {false};

private _vehicle = vehicle player;
if (isNull _vehicle || {!alive _vehicle}) exitWith {false};
if !(typeOf _vehicle isEqualTo "RHS_MELB_AH6M") exitWith {false};
if !(player in [driver _vehicle, gunner _vehicle]) exitWith {false};

private _armed = !(_vehicle getVariable ["RS_MH6V3_quickFireArmed", false]);
_vehicle setVariable ["RS_MH6V3_quickFireArmed", _armed, true];

[_vehicle] call RS_MH6V3_fnc_showExternalWeaponControl;

true
