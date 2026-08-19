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

// private _configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "AMSData";
// private _AMSEnabled = getNumber (_configPath >> "AMSEnabled"); if (_AMSEnabled == 0) exitWith {};
// private _DialogClass = getText (_configPath >> "DialogClass");
// private _AircraftBase = getText (_configPath >> "AircraftBase");
// private _CustomPreset = getText (_configPath >> "CustomPreset");
// private _CustomPresetAttachment = getText (_configPath >> "CustomPresetAttachment");
// private _presetNumber = getNumber (_configPath >> "presetNumber");
// private _EditNumber = getNumber (_configPath >> "EditNumber");
// private _ListboxArray = getArray (_configPath >> "ListboxArray");
// private _loadout_script = getText (_configPath >> "loadout_script");
// private _loadout_pre = getText (_configPath >> "loadout_pre");
// private _loadout_apply = getText (_configPath >> "loadout_apply");
// private _loadout_post = getText (_configPath >> "loadout_post");
// private _CustomFuelEnabled = getNumber (_configPath >> "CustomFuelEnabled");
// private _CustomFuelScript = getText (_configPath >> "CustomFuelScript");
// private _CustomLoadoutScriptEnabled = getNumber (_configPath >> "CustomLoadoutScriptEnabled");
// private _CustomLoadoutScript = getText (_configPath >> "CustomLoadoutScript");


private _mag_ary = [];
private _preset_ary = [];
private _custom_preset_ary = [];
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
if (not(_plane iskindof _AircraftBase)) ExitWith {systemchat "You Must get in the right aircraft!";};
_handle= CreateDialog _DialogClass;

// add preset from config
_preset_config = "true" configClasses (configFile >> "CfgVehicles" >> _planetype >> "Components" >> "TransportPylonsComponent" >> "presets" ); 
_preset_array =  _preset_config apply {configName _x};
_preset_count = count _preset_array;

for "_g" from 0 to _preset_count - 1 do
{
	_get_preset = _preset_array select _g;
	_preset_name = getText (configFile >> "CfgVehicles" >> _planetype >> "Components" >> "TransportPylonsComponent" >> "presets" >> _get_preset >> "displayName");
	_preset_data = getText (configFile >> "CfgVehicles" >> _planetype >> "Components" >> "TransportPylonsComponent" >> "presets" >> _get_preset >> "dataname");
	_one_preset_ary = [_preset_name,_preset_data];
	_preset_ary pushBack _one_preset_ary;
};

// add preset from custom preset	
if (isNil {profileNamespace getVariable _CustomPreset}) then
{
	profileNamespace setVariable [_CustomPreset,[]];
	profileNamespace setVariable [_CustomPresetAttachment,[]];
	systemchat "custom preset data installed.(you can see this message only one time)";
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

private _allPylons = "true" configClasses (
		configFile 
		>> 
		"CfgVehicles" 
		>> 
		"Plane_Fighter_01_Base_F" 
		>> 
		"Components" 
		>> 
		"TransportPylonsComponent" 
		>> 
		"pylons"
		) apply {configName _x};


[_presetNumber,_preset_ary] call FIR_fnc_lbadd;
_preset_ary = [];		
	
//0000 is dummy for index 0	
private _lbarray = _ListboxArray;
private _lbcount = 0;
_lbcount = (count _lbarray)-1;

for "_r" from 1 to _lbcount do
{
	private _select_lb = _lbarray select _r;
	private _wep_list = _plane getCompatiblePylonMagazines _r;
	private _wep_cnt = count _wep_list;

	for "_i" from 0 to _wep_cnt-1 do
	{
		if (isNil "AWS_AMS_Blacklist") then 
		{
			private _wep = _wep_list select _i;
			private _wep_name = getText (configFile >> "CfgMagazines" >> _wep >> "displayName");
			private _wep_ary = [_wep_name,_wep];
			_mag_ary pushback _wep_ary;
		}
		else
		{
			private _blacklist = AWS_AMS_Blacklist;
			private _wep = _wep_list select _i;
			
			if (_wep in _blacklist) then
			{
				
			}
			else
			{
				private _wep_name = getText (configFile >> "CfgMagazines" >> _wep >> "displayName");
				private _wep_ary = [_wep_name,_wep];
				_mag_ary pushback _wep_ary;						
			};
		};	
	}; 
	[_select_lb,_mag_ary] call FIR_fnc_lbadd;
	_mag_ary = [];		
};


if (_CustomLoadoutScriptEnabled == 1) then
{
	_handle = execVM _CustomLoadoutScript;
}
else
{

};