params [
	"_vehicle"
];

if (isNull _vehicle || {!alive _vehicle}) exitWith {[-1, -1]};

private _originModel = _vehicle selectionPosition ["z_gunl_chamber", "Memory"];
private _aimModel = [-0.939121, 6.27772, -1.11739];

if (
	_originModel isEqualTo [0, 0, 0] ||
	{(_originModel vectorDistance _aimModel) < 0.001}
) exitWith {[-1, -1]};

private _origin = _vehicle modelToWorldVisualWorld _originModel;
private _aimPoint = _vehicle modelToWorldVisualWorld _aimModel;
private _direction = _origin vectorFromTo _aimPoint;

[_origin, vectorNormalized _direction]
