if (!hasInterface) exitWith {false};
if (!isNull curatorCamera) exitWith {false};

private _vehicle = vehicle player;
if (isNull _vehicle || {!alive _vehicle}) exitWith {false};
if !(typeOf _vehicle in ["RHS_MELB_H6M", "RHS_MELB_MH6M", "RHS_MELB_AH6M"]) exitWith {false};
if !(player in [driver _vehicle, gunner _vehicle]) exitWith {false};

private _armed = !(player getVariable ["RS_MH6V3_quickFireArmed", false]);
player setVariable ["RS_MH6V3_quickFireArmed", _armed, false];

[_armed] call RS_MH6V3_fnc_showQuickFireStatus;

true
