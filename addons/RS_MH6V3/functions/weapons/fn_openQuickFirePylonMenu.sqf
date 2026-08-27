params [
	["_vehicle", vehicle player]
];

if (!hasInterface) exitWith {false};
if (isNull _vehicle || {!alive _vehicle} || {typeOf _vehicle != "RHS_MELB_AH6M"}) exitWith {false};
if !(vehicle player isEqualTo _vehicle && {currentPilot _vehicle isEqualTo player}) exitWith {
	systemChat "RS MH-6V3: only the active pilot can configure the Hydra Rocket Ripple system.";
	false
};

private _hydraPylons = [_vehicle] call RS_MH6V3_fnc_getHydraPylonData;
if (_hydraPylons isEqualTo []) exitWith {
	systemChat "RS MH-6V3: no Hydra pylons are installed.";
	false
};

private _sequence = +(_vehicle getVariable ["RS_MH6V3_quickHydraSequence", []]);
if (_sequence isEqualTo []) then {
	private _loaded = _hydraPylons select {(_x # 3) > 0};
	private _source = if (_loaded isEqualTo []) then {_hydraPylons} else {_loaded};
	_sequence = [(_source # 0) # 0];
};

uiNamespace setVariable ["RS_MH6V3_quickFireMenuVehicle", _vehicle];
uiNamespace setVariable ["RS_MH6V3_quickFireMenuSequence", _sequence];
uiNamespace setVariable [
	"RS_MH6V3_quickFireMenuMode",
	_vehicle getVariable ["RS_MH6V3_quickHydraMode", "single"]
];

createDialog "RS_MH6V3_QuickFirePylonMenu"
