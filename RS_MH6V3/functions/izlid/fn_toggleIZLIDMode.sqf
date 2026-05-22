if (!hasInterface) exitWith {false};
if (!isNull curatorCamera) exitWith {false};

private _vehicle = vehicle player;
if !(_vehicle isKindOf "RHS_MELB_AH6M") exitWith {false};
if !(player in _vehicle) exitWith {false};

if !(player isEqualTo driver _vehicle || {player isEqualTo (_vehicle turretUnit [0])}) exitWith {
	false
};

private _mode = _vehicle getVariable ["RS_MH6V3_izlidMode", 3];
private _coneMode = _vehicle getVariable ["RS_MH6V3_izlidConeMode", 1];
private _nextMode = _mode;
private _nextConeMode = _coneMode;

switch (true) do {
	case (_mode == 1): {
		_nextMode = 2;
		_nextConeMode = 1;
	};
	case (_mode == 2 && {_coneMode == 1}): {
		_nextMode = 2;
		_nextConeMode = 2;
	};
	case (_mode == 2 && {_coneMode == 2}): {
		_nextMode = 2;
		_nextConeMode = 3;
	};
	case (_mode == 2): {
		_nextMode = 3;
		_nextConeMode = 1;
	};
	case (_mode == 3 && {_coneMode == 1}): {
		_nextMode = 3;
		_nextConeMode = 2;
	};
	case (_mode == 3 && {_coneMode == 2}): {
		_nextMode = 3;
		_nextConeMode = 3;
	};
	default {
		_nextMode = 1;
		_nextConeMode = 1;
	};
};

[_vehicle, _nextMode, _nextConeMode] call RS_MH6V3_fnc_setIZLIDMode
