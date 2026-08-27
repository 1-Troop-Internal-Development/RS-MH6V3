params [
	["_direction", 1]
];

if (!hasInterface) exitWith {};

private _vehicle = vehicle player;
if (
	isNull _vehicle ||
	{!(_vehicle isKindOf "RHS_MELB_AH6M")} ||
	{!(player in [driver _vehicle, gunner _vehicle, _vehicle turretUnit [0]])}
) exitWith {};

private _lists = [_vehicle] call RS_MH6V3_fnc_getACRERadioLists;
private _radios = _lists get "all";
if (_radios isEqualTo []) exitWith {};

private _selectedRadio = missionNamespace getVariable ["RS_MH6V3_acreSelectedRadioId", ""];
private _selectedIndex = _radios find _selectedRadio;
if (_selectedIndex < 0) then {
	_selectedIndex = 0;
} else {
	_selectedIndex = (_selectedIndex + _direction) mod count _radios;
	if (_selectedIndex < 0) then {
		_selectedIndex = _selectedIndex + count _radios;
	};
};

missionNamespace setVariable ["RS_MH6V3_acreSelectedRadioId", _radios select _selectedIndex];
missionNamespace setVariable ["RS_MH6V3_acreForceStatus", true];
missionNamespace setVariable ["RS_MH6V3_acreSelectionNonce", (missionNamespace getVariable ["RS_MH6V3_acreSelectionNonce", 0]) + 1];

if (!isNull (uiNamespace getVariable ["RS_MH6V3_acreProgrammerDisplay", displayNull])) then {
	[false] call RS_MH6V3_fnc_populateACRERadioProgrammer;
};
