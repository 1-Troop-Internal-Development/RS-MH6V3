params ["_vehicle", "_origin", "_direction", "_offset"];

private _illuminator = _vehicle getVariable ["RS_MH6V3_izlidIlluminator", objNull];
private _illuminatorType = _vehicle getVariable ["RS_MH6V3_izlidIlluminatorType", ""];
private _illuminatorClass = "RS_MH6V3_IZLID_Illuminator";
private _settingsVersion = 2;
private _needsSettings = false;
private _useFallbackReflector = !(isClass (configFile >> "CfgVehicles" >> _illuminatorClass));

if (_useFallbackReflector) then {
	_illuminatorClass = "#lightreflector";
};

if (_illuminatorType != _illuminatorClass) then {
	deleteVehicle _illuminator;
	_illuminator = objNull;
	_needsSettings = true;
};

if (isNull _illuminator) then {
	private _legacyBoost = _vehicle getVariable ["RS_MH6V3_izlidIlluminatorBoost", objNull];
	deleteVehicle _legacyBoost;

	_illuminator = _illuminatorClass createVehicleLocal [0, 0, 0];
	_vehicle setVariable ["RS_MH6V3_izlidIlluminator", _illuminator];
	_vehicle setVariable ["RS_MH6V3_izlidIlluminatorType", _illuminatorClass];
	_vehicle setVariable ["RS_MH6V3_izlidIlluminatorBoost", objNull];
	_needsSettings = true;
};

if (_useFallbackReflector && {_needsSettings || {(_vehicle getVariable ["RS_MH6V3_izlidIlluminatorSettings", -1]) != _settingsVersion}}) then {
	_illuminator setLightColor [4, 4, 4];
	_illuminator setLightAmbient [0, 0, 0];
	_illuminator setLightIntensity 180000;
	_illuminator setLightConePars [9, 7.65, 1];
	_illuminator setLightUseFlare true;
	_illuminator setLightFlareSize 0.2;
	_illuminator setLightFlareMaxDistance 7000;
	_illuminator setLightIR true;
	_illuminator setLightAttenuation [1, 3.14159 * 0.012, 0, 1, 4000, 6000];

	_vehicle setVariable ["RS_MH6V3_izlidIlluminatorSettings", _settingsVersion];
};

private _originModel = [-0.849121, 1.27772, -1.30739];
private _endpointModel = [-0.849121, 4.27772, -1.23239];
private _directionModel = vectorNormalized (_originModel vectorFromTo _endpointModel);
private _illuminatorModel = _originModel vectorAdd (_directionModel vectorMultiply _offset);
private _illuminatorAimModel = _illuminatorModel vectorAdd (_directionModel vectorMultiply 10);

private _illuminatorOrigin = _vehicle modelToWorldVisualWorld _illuminatorModel;
private _illuminatorAim = _vehicle modelToWorldVisualWorld _illuminatorAimModel;
private _illuminatorDirection = _illuminatorOrigin vectorFromTo _illuminatorAim;

_illuminator setPosASL _illuminatorOrigin;
_illuminator setVectorDirAndUp [_illuminatorDirection, [0, 1, 0]];

_illuminator
