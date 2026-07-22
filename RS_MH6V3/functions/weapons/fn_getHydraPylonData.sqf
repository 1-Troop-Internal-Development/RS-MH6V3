params [
	["_vehicle", objNull]
];

if (isNull _vehicle) exitWith {[]};

private _knownWeapons = [
	"RS_MH6V3_weap_FFARLauncher_HEAT",
	"RS_MH6V3_weap_FFARLauncher_M274",
	"rhs_weap_FFARLauncher",
	"rhs_weap_FFARLauncher_M229",
	"rhs_weap_FFARLauncher_M257",
	"rhs_weap_FFARLauncher_M282",
	"rhs_weap_FFARLauncher_M247",
	"rhs_weap_FFARLauncher_M156",
	"rhs_weap_FFARLauncher_M274",
	"rhs_weap_FFARLauncher_M278"
];

private _findWeapon = {
	params ["_magazine"];

	private _weapon = getText (configFile >> "CfgMagazines" >> _magazine >> "pylonWeapon");
	if (_weapon in _knownWeapons) exitWith {_weapon};

	private _weaponLower = toLower _weapon;
	private _magazineLower = toLower _magazine;
	private _displayNameLower = toLower getText (configFile >> "CfgMagazines" >> _magazine >> "displayName");
	private _isHydra =
		(_weaponLower find "ffar") >= 0
		|| {(_weaponLower find "hydra") >= 0}
		|| {(_magazineLower find "ffar") >= 0}
		|| {(_magazineLower find "hydra") >= 0}
		|| {(_displayNameLower find "ffar") >= 0}
		|| {(_displayNameLower find "hydra") >= 0};

	if (!_isHydra) exitWith {""};
	if (_weapon != "" && {isClass (configFile >> "CfgWeapons" >> _weapon)}) exitWith {_weapon};

	if ((_magazineLower find "heat") >= 0) exitWith {"RS_MH6V3_weap_FFARLauncher_HEAT"};
	if ((_magazineLower find "rs_mh6v3_mag_hydra_m274") >= 0) exitWith {"RS_MH6V3_weap_FFARLauncher_M274"};
	if ((_magazineLower find "m229") >= 0) exitWith {"rhs_weap_FFARLauncher_M229"};
	if ((_magazineLower find "m257") >= 0) exitWith {"rhs_weap_FFARLauncher_M257"};
	if ((_magazineLower find "m282") >= 0) exitWith {"rhs_weap_FFARLauncher_M282"};
	if ((_magazineLower find "m247") >= 0) exitWith {"rhs_weap_FFARLauncher_M247"};
	if ((_magazineLower find "m156") >= 0) exitWith {"rhs_weap_FFARLauncher_M156"};
	if ((_magazineLower find "m274") >= 0) exitWith {"rhs_weap_FFARLauncher_M274"};
	if ((_magazineLower find "m278") >= 0) exitWith {"rhs_weap_FFARLauncher_M278"};

	"rhs_weap_FFARLauncher"
};

private _result = [];
{
	if (_x != "") then {
		private _weapon = [_x] call _findWeapon;
		if (_weapon != "" && {isClass (configFile >> "CfgWeapons" >> _weapon)}) then {
			_result pushBack [_forEachIndex + 1, _weapon, _x, _vehicle ammoOnPylon (_forEachIndex + 1)];
		};
	};
} forEach getPylonMagazines _vehicle;

_result
