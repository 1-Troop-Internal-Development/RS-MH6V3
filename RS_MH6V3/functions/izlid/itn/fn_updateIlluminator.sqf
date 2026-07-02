if (!hasInterface) exitWith {objNull};

params [
	"_vehicle",
	"_origin",
	"_direction",
	["_offset", 0, [0]],
	["_coneMode", 1, [0]]
];

if (isNull _vehicle) exitWith {objNull};

private _illuminator = _vehicle getVariable ["RS_MH6V3_izlidIlluminator", objNull];
private _illuminatorType = _vehicle getVariable ["RS_MH6V3_izlidIlluminatorType", ""];
private _dynamicNarrow = _coneMode == 3 && {_vehicle getVariable ["RS_MH6V3_izlidConeTriggerNarrow", false]};
private _illuminatorClass = if (_coneMode == 2 || {_dynamicNarrow}) then {
	"RS_MH6V3_IZLID_Illuminator_Narrow"
} else {
	"RS_MH6V3_IZLID_Illuminator"
};

private _brightnessPercent = _vehicle getVariable [
	"RS_MH6V3_irIlluminatorBrightnessActive",
	_vehicle getVariable ["RS_MH6V3_irIlluminatorBrightnessPercent", 100]
];
_brightnessPercent = 0 max (_brightnessPercent min 100);

if (_brightnessPercent <= 0) exitWith {
	[_vehicle] call RS_MH6V3_fnc_cleanupIlluminator;
	objNull
};

if (_illuminatorType != _illuminatorClass) then {
	deleteVehicle _illuminator;
	_illuminator = objNull;
};

if (isNull _illuminator) then {
	private _legacyBoost = _vehicle getVariable ["RS_MH6V3_izlidIlluminatorBoost", objNull];
	deleteVehicle _legacyBoost;

	_illuminator = _illuminatorClass createVehicleLocal [0, 0, 0];
	_vehicle setVariable ["RS_MH6V3_izlidIlluminator", _illuminator];
	_vehicle setVariable ["RS_MH6V3_izlidIlluminatorType", _illuminatorClass];
	_vehicle setVariable ["RS_MH6V3_izlidIlluminatorBoost", objNull];
};

private _illuminatorDirection = vectorNormalized _direction;
private _illuminatorOrigin = _origin vectorAdd (_illuminatorDirection vectorMultiply _offset);
private _illuminatorUp = _vehicle vectorModelToWorldVisual [0, 0, 1];

_illuminator setPosASL _illuminatorOrigin;
_illuminator setVectorDirAndUp [_illuminatorDirection, _illuminatorUp];
_illuminator setLightIntensity ((_brightnessPercent / 100) * 4000000);

_illuminator
