params ["_vehicle"];

if (_vehicle isEqualType []) then {
	_vehicle = _vehicle param [0, objNull];
};

if !([_vehicle] call RS_MH6V3_fnc_canFastRope) exitWith {false};

[player, _vehicle] call ace_fastroping_fnc_fastRope;
true
