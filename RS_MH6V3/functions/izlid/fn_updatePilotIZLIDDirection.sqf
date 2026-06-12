if (!hasInterface || {!isNull curatorCamera}) exitWith {};

private _vehicle = vehicle player;
if (
	typeOf _vehicle != "RHS_MELB_AH6M"
	|| {!(player isEqualTo currentPilot _vehicle)}
	|| {!(_vehicle getVariable ["RS_MH6V3_pilotIZLIDEnabled", false])}
) exitWith {};

private _now = diag_tickTime;
private _lastUpdate = player getVariable ["RS_MH6V3_pilotIZLIDLastUpdate", -1];
if ((_now - _lastUpdate) < 0.05) exitWith {};

private _originModel = if (player isEqualTo driver _vehicle) then {
	[-0.776758, 1.71812, -0.407359]
} else {
	[0.913477, 1.77864, -0.407359]
};
private _origin = _vehicle modelToWorldVisualWorld _originModel;
private _cameraOrigin = positionCameraToWorld [0, 0, 0];
private _cameraForwardPoint = positionCameraToWorld [0, 0, 3000];
private _cameraDirection = vectorNormalized (_cameraOrigin vectorFromTo _cameraForwardPoint);
private _centerAimPoint = _cameraOrigin vectorAdd (_cameraDirection vectorMultiply 3000);
private _directionModel = _vehicle vectorWorldToModelVisual (
	vectorNormalized (_origin vectorFromTo _centerAimPoint)
);
private _yaw = (_directionModel select 0) atan2 (_directionModel select 1);
_yaw = if (player isEqualTo driver _vehicle) then {
	-105 max (_yaw min 0)
} else {
	0 max (_yaw min 105)
};

private _horizontalLength = sqrt (
	((_directionModel select 0) ^ 2) +
	((_directionModel select 1) ^ 2)
);
private _expandedDirectionModel = [
	(sin _yaw) * _horizontalLength,
	(cos _yaw) * _horizontalLength,
	_directionModel select 2
];
private _direction = vectorNormalized (_vehicle vectorModelToWorldVisual _expandedDirectionModel);
private _lastDirection = player getVariable ["RS_MH6V3_pilotIZLIDLastDirection", [0, 0, 0]];
private _directionChanged = (_direction vectorDistance _lastDirection) > 0.0025;

if (!_directionChanged && {(_now - _lastUpdate) < 0.5}) exitWith {};

player setVariable ["RS_MH6V3_pilotIZLIDLastDirection", _direction, false];
player setVariable ["RS_MH6V3_pilotIZLIDLastUpdate", _now, false];
_vehicle setVariable ["RS_MH6V3_pilotIZLIDDirection", _direction, true];
