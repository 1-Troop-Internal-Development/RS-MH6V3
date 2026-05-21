params [
	["_requestOtherSeat", true]
];

if (!hasInterface) exitWith {};

private _display = uiNamespace getVariable ["RS_MH6V3_acreProgrammerDisplay", displayNull];
if (isNull _display) exitWith {};

private _vehicle = uiNamespace getVariable ["RS_MH6V3_acreProgrammerVehicle", vehicle player];
if (isNull _vehicle) exitWith {};

private _myInventoryList = _display displayCtrl 86310;
private _otherInventoryList = _display displayCtrl 86311;
private _myRackList = _display displayCtrl 86312;
private _otherRackList = _display displayCtrl 86313;
private _radioCombo = _display displayCtrl 86321;
private _otherSearch = _display displayCtrl 86328;
private _otherSearchText = toLower (ctrlText _otherSearch);
private _selectedRadioId = missionNamespace getVariable ["RS_MH6V3_acreSelectedRadioId", ""];
private _selectedRadioIndex = lbCurSel _radioCombo;
private _selectedTuneId = "";
private _selectedTuneOwner = 0;
if (_selectedRadioIndex >= 0) then {
	_selectedTuneId = _radioCombo lbData _selectedRadioIndex;
	_selectedTuneOwner = _radioCombo lbValue _selectedRadioIndex;
};
if (_selectedRadioId isEqualTo "" && {_selectedRadioIndex >= 0} && {_selectedTuneOwner isEqualTo 0}) then {
	_selectedRadioId = _radioCombo lbData _selectedRadioIndex;
};

lbClear _myInventoryList;
lbClear _otherInventoryList;
lbClear _myRackList;
lbClear _otherRackList;
lbClear _radioCombo;

private _addRadioRow = {
	params ["_list", "_radioId"];

	private _info = [_radioId, false] call RS_MH6V3_fnc_getACRERadioInfo;
	private _channel = _info get "channel";
	private _on = ["OFF", "ON"] select (_info get "on");
	private _selectedMarker = ["", "* "] select (_radioId isEqualTo (missionNamespace getVariable ["RS_MH6V3_acreSelectedRadioId", ""]));
	private _text = format ["%1%2 | %3 | %4", _selectedMarker, _info get "name", _channel, _on];
	private _index = _list lbAdd _text;
	_list lbSetData [_index, _radioId];
	if (_info get "monitoring") then {
		_list lbSetColor [_index, [0.55, 1, 0.62, 1]];
	} else {
		_list lbSetColor [_index, [0.65, 0.65, 0.65, 1]];
	};
};

private _addOtherRow = {
	params ["_list", "_row"];

	private _text = if (_row isEqualType createHashMap) then {
		_row getOrDefault ["text", "Unknown radio"]
	} else {
		_row
	};
	private _index = _list lbAdd _text;
	if (_row isEqualType createHashMap) then {
		_list lbSetData [_index, _row getOrDefault ["id", ""]];
		_list lbSetValue [_index, _row getOrDefault ["channelNumber", -1]];
	};
	_list lbSetColor [_index, [0.78, 0.82, 0.78, 1]];
};

private _addOtherTuneRow = {
	params ["_radioCombo", "_row", "_prefix", ["_owner", 1]];

	if !(_row isEqualType createHashMap) exitWith {};
	private _radioId = _row getOrDefault ["id", ""];
	private _text = _row getOrDefault ["text", "Unknown radio"];
	if (_radioId isEqualTo "") exitWith {};

	private _idx = _radioCombo lbAdd format ["OTHER %1 | %2", _prefix, _text];
	_radioCombo lbSetData [_idx, _radioId];
	_radioCombo lbSetValue [_idx, _owner];
};

