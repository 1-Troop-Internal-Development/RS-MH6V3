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
private _AMSEnabled = getNumber (_configPath >> "AMSEnabled"); if (_AMSEnabled == 0) exitWith {};
private _DialogClass = getText (_configPath >> "DialogClass");
private _AircraftBase = getText (_configPath >> "AircraftBase");
private _CustomPreset = getText (_configPath >> "CustomPreset");
private _CustomPresetAttachment = getText (_configPath >> "CustomPresetAttachment");
private _presetNumber = getNumber (_configPath >> "presetNumber");
private _EditNumber = getNumber (_configPath >> "EditNumber");
private _ListboxArray = getArray (_configPath >> "ListboxArray");
private _loadout_script = getText (_configPath >> "loadout_script");
private _loadout_pre = getText (_configPath >> "loadout_pre");
private _loadout_apply = getText (_configPath >> "loadout_apply");
private _loadout_post = getText (_configPath >> "loadout_post");
private _CustomFuelEnabled = getNumber (_configPath >> "CustomFuelEnabled");
private _CustomFuelScript = getText (_configPath >> "CustomFuelScript");

private _preset = lbdata [_presetNumber,(lbCurSel _presetNumber)];
private _custom_preset_ary = [];
private _preset_ary = [];
private _temp_ary = [];
private _one_preset_ary = [];
private _temp_attachment_ary = [];

private _customlist = profileNamespace getVariable _CustomPreset;
private _customlist_attachment = profileNamespace getVariable _CustomPresetAttachment;
private _element = _customlist find _preset;	

if (_element >= 0) then
{
	_deleted_list = _customlist deleteAt _element;
	_deleted_list_attachment = _customlist_attachment deleteAt _element;
	profileNamespace setVariable [_CustomPreset,_customlist];	
	profileNamespace setVariable [_CustomPresetAttachment,_customlist_attachment];	
	systemchat  format ["custom preset %1 deleted.",_deleted_list];
}
else
{
	systemchat "this aren't the preset you're looking for.";
};

lbClear _presetNumber;

// add preset from config
private _preset_config = "true" configClasses (configFile >> "CfgVehicles" >> _planetype >> "Components" >> "TransportPylonsComponent" >> "presets" ); 
private _preset_array =  _preset_config apply {configName _x};
private _preset_count = count _preset_array;

for "_g" from 0 to _preset_count - 1 do
{
	_get_preset = _preset_array select _g;
	_preset_name = getText (configFile >> "CfgVehicles" >> _planetype >> "Components" >> "TransportPylonsComponent" >> "presets" >> _get_preset >> "displayName");
	_preset_data = getText (configFile >> "CfgVehicles" >> _planetype >> "Components" >> "TransportPylonsComponent" >> "presets" >> _get_preset >> "dataname");
	_one_preset_ary = [_preset_name,_preset_data];
	_preset_ary pushBack _one_preset_ary;
};

_customlist = profileNamespace getVariable _CustomPreset;
_customlist_c = count _customlist;

for "_c" from 0 to _customlist_c-1 do
{
	_get_preset = _customlist select _c;
	_one_preset_ary = [_get_preset,_get_preset];
	_preset_ary pushBack _one_preset_ary;
};

[_presetNumber,_preset_ary] call FIR_fnc_lbadd;
_preset_ary = [];		

