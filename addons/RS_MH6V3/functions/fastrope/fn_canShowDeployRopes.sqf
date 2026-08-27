params ["_vehicle"];

if (_vehicle isEqualType []) then {
	_vehicle = _vehicle param [0, objNull];
};

if (!hasInterface) exitWith {false};
if (isNull _vehicle || {!alive _vehicle}) exitWith {false};
if (typeOf _vehicle != "RHS_MELB_MH6M") exitWith {false};
if !(call RS_MH6V3_fnc_isFastRopeConfigured) exitWith {false};
if !(call RS_MH6V3_fnc_isACEFastRopingAvailable) exitWith {false};

if (_vehicle getVariable ["RS_MH6V3_ropesDeployed", false]) exitWith {false};

(_vehicle getVariable ["RS_MH6V3_friesPrepared", false])
|| {[_vehicle] call RS_MH6V3_fnc_canPrepareFRIES}
|| {[_vehicle] call RS_MH6V3_fnc_canDeployRopes}
