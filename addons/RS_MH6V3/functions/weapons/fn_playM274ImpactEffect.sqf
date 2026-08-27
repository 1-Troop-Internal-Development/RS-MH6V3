params [
	["_positionASL", [0, 0, 0], [[]]]
];

if (!hasInterface || {(count _positionASL) < 3}) exitWith {};

private _positionATL = ASLToATL _positionASL;
private _light = "#lightpoint" createVehicleLocal _positionATL;
_light setPosASL _positionASL;
_light setLightColor [1, 0.86, 0.55];
_light setLightAmbient [0.25, 0.18, 0.08];
_light setLightBrightness 8;
_light setLightDayLight true;
_light setLightUseFlare true;
_light setLightFlareSize 2.5;
_light setLightFlareMaxDistance 900;
_light setLightAttenuation [0.05, 0, 0, 1.4, 28, 80];

playSound3D [
	"A3\Sounds_F\arsenal\explosives\grenades\Explosion_gng_grenades_01.wss",
	objNull,
	false,
	_positionASL,
	4.5,
	1.55,
	1200
];

[_light] spawn {
	params ["_light"];

	sleep 0.06;
	if (!isNull _light) then {
		_light setLightBrightness 2.2;
	};

	sleep 0.08;
	if (!isNull _light) then {
		deleteVehicle _light;
	};
};
