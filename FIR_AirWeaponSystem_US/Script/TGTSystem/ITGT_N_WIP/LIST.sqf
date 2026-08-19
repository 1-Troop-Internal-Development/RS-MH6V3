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

_lb_pylon_ctrl = (findDisplay 5581) displayCtrl 1500;
_lb_tgt_ctrl = (findDisplay 5581) displayCtrl 1501;
_list_pic = (findDisplay 5581) displayCtrl 1202;
_grid_edit = (findDisplay 5581) displayCtrl 1400;
_map = (findDisplay 5581) displayCtrl 3620;

_lb_pylon_ctrl ctrlShow true;
_lb_tgt_ctrl ctrlShow true;
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

_text_pylon_idx ctrlShow false;
_text_pylon_weap ctrlShow false;
_text_mode ctrlShow false;
_mode_combo ctrlShow false;
_text_prior ctrlShow false;
_edit_priority ctrlShow false;
_btn_edit_apply ctrlShow false;
_priority_check ctrlShow false;

_btn_edit_apply ctrlEnable false;
_mode_combo ctrlEnable false;
_edit_priority ctrlEnable false;
_priority_check ctrlEnable false;

_list_pic ctrlSetText "FIR_AirWeaponSystem_US\ui\itgt\list_ca.paa";


lbClear _lb_pylon_ctrl;
lbClear _lb_tgt_ctrl;

_type = _plane getvariable ["ITGT_TYPE","GPS"];

private _allPylons = "true" configClasses (
		configFile 
		>> 
		"CfgVehicles" 
		>> 
		_planetype 
		>> 
		"Components" 
		>> 
		"TransportPylonsComponent" 
		>> 
		"pylons"
		) apply {configName _x};

private _lbarray = _allPylons;	

_pylonlist = GetPylonMagazines _plane;
_pylon_count = (count _pylonlist)-1;

private _hashmap = _plane getVariable "ITGT_LIST_hashmap";
private _pylonlist_count = (count _hashmap)-1;
private _pylon_ary = [];
// systemchat format ["%1",_pylonlist];

for "_r" from 0 to _pylon_count do
{
	// array [code,pylon index , current ammo count,wep_name]
	_select_pylon = _pylonlist select _r;
	_select_data = _hashmap get _select_pylon; 
	
	 _name = _select_pylon select 1;
	
	 _txt = format ["%1/%2",_select_pylon,_name];
	
	 _pylon_ary_elements = [_txt,_select_pylon];
	_pylon_ary pushback _pylon_ary_elements;			
};

[5581,1500,_pylon_ary,"data"] call FIR_fnc_lbadd_display;

private _tgtlist = _plane getVariable "ITGT_GPS_TGTLIST";
private _tgtlist_count = (count _tgtlist)-1;
private _tgt_ary = [];

private _tgtlist_keys = keys _tgtlist;

if (count _tgtlist_keys != 0) then
{
	for "_r" from 0 to _tgtlist_count do
	{
	// element structure [index,tgtID,tgtpos,markerID];
		_select_tgt = _tgtlist_keys select _r;
		_get_data = _tgtlist get _select_tgt;
		_id = _get_data select 1;
		_pos = _get_data select 2;
	
		 _txt = format ["%1/%2",_select_tgt,_pos];
	
		 _tgt_ary_elements = [_txt,_select_tgt];
		_tgt_ary pushback _tgt_ary_elements;			
	};

	[5581,1501,_tgt_ary,"data"] call FIR_fnc_lbadd_display;

};
