params [
	["_vehicle", objNull],
	["_weapon", "", [""]],
	["_muzzle", "", [""]],
	["_mode", "", [""]],
	["_ammo", "", [""]],
	["_magazine", "", [""]],
	["_projectile", objNull]
];

if (isNull _vehicle || {!(_vehicle isKindOf "RHS_MELB_AH6M")}) exitWith {};

private _sendShakeToCrew = {
	params ["_vehicle", "_effect", "_strength"];

	{
		if (isPlayer _x) then {
			[
				"RS_MH6V3_cameraShake",
				[_vehicle, _effect, _strength],
				_x
			] call CBA_fnc_targetEvent;
		};
	} forEach crew _vehicle;
};

private _applyLaunchTorque = {
	params [
		["_vehicle", objNull],
		["_projectile", objNull],
		["_effect", "", [""]],
		["_fallbackSideSign", 0, [0]]
	];

	if (isNull _vehicle || {!local _vehicle}) exitWith {};

	private _sideSign = _fallbackSideSign;
	if (!isNull _projectile) then {
		private _projectileModelPos = _vehicle worldToModelVisual (getPosASL _projectile);
		private _sideOffset = _projectileModelPos select 0;
		if ((abs _sideOffset) >= 0.2) then {
			_sideSign = if (_sideOffset < 0) then {-1} else {1};
		};
	};
	if (_sideSign == 0) exitWith {};

	private _baseTorque = if (_effect == "missile") then {725} else {500};
	private _yawAxis = vectorUpVisual _vehicle;
	private _rollAxis = vectorDirVisual _vehicle;

	_vehicle addTorque (_yawAxis vectorMultiply (_sideSign * _baseTorque));
	_vehicle addTorque (_rollAxis vectorMultiply (_sideSign * _baseTorque * 0.15));
};

private _simulation = toLower getText (configFile >> "CfgAmmo" >> _ammo >> "simulation");
if (_simulation in ["shotrocket", "shotmissile"]) exitWith {
	private _strength = if (_simulation == "shotmissile") then {1.25} else {1};
	private _effect = if (_simulation == "shotmissile") then {"missile"} else {"rocket"};
	private _fallbackSideSign = 0;
	private _recoilPylon = _vehicle getVariable ["RS_MH6V3_quickHydraRecoilPylon", []];
	if (
		(count _recoilPylon) == 2 &&
		{(diag_tickTime - (_recoilPylon # 1)) < 1}
	) then {
		_fallbackSideSign = if ((_recoilPylon # 0) in [1, 2]) then {1} else {-1};
	};

	[_vehicle, _projectile, _effect, _fallbackSideSign] call _applyLaunchTorque;
	[_vehicle, _effect, _strength] call _sendShakeToCrew;
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
	if (_mode == "HighROF") then {1.28} else {1.05}
};
_vehicle setVariable ["RS_MH6V3_lastMinigunShakePublish", _now, false];
[_vehicle, "gun", _strength] call _sendShakeToCrew;
