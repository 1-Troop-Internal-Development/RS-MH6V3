params [
	["_vehicle", objNull],
	["_weapon", ""],
	["_muzzle", ""],
	["_mode", ""],
	["_ammo", ""],
	["_magazine", ""],
	["_projectile", objNull]
];

if (!local _vehicle) exitWith {};
if (isNull _projectile) exitWith {};
if !(_ammo find "RS_MH6V3_ammo_M255_APERS_" == 0) exitWith {};

private _ammoConfig = configFile >> "CfgAmmo" >> _ammo;
private _triggerDistance = getNumber (_ammoConfig >> "triggerDistance");
if (_triggerDistance <= 0) exitWith {};
private _adaptiveFuze = (getNumber (_ammoConfig >> "RS_MH6V3_adaptiveFuze")) > 0;

if (_adaptiveFuze) exitWith {
	private _adaptiveDistance = getNumber (_ammoConfig >> "RS_MH6V3_adaptiveDistance");
	private _minTravelBeforeFuze = getNumber (_ammoConfig >> "RS_MH6V3_minTravelBeforeFuze");
	private _flechetteCount = getNumber (_ammoConfig >> "RS_MH6V3_flechetteCount");
	private _coneAngle = getNumber (_ammoConfig >> "submunitionConeAngle");
	private _flechetteAmmo = getText (_ammoConfig >> "submunitionAmmo");

	if (_adaptiveDistance <= 0) then {
		_adaptiveDistance = 75;
	};
	if (_minTravelBeforeFuze <= 0) then {
		_minTravelBeforeFuze = 125;
	};
	if (_flechetteCount <= 0) then {
		_flechetteCount = 80;
	};
	if (_coneAngle <= 0) then {
		_coneAngle = 4;
	};
	if (_flechetteAmmo == "") exitWith {};

	[_vehicle, _projectile, getPosASL _projectile, _adaptiveDistance, _minTravelBeforeFuze, _flechetteCount, _coneAngle, _flechetteAmmo] spawn {
		params ["_vehicle", "_projectile", "_startPos", "_adaptiveDistance", "_minTravelBeforeFuze", "_flechetteCount", "_coneAngle", "_flechetteAmmo"];

		private _lastPos = _startPos;
		private _lastVelocity = velocity _projectile;
		private _timeout = diag_tickTime + 8;
		private _disperse = false;

		while {diag_tickTime < _timeout && {!isNull _projectile}} do {
			_lastPos = getPosASL _projectile;
			_lastVelocity = velocity _projectile;

			private _speed = vectorMagnitude _lastVelocity;
			if (_speed > 1 && {(_lastPos distance _startPos) >= _minTravelBeforeFuze}) then {
				private _direction = vectorNormalized _lastVelocity;
				private _traceDistance = (_adaptiveDistance max 25) + ((_speed * 0.05) max 25);
				private _traceEnd = _lastPos vectorAdd (_direction vectorMultiply _traceDistance);
				private _surfaces = lineIntersectsSurfaces [_lastPos, _traceEnd, _vehicle, _projectile, true, 1, "GEOM", "FIRE"];

				if (_surfaces isNotEqualTo [] && {(_lastPos distance ((_surfaces # 0) # 0)) <= _adaptiveDistance}) exitWith {
					_disperse = true;
				};
			};

			sleep 0.01;
		};

		if (!_disperse || {isNull _projectile}) exitWith {};

		[_lastPos, _lastVelocity] remoteExecCall ["RS_MH6V3_Flechette_fnc_spawnM255DispersionSmoke", 0];

		private _direction = [0, 1, 0];
		private _speed = vectorMagnitude _lastVelocity;
		if (_speed > 1) then {
			_direction = vectorNormalized _lastVelocity;
		};

		private _referenceUp = [0, 0, 1];
		if (abs (_direction vectorDotProduct _referenceUp) > 0.95) then {
			_referenceUp = [0, 1, 0];
		};

		private _right = _direction vectorCrossProduct _referenceUp;
		_right = vectorNormalized _right;
		private _up = _right vectorCrossProduct _direction;
		_up = vectorNormalized _up;
		private _coneTan = tan _coneAngle;
		private _originATL = ASLToATL _lastPos;

		for "_i" from 1 to _flechetteCount do {
			private _theta = random 360;
			private _offset = (sqrt (random 1)) * _coneTan;
			private _pelletDirection = _direction
				vectorAdd (_right vectorMultiply ((cos _theta) * _offset))
				vectorAdd (_up vectorMultiply ((sin _theta) * _offset));
			_pelletDirection = vectorNormalized _pelletDirection;

			private _pellet = createVehicle [_flechetteAmmo, _originATL, [], 0, "CAN_COLLIDE"];
			_pellet setPosASL _lastPos;
			_pellet setVectorDir _pelletDirection;
			_pellet setVelocity (_pelletDirection vectorMultiply (1500 + random 220));
			_pellet setShotParents [_vehicle, effectiveCommander _vehicle];
		};

		deleteVehicle _projectile;
	};
};

[_projectile, getPosASL _projectile, _triggerDistance] spawn {
	params ["_projectile", "_startPos", "_triggerDistance"];

	private _lastPos = _startPos;
	private _lastVelocity = velocity _projectile;
	private _timeout = diag_tickTime + 8;
	private _reachedFuze = false;

	while {diag_tickTime < _timeout && {!isNull _projectile}} do {
		_lastPos = getPosASL _projectile;
		_lastVelocity = velocity _projectile;

		if ((_lastPos distance _startPos) >= _triggerDistance) exitWith {
			_reachedFuze = true;
		};

		sleep 0.01;
	};

	if (_reachedFuze || {(_lastPos distance _startPos) > 20}) then {
		[_lastPos, _lastVelocity] remoteExecCall ["RS_MH6V3_Flechette_fnc_spawnM255DispersionSmoke", 0];

		sleep 0.03;
		if (!isNull _projectile) then {
			deleteVehicle _projectile;
		};
	};
};
