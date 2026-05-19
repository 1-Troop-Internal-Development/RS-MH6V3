params ["_vehicle"];

if (isNull _vehicle || {!alive _vehicle}) exitWith {[-1, -1]};

private _origin = _vehicle modelToWorldVisualWorld [-0.849121, 1.27772, -1.30739];
private _endpoint = _vehicle modelToWorldVisualWorld [-0.849121, 4.27772, -1.23239];
private _direction = _origin vectorFromTo _endpoint;

[_origin, vectorNormalized _direction]
