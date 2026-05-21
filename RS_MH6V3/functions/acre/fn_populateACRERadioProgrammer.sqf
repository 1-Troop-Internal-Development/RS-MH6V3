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
	private _text = format ["%1 | %2 | %3", _info get "name", _channel, _on];
	private _index = _list lbAdd _text;
	_list lbSetData [_index, _radioId];
	if (_info get "monitoring") then {
		_list lbSetColor [_index, [0.55, 1, 0.62, 1]];
	} else {
		_list lbSetColor [_index, [0.65, 0.65, 0.65, 1]];
	};
};

private _addOtherRow = {
	params ["_list", "_text"];

	private _index = _list lbAdd _text;
	_list lbSetColor [_index, [0.78, 0.82, 0.78, 1]];
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
		if (!isNil "acre_api_fnc_getRadioChannel") then {
			private _acreChannel = [_radioId] call acre_api_fnc_getRadioChannel;
			if (!isNil "_acreChannel" && {_acreChannel isEqualType 0}) then {
				_channel = format ["CH %1", _acreChannel max 1];
			};
		};

		_rows pushBackUnique format ["%1 | %2 | AI", _name, _channel];
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

{
	[_myInventoryList, _x] call _addRadioRow;
	private _info = [_x, false] call RS_MH6V3_fnc_getACRERadioInfo;
	private _idx = _radioCombo lbAdd format ["INV | %1 | %2", _info get "name", _info get "channel"];
	_radioCombo lbSetData [_idx, _x];
} forEach _inventory;

{
	[_myRackList, _x] call _addRadioRow;
	private _info = [_x, false] call RS_MH6V3_fnc_getACRERadioInfo;
	private _idx = _radioCombo lbAdd format ["RACK | %1 | %2", _info get "name", _info get "channel"];
	_radioCombo lbSetData [_idx, _x];
} forEach _racks;

if ((lbSize _myInventoryList) == 0) then {
	_myInventoryList lbAdd "No inventory radios detected.";
};

if ((lbSize _myRackList) == 0) then {
	_myRackList lbAdd "No rack radios detected.";
};

if ((lbSize _radioCombo) > 0) then {
	_radioCombo lbSetCurSel 0;
};

private _otherUnit = if (player isEqualTo driver _vehicle) then {
	private _copilot = _vehicle turretUnit [0];
	if (isNull _copilot) then {gunner _vehicle} else {_copilot}
} else {
	driver _vehicle
};

private _otherRows = [];
private _otherRackRows = [];
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
	if (!isNull _otherUnit) then {
		_otherRows = [_otherUnit] call _getUnitInventoryRows;
	} else {
		_otherRows = ["Other seat is empty."];
	};
};

{
	[_otherInventoryList, _x] call _addOtherRow;
} forEach _otherRows;

{
	[_otherRackList, _x] call _addOtherRow;
} forEach _otherRackRows;

if ((lbSize _otherInventoryList) == 0) then {
	if (!isNull _otherUnit && {!isPlayer _otherUnit}) then {
		_otherInventoryList lbAdd "No AI inventory radios detected.";
	} else {
		_otherInventoryList lbAdd "Waiting for other seat radio data.";
	};
};

if ((lbSize _otherRackList) == 0) then {
	if (!isNull _otherUnit && {!isPlayer _otherUnit}) then {
		_otherRackList lbAdd "AI crew has no rack radio data.";
	} else {
		_otherRackList lbAdd "Waiting for other seat rack data.";
	};
};
