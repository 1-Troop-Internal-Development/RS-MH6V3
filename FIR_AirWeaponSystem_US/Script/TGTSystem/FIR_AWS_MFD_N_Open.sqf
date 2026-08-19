/* Open MFD By Firewill */
/*
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
findDisplay 46 createDisplay "FIR_AWS_ITGT";

_slotcheck = _plane getvariable ["AWS_MEMORYSLOT_CHECK","no"];

if (_slotcheck == "no") then
{
	_plane setVariable ["AWS_MEMORYSLOT_CHECK","yes",true];
	_plane setVariable ["AWS_MEMORYSLOT",1,true];	
	_plane setvariable ["FIR_AWS_Nux_tvs_thermal",0];	
	_plane setVariable ["AWS_ITGT_GPS_TGTLIST",[],true];
	_plane setVariable ["AWS_ITGT_GPS_LOCKED_ARRAY",[],true];	
	_plane setVariable ["AWS_ITGT_GPS_TGTLIST_INDEX",0,true];
	
	// initialize GPS munitions 

	_pylonlist = GetPylonMagazines _plane;
	_gps_array = [];
	_pylon_count = (count _pylonlist)-1;

	for "_i" from 0 to _pylon_count do
	{
		_mag = _pylonlist select _i;
		_ammoname = getText (Configfile >> "CfgMagazines" >> _mag >> "ammo" );
		_gps_bomb = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_GPS_Bomb_Guide");
		_gps_mssl = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_GPS_MSSL_Guide");	
		If (_gps_bomb isEqualTo 1 or _gps_mssl isEqualTo 1) then
		{
			_ammo_c = _plane ammoOnPylon (_i+1);
			_code = "hp" + str (_i+1);
			// array [pylon code,pylon index, current ammo count,wep_name,tgtid,islock,mode]
			_ary = [_code,(_i+1),_ammo_c,_mag,"",false,"gps"];
			_gps_array pushBack _ary;		
		};
	};
	_plane setVariable ["AWS_ITGT_GPS_ARRAY",_gps_array,true];
	
	_dead_marker = [_plane,"y"] execVM "\FIR_AirWeaponSystem_US\script\TGTSystem\ITGT_N\DEAD_MARKER.sqf";
}
else
{
	private _gps_array = _plane getVariable ["AWS_ITGT_GPS_ARRAY",0];
	if (_gps_array isEqualTo 0) exitWith {systemChat localize "str_FIR_ITGT_NOT_INIT";};

	for "_i" from 0 to (count _gps_array)-1 do
	{
		private _pylon_code = ((_gps_array select _i)select 0);
		private _pylon_num = ((_gps_array select _i) select 1);
		private _pylon_ammo_count = ((_gps_array select _i) select 2);
		private _wep_name = ((_gps_array select _i) select 3);
		private _tgt_id = ((_gps_array select _i) select 4);
		private _islock = ((_gps_array select _i) select 5);
		private _gmode = ((_gps_array select _i) select 6);

		_gps_array set [_i,[_pylon_code,_pylon_num,_pylon_ammo_count,_wep_name,_tgt_id,_islock,_gmode]];
	};
	_plane setVariable ["AWS_ITGT_GPS_ARRAY",_gps_array,true];	
};

_lb_pylon_ctrl = (findDisplay 5581) displayCtrl 1500;
_lb_tgt_ctrl = (findDisplay 5581) displayCtrl 1501;
_list_pic = (findDisplay 5581) displayCtrl 1202;
_grid_edit = (findDisplay 5581) displayCtrl 1400;
_map = (findDisplay 5581) displayCtrl 3620;

_text_pylon_idx = (findDisplay 5581) displayCtrl 1001;
_text_pylon_weap = (findDisplay 5581) displayCtrl 1002;
_text_mode = (findDisplay 5581) displayCtrl 1003;
_mode_combo = (findDisplay 5581) displayCtrl 2100;
_text_prior = (findDisplay 5581) displayCtrl 1004;
_edit_priority = (findDisplay 5581) displayCtrl 1401;
_btn_edit_apply = (findDisplay 5581) displayCtrl 1614;
_priority_check = (findDisplay 5581) displayCtrl 2800;

// hide and show ctrls in map area default.
_lb_pylon_ctrl ctrlShow false;
_lb_tgt_ctrl ctrlShow false;
_list_pic ctrlShow false;
_grid_edit ctrlShow true;
_map ctrlShow true;

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


*/

