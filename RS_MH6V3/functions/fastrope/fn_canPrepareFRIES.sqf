params ["_vehicle"];

if (_vehicle isEqualType []) then {
	_vehicle = _vehicle param [0, objNull];
};

if (!hasInterface) exitWith {false};
if (isNull _vehicle || {!alive _vehicle}) exitWith {false};
if (typeOf _vehicle != "RHS_MELB_MH6M") exitWith {false};
if !(player in _vehicle) exitWith {false};
if !(call RS_MH6V3_fnc_isFastRopeConfigured) exitWith {false};
if !(call RS_MH6V3_fnc_isACEFastRopingAvailable) exitWith {false};

[_vehicle] call ace_fastroping_fnc_canPrepareFRIES