private _getUnitInventoryRows = {
	params ["_unit"];

	private _rows = [];
	if (isNull _unit) exitWith {_rows};

	private _items = (items _unit) +
		(assignedItems _unit) +
		(weapons _unit) +
		(uniformItems _unit) +
		(vestItems _unit) +
		(backpackItems _unit);
	_items = _items arrayIntersect _items;

	private _addRadio = {
		params ["_radioId", "_baseRadio"];

		private _name = "";
		if (!isNil "acre_api_fnc_getDisplayName") then {
			_name = [_radioId] call acre_api_fnc_getDisplayName;
		};
		if (isNil "_name" || {!(_name isEqualType "")} || {_name isEqualTo ""}) then {
			_name = getText (configFile >> "CfgWeapons" >> _baseRadio >> "displayName");
		};
		if (_name isEqualTo "") then {
			_name = _baseRadio;
		};

		private _channel = "CH -";
		private _channelNumber = -1;
		if (!isNil "acre_api_fnc_getRadioChannel") then {
			private _acreChannel = [_radioId] call acre_api_fnc_getRadioChannel;
			if (!isNil "_acreChannel" && {_acreChannel isEqualType 0}) then {
				_channelNumber = _acreChannel max 1;
				_channel = format ["CH %1", _channelNumber];
			};
		};

		_rows pushBackUnique createHashMapFromArray [
			["id", _radioId],
			["channelNumber", _channelNumber],
			["text", format ["%1 | %2 | AI", _name, _channel]]
		];
	};

	{
		private _baseRadio = _x;
		if (!isNil "acre_api_fnc_getBaseRadio") then {
			private _resolvedBase = [_x] call acre_api_fnc_getBaseRadio;
			if (!isNil "_resolvedBase" && {_resolvedBase isEqualType ""} && {_resolvedBase isNotEqualTo ""}) then {
				_baseRadio = _resolvedBase;
			};
		};

		private _isRadio = false;
		if (!isNil "acre_api_fnc_isRadio") then {
			_isRadio = [_baseRadio] call acre_api_fnc_isRadio;
			if (isNil "_isRadio" || {!(_isRadio isEqualType true)}) then {
				_isRadio = false;
			};
		};

		if (_isRadio) then {
			private _radioIds = [];
			if (!isNil "acre_api_fnc_getAllRadiosByType") then {
				_radioIds = [_baseRadio, _unit] call acre_api_fnc_getAllRadiosByType;
				if (isNil "_radioIds" || {!(_radioIds isEqualType [])}) then {
					_radioIds = [];
				};
			};

			if (_radioIds isEqualTo []) then {
				[_baseRadio, _baseRadio] call _addRadio;
			} else {
				{
					[_x, _baseRadio] call _addRadio;
				} forEach _radioIds;
			};
		};
	} forEach _items;

	_rows
};

private _lists = [_vehicle] call RS_MH6V3_fnc_getACRERadioLists;
private _inventory = _lists get "inventory";
private _racks = _lists get "racks";
private _radios = _lists get "all";
if !(_selectedRadioId in _radios) then {
	_selectedRadioId = if (_radios isEqualTo []) then {""} else {_radios select 0};
};
missionNamespace setVariable ["RS_MH6V3_acreSelectedRadioId", _selectedRadioId];

{
	[_myInventoryList, _x] call _addRadioRow;
	private _info = [_x, false] call RS_MH6V3_fnc_getACRERadioInfo;
	private _selectedMarker = ["", "* "] select (_x isEqualTo _selectedRadioId);
	private _idx = _radioCombo lbAdd format ["%1INV | %2 | %3", _selectedMarker, _info get "name", _info get "channel"];
	_radioCombo lbSetData [_idx, _x];
	_radioCombo lbSetValue [_idx, 0];
} forEach _inventory;

{
	[_myRackList, _x] call _addRadioRow;
	private _info = [_x, false] call RS_MH6V3_fnc_getACRERadioInfo;
	private _selectedMarker = ["", "* "] select (_x isEqualTo _selectedRadioId);
	private _idx = _radioCombo lbAdd format ["%1RACK | %2 | %3", _selectedMarker, _info get "name", _info get "channel"];
	_radioCombo lbSetData [_idx, _x];
	_radioCombo lbSetValue [_idx, 0];
} forEach _racks;

if ((lbSize _myInventoryList) == 0) then {
	_myInventoryList lbAdd "No inventory radios detected.";
};

if ((lbSize _myRackList) == 0) then {
	_myRackList lbAdd "No rack radios detected.";
};

