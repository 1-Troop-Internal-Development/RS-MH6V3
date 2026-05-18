disableSerialization;

private _display = uiNamespace getVariable ["RS_MH6V3_liveryDisplay", displayNull];
if (isNull _display) exitWith {};

private _vehicle = uiNamespace getVariable ["RS_MH6V3_liveryVehicle", objNull];
private _combo = _display displayCtrl 86064;
private _applyButton = _display displayCtrl 86065;

lbClear _combo;

private _liveries = [_vehicle] call RS_MH6V3_fnc_getAvailableLiveries;
private _currentTexture = if (isNull _vehicle) then {""} else {
	private _textures = getObjectTextures _vehicle;
	if ((count _textures) > 0) then {_textures # 0} else {""}
};

if (_liveries isEqualTo []) exitWith {
	private _index = _combo lbAdd "No liveries available";
	_combo lbSetCurSel _index;
	_applyButton ctrlEnable false;
};

{
	_x params ["_id", "_name", "_texture"];

	private _index = _combo lbAdd _name;
	_combo lbSetData [_index, str _x];

	if (_texture == _currentTexture) then {
		_combo lbSetCurSel _index;
	};
} forEach _liveries;

if ((lbCurSel _combo) < 0) then {
	_combo lbSetCurSel 0;
};

_applyButton ctrlEnable true;
