disableSerialization;

private _display = uiNamespace getVariable ["RS_MH6V3_quickFireMenuDisplay", displayNull];
if (isNull _display) exitWith {};

private _vehicle = uiNamespace getVariable ["RS_MH6V3_quickFireMenuVehicle", objNull];
private _pylonList = _display displayCtrl 86410;
private _sequenceList = _display displayCtrl 86411;
private _modeCombo = _display displayCtrl 86412;
private _applyButton = _display displayCtrl 86420;
private _selectedPylon = lbCurSel _pylonList;
private _selectedStep = lbCurSel _sequenceList;

lbClear _pylonList;
lbClear _sequenceList;
lbClear _modeCombo;

private _hydraPylons = [_vehicle] call RS_MH6V3_fnc_getHydraPylonData;
{
	_x params ["_pylonIndex", "_weapon", "_magazine", "_ammo"];
	private _name = getText (configFile >> "CfgMagazines" >> _magazine >> "displayName");
	if (_name == "") then {
		_name = _magazine;
	};

	private _row = _pylonList lbAdd format ["Pylon %1 | %2 | %3 remaining", _pylonIndex, _name, _ammo];
	_pylonList lbSetValue [_row, _pylonIndex];
	if (_ammo <= 0) then {
		_pylonList lbSetColor [_row, [0.62, 0.62, 0.62, 1]];
	};
} forEach _hydraPylons;

private _sequence = +(uiNamespace getVariable ["RS_MH6V3_quickFireMenuSequence", []]);
{
	private _pylonIndex = _x;
	private _entry = _hydraPylons findIf {(_x # 0) == _pylonIndex};
	private _name = "Unavailable";
	if (_entry >= 0) then {
		private _magazine = (_hydraPylons # _entry) # 2;
		_name = getText (configFile >> "CfgMagazines" >> _magazine >> "displayName");
		if (_name == "") then {
			_name = _magazine;
		};
	};

	private _row = _sequenceList lbAdd format ["Step %1 | Pylon %2 | %3", _forEachIndex + 1, _pylonIndex, _name];
	_sequenceList lbSetValue [_row, _pylonIndex];
	if (_entry < 0) then {
		_sequenceList lbSetColor [_row, [1, 0.42, 0.36, 1]];
	};
} forEach _sequence;

private _singleIndex = _modeCombo lbAdd "Single Pylon Priority";
_modeCombo lbSetData [_singleIndex, "single"];
private _cycleIndex = _modeCombo lbAdd "Cycling Sequence";
_modeCombo lbSetData [_cycleIndex, "cycle"];

private _mode = uiNamespace getVariable ["RS_MH6V3_quickFireMenuMode", "single"];
_modeCombo lbSetCurSel (if (_mode == "cycle") then {_cycleIndex} else {_singleIndex});

if ((lbSize _pylonList) > 0) then {
	_pylonList lbSetCurSel ((_selectedPylon max 0) min ((lbSize _pylonList) - 1));
};
if ((lbSize _sequenceList) > 0) then {
	_sequenceList lbSetCurSel ((_selectedStep max 0) min ((lbSize _sequenceList) - 1));
};

_applyButton ctrlEnable !(_sequence isEqualTo []);
