/*Jettison Fueltank Script By Firewill*/

_plane = _this select 0;

private _configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "JettisonSystem";
private _JettisonEnabled = getNumber (_configPath >> "JettisonEnabled"); if (_JettisonEnabled == 0) exitWith {};
private _JettisonType = getNumber (_configPath >> "JettisonType");
private _JettisonPylon = getNumber (_configPath >> "JettisonPylon");
private _fuelswitch_type = getText (_configPath >> "fuelswitch_type"); 
private _FuelswitchName = getText (_configPath >> "FuelswitchName");
private _ScriptPath = getText (_configPath >> "JettisonScript");
private _Fuel_Internal = getNumber (_configPath >> "Fuel_Internal");
private _Fueltank_list = getArray (_configPath >> "Fueltank_list");
private _Fueltank_Hardpoint = getArray (_configPath >> "Fueltank_Hardpoint");
private _Fueltank_hide = getArray (_configPath >> "Fueltank_hide");

private _Fueltank_code_enable = getNumber (_configPath >> "Fueltank_code_enable");
private _Fueltank_code = getText (_configPath >> "Fueltank_code");

_plane_pylon = GetPylonMagazines _plane;

if (_fuelswitch_type == "variable") then
{
	if (fuel _plane <= _Fuel_Internal) then
	{
		_plane setVariable [_FuelswitchName,false,true];		
	}
	else
	{
		_plane setfuel _Fuel_Internal;
		_plane setVariable [_FuelswitchName,false,true];		
	};
}
else
{
	if (fuel _plane <= _Fuel_Internal) then
	{
		_plane animate [_FuelswitchName,0];	
	}
	else
	{
		_plane setfuel _Fuel_Internal;
		_plane animate [_FuelswitchName,0];	
	};
};

private _fueltank_list_count = count _Fueltank_list - 1;
private _Fueltank_Hardpoint_count =  count _Fueltank_Hardpoint - 1;

private _mag = "";
private _mag_ammo = "";
private _ammomodel = "";

_tankvel =[0,0,0];

_plane say "FIR_ReleaseSound";

_exec = [_plane] execVM _ScriptPath;
waitUntil {scriptDone _exec};

sleep 0.03;

if (_Fueltank_code_enable isEqualTo 1 ) then
{
	if (_JettisonPylon == 1 ) then
	{
			for "_i" from 0 to _Fueltank_Hardpoint_count do
			{
				_hardpoint = _Fueltank_Hardpoint select _i;
				_hardpoint_index = _hardpoint + 1;
				_pylon = _plane_pylon select _hardpoint;
				_fueltank_code_pylon = getText (configFile >> "CfgMagazines" >> _pylon >> "FIR_AWS_Fueltank_Code");				
				if (_fueltank_code_pylon isEqualTo _fueltank_code) then
				{
					_plane setPylonLoadOut [_hardpoint_index, "FIR_Empty_P_1rnd_M", false, []];		
				};
			};

	};
}
else
{
	if (_JettisonPylon == 1 ) then
	{
		for "_i" from 0 to _fueltank_list_count do
		{
			_mag = _Fueltank_list select _i;
			_mag_ammo = getText (configFile >> "CfgMagazines" >> _mag >> "ammo");
			// _ammomodel = getText (configFile >> "CfgAmmo" >> _mag_ammo >> "model");
			
			for "_j" from 0 to _Fueltank_Hardpoint_count do
			{
				_hardpoint = _Fueltank_Hardpoint select _j;
				_hardpoint_index = _hardpoint + 1;
				_pylon = _plane_pylon select _hardpoint;
				if (_pylon == _mag) then
				{
					_plane setPylonLoadOut [_hardpoint_index, "FIR_Empty_P_1rnd_M", false, []];		
				};
			};
		};
	};
};



