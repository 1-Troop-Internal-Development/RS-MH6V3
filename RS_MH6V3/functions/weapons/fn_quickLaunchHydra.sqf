params [
	["_vehicle", objNull],
	["_operator", objNull],
	["_hydraWeapon", ""],
	["_mode", "Single"]
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
if !(_vehicle getVariable ["RS_MH6V3_quickFireArmed", false]) exitWith {
	[_vehicle] call RS_MH6V3_fnc_showExternalWeaponControl;
	false
};

private _lastFire = _vehicle getVariable ["RS_MH6V3_quickHydraLastFire", -1];
if (time - _lastFire < 0.15) exitWith {false};

private _hydraWeapons = [
	"rhs_weap_FFARLauncher",
	"rhs_weap_FFARLauncher_M229",
	"rhs_weap_FFARLauncher_M257",
	"rhs_weap_FFARLauncher_M282",
	"rhs_weap_FFARLauncher_M247",
	"rhs_weap_FFARLauncher_M156",
	"rhs_weap_FFARLauncher_M274",
	"rhs_weap_FFARLauncher_M278"
];

private _findHydraWeaponFromMagazine = {
	params [
		"_magazine",
		"_fallbackWeapons"
	];

	private _magazineLower = toLower _magazine;
	private _weapon = getText (configFile >> "CfgMagazines" >> _magazine >> "pylonWeapon");

	if (_weapon == "") then {
		{
			private _candidate = _x;
			private _magazines = getArray (configFile >> "CfgWeapons" >> _candidate >> "magazines");

			if (_magazine in _magazines) exitWith {
				_weapon = _candidate;
			};
		} forEach _fallbackWeapons;
	};

	if (_weapon == "") then {
		private _weaponClasses = "true" configClasses (configFile >> "CfgWeapons");

		{
			private _candidate = configName _x;
			private _candidateLower = toLower _candidate;
			private _displayNameLower = toLower getText (_x >> "displayName");

			if (
				(
					(_candidateLower find "ffar") >= 0
					|| {(_candidateLower find "hydra") >= 0}
					|| {(_displayNameLower find "hydra") >= 0}
					|| {(_displayNameLower find "ffar") >= 0}
				)
				&& {_magazine in getArray (_x >> "magazines")}
			) exitWith {
				_weapon = _candidate;
			};
		} forEach _weaponClasses;
	};

	if (_weapon == "") then {
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

		if ((_magazineLower find "m282") >= 0) then {
			_weapon = "rhs_weap_FFARLauncher_M282";
		};

		if ((_magazineLower find "m247") >= 0) then {
			_weapon = "rhs_weap_FFARLauncher_M247";
		};

		if ((_magazineLower find "m156") >= 0) then {
			_weapon = "rhs_weap_FFARLauncher_M156";
		};

		if ((_magazineLower find "m274") >= 0) then {
			_weapon = "rhs_weap_FFARLauncher_M274";
		};

		if ((_magazineLower find "m278") >= 0) then {
			_weapon = "rhs_weap_FFARLauncher_M278";
		};
	};

	_weapon
};

private _hydraPylonWeapons = [];
private _pylonMagazines = getPylonMagazines _vehicle;

{
	private _pylonIndex = _forEachIndex + 1;

	if (_x != "" && {_vehicle ammoOnPylon _pylonIndex > 0}) then {
		private _pylonWeapon = [_x, _hydraWeapons] call _findHydraWeaponFromMagazine;

		if (_pylonWeapon != "" && {isClass (configFile >> "CfgWeapons" >> _pylonWeapon)}) then {
			_hydraPylonWeapons pushBack [_pylonIndex, _pylonWeapon];
		};
	};
} forEach _pylonMagazines;

if (_hydraPylonWeapons isEqualTo []) exitWith {false};

if (_hydraWeapon == "") then {
	private _lastPylonIndex = _vehicle getVariable ["RS_MH6V3_quickHydraLastPylon", 0];
	private _nextPylonWeapon = _hydraPylonWeapons findIf {(_x # 0) > _lastPylonIndex};

	if (_nextPylonWeapon < 0) then {
		_nextPylonWeapon = 0;
	};

	(_hydraPylonWeapons # _nextPylonWeapon) params ["_hydraPylonIndex", "_hydraPylonWeapon"];
	_hydraWeapon = _hydraPylonWeapon;
	_vehicle setVariable ["RS_MH6V3_quickHydraLastPylon", _hydraPylonIndex];
};

if (_hydraWeapon == "") then {
	private _availableWeapons = (weapons _vehicle) + (_vehicle weaponsTurret [-1]) + (_vehicle weaponsTurret []) + (_vehicle weaponsTurret [0]);

	{
		private _weaponLower = toLower _x;
		private _displayNameLower = toLower getText (configFile >> "CfgWeapons" >> _x >> "displayName");

		if (
			(
				_x in _hydraWeapons
				|| {(_weaponLower find "ffar") >= 0}
				|| {(_weaponLower find "hydra") >= 0}
				|| {(_displayNameLower find "hydra") >= 0}
				|| {(_displayNameLower find "ffar") >= 0}
			)
		) exitWith {
			_hydraWeapon = _x;
		};
	} forEach _availableWeapons;
};

if (_hydraWeapon == "") exitWith {false};

_vehicle setVariable ["RS_MH6V3_quickHydraLastFire", time];

private _turretPath = if (_operator isEqualTo gunner _vehicle) then {[0]} else {[-1]};
private _weaponState = weaponState [_vehicle, _turretPath];

_operator forceWeaponFire [_hydraWeapon, _mode];

[_vehicle, _turretPath, _weaponState] spawn {
	params [
		"_vehicle",
		"_turretPath",
		"_weaponState"
	];

	sleep 0.01;

	if (isNull _vehicle || {count _weaponState < 1}) exitWith {};

	private _previousWeapon = _weaponState # 0;
	if (_previousWeapon == "") exitWith {};

	_vehicle selectWeaponTurret [_previousWeapon, _turretPath];
};

true
