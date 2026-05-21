params [
	["_delta", 0.25]
];

if (!hasInterface) exitWith {};
if (isNil "acre_api_fnc_getRadioVolume" || {isNil "acre_api_fnc_setRadioVolume"}) exitWith {};

private _vehicle = vehicle player;
if (
	isNull _vehicle ||
	{!(_vehicle isKindOf "RHS_MELB_AH6M")} ||
	{!(player in [driver _vehicle, gunner _vehicle, _vehicle turretUnit [0]])}
) exitWith {};

private _lists = [_vehicle] call RS_MH6V3_fnc_getACRERadioLists;
private _radios = _lists get "all";
if (_radios isEqualTo []) exitWith {};

private _radioId = missionNamespace getVariable ["RS_MH6V3_acreSelectedRadioId", ""];
if !(_radioId in _radios) then {
	_radioId = [] call acre_api_fnc_getCurrentRadio;
	if (isNil "_radioId" || {!(_radioId isEqualType "")} || {!(_radioId in _radios)}) then {
		_radioId = _radios select 0;
	};
	missionNamespace setVariable ["RS_MH6V3_acreSelectedRadioId", _radioId];
};

private _currentVolume = [_radioId] call acre_api_fnc_getRadioVolume;
if (isNil "_currentVolume" || {!(_currentVolume isEqualType 0)}) exitWith {};

private _originalVolumes = missionNamespace getVariable ["RS_MH6V3_acreOriginalRadioVolumes", createHashMap];
if (isNil {_originalVolumes get _radioId}) then {
	_originalVolumes set [_radioId, _currentVolume];
	missionNamespace setVariable ["RS_MH6V3_acreOriginalRadioVolumes", _originalVolumes];
};

private _newVolume = (_currentVolume + _delta) max 0;
[_radioId, _newVolume] call acre_api_fnc_setRadioVolume;

missionNamespace setVariable ["RS_MH6V3_acreForceStatus", true];
missionNamespace setVariable ["RS_MH6V3_acreSelectionNonce", (missionNamespace getVariable ["RS_MH6V3_acreSelectionNonce", 0]) + 1];

if (!isNull (uiNamespace getVariable ["RS_MH6V3_acreProgrammerDisplay", displayNull])) then {
	[false] call RS_MH6V3_fnc_populateACRERadioProgrammer;
};
