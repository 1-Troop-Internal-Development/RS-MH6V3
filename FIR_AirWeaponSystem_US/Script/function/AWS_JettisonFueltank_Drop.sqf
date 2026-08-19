/*Jettison Fueltank Script By Firewill*/

private ["_plane","_actual_Fueltank"];

_plane = _this select 0;

private _configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "JettisonSystem";
private _JettisonEnabled = getNumber (_configPath >> "JettisonEnabled"); if (_JettisonEnabled == 0) exitWith {};
private _Fueltank_list = getArray (_configPath >> "Fueltank_list");
private _Fueltank_Hardpoint = getArray (_configPath >> "Fueltank_Hardpoint");
private _Fueltank_Hardpoint_Offset = getArray (_configPath >> "Fueltank_Hardpoint_Offset");
private _Fueltank_hide = getArray (_configPath >> "Fueltank_hide");

_plane_pylon = GetPylonMagazines _plane;

private _fueltank_list_count = count _Fueltank_list - 1;
private _Fueltank_Hardpoint_count =  count _Fueltank_Hardpoint - 1;

private _mag = "";
private _fueltank_Model = "";
private _fueltank_Model_Path = "";
private _ammomodel = "";
private _fueltankarray = [];
private _fueltankcodearray = [];

_tankvel =[0,0,0];
hint "runnin";
for "_i" from 0 to _fueltank_list_count do
{
	_mag = _Fueltank_list select _i;
	_fueltank_Model = getText (configFile >> "CfgMagazines" >> _mag >> "FIR_AWS_Fueltank_Code");
	_fueltank_Model_Path =  getText (configFile >> "CfgVehicles" >> _fueltank_Model >> "model");
	for "_j" from 0 to _Fueltank_Hardpoint_count do
	{
		_hardpoint = _Fueltank_Hardpoint select _j;
		_hardpoint_offset = _Fueltank_Hardpoint_Offset select _j;		
		_hardpoint_index = _hardpoint + 1;
		_pylon = _plane_pylon select _hardpoint;
		if (_pylon == _mag) then
		{
			_actual_Fueltank = createVehicle [_fueltank_Model, [100,100,100],[],0,"CAN_COLLIDE"];
			_actual_Fueltank allowDamage false;
			_plane disableCollisionWith _actual_Fueltank;	
			_actual_Fueltank setPos [(getPos _plane select 0)+(_hardpoint_offset), getPos _plane select 1, (getPos _plane select 2) -3];
			_actual_Fueltank setVectorDirAndUp [vectorDir _plane, vectorUp _plane];		
			_fueltankarray pushBack _actual_Fueltank;
			// drop[_fueltank_Model_Path,"","SpaceObject",1,100,[_hardpoint_offset,-1,-1],_tankvel,0.2,10,1,0.05,[1],[[1,1,1,1]],[0],2,0,"","",_plane];			
			// hint "fueltank created";			

		};
	};
};

sleep 40;

private _actual_Fueltank_count = count _fueltankarray-1;

for "_k" from 0 to _actual_Fueltank_count do
{
	_remove_fueltank = _fueltankarray select _k;
	deleteVehicle _remove_fueltank;
};

