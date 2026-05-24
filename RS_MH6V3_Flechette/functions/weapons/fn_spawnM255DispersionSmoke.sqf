if (!hasInterface) exitWith {};

params [
	["_posASL", [0, 0, 0], [[]], [3]],
	["_velocity", [0, 0, 0], [[]], [3]]
];

private _posATL = ASLToATL _posASL;
private _source = "#particlesource" createVehicleLocal _posATL;
private _light = "#lightpoint" createVehicleLocal _posATL;
private _smokeVelocity = [0, 0, 0];

if ((vectorMagnitude _velocity) > 0.01) then {
	_smokeVelocity = (vectorNormalized _velocity) vectorMultiply 8;
};

playSound3D [
	"A3\Sounds_F\arsenal\explosives\grenades\Explosion_gng_grenades_01.wss",
	objNull,
	false,
	_posASL,
	3,
	1.15,
	900
];

_light setLightColor [1, 0.35, 0.03];
_light setLightAmbient [0.6, 0.16, 0.01];
_light setLightBrightness 0.35;
_light setLightDayLight true;
_light setLightUseFlare false;

_source setParticleParams [
	["\A3\data_f\ParticleEffects\Universal\Universal", 16, 7, 48, 0],
	"",
	"Billboard",
	1,
	0.35,
	[0, 0, 0],
	_smokeVelocity,
	1,
	1.275,
	1,
	0.08,
	[0.45, 1.1, 1.7],
	[
		[1, 0.36, 0.03, 0.46],
		[1, 0.24, 0.01, 0.22],
		[0.75, 0.12, 0, 0]
	],
	[1.4, 0.6],
	0.06,
	0.08,
	"",
	"",
	_source
];
_source setParticleRandom [
	0.08,
	[0.25, 0.25, 0.25],
	[0.65, 0.65, 0.65],
	3,
	0.28,
	[0.08, 0.04, 0.02, 0.08],
	0.04,
	0.04
];
_source setDropInterval 0.0015;

[_source, _light] spawn {
	params ["_source", "_light"];

	sleep 0.12;
	if (!isNull _source) then {
		_source setDropInterval 0;
	};

	sleep 0.12;
	deleteVehicle _light;

	sleep 0.45;
	deleteVehicle _source;
};
