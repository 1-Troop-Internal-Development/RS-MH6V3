disableSerialization;

private _display = uiNamespace getVariable ["RS_MH6V3_pylonOwnerMenuDisplay", displayNull];
if (isNull _display) exitWith {};

private _vehicle = uiNamespace getVariable ["RS_MH6V3_pylonOwnerMenuVehicle", objNull];
if (isNull _vehicle) exitWith {closeDialog 0};

private _magazines = getPylonMagazines _vehicle;
private _overrides = _vehicle getVariable ["RS_MH6V3_pylonOwnerOverride", []];
private _labelIdcs = [86610, 86611, 86612, 86613];
private _comboIdcs = [86620, 86621, 86622, 86623];

for "_i" from 0 to 3 do {
	private _label = _display displayCtrl (_labelIdcs select _i);
	private _combo = _display displayCtrl (_comboIdcs select _i);
	private _magazine = _magazines param [_i, ""];

	if (_magazine == "") then {
		_label ctrlSetText format ["Pylon %1 - Empty", _i + 1];
		_combo ctrlEnable false;
	} else {
		private _name = getText (configFile >> "CfgMagazines" >> _magazine >> "displayName");
		if (_name == "") then {
			_name = _magazine;
		};
		_label ctrlSetText format ["Pylon %1 - %2", _i + 1, _name];
		_combo ctrlEnable true;
	};

	lbClear _combo;
	private _autoIndex = _combo lbAdd "Automatic";
	_combo lbSetData [_autoIndex, ""];
	private _pilotIndex = _combo lbAdd "Pilot";
	_combo lbSetData [_pilotIndex, "pilot"];
	private _copilotIndex = _combo lbAdd "Copilot";
	_combo lbSetData [_copilotIndex, "copilot"];

	private _override = _overrides param [_i, ""];
	private _selectIndex = switch (_override) do {
		case "pilot": {_pilotIndex};
		case "copilot": {_copilotIndex};
		default {_autoIndex};
	};
	_combo lbSetCurSel _selectIndex;
};
