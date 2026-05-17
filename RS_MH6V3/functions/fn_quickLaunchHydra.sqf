if (_this isEqualType [] && {count _this >= 3}) exitWith {
	_this params ["_vehicle", "_hydraWeapon", "_mode"];

	if (isNull _vehicle || {!alive _vehicle}) exitWith {false};
	if (!local _vehicle) exitWith {false};

	_vehicle forceWeaponFire [_hydraWeapon, _mode];
	true
};

if (!hasInterface) exitWith {false};
if (!isNull curatorCamera) exitWith {false};

private _vehicle = vehicle player;
if !(_vehicle isKindOf "RHS_MELB_AH6M") exitWith {false};
if !(player in _vehicle) exitWith {false};
if !(player isEqualTo currentPilot _vehicle) exitWith {false};

private _availableWeapons = (weapons _vehicle) + (_vehicle weaponsTurret [-1]) + (_vehicle weaponsTurret []);
private _hydraWeapons =
[
	"rhs_weap_FFARLauncher",
	"rhs_weap_FFARLauncher_M229",
	"rhs_weap_FFARLauncher_M257"
];
private _hydraWeapon = "";

{
	if (_x in _availableWeapons) exitWith {
		_hydraWeapon = _x;
	};
} forEach _hydraWeapons;

if (_hydraWeapon == "") then {
	private _pylonMagazines = getPylonMagazines _vehicle;
	private _hydraMagazines =
	[
		"rhs_mag_M151_7",
		"rhs_mag_M151_7_green",
		"rhs_mag_M151_7_USAF_LAU131",
		"rhs_mag_M151_19",
		"rhs_mag_M151_19_green",
		"rhs_mag_M151_21_USAF_LAU131_3"
	];

	{
		if (_x in _hydraMagazines) exitWith {
			private _pylonWeapon = getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon");

			if (_pylonWeapon != "") then {
				_hydraWeapon = _pylonWeapon;
			};
		};
	} forEach _pylonMagazines;
};

if (_hydraWeapon == "") exitWith {
	hintSilent "Hydra unavailable";
	false
};

private _lastFire = _vehicle getVariable ["RS_MH6V3_quickHydraLastFire", -1];
if (time - _lastFire < 0.15) exitWith {false};
_vehicle setVariable ["RS_MH6V3_quickHydraLastFire", time];

if (!local _vehicle) exitWith {
	[_vehicle, _hydraWeapon, "Single"] remoteExecCall ["RS_MH6V3_fnc_quickLaunchHydra", _vehicle];
	true
};

_vehicle forceWeaponFire [_hydraWeapon, "Single"];
true
