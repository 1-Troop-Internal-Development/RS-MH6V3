params ["_vehicle"];

if (_vehicle isEqualType []) then {
	_vehicle = _vehicle param [0, objNull];
};

if !([_vehicle] call RS_MH6V3_fnc_canPrepareFRIES) exitWith {false};

[_vehicle] call ace_fastroping_fnc_prepareFRIES;
_vehicle setVariable ["RS_MH6V3_friesPrepared", true, true];
true
