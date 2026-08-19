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
private _AircraftBase = getText (_configPath >> "AircraftBase");
private _CustomPreset = getText (_configPath >> "CustomPreset");

private _preset = lbdata [1502,(lbCurSel 1502)];
private _custom_preset_ary = [];
private _preset_ary = [];
private _temp_ary = [];
private _one_preset_ary = [];
private _temp_attachment_ary = [];


private _customlist = profileNamespace getVariable _CustomPreset;
private _element = _customlist find _preset;	

if (_element >= 0) then
{
	_data = _customlist select _element;
	profileNamespace setVariable [_data,nil];
	_deleted_list = _customlist deleteAt _element;
	profileNamespace setVariable [_CustomPreset,_customlist];	
	systemchat  format ["custom preset %1 deleted.",_deleted_list];	
	saveProfileNamespace;
}
else
{
	systemchat "this isn't the preset you're looking for.";
};

lbClear 1502;	

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
