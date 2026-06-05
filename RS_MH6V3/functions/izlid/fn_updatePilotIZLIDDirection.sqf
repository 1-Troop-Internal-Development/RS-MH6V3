if (!hasInterface || {!isNull curatorCamera}) exitWith {};

private _vehicle = vehicle player;
if (
	typeOf _vehicle != "RHS_MELB_AH6M"
	|| {!(player isEqualTo currentPilot _vehicle)}
	|| {!(_vehicle getVariable ["RS_MH6V3_izlidEnabled", false])}
	|| {!(_vehicle getVariable ["RS_MH6V3_pilotIZLIDEnabled", false])}
) exitWith {};

private _now = diag_tickTime;
private _lastUpdate = player getVariable ["RS_MH6V3_pilotIZLIDLastUpdate", -1];
if ((_now - _lastUpdate) < 0.05) exitWith {};

private _direction = vectorNormalized (eyeDirection player);
private _lastDirection = player getVariable ["RS_MH6V3_pilotIZLIDLastDirection", [0, 0, 0]];
private _directionChanged = (_direction vectorDistance _lastDirection) > 0.0025;

if (!_directionChanged && {(_now - _lastUpdate) < 0.5}) exitWith {};

player setVariable ["RS_MH6V3_pilotIZLIDLastDirection", _direction, false];
player setVariable ["RS_MH6V3_pilotIZLIDLastUpdate", _now, false];
_vehicle setVariable ["RS_MH6V3_pilotIZLIDDirection", _direction, true];
