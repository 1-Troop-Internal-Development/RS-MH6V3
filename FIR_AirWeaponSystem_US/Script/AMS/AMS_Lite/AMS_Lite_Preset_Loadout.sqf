/*loadout system by Firewill*/

private _plane = "";
private _planetype = "";
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

_loadout_status = _plane getVariable "Loadout_Status";

if (_loadout_status == "yes") ExitWith {systemchat "AMS is working."};

_plane setvariable ["Loadout_Status","yes",true];

systemChat "AMS Started";

private _turrets = allTurrets [_plane,false];
private _turret_check = _turrets find [0];


private _plane_ary = _plane getVariable "Pylon_Preset_Ary";
private _plane_ary_count = (count _plane_ary) - 1;
if (_turret_check != -1) then
{
	{_plane removeMagazine _x} forEach magazines _plane;
	{_plane removeWeapon _x} forEach weapons _plane;

	{ _plane removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach getPylonMagazines _plane;
	
	private _pilot_mag = _plane magazinesTurret [-1];
	private _pilot_weap = _plane weaponsTurret [-1];	
	{_plane removeMagazineTurret [_x,[-1]]} forEach _pilot_mag;
	{_plane removeWeaponTurret [_x,[-1]]} forEach _pilot_weap;
}
else
{
	{_plane removeMagazine _x} forEach magazines _plane;
	{_plane removeWeapon _x} forEach weapons _plane;

	{ _plane removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach getPylonMagazines _plane;
};

sleep 1;

private _configPath = configFile >> "CfgVehicles" >> typeOf _plane;
private _weapons = getArray (_configPath >> "weapons");
private _mags = getArray (_configPath >> "magazines");

if (_turret_check != -1) then
{
	private _gunner_weapons = getArray (_configPath >> "Turrets" >> "MainTurret" >> "weapons");
	private _gunner_mags = getArray (_configPath >> "Turrets" >> "MainTurret" >> "magazines");
	private _gunner_turret = _turrets select _turret_check;
	{_plane addWeaponTurret [_x,_gunner_turret]} foreach _gunner_weapons;
	{_plane addMagazineTurret [_x,_gunner_turret]} foreach _gunner_mags;

	{_plane addMagazineTurret [_x,[-1]]} forEach _mags;	
	{_plane addWeaponTurret [_x,[-1]]} forEach _weapons;	
}
else
{
	{_plane addWeapon _x} foreach _weapons;
	{_plane addMagazine _x} foreach _mags;
};

sleep 2;

private _interval = 0.5;
private _custom = false;
private _mass = 0;
private _turret = [];

if (isNil "AWS_AMS_LoadingTime") then 
{
	systemchat "custom value not found. standard inverval time : 0.5s";
}
else
{
	systemchat "Weight-based Loading time enabled.";
	_custom = true;
};

for "_i" from 0 to _plane_ary_count do
{
	if (isEngineOn _plane) exitWith {systemChat "AMS cancelled : engine is on."};
	private _element = _plane_ary select _i;
	private _name = _element select 0;
	private _equip = _element select 1;
	private _check = _element select 2;
	if (_custom) then
	{
		_mass = getNumber  (configFile >> "CfgMagazines" >> _equip >> "mass");		
		_interval = _mass * 0.1;
	};
	systemchat format ["%1 / load time : %2 s",_equip,_interval];	
	sleep _interval;
	
	if (_check == "gunner") then
	{
		_plane setPylonLoadOut [_name,_equip, false, [0]];
	}
	else
	{
		_plane setPylonLoadOut [_name,_equip, false, []];	
	};

};

sleep 2;

systemChat "weapons loading completed";
_plane setvariable ["Loadout_Status","no",true];
	