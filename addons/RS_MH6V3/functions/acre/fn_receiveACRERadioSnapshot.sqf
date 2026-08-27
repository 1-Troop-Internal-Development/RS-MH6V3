params [
	["_unit", objNull],
	["_snapshot", createHashMapFromArray [["inventory", []], ["racks", []]]]
];

if (!hasInterface) exitWith {};
if (isNull _unit || {!isPlayer _unit}) exitWith {};
if !(_snapshot isEqualType createHashMap || {_snapshot isEqualType []}) exitWith {};

private _snapshotKey = format ["RS_MH6V3_acreSnapshot_%1", getPlayerUID _unit];
uiNamespace setVariable [_snapshotKey, _snapshot];

private _display = uiNamespace getVariable ["RS_MH6V3_acreProgrammerDisplay", displayNull];
if (!isNull _display) then {
	[false] call RS_MH6V3_fnc_populateACRERadioProgrammer;
};