/*I-TGT 2.0 BRAVO OPEN - UI Open function by Firewill
Open I-TGT UI
*/

private _plane = "";
private _planetype = "";
private _UAV = getConnectedUAV player;
private _number = 0;

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
findDisplay 46 createDisplay "FIR_AWS_ITGT";
private _ITGT_Display = findDisplay 5581;

_slotcheck = _plane getvariable ["AWS_MEMORYSLOT_CHECK","no"];

if (_slotcheck == "no") then
{
	_plane setVariable ["AWS_MEMORYSLOT_CHECK","yes",true];
	_plane setVariable ["AWS_MEMORYSLOT",1,true];	
	_plane setvariable ["FIR_AWS_Nux_tvs_thermal",0];	

	private _AWS_ITGT_GPS_ARRAY = CreateHashMap;
	private _AWS_ITGT_GPS_TGTLIST = CreateHashMap;
	private _AWS_ITGT_GPS_LOCKEDLIST = CreateHashMap;

	_plane setVariable ["AWS_ITGT_GPS_TGTLIST_INDEX",0,true];
	
	// initialize GPS munitions 

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
	_gps_array = [];
	_pylon_count = (count _pylonlist)-1;

	
	for "_i" from 0 to _pylon_count do
	{
		_pyloncode = _allPylons select _i;
		_mag = _pylonlist select _i;
		_ammoname = getText (Configfile >> "CfgMagazines" >> _mag >> "ammo" );
		_gps_bomb = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_GPS_Bomb_Guide");
		_gps_mssl = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_GPS_MSSL_Guide");
		_number = _number + 1;	
		If (_gps_bomb isEqualTo 1 or _gps_mssl isEqualTo 1) then
		{
			_ammo_c = _plane ammoOnPylon _pyloncode;
			
			// pyloncode = hashmap key, [current ammo count,wep_name,tgtid,islock,mode,pylonnumber]
			_ovrd = _AWS_ITGT_GPS_ARRAY set [_pyloncode,[_ammo_c,_mag,"",false,"gps",_number]];	
		};
	};	

	_plane setVariable ["AWS_ITGT_GPS_ARRAY",_AWS_ITGT_GPS_ARRAY];
	_plane setVariable ["AWS_ITGT_GPS_TGTLIST",_AWS_ITGT_GPS_TGTLIST];	
	_plane setVariable ["ITGT_GPS_LOCKEDLIST",_AWS_ITGT_GPS_LOCKEDLIST];	
	_dead_marker_handle = _plane addEventHandler ["killed", {[_this] execVM "\FIR_AirWeaponSystem_US_Cfg\sqs\ITGT\DEAD_MARKER.sqf"}];	
}
else
{
	private _gps_array = _plane getVariable ["AWS_ITGT_GPS_ARRAY",0];
	if (_gps_array isEqualTo 0) exitWith {systemChat localize "str_FIR_ITGT_NOT_INIT";};
};

_lb_pylon_ctrl = _ITGT_Display displayCtrl 1500;
_lb_tgt_ctrl = _ITGT_Display displayCtrl 1501;
_list_pic = _ITGT_Display displayCtrl 1202;
_grid_edit = _ITGT_Display displayCtrl 1400;
_map = _ITGT_Display displayCtrl 3620;

_text_pylon_idx = _ITGT_Display displayCtrl 1001;
_text_pylon_weap = _ITGT_Display displayCtrl 1002;
_text_mode = _ITGT_Display displayCtrl 1003;
_mode_combo = _ITGT_Display displayCtrl 2100;
_text_prior = _ITGT_Display displayCtrl 1004;
_edit_priority = _ITGT_Display displayCtrl 1401;
_btn_edit_apply = _ITGT_Display displayCtrl 1614;
_priority_check = _ITGT_Display displayCtrl 2800;

// hide and show ctrls in map area default.
_lb_pylon_ctrl ctrlShow false;
_lb_tgt_ctrl ctrlShow false;
_list_pic ctrlShow false;
_grid_edit ctrlShow true;
_map ctrlShow true;

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


