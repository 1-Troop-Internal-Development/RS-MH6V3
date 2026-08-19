/*Jettison Fueltank Script By Firewill*/

_plane = _this select 0;

private _configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "JettisonSystem";
private _JettisonEnabled = getNumber (_configPath >> "JettisonEnabled"); if (_JettisonEnabled == 0) exitWith {};
private _fuelswitch_type = getText (_configPath >> "fuelswitch_type"); 
private _FuelswitchName = getText (_configPath >> "FuelswitchName");
private _Fuel_Internal = getNumber (_configPath >> "Fuel_Internal");
private _Fueltank_list = getArray (_configPath >> "Fueltank_list");
private _Fueltank_Hardpoint = getArray (_configPath >> "Fueltank_Hardpoint");
private _Fueltank_Hardpoint_Offset = getArray (_configPath >> "Fueltank_Hardpoint_Offset");
private _Fueltank_hide = getArray (_configPath >> "Fueltank_hide");

_plane_pylon = GetPylonMagazines _plane;

private _fueltank_list_count = count _Fueltank_list - 1;
private _Fueltank_Hardpoint_count = count _Fueltank_hide - 1;

private _mag = "";
private _mag_ammo = "";
private _ammomodel = "";

_tankvel =[0,0,0];


for "_j" from 0 to _Fueltank_Hardpoint_count do
{
	_hide_object = _Fueltank_hide select _j;
	_plane animate [_hide_object,1,true];
};

