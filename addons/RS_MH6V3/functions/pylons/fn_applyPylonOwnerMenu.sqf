disableSerialization;

private _display = uiNamespace getVariable ["RS_MH6V3_pylonOwnerMenuDisplay", displayNull];
if (isNull _display) exitWith {false};

private _vehicle = uiNamespace getVariable ["RS_MH6V3_pylonOwnerMenuVehicle", objNull];
if (isNull _vehicle) exitWith {closeDialog 0; false};

private _comboIdcs = [86620, 86621, 86622, 86623];
private _overrides = [];
{
	private _combo = _display displayCtrl _x;
	private _selectIndex = lbCurSel _combo;
	private _owner = if (_selectIndex < 0) then {""} else {_combo lbData _selectIndex};
	_overrides pushBack _owner;
} forEach _comboIdcs;

_vehicle setVariable ["RS_MH6V3_pylonOwnerOverride", _overrides, true];
[_vehicle] call RS_MH6V3_fnc_syncPylonOwner;

private _summary = [];
{
	if (_x != "") then {
		private _label = if (_x == "copilot") then {"Copilot"} else {"Pilot"};
		_summary pushBack format ["Pylon %1: %2", _forEachIndex + 1, _label];
	};
} forEach _overrides;

if (_summary isEqualTo []) then {
	systemChat "RS MH-6V3: Pylon ownership set to automatic for all pylons.";
} else {
	systemChat format ["RS MH-6V3: Pylon ownership - %1.", (_summary joinString ", ")];
};

closeDialog 1;
true
