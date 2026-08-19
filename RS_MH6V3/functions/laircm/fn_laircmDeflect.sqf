params [
	["_vehicle", objNull, [objNull]],
	["_missile", objNull, [objNull]]
];

if (isNull _vehicle || {isNull _missile}) exitWith {};
if !(_vehicle isKindOf "RHS_MELB_base") exitWith {};

if (!local _missile) exitWith {};

private _activeKey = format ["RS_MH6V3_laircmDeflectActive_%1", netId _missile];
if (missionNamespace getVariable [_activeKey, false]) exitWith {};
missionNamespace setVariable [_activeKey, true, false];

_missile setMissileTarget objNull;
_missile setMissileTargetPos ((getPosASL _missile) vectorAdd ((vectorNormalized velocity _missile) vectorMultiply 500));

[_vehicle, _missile, _activeKey] spawn {
	params ["_vehicle", "_missile", "_activeKey"];

	if (isNull _vehicle || {isNull _missile}) exitWith {
		missionNamespace setVariable [_activeKey, false, false];
	};

	private _startTime = time;
	private _endTime = _startTime + 5.5;
	private _sideSign = selectRandom [-1, 1];
	private _blend = 0;
	private _startPos = getPosASL _missile;
	private _vehiclePos = getPosASL _vehicle;
	private _initialVelocity = velocity _missile;
	private _initialSpeed = (vectorMagnitude _initialVelocity) max 90;
	private _initialForward = vectorNormalized _initialVelocity;
	private _missVector = vectorNormalized (_startPos vectorDiff _vehiclePos);
	private _sideDrift = vectorNormalized [
		(_initialForward # 1) * _sideSign,
		-(_initialForward # 0) * _sideSign,
		0
	];
	private _terrainDrift = [0, 0, -0.34];
	private _blindDir = vectorNormalized (
		(_initialForward vectorMultiply 0.52)
		vectorAdd (_missVector vectorMultiply 0.28)
		vectorAdd (_sideDrift vectorMultiply 0.38)
		vectorAdd _terrainDrift
	);
	private _falseTargetBase = _startPos
		vectorAdd (_initialForward vectorMultiply 850)
		vectorAdd (_sideDrift vectorMultiply (450 + random 350))
		vectorAdd [0, 0, -260 - random 220];

	while {time < _endTime && {!isNull _vehicle} && {!isNull _missile}} do {
		private _velocity = velocity _missile;
		private _speed = ((vectorMagnitude _velocity) max 90) min _initialSpeed;
		private _forward = vectorNormalized _velocity;
		private _missilePos = getPosASL _missile;
		private _elapsed = time - _startTime;
		private _falseTarget = _falseTargetBase
			vectorAdd (_blindDir vectorMultiply (_elapsed * 35))
			vectorAdd [0, 0, -(_elapsed * 18)];
		private _falseTargetDir = vectorNormalized (_falseTarget vectorDiff _missilePos);

		_blend = (_blend + 0.018) min 0.38;

		private _targetDir = vectorNormalized (
			(_forward vectorMultiply (1 - _blend))
			vectorAdd (_falseTargetDir vectorMultiply _blend)
		);

		_missile setMissileTarget objNull;
		_missile setMissileTargetPos _falseTarget;
		_missile setVelocity (_targetDir vectorMultiply (_speed * 0.99));

		sleep 0.08;
	};

	missionNamespace setVariable [_activeKey, false, false];
};
