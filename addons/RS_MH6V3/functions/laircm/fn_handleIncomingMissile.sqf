params [
	["_vehicle", objNull, [objNull]],
	["_ammo", "", [""]],
	["_launcher", objNull, [objNull]],
	["_instigator", objNull, [objNull]],
	["_missile", objNull, [objNull]]
];

if (isNull _vehicle || {!alive _vehicle}) exitWith {};
if !(_vehicle isKindOf "RHS_MELB_base") exitWith {};
if (isNull _missile) exitWith {};
if (!isEngineOn _vehicle) exitWith {};
if (!(missionNamespace getVariable ["RS_MH6V3_laircmEnabled", true])) exitWith {};

if (!isServer) exitWith {
	private _forwardKey = format ["RS_MH6V3_laircmForwarded_%1", netId _missile];
	if (missionNamespace getVariable [_forwardKey, false]) exitWith {};
	missionNamespace setVariable [_forwardKey, true, false];
	[_forwardKey] spawn {
		params ["_key"];

		sleep 15;
		missionNamespace setVariable [_key, nil, false];
	};

	_this remoteExecCall ["RS_MH6V3_fnc_handleIncomingMissile", 2];
};

private _ammoCfg = configFile >> "CfgAmmo" >> _ammo;
private _ammoLower = toLower _ammo;
private _missileLower = toLower typeOf _missile;

private _isIRThreat =
	(getNumber (_ammoCfg >> "irLock")) > 0
	|| {(_ammoLower find "stinger") >= 0}
	|| {(_ammoLower find "igla") >= 0}
	|| {(_ammoLower find "9k38") >= 0}
	|| {(_ammoLower find "strela") >= 0}
	|| {(_missileLower find "stinger") >= 0}
	|| {(_missileLower find "igla") >= 0}
	|| {(_missileLower find "9k38") >= 0}
	|| {(_missileLower find "strela") >= 0};

if (!_isIRThreat) exitWith {};

private _missileKey = format ["RS_MH6V3_laircmHandled_%1", netId _missile];
if (missionNamespace getVariable [_missileKey, false]) exitWith {};
missionNamespace setVariable [_missileKey, true, false];
[_missileKey] spawn {
	params ["_key"];

	sleep 15;
	missionNamespace setVariable [_key, nil, false];
};

