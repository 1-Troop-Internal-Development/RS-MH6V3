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

private _hardpoint_ary = [];
private _listbox_count = count _ListboxArray;

for "_g" from 1 to _listbox_count - 1 do
{
	private _get_hp = _ListboxArray select _g;
	private _hp = lbData [_get_hp,(lbCurSel _get_hp)];
	_hardpoint_ary pushBack _hp;
};

private _customlist = profileNamespace getVariable _CustomPreset;
private _customlist_attachment = profileNamespace getVariable _CustomPresetAttachment;
private _element = _customlist find _preset;	
_customlist_attachment set [_element,_hardpoint_ary];
profileNamespace setVariable [_CustomPresetAttachment,_customlist_attachment];	
systemchat format ["custom preset %1 has been updated",_preset];



