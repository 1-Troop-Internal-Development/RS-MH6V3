if (!isNil "ace_fastroping_fnc_onCutCommon") then {
	_this call ace_fastroping_fnc_onCutCommon;
};

private _vehicle = objNull;

if (_this isEqualType objNull) then {
	_vehicle = _this;
} else {
	if (_this isEqualType []) then {
		_vehicle = _this param [0, objNull];
	};
};

if (isNull _vehicle) exitWith {};

_vehicle setVariable ["RS_MH6V3_friesPrepared", false, true];
_vehicle setVariable ["RS_MH6V3_ropesDeployed", false, true];
