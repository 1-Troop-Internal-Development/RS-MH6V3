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

if (not(_plane iskindof "Plane") and not(_plane isKindOf "Helicopter")) ExitWith {player vehiclechat "You Must get in the Aircraft!";};

disableSerialization;
_mydisplay = findDisplay 5581;

systemChat "PYLON EDIT MODE";

_lb_pylon_ctrl = (findDisplay 5581) displayCtrl 1500;

_cursel = lbCurSel _lb_pylon_ctrl;

if (_cursel isEqualTo -1) exitWith {systemChat "select pylon to edit."};

_lb_tgt_ctrl = (findDisplay 5581) displayCtrl 1501;
_list_pic = (findDisplay 5581) displayCtrl 1202;
_grid_edit = (findDisplay 5581) displayCtrl 1400;
_map = (findDisplay 5581) displayCtrl 3620;

_lb_pylon_ctrl ctrlShow false;
_lb_tgt_ctrl ctrlShow false;
_list_pic ctrlShow true;
_grid_edit ctrlShow false;
_map ctrlShow false;

_text_pylon_idx = (findDisplay 5581) displayCtrl 1001;
_text_pylon_weap = (findDisplay 5581) displayCtrl 1002;
_text_mode = (findDisplay 5581) displayCtrl 1003;
_mode_combo = (findDisplay 5581) displayCtrl 2100;
_text_prior = (findDisplay 5581) displayCtrl 1004;
_edit_priority = (findDisplay 5581) displayCtrl 1401;
_btn_edit_apply = (findDisplay 5581) displayCtrl 1614;
_priority_check = (findDisplay 5581) displayCtrl 2800;

_text_pylon_idx ctrlShow true;
_text_pylon_weap ctrlShow true;
_text_mode ctrlShow true;
_mode_combo ctrlShow true;
_text_prior ctrlShow true;
_edit_priority ctrlShow true;
_btn_edit_apply ctrlShow true;
_priority_check ctrlShow true;

_btn_edit_apply ctrlEnable true;
_mode_combo ctrlEnable true;
_edit_priority ctrlEnable true;
_priority_check ctrlEnable true;

_list_pic ctrlSetText "FIR_AirWeaponSystem_US\ui\itgt\edit_ca.paa";

lbClear _mode_combo;

_mode_list = [["GPS","GPS"],["Dual","DUAL"],["CG","CG"],["CG-T","CGT"]];

[5581,2100,_mode_list,"data"] call FIR_fnc_lbadd_display;

_data = _lb_pylon_ctrl lbdata _cursel;

_gps_array = _plane getVariable "AWS_ITGT_GPS_ARRAY";
_pylon_path = [_gps_array, _data] call BIS_fnc_findNestedElement;
_pylon_selected_path = _pylon_path select 0;

_pylon_code = ((_gps_array select _pylon_selected_path)select 0);
_pylon_num = ((_gps_array select _pylon_selected_path) select 1);
_pylon_ammo_count = ((_gps_array select _pylon_selected_path) select 2);
_wep_name = ((_gps_array select _pylon_selected_path) select 3);
_tgt_id = ((_gps_array select _pylon_selected_path) select 4);
_islock = ((_gps_array select _pylon_selected_path) select 5);
_mode = ((_gps_array select _pylon_selected_path) select 6);

_txt_p = "pylon:";
_txt_p = _txt_p+_pylon_code;

_txt_w = "name:";
_txt_w = _txt_w+_wep_name;

_text_pylon_idx ctrlSetText _txt_p;
_text_pylon_weap ctrlSetText _txt_w;

_mode_combo lbSetCurSel 0;

_plane setvariable ["AWS_ITGT_PYLON_TEMP",[_pylon_code,_pylon_num],true];

