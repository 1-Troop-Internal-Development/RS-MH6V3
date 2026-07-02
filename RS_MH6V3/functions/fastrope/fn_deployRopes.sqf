params ["_vehicle"];

if (_vehicle isEqualType []) then {
	_vehicle = _vehicle param [0, objNull];
};

if !([_vehicle] call RS_MH6V3_fnc_canDeployRopes) exitWith {false};

[_vehicle, player, "ACE_rope36"] call ace_fastroping_fnc_deployRopes;
_vehicle setVariable ["RS_MH6V3_ropesDeployed", true, true];
true
