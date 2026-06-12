params [
	["_vehicle", objNull],
	["_weapon", "", [""]],
	["_muzzle", "", [""]],
	["_mode", "", [""]],
	["_ammo", "", [""]]
];

if (isNull _vehicle || {!(_vehicle isKindOf "RHS_MELB_AH6M")}) exitWith {};

private _simulation = toLower getText (configFile >> "CfgAmmo" >> _ammo >> "simulation");
if (_simulation in ["shotrocket", "shotmissile"]) exitWith {
	private _strength = if (_simulation == "shotmissile") then {1.25} else {1};
	_vehicle setVariable ["RS_MH6V3_launchShakePulse", [serverTime, _strength], true];
};

private _isM134 = _weapon == "RS_MH6V3_weap_m134_pylon";
private _isGAU19 = ((toLower _weapon) find "gau19") >= 0;

if (!_isM134 && {!_isGAU19}) exitWith {};

private _now = serverTime;
private _lastPublished = _vehicle getVariable ["RS_MH6V3_lastMinigunShakePublish", -1];

// Miniguns fire too quickly to replicate every shot. A short pulse keeps all crew clients informed.
if ((_now - _lastPublished) < 0.08) exitWith {};

private _strength = if (_isGAU19) then {
	1.75
} else {
	if (_mode == "HighROF") then {1.4} else {1.15}
};
_vehicle setVariable ["RS_MH6V3_lastMinigunShakePublish", _now, false];
_vehicle setVariable ["RS_MH6V3_minigunShakePulse", [_now, _strength], true];
