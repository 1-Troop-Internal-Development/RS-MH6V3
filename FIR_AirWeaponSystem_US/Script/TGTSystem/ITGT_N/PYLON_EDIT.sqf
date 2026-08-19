/*I-TGT 2.0 Designate  location function by Firewill
only adding target location.
*/

private _plane = "";
private _planetype = "";

private _UAV = getConnectedUAV player;

//if not UAV
if (_UAV isEqualTo objNull) then
{
	_plane = vehicle player;
	_plane_pilot = driver _plane;
}
else
{
// if UAV and MQ-81U only

		_plane = _UAV;	
		_plane_pilot = player;		
};

_planetype = typeof _plane;	

if (not(_plane iskindof "Plane") and not(_plane isKindOf "Helicopter")) ExitWith {player vehiclechat localize "str_FIR_ITGT_AIRCRAFT_WARN";};

disableSerialization;
_mydisplay = findDisplay 5581;

_mode_combo = (findDisplay 5581) displayCtrl 2100;
_edit_priority = (findDisplay 5581) displayCtrl 1401;
_priority_check = (findDisplay 5581) displayCtrl 2800;

_cursel = lbCurSel _mode_combo;
if (_cursel isEqualTo -1) exitWith {systemChat localize "str_FIR_ITGT_PYLON_EDIT_SELECT_CHECK"};

_data = _mode_combo lbData _cursel;

_pylondata = _plane getVariable "AWS_ITGT_PYLON_TEMP";

_hp = _pylondata select 0;
_hp_num = _pylondata select 1;

_gps_array = _plane getVariable "AWS_ITGT_GPS_ARRAY";
_pylon_path = [_gps_array, _hp] call BIS_fnc_findNestedElement;
_pylon_selected_path = _pylon_path select 0;

_pylon_code = ((_gps_array select _pylon_selected_path)select 0);
_pylon_num = ((_gps_array select _pylon_selected_path) select 1);
_pylon_ammo_count = ((_gps_array select _pylon_selected_path) select 2);
_wep_name = ((_gps_array select _pylon_selected_path) select 3);
_tgt_id = ((_gps_array select _pylon_selected_path) select 4);
_islock = ((_gps_array select _pylon_selected_path) select 5);
_mode = ((_gps_array select _pylon_selected_path) select 6);

_gps_array set [_pylon_selected_path,[_pylon_code,_pylon_num,_pylon_ammo_count,_wep_name,_tgt_id,_islock,_data]];
_plane setVariable ["AWS_ITGT_GPS_ARRAY",_gps_array,true];

_checked = cbChecked _priority_check;

if (_checked) then
{
	_text = ctrlText _edit_priority;
	_text = _text call BIS_fnc_parseNumber;
	if (_text isEqualTo -1) exitWith {systemChat localize "str_FIR_ITGT_PYLON_EDIT_NUMBER_CHECK"};
	_pylonlist = (configProperties [configFile >> "CfgVehicles" >> typeOf _plane >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getnumber (_x >> "priority")};
	_hp_num = _hp_num - 1;
	_pylonlist set [_hp_num,_text];
	hint format ["%1",_pylonlist];
	_plane setPylonsPriority _pylonlist;
};


systemChat format [localize "str_FIR_ITGT_PYLON_EDIT_UPDATE",_pylon_num,_data];


