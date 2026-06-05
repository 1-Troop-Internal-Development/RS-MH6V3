params [
	"_vehicle"
];

if (isNull _vehicle || {!alive _vehicle}) exitWith {[-1, -1]};

private _laserForwardOffset = 2;
private _originModel = [-0.849121, 1.27772 + _laserForwardOffset, -1.30739];
private _endpointModel = [-0.849121, 4.27772 + _laserForwardOffset, -1.20739];

private _origin = _vehicle modelToWorldVisualWorld _originModel;
private _directionModel = vectorNormalized (_originModel vectorFromTo _endpointModel);
private _direction = _vehicle vectorModelToWorldVisual _directionModel;

[_origin, vectorNormalized _direction]
