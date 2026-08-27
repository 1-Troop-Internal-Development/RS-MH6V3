params [
	["_operation", ""]
];

disableSerialization;

private _display = uiNamespace getVariable ["RS_MH6V3_quickFireMenuDisplay", displayNull];
if (isNull _display) exitWith {false};

private _vehicle = uiNamespace getVariable ["RS_MH6V3_quickFireMenuVehicle", objNull];
private _pylonList = _display displayCtrl 86410;
private _sequenceList = _display displayCtrl 86411;
private _sequence = +(uiNamespace getVariable ["RS_MH6V3_quickFireMenuSequence", []]);
private _selectedStep = lbCurSel _sequenceList;
private _changed = false;

switch (toLower _operation) do {
	case "add": {
		private _selectedPylon = lbCurSel _pylonList;
		if (_selectedPylon >= 0) then {
			_sequence pushBack (_pylonList lbValue _selectedPylon);
			_selectedStep = (count _sequence) - 1;
			_changed = true;
		};
	};
	case "remove": {
		if (_selectedStep >= 0 && {_selectedStep < count _sequence}) then {
			_sequence deleteAt _selectedStep;
			_selectedStep = _selectedStep min ((count _sequence) - 1);
			_changed = true;
		};
	};
	case "up": {
		if (_selectedStep > 0 && {_selectedStep < count _sequence}) then {
			private _value = _sequence deleteAt _selectedStep;
			_selectedStep = _selectedStep - 1;
			_sequence insert [_selectedStep, [_value]];
			_changed = true;
		};
	};
	case "down": {
		if (_selectedStep >= 0 && {_selectedStep < ((count _sequence) - 1)}) then {
			private _value = _sequence deleteAt _selectedStep;
			_selectedStep = _selectedStep + 1;
			_sequence insert [_selectedStep, [_value]];
			_changed = true;
		};
	};
	case "clear": {
		_sequence = [];
		_selectedStep = -1;
		_changed = true;
	};
	case "loaded": {
		_sequence = (([_vehicle] call RS_MH6V3_fnc_getHydraPylonData) select {
			(_x # 3) > 0
		}) apply {
			_x # 0
		};
		_selectedStep = if (_sequence isEqualTo []) then {-1} else {0};
		_changed = true;
	};
};

if (_changed) then {
	uiNamespace setVariable ["RS_MH6V3_quickFireMenuSequence", _sequence];
	[] call RS_MH6V3_fnc_populateQuickFirePylonMenu;

	if (_selectedStep >= 0) then {
		_sequenceList lbSetCurSel _selectedStep;
	};
};

_changed
