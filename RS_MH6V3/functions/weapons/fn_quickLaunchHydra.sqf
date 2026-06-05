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
if (typeOf _vehicle != "RHS_MELB_AH6M") exitWith {false};
if !(_operator in [driver _vehicle, gunner _vehicle]) exitWith {false};
if !(_operator in _vehicle) exitWith {false};

private _sequence = +(_vehicle getVariable ["RS_MH6V3_quickHydraSequence", []]);
if (_sequence isEqualTo []) exitWith {
	[
		"RS MH-6V3: Hydra Rocket Ripple sequence is not configured.",
		_vehicle
	] call RS_MH6V3_fnc_notifyAircrew;
	false
};

if (!local _vehicle) exitWith {
	[_vehicle, _operator, _hydraWeapon, _mode] remoteExecCall ["RS_MH6V3_fnc_quickLaunchHydra", _vehicle];
	true
};

if !(_vehicle getVariable ["RS_MH6V3_quickFireArmed", false]) exitWith {
	[_vehicle] call RS_MH6V3_fnc_showExternalWeaponControl;
	false
};

private _lastFire = _vehicle getVariable ["RS_MH6V3_quickHydraLastFire", -1];
if (time - _lastFire < 0.15) exitWith {false};

private _loadedHydraPylons = (([_vehicle] call RS_MH6V3_fnc_getHydraPylonData) select {
	(_x # 3) > 0
});
if (_loadedHydraPylons isEqualTo []) exitWith {false};

private _modeSetting = _vehicle getVariable ["RS_MH6V3_quickHydraMode", "single"];

private _sequenceStep = _vehicle getVariable ["RS_MH6V3_quickHydraSequenceStep", 0];
if (_sequenceStep < 0 || {_sequenceStep >= count _sequence}) then {
	_sequenceStep = 0;
};

private _selectedSequenceStep = -1;
private _selectedPylonEntry = -1;

for "_offset" from 0 to ((count _sequence) - 1) do {
	private _candidateStep = (_sequenceStep + _offset) mod (count _sequence);
	private _candidatePylon = _sequence # _candidateStep;
	private _candidateEntry = _loadedHydraPylons findIf {(_x # 0) == _candidatePylon};

	if (_candidateEntry >= 0) exitWith {
		_selectedSequenceStep = _candidateStep;
		_selectedPylonEntry = _candidateEntry;
	};
};

if (_selectedPylonEntry < 0) exitWith {false};
private _selectedPylonIndex = _sequence # _selectedSequenceStep;

_vehicle setVariable [
	"RS_MH6V3_quickHydraSequenceStep",
	if (_modeSetting == "cycle") then {
		(_selectedSequenceStep + 1) mod (count _sequence)
	} else {
		_selectedSequenceStep
	},
	true
];

private _selectedHydraWeapon = (_loadedHydraPylons # _selectedPylonEntry) # 1;
if (_hydraWeapon == "") then {
	_hydraWeapon = _selectedHydraWeapon;
};
if (_hydraWeapon == "") exitWith {false};

private _supportedModes = getArray (configFile >> "CfgWeapons" >> _hydraWeapon >> "modes");
if !(_mode in _supportedModes) then {
	_mode = if ("Single" in _supportedModes) then {"Single"} else {_supportedModes param [0, ""]};
};
if (_mode == "") exitWith {false};

private _turretPath = if (_operator isEqualTo driver _vehicle) then {[-1]} else {[0]};
private _previousWeaponState = weaponState [_vehicle, _turretPath];
private _pylonCount = count getPylonMagazines _vehicle;
private _defaultPriorities = [];
private _selectedPriorities = [];

for "_pylonIndex" from 1 to _pylonCount do {
	private _pylonConfig = configFile
		>> "CfgVehicles"
		>> typeOf _vehicle
		>> "Components"
		>> "TransportPylonsComponent"
		>> "pylons"
		>> format ["pylon%1", _pylonIndex];
	private _defaultPriority = getNumber (_pylonConfig >> "priority");

	_defaultPriorities pushBack _defaultPriority;
	_selectedPriorities pushBack (if (_pylonIndex == _selectedPylonIndex) then {1000} else {0});
};

_vehicle setPylonsPriority _selectedPriorities;
_operator forceWeaponFire [_hydraWeapon, _mode];

[
	{
		params ["_vehicle", "_turretPath", "_weaponState", "_defaultPriorities"];

		if (isNull _vehicle || {!local _vehicle}) exitWith {};

		_vehicle setPylonsPriority _defaultPriorities;
		if (count _weaponState >= 3 && {(_weaponState # 0) != ""}) then {
			_vehicle selectWeaponTurret [
				_weaponState # 0,
				_turretPath,
				_weaponState # 1,
				_weaponState # 2
			];
		};
	},
	[_vehicle, _turretPath, _previousWeaponState, _defaultPriorities]
] call CBA_fnc_execNextFrame;

_vehicle setVariable ["RS_MH6V3_quickHydraLastFire", time];

true
