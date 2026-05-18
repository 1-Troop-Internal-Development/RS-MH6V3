params [
	["_vehicle", objNull],
	["_operator", objNull]
];

if (!hasInterface) exitWith {false};
if (!isNull curatorCamera) exitWith {false};

if (isNull _vehicle) then {
	_vehicle = vehicle player;
};
if (isNull _operator) then {
	_operator = player;
};

if (isNull _vehicle || {!alive _vehicle}) exitWith {false};
if !(typeOf _vehicle in ["RHS_MELB_H6M", "RHS_MELB_MH6M", "RHS_MELB_AH6M"]) exitWith {false};
if !(_operator in [driver _vehicle, gunner _vehicle]) exitWith {false};
if !(_operator in _vehicle) exitWith {false};
if !(_operator getVariable ["RS_MH6V3_quickFireArmed", false]) exitWith {
	[false] call RS_MH6V3_fnc_showQuickFireStatus;
	false
};

private _lastFire = _vehicle getVariable ["RS_MH6V3_quickHydraLastFire", -1];
if (time - _lastFire < 0.15) exitWith {false};
_vehicle setVariable ["RS_MH6V3_quickHydraLastFire", time];

private _hydraPylons = [];

{
	private _pylonIndex = _forEachIndex + 1;
	private _magazine = _x;
	private _magazineLower = toLower _magazine;

	if (_magazine != "" && {_vehicle ammoOnPylon _pylonIndex > 0}) then {
		private _weapon = "";

		if (
			(_magazineLower find "m151") >= 0
			|| {(_magazineLower find "ffar") >= 0}
		) then {
			_weapon = "rhs_weap_FFARLauncher";
		};

		if ((_magazineLower find "m229") >= 0) then {
			_weapon = "rhs_weap_FFARLauncher_M229";
		};

		if ((_magazineLower find "m257") >= 0) then {
			_weapon = "rhs_weap_FFARLauncher_M257";
		};

		if (_weapon == "") then {
			_weapon = getText (configFile >> "CfgMagazines" >> _magazine >> "pylonWeapon");
		};

		if (_weapon != "" && {isClass (configFile >> "CfgWeapons" >> _weapon)}) then {
			_hydraPylons pushBack [_pylonIndex, _weapon, _magazine];
		};
	};
} forEach getPylonMagazines _vehicle;

if (_hydraPylons isEqualTo []) exitWith {
	hintSilent "Hydra unavailable";
	false
};

private _lastPylon = _vehicle getVariable ["RS_MH6V3_quickHydraLastPylon", 0];
private _selected = _hydraPylons # 0;

{
	if ((_x # 0) > _lastPylon) exitWith {
		_selected = _x;
	};
} forEach _hydraPylons;

if ((_selected # 0) <= _lastPylon) then {
	_selected = _hydraPylons # 0;
};

_vehicle setVariable ["RS_MH6V3_quickHydraLastPylon", _selected # 0];

private _fired = _vehicle fireAtTarget [objNull, _selected # 1];

if (!_fired) exitWith {
	hintSilent "Hydra failed to fire";
	false
};

true