private _otherUnit = if (player isEqualTo driver _vehicle) then {
	private _copilot = _vehicle turretUnit [0];
	if (isNull _copilot) then {gunner _vehicle} else {_copilot}
} else {
	driver _vehicle
};
uiNamespace setVariable ["RS_MH6V3_acreProgrammerOtherUnit", _otherUnit];

private _otherRows = [];
private _otherRackRows = [];
private _otherTuneOwner = 1;
if (!isNull _otherUnit && {isPlayer _otherUnit}) then {
	private _snapshotKey = format ["RS_MH6V3_acreSnapshot_%1", getPlayerUID _otherUnit];
	private _snapshot = uiNamespace getVariable [_snapshotKey, createHashMapFromArray [["inventory", []], ["racks", []]]];
	if (_snapshot isEqualType createHashMap) then {
		_otherRows = _snapshot get "inventory";
		_otherRackRows = _snapshot get "racks";
		if (isNil "_otherRows" || {!(_otherRows isEqualType [])}) then {
			_otherRows = [];
		};
		if (isNil "_otherRackRows" || {!(_otherRackRows isEqualType [])}) then {
			_otherRackRows = [];
		};
	} else {
		_otherRows = _snapshot;
	};
	if (_requestOtherSeat) then {
		[player, _vehicle] remoteExecCall ["RS_MH6V3_fnc_publishACRERadioSnapshot", owner _otherUnit];
	};
} else {
	_otherTuneOwner = 2;
	if (!isNull _otherUnit) then {
		_otherRows = [_otherUnit] call _getUnitInventoryRows;
	} else {
		_otherRows = ["Other seat is empty."];
	};
};

private _filterOtherRows = {
	params ["_rows", "_searchText"];
	if (_searchText isEqualTo "") exitWith {_rows};

	_rows select {
		private _text = if (_x isEqualType createHashMap) then {
			_x getOrDefault ["text", ""]
		} else {
			_x
		};

		(toLower _text) find _searchText >= 0
	}
};

_otherRows = [_otherRows, _otherSearchText] call _filterOtherRows;
_otherRackRows = [_otherRackRows, _otherSearchText] call _filterOtherRows;

{
	[_otherInventoryList, _x] call _addOtherRow;
	[_radioCombo, _x, "INV", _otherTuneOwner] call _addOtherTuneRow;
} forEach _otherRows;

{
	[_otherRackList, _x] call _addOtherRow;
	[_radioCombo, _x, "RACK", _otherTuneOwner] call _addOtherTuneRow;
} forEach _otherRackRows;

if ((lbSize _otherInventoryList) == 0) then {
	if (_otherSearchText isNotEqualTo "") then {
		_otherInventoryList lbAdd "No matching other seat inventory radios.";
	} else {
		if (!isNull _otherUnit && {!isPlayer _otherUnit}) then {
			_otherInventoryList lbAdd "No AI inventory radios detected.";
		} else {
			_otherInventoryList lbAdd "Waiting for other seat radio data.";
		};
	};
};

if ((lbSize _otherRackList) == 0) then {
	if (_otherSearchText isNotEqualTo "") then {
		_otherRackList lbAdd "No matching other seat rack radios.";
	} else {
		if (!isNull _otherUnit && {!isPlayer _otherUnit}) then {
			_otherRackList lbAdd "AI crew has no rack radio data.";
		} else {
			_otherRackList lbAdd "Waiting for other seat rack data.";
		};
	};
};

if ((lbSize _radioCombo) > 0) then {
	private _selectedIndex = 0;
	private _fallbackTuneId = if (_selectedTuneId isEqualTo "") then {_selectedRadioId} else {_selectedTuneId};
	for "_idx" from 0 to ((lbSize _radioCombo) - 1) do {
		private _sameRadio = (_radioCombo lbData _idx) isEqualTo _fallbackTuneId;
		private _sameOwner = (_radioCombo lbValue _idx) isEqualTo _selectedTuneOwner;
		if (_sameRadio && {_sameOwner}) exitWith {
			_selectedIndex = _idx;
		};
	};
	_radioCombo lbSetCurSel _selectedIndex;
	if ((_radioCombo lbValue _selectedIndex) isEqualTo 0) then {
		missionNamespace setVariable ["RS_MH6V3_acreSelectedRadioId", _radioCombo lbData _selectedIndex];
	};
};
