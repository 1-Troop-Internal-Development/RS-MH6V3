/*AMS Lite dialog By Firewill*/
/*FOR NEW PYLON SYSTEM*/

if (not(isNil "AWS_AMS_Disable")) exitWith
{
	systemchat "AMS deactivated via AWS_AMS_Disable command.";
};

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

private _configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "AMSData";
private _configcheck = isClass (_configPath);
private _AircraftBase = "";
private _CustomPreset = "";
private _CustomPresetAttachment = "";
if (_configcheck) then
{
	_AircraftBase = getText (_configPath >> "AircraftBase");
	_CustomPreset = getText (_configPath >> "CustomPreset");
	_CustomPresetAttachment = getText (_configPath >> "CustomPresetAttachment");
};

private _turrets = allTurrets [_plane,false];
private _turret_check = _turrets find [0];


private _yes_icon = "FIR_AirWeaponSystem_US\ui\yes_ca.paa";
private _no_icon = "FIR_AirWeaponSystem_US\ui\no_ca.paa";

private _temp_ary = [];
private _preset_ary = [];

private _planetype = typeof _plane;
private _ams_list_config = "true" configClasses (configFile >> "CfgAWS_AMS_List"); 
private _ams_list_array = _ams_list_config apply {configName _x};

private _ams_list_config_msn = "true" configClasses (getMissionConfig "CfgAWS_AMS_List"); 
private _ams_list_array_msn = _ams_list_config_msn apply {configName _x};

_ams_list_array = _ams_list_array + _ams_list_array_msn;

private _list = nearestObjects [_plane,_ams_list_array, 160];
private _list_count = count _list;

if (_list_count == 0) ExitWith {systemchat "No AMS supported object found within 160m."};

If (not Local _plane) ExitWith {};
if (not(_plane iskindof "Plane" or _plane iskindof "Helicopter")) ExitWith {systemchat "You Must get in the right aircraft!";};
_handle= CreateDialog "AMS_Lite_GUI";


if (_turret_check == -1) then
{
	ctrlShow [1008, false ];
	ctrlShow [2800,false];
	ctrlEnable [2800, false];
}
else
{
	ctrlShow [1008, true ];
	ctrlShow [2800,true];
	ctrlEnable [2800, true];
};

/* HIDE PRESET PARTS TEMPORARY*/
	ctrlShow [1003, false ];
	ctrlShow [1400, false ];	
	ctrlShow [1502, false ];
	ctrlShow [1603, false ];
	ctrlShow [1604, false ];
	ctrlShow [1605, false ];	
	ctrlShow [1608, false ];		
	ctrlEnable [1603, false];	
	ctrlEnable [1604, false];	
	ctrlEnable [1605, false];		
	ctrlEnable [1608,false];

 /* WORK IN PROGRESS
 
_preset_config = "true" configClasses (configFile >> "CfgVehicles" >> _planetype >> "Components" >> "TransportPylonsComponent" >> "presets" ); 
_preset_array =  _preset_config apply {configName _x};
_preset_count = count _preset_array;

for "_g" from 0 to _preset_count - 1 do
{
	_get_preset = _preset_array select _g;
	_preset_name = getText (configFile >> "CfgVehicles" >> _planetype >> "Components" >> "TransportPylonsComponent" >> "presets" >> _get_preset >> "displayName");
	_preset_class = configName (configFile >> "CfgVehicles" >> _planetype >> "Components" >> "TransportPylonsComponent" >> "presets" >> _get_preset);
	_one_preset_ary = [_preset_name,_preset_class];
	_preset_ary pushBack _one_preset_ary;
};


if (_configcheck) then
{
	// add preset from custom preset	
	if (isNil {profileNamespace getVariable _CustomPreset}) then
	{

		profileNamespace setVariable [_CustomPreset,[]];
		profileNamespace setVariable [_CustomPresetAttachment,[]];
		systemchat "custom preset data installed.(you can see this message only one time)";
		saveProfileNamespace;	
	}
	else
	{
		_customlist = profileNamespace getVariable _CustomPreset;
		_customlist_c = count _customlist;
		if (_customlist_c > 0) then
		{
			for "_c" from 0 to _customlist_c - 1 do
			{
				_get_preset = _customlist select _c;
				_one_preset_ary = [_get_preset,_get_preset];
				_preset_ary pushBack _one_preset_ary;
			};	
		}
		else
		{
		  // do nothing
		};
	};	
};

[1502,_preset_ary] call FIR_fnc_lbadd;
_preset_ary = [];	

*/



//pylons work

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
private _lbcount = (count _lbarray)-1;

	for "_y" from 0 to _lbcount do
	{	
		private _name = _lbarray select _y;
		private _tempblock = [_name, "","pilot"];
		
		_temp_ary pushBack _tempblock;
	};	
	_plane setVariable ["Pylon_Temp_Ary", _temp_ary,true];
	



for "_r" from 0 to _lbcount do
{
	private _select_lb = _lbarray select _r;
	private _num = lbAdd [1500,_select_lb];
	lbSetData [1500, _r, _select_lb];	
	lbSetValue [1500,_r,_r];		
	
	lbAdd [1503,_select_lb];	
	lbSetData [1503, _r, _select_lb];	
	lbSetValue [1503,_r,_r];		
	lbSetPicture [1503, _r,_no_icon];
	lbSetTooltip [1503 ,_r, "NONE"];
};


// set loadout image on the left

private _get_image = "";
_get_image = [configfile >>  "CfgVehicles" >> typeOf _plane ,"fir_ams_image","no"] call BIS_fnc_returnConfigEntry;

if (_get_image != "no") then
{
	ctrlSetText [1201, _get_image];
}
else
{
	_get_image = [configfile >>  "CfgVehicles" >> typeOf _plane >> "Components" >> "TransportPylonsComponent" ,"UIPicture","no"] call BIS_fnc_returnConfigEntry;
	if (_get_image != "no") then
	{
		ctrlSetText [1201, _get_image];
	}
	else
	{
		ctrlSetText [1201, "\FIR_AirWeaponSystem_US\ui\pic_no_preview.paa"];	
	};
};