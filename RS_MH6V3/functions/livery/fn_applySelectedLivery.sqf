disableSerialization;

private _display = uiNamespace getVariable ["RS_MH6V3_liveryDisplay", displayNull];
if (isNull _display) exitWith {};

private _vehicle = uiNamespace getVariable ["RS_MH6V3_liveryVehicle", objNull];
private _combo = _display displayCtrl 86064;
private _index = lbCurSel _combo;

if (_index < 0) exitWith {};
if (isNull _vehicle || {!alive _vehicle}) exitWith {};
if !(typeOf _vehicle in ["RHS_MELB_H6M", "RHS_MELB_MH6M", "RHS_MELB_AH6M"]) exitWith {};

private _data = _combo lbData _index;
if (_data == "") exitWith {};

private _livery = parseSimpleArray _data;
if ((count _livery) < 3) exitWith {};

_livery params ["_id", "_name", "_texture"];
["RS_MH6V3_requestApplyLivery", [_vehicle, _texture, _name, player]] call CBA_fnc_serverEvent;
closeDialog 0;
