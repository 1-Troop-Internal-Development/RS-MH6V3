params ["_vehicle"];

if (isNull _vehicle || {!alive _vehicle}) exitWith {[-1, -1]};

private _origin = _vehicle modelToWorldVisualWorld [-0.849121, 1.27772, -1.30739];
private _endpointUpBias = 0.025;
private _direction = (vectorDirVisual _vehicle) vectorAdd ((vectorUpVisual _vehicle) vectorMultiply _endpointUpBias);

[_origin, vectorNormalized _direction]
