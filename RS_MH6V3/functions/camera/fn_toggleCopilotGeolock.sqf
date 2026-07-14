params [
	["_vehicle", objNull],
	["_forceUnlock", false]
];

if (!hasInterface) exitWith {false};

private _player = player;
if (isNull _vehicle) then {
	_vehicle = vehicle _player;
};

if (isNull _vehicle || {!alive _vehicle}) exitWith {false};
if !(typeOf _vehicle in ["RHS_MELB_H6M", "RHS_MELB_MH6M", "RHS_MELB_AH6M"]) exitWith {false};
if !(_player isEqualTo (_vehicle turretUnit [0])) exitWith {false};

private _locked = _vehicle getVariable ["RS_MH6V3_FLIRGeolockActive", false];

if (_forceUnlock || {_locked}) exitWith {
	_vehicle lockCameraTo [objNull, [0]];
	_vehicle enableDirectionStabilization [false, [0]];
	_vehicle setVariable ["RS_MH6V3_FLIRGeolockTarget", objNull, false];
	_vehicle setVariable ["RS_MH6V3_FLIRGeolockActive", false, false];
	systemChat "RS MH-6V3: copilot GEOLOCK released.";
	true
};

private _screenCenter = [0.5, 0.5];
private _originASL = AGLToASL (positionCameraToWorld [0, 0, 0]);
private _direction = screenToWorldDirection _screenCenter;
private _endASL = _originASL vectorAdd ((vectorNormalized _direction) vectorMultiply 6000);
private _groundASL = AGLToASL (screenToWorld _screenCenter);
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

private _target = _groundASL;
if !(_surfaces isEqualTo []) then {
	private _surface = _surfaces # 0;
	private _positionASL = _surface # 0;
	private _hitObject = _surface # 2;
	_target = [_hitObject, _positionASL] select (isNull _hitObject || {_hitObject isKindOf "Man"});
};

_vehicle enableDirectionStabilization [true, [0]];
_vehicle lockCameraTo [_target, [0]];
_vehicle setVariable ["RS_MH6V3_FLIRGeolockTarget", _target, false];
_vehicle setVariable ["RS_MH6V3_FLIRGeolockActive", true, false];
systemChat "RS MH-6V3: copilot GEOLOCK set.";

true