[_vehicle, _ammoLower, _missileLower, _missile] spawn {
	params ["_vehicle", "_ammoLower", "_missileLower", "_missile"];

	if (isNull _vehicle || {!alive _vehicle} || {isNull _missile}) exitWith {};

	sleep 1.8;

	if (
		isNull _vehicle
		|| {!alive _vehicle}
		|| {isNull _missile}
		|| {!(missionNamespace getVariable ["RS_MH6V3_laircmEnabled", true])}
		|| {!isEngineOn _vehicle}
	) exitWith {};

	private _getMissileAspect = {
		params ["_vehicle", "_missile"];

		private _modelPos = _vehicle worldToModelVisual (ASLToAGL getPosASL _missile);
		private _x = abs (_modelPos # 0);
		private _y = _modelPos # 1;
		private _z = _modelPos # 2;
		private _horizontal = (_x max (abs _y)) max 1;
		private _directRear = _y < -18 && {_x < ((abs _y) * 0.24)};
		private _directBottom = _z < -13 && {abs _z > (_horizontal * 1.08)};
		private _directTop = _z > 10 && {_z > (_horizontal * 0.85)};
		private _clearLOS = lineIntersectsSurfaces [
			getPosASL _vehicle,
			getPosASL _missile,
			_vehicle,
			_missile,
			true,
			1,
			"VIEW",
			"FIRE"
		] isEqualTo [];

		[_modelPos, _directRear, _directBottom, _directTop, _clearLOS]
	};

	private _aspect = [_vehicle, _missile] call _getMissileAspect;
	private _waitUntil = diag_tickTime + 1.3;
	while {
		diag_tickTime < _waitUntil
		&& {!isNull _vehicle}
		&& {!isNull _missile}
		&& {!(_aspect # 4) || {_aspect # 1} || {_aspect # 2} || {_aspect # 3}}
	} do {
		sleep 0.1;
		_aspect = [_vehicle, _missile] call _getMissileAspect;
	};

	if (isNull _vehicle || {isNull _missile}) exitWith {};

	private _activeMissiles = (_vehicle getVariable ["RS_MH6V3_laircmActiveMissiles", []]) select {
		!isNull _x && {alive _x}
	};

	if ((count _activeMissiles) >= 2) exitWith {
		private _distance = _vehicle distance _missile;
		private _missileSpeed = vectorMagnitude velocity _missile;
		_vehicle setVariable ["RS_MH6V3_laircmActiveMissiles", _activeMissiles, false];
		_vehicle setVariable ["RS_MH6V3_laircmLastResult", [false, 0, _distance, _missileSpeed], false];

		{
			if (isPlayer _x) then {
				[_vehicle, _missile, false] remoteExecCall ["RS_MH6V3_fnc_laircmVisual", _x];
			};
		} forEach crew _vehicle;
	};

	_vehicle setVariable ["RS_MH6V3_laircmLastMissile", _missile, false];

	private _distance = _vehicle distance _missile;
	private _missileSpeed = vectorMagnitude velocity _missile;
	private _getHitDamage = {
		params ["_hitPoint"];

		private _hitDamage = _vehicle getHitPointDamage _hitPoint;
		if (_hitDamage isEqualType 0) exitWith {_hitDamage max 0};

		0
	};

	private _damagePenalty = (damage _vehicle) * 0.28;
	private _enginePenalty = (["HitEngine"] call _getHitDamage) * 0.2;
	private _avionicsPenalty = (["HitAvionics"] call _getHitDamage) * 0.25;
	private _rangePenalty = 0;
	private _rangeBonus = 0;

	if (_distance < 250) then {
		_rangePenalty = 0.45;
	} else {
		if (_distance < 500) then {
			_rangePenalty = 0.25;
		} else {
			if (_distance >= 2000) then {
				_rangeBonus = 0.08;
			};
		};
	};

	private _speedPenalty = 0;
	if (_missileSpeed > 700) then {
		_speedPenalty = 0.22;
	} else {
		if (_missileSpeed > 500) then {
			_speedPenalty = 0.12;
		};
	};

	private _aspectPenalty = 0;
	if (_aspect # 1) then {
		_aspectPenalty = _aspectPenalty + 0.08;
	};
	if (_aspect # 2) then {
		_aspectPenalty = _aspectPenalty + 0.1;
	};
	if (_aspect # 3) then {
		_aspectPenalty = _aspectPenalty + 0.1;
	};
	if !(_aspect # 4) then {
		_aspectPenalty = _aspectPenalty + 0.12;
	};

	private _seekerPenalty = 0;
	if ((_ammoLower find "stinger") >= 0 || {(_missileLower find "stinger") >= 0}) then {
		_seekerPenalty = 0.08;
	};
	if ((_ammoLower find "verba") >= 0 || {(_missileLower find "verba") >= 0}) then {
		_seekerPenalty = 0.12;
	};

	private _engagements = (_vehicle getVariable ["RS_MH6V3_laircmRecentEngagements", []]) select {
		diag_tickTime - _x < 8
	};
	_engagements pushBack diag_tickTime;
	_vehicle setVariable ["RS_MH6V3_laircmRecentEngagements", _engagements, false];

	private _saturationPenalty = (((count _engagements) - 1) max 0) * 0.12;
	private _successChance = 0.88
		- _damagePenalty
		- _enginePenalty
		- _avionicsPenalty
		- _rangePenalty
		+ _rangeBonus
		- _speedPenalty
		- _aspectPenalty
		- _seekerPenalty
		- _saturationPenalty;

	_successChance = (_successChance max 0.12) min 0.95;

	private _success = (random 1) <= _successChance;
	_vehicle setVariable [
		"RS_MH6V3_laircmLastResult",
		[_success, _successChance, _distance, _missileSpeed],
		false
	];

	if (_success) then {
		_activeMissiles pushBack _missile;
		_vehicle setVariable ["RS_MH6V3_laircmActiveMissiles", _activeMissiles, false];
		[_vehicle, _missile] spawn {
			params ["_vehicle", "_missile"];

			sleep 6;
			if (!isNull _vehicle) then {
				private _activeMissiles = (_vehicle getVariable ["RS_MH6V3_laircmActiveMissiles", []]) select {
					!isNull _x && {alive _x} && {!(_x isEqualTo _missile)}
				};
				_vehicle setVariable ["RS_MH6V3_laircmActiveMissiles", _activeMissiles, false];
			};
		};

		[_vehicle, _missile] remoteExecCall ["RS_MH6V3_fnc_laircmDeflect", 0];
	};

	{
		if (isPlayer _x) then {
			[_vehicle, _missile, _success] remoteExecCall ["RS_MH6V3_fnc_laircmVisual", _x];
		};
	} forEach crew _vehicle;
};
