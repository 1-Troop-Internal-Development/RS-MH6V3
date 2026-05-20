if (!hasInterface) exitWith {objNull};

params ["_vehicle", "_origin", "_direction", "_offset", ["_coneMode", 1, [0]]];

private _illuminator = _vehicle getVariable ["RS_MH6V3_izlidIlluminator", objNull];
private _illuminatorType = _vehicle getVariable ["RS_MH6V3_izlidIlluminatorType", ""];
private _dynamicNarrow = _coneMode == 3 && {_vehicle getVariable ["RS_MH6V3_izlidConeTriggerNarrow", false]};
private _baseIlluminatorClass = if (_coneMode == 2 || {_dynamicNarrow}) then {
	"RS_MH6V3_IZLID_Illuminator_Narrow"
} else {
	"RS_MH6V3_IZLID_Illuminator"
};

private _originModel = [-0.849121, 1.27772, -1.30739];
private _endpointModel = [-0.849121, 4.27772, -1.20739];
private _directionModel = vectorNormalized (_originModel vectorFromTo _endpointModel);
private _illuminatorModel = _originModel vectorAdd (_directionModel vectorMultiply _offset);
private _illuminatorAimModel = _illuminatorModel vectorAdd (_directionModel vectorMultiply 10);

private _illuminatorOrigin = _vehicle modelToWorldVisualWorld _illuminatorModel;
private _illuminatorAim = _vehicle modelToWorldVisualWorld _illuminatorAimModel;
private _illuminatorDirection = _illuminatorOrigin vectorFromTo _illuminatorAim;

private _brightnessPercent = _vehicle getVariable ["RS_MH6V3_irIlluminatorBrightnessActive", _vehicle getVariable ["RS_MH6V3_irIlluminatorBrightnessPercent", 100]];
_brightnessPercent = 0 max (_brightnessPercent min 100);
private _brightness = (_brightnessPercent / 100) * 4000000;

private _maxImpactDistance = 1000;
private _impactEnd = _illuminatorOrigin vectorAdd (_illuminatorDirection vectorMultiply _maxImpactDistance);
private _surfaces = lineIntersectsSurfaces [_illuminatorOrigin, _impactEnd, _vehicle, _illuminator, true, 1, "GEOM", "NONE"];
private _impactDistance = _maxImpactDistance;

if (_surfaces isNotEqualTo []) then {
	_impactDistance = _illuminatorOrigin distance (_surfaces # 0 # 0);
};

private _smoothedImpactDistance = _vehicle getVariable ["RS_MH6V3_izlidIlluminatorImpactDistance", _impactDistance];
_smoothedImpactDistance = _smoothedImpactDistance + ((_impactDistance - _smoothedImpactDistance) * 0.05);
_vehicle setVariable ["RS_MH6V3_izlidIlluminatorImpactDistance", _smoothedImpactDistance, false];

private _targetDistanceFactor = switch (true) do {
	case (_smoothedImpactDistance < 60): {0.1};
	case (_smoothedImpactDistance < 100): {0.2};
	case (_smoothedImpactDistance < 150): {0.4};
	case (_smoothedImpactDistance < 350): {0.6};
	case (_smoothedImpactDistance < 650): {0.8};
	default {1};
};

private _distanceFactor = _vehicle getVariable ["RS_MH6V3_izlidIlluminatorDistanceFactor", _targetDistanceFactor];
private _lastDistanceFactorChange = _vehicle getVariable ["RS_MH6V3_izlidIlluminatorDistanceFactorTime", 0];

if (!(_distanceFactor isEqualTo _targetDistanceFactor) && {(diag_tickTime - _lastDistanceFactorChange) > 1.25}) then {
	_distanceFactor = _targetDistanceFactor;
	_vehicle setVariable ["RS_MH6V3_izlidIlluminatorDistanceFactor", _distanceFactor, false];
	_vehicle setVariable ["RS_MH6V3_izlidIlluminatorDistanceFactorTime", diag_tickTime, false];
};

private _desiredBrightnessBucket = round (((_brightness * _distanceFactor) / 4000000) * 10) * 10;
_desiredBrightnessBucket = 0 max (_desiredBrightnessBucket min 100);

private _brightnessBucket = _vehicle getVariable ["RS_MH6V3_izlidIlluminatorBrightnessBucket", _desiredBrightnessBucket];
private _lastBucketChange = _vehicle getVariable ["RS_MH6V3_izlidIlluminatorBrightnessBucketTime", 0];
private _bucketDelta = abs (_desiredBrightnessBucket - _brightnessBucket);

if (_bucketDelta >= 30 || {_desiredBrightnessBucket in [0, 100] && {(diag_tickTime - _lastBucketChange) > 1}} || {(diag_tickTime - _lastBucketChange) > 1.25 && {_bucketDelta >= 10}}) then {
	_brightnessBucket = _desiredBrightnessBucket;
	_vehicle setVariable ["RS_MH6V3_izlidIlluminatorBrightnessBucket", _brightnessBucket, false];
	_vehicle setVariable ["RS_MH6V3_izlidIlluminatorBrightnessBucketTime", diag_tickTime, false];
};

private _illuminatorClass = if (_brightnessBucket >= 100) then {
	_baseIlluminatorClass
} else {
	format ["%1_B%2", _baseIlluminatorClass, _brightnessBucket]
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

_illuminator setPosASL _illuminatorOrigin;
_illuminator setVectorDirAndUp [_illuminatorDirection, [0, 1, 0]];

_illuminator
