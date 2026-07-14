if (!hasInterface) exitWith {};

private _display = uiNamespace getVariable ["RS_MH6V3_MELB_FLIRCtrl", displayNull];
if (isNull _display || {cameraView isNotEqualTo "gunner"}) exitWith {};

private _player = player;
private _vehicle = vehicle _player;
if (isNull _vehicle || {!alive _vehicle}) exitWith {};
if !(typeOf _vehicle in ["RHS_MELB_H6M", "RHS_MELB_MH6M", "RHS_MELB_AH6M"]) exitWith {};
if !(_player isEqualTo driver _vehicle || {_player isEqualTo (_vehicle turretUnit [0])}) exitWith {};

private _screenCenter = [0.5, 0.5];
private _originASL = AGLToASL (positionCameraToWorld [0, 0, 0]);
private _direction = vectorNormalized (screenToWorldDirection _screenCenter);
if (_direction isEqualTo [0, 0, 0]) exitWith {};

private _endASL = _originASL vectorAdd (_direction vectorMultiply 6000);
private _surfaces = lineIntersectsSurfaces [
	_originASL,
	_endASL,
	_vehicle,
	_player,
	true,
	5,
	"VIEW",
	"FIRE",
	true
];

private _targetASL = if (_surfaces isEqualTo []) then {
	AGLToASL (screenToWorld _screenCenter)
} else {
	(_surfaces # 0) # 0
};
private _targetAGL = ASLToAGL _targetASL;

drawIcon3D [
	"\a3\ui_f\data\IGUI\Cfg\Cursors\select_ca.paa",
	[0.1, 0.55, 1, 0.95],
	_targetAGL,
	0.85,
	0.85,
	0,
	"",
	0,
	0.03,
	"PuristaMedium",
	"center",
	false
];
