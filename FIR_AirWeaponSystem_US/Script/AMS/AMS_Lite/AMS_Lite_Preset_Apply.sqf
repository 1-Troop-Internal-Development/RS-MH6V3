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

private _dialogNumber = 5280;
private _checkboxnumber = 2800;

disableSerialization;
_mydisplay = findDisplay _dialogNumber;
private _cb_ctrl = _mydisplay displayCtrl _checkboxnumber;	
private _checked = cbChecked _cb_ctrl;

private _turrets = allTurrets [_plane,false];
private _turret_check = _turrets find [0];

private _check = "";

if (_turret_check != -1 and _checked) then
{
	_check = "gunner";
}
else //for pilot
{
	_check = "pilot";
};	

private _preset = lbdata [1502,(lbCurSel 1502)];

if ((lbCurSel 1502) == -1) exitWith {systemChat "preset not selected"};

systemchat format ["preset : %1",_preset];

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
// private _lbcount = 0;
private _lbcount = (count _lbarray)-1;


private _preset_config = "true" configClasses (configFile >> "CfgVehicles" >> _planetype >> "Components" >> "TransportPylonsComponent" >> "presets" ); 
private _preset_array =  _preset_config apply {configName _x};
private _list = [];
private _hp_ary = [];

private _get_hp= "";
private _get_py = "";
private _hp_ary = [];

if (_preset in _preset_array) then
{
	_list = getarray (configfile >> "CfgVehicles" >> _planetype >> "Components" >> "TransportPylonsComponent" >> "presets" >> _preset >> "attachment");	
	_list_count = count _list;
	for "_g" from 0 to _list_count - 1 do
	{
		_get_hp = _list select _g;	
		_get_py = _lbarray select _g;
		_ary_temp = [_get_py,_get_hp,_check];
		_hp_ary pushBack _ary_temp;
	};	
	_plane setVariable ["Pylon_Preset_Ary",_hp_ary,true];		
}
else
{	
	private _plane_ary = profileNamespace getVariable _preset;
	_plane setVariable ["Pylon_Preset_Ary",_plane_ary,true];	
};


_apply = execVM "FIR_AirWeaponSystem_US\Script\AMS\AMS_Lite\AMS_Lite_Preset_Loadout.sqf";


