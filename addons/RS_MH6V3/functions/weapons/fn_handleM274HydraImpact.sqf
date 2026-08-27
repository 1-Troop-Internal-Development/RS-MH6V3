params [
	["_positionASL", [0, 0, 0], [[]]]
];

if ((count _positionASL) < 3) exitWith {};

[_positionASL] remoteExecCall ["RS_MH6V3_fnc_playM274ImpactEffect", 0];

private _impactATL = ASLToATL _positionASL;
private _smokeClass = "RS_MH6V3_ammo_Hydra_M274_SmokeCloud";
private _spawnOffsets =
[
	[0, 0, 0],
	[1.8, 0.9, 0],
	[-1.8, -0.9, 0]
];

{
	private _posATL = [
		(_impactATL # 0) + (_x # 0),
		(_impactATL # 1) + (_x # 1),
		(_impactATL # 2) max 0
	];
	private _smoke = createVehicle [_smokeClass, _posATL, [], 0, "CAN_COLLIDE"];
	_smoke hideObjectGlobal true;
	_smoke setVelocity [
		(random 0.8) - 0.4,
		(random 0.8) - 0.4,
		0.6 + random 0.3
	];
} forEach _spawnOffsets;
