/*loadout system by Firewill*/
if (not Local player) Exitwith {};
private _plane = vehicle Player;

_loadout_status = _plane getVariable "Loadout_Status";

if (_loadout_status == "yes") ExitWith {_plane vehiclechat "Loadout Dialog is working."};

_plane setvariable ["Loadout_Status","yes",true];


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

_preset = lbCurSel _presetNumber;

private _hardpoint_ary = [];
private _listbox_count = count _ListboxArray;

for "_g" from 1 to _listbox_count - 1 do
{
	private _get_hp = _ListboxArray select _g;
	private _hp = lbData [_get_hp,(lbCurSel _get_hp)];
	_hardpoint_ary pushBack _hp;
};

_pre = execVM _loadout_pre;
waitUntil {scriptDone _pre};	
_apply = _hardpoint_ary execVM _loadout_apply;
waitUntil {scriptDone _apply};	
_post = execVM _loadout_post;




_plane setvariable ["Loadout_Status","no",true];
	