/*loadout system by Firewill*/

if (not Local player) Exitwith {};
// private _plane = vehicle Player;


private _plane = "";

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

private _planetype = typeof _plane;

private _configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "AMSData";
private _configcheck = isClass (_configPath);
private _AircraftBase = "";
private _CustomPreset = "";
if (not _configcheck) exitWith
{
	systemChat "this aircraft doesn't support the AMS, only Aircraft pre-defined presets are available to use.";
};

private _AircraftBase = getText (_configPath >> "AircraftBase");
private _CustomPreset = getText (_configPath >> "CustomPreset");

// add preset from config
_preset_config = "true" configClasses (configFile >> "CfgVehicles" >> _planetype >> "Components" >> "TransportPylonsComponent" >> "presets" ); 
_preset_array =  _preset_config apply {configName _x};
_preset_count = count _preset_array;

//custom preset ["presetName","PresetNaem2","PresetName3"];
//example : Plane_CAS_01_dynamicLoadout_base_F_CustomPreset_list
//actual array : ["PresetName",[["blah",blah],["blah2",blah2]]];

private _preset = lbdata [1502,(lbCurSel 1502)];
private _name = ctrlText 1400;

private _dataname = _CustomPreset + _name;
private _nameary = [_name,_dataname];

private _plane_ary = _plane getVariable "Pylon_Temp_Ary";
private _plane_ary_count = (count _plane_ary) - 1;

private _CustomPreset_ary = [];
_CustomPreset_ary = profileNamespace getVariable _CustomPreset;
private _preset_ary = [];
private _one_preset_ary = [];

if (_nameary in _preset_array) exitWith {systemChat "You can't add,modify this preset.(pre-defined preset)"};

if (_nameary in _CustomPreset_ary) then
{
	//update
	profileNamespace setVariable [_dataname,_plane_ary,true];	
	saveProfileNamespace;	
	
	systemchat "preset updated";	
}
else
{
	//add
	_CustomPreset_ary pushback _nameary;	
	profileNamespace setVariable [_CustomPreset,_CustomPreset_ary,true];	
	profileNamespace setVariable [_dataname,_plane_ary,true];
	saveProfileNamespace;
	
	systemchat "Preset added";	
	
};

lbClear 1502;	
	

for "_g" from 0 to _preset_count - 1 do
{
	_get_preset = _preset_array select _g;
	_preset_name = getText (configFile >> "CfgVehicles" >> _planetype >> "Components" >> "TransportPylonsComponent" >> "presets" >> _get_preset >> "displayName");
	_preset_class = configName (configFile >> "CfgVehicles" >> _planetype >> "Components" >> "TransportPylonsComponent" >> "presets" >> _get_preset);
	_one_preset_ary = [_preset_name,_preset_class];
	_preset_ary pushBack _one_preset_ary;
};

_customlist = profileNamespace getVariable _CustomPreset;
_customlist_c = count _customlist;
if (_customlist_c > 0) then
{
	for "_c" from 0 to _customlist_c - 1 do
	{
		_get_preset = _customlist select _c;
		_get_name = _get_preset select 0;
		_get_dataname = _get_preset select 1;
		_one_preset_ary = [_get_name,_get_dataname];
		_preset_ary pushBack _one_preset_ary;
	};	
}
else
{
  // do nothing
};

[1502,_preset_ary] call FIR_fnc_lbadd;
_preset_ary = [];	

lbSetCurSel [1502, -1];
