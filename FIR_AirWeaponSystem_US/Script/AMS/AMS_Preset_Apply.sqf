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
private _loadout_scriptenabled = getNumber (_configPath >> "loadout_scriptenabled");
private _loadout_script = getText (_configPath >> "loadout_script");
private _loadout_pre = getText (_configPath >> "loadout_pre");
private _loadout_apply = getText (_configPath >> "loadout_apply");
private _loadout_post = getText (_configPath >> "loadout_post");
private _CustomFuelEnabled = getNumber (_configPath >> "CustomFuelEnabled");
private _CustomFuelScript = getText (_configPath >> "CustomFuelScript");
private _apply = "";

private _preset = lbdata [_presetNumber,(lbCurSel _presetNumber)];
systemchat format ["preset : %1",_preset];

private _preset_config = "true" configClasses (configFile >> "CfgVehicles" >> _planetype >> "Components" >> "TransportPylonsComponent" >> "presets" ); 
private _preset_array =  _preset_config apply {configName _x};
private _list = [];
private _hp_ary = [];
if (_preset in _preset_array) then
{
	_list = getarray (configfile >> "CfgVehicles" >> _planetype >> "Components" >> "TransportPylonsComponent" >> "presets" >> _preset >> "attachment");	
	_list_count = count _list;
	for "_g" from 0 to _list_count - 1 do
	{
		private _get_hp = _list select _g;
		_hp_ary pushBack _get_hp;
	};	
}
else
{
	_customlist = profileNamespace getVariable _CustomPreset;
	_customlist_attachment = profileNamespace getVariable _CustomPresetAttachment;
	_element = _customlist find _preset;	
	_list = _customlist_attachment select _element;	
	_list_count = count _list;
	for "_g" from 0 to _list_count - 1 do
	{
		private _get_hp = _list select _g;
		_hp_ary pushBack _get_hp;
	};
	

};


_pre = execVM _loadout_pre;
waitUntil {scriptDone _pre};	
_apply = _hp_ary execVM _loadout_apply;
waitUntil {scriptDone _apply};	
_post = execVM _loadout_post;


