/*

use configClasses 
AWS EW "Sensor Jamming System"  
jamming enemy Sensors, specially Active Radar in Range.


by Firewill
*/
private ["_jammerpos","_pylon","_pylon_c","_range","_component","_componame","_compopick","_getunits","_hostiles","_hostiles_count","_sleep_time","_cooltime"];

_plane = vehicle player;
_pilot = driver _plane;
_planetype = typeof _plane;

_side = side _plane;
_hostiles = [];
_sleep_time = 60;
_cooltime = 90;

if (not(_plane iskindof "Plane") and not(_plane isKindOf "Helicopter")) ExitWith {player vehiclechat "You Must get in the Aircraft!";};

_active = _plane getVariable "AWS_EW_ACTIVE";

if (_active == "yes") exitWith {_plane vehicleChat "ERROR: SENSOR JAMMING IN PROGRESS.";};

_range = 5000;
_jammerpos = getpos _plane;

_pylon = getPylonMagazines _plane;
_pylon_c = count _pylon;

_plane setVariable ["AWS_EW_ACTIVE","yes",true];

for "_i" from 0 to _pylon_c-1 do
{
	_mag = _pylon select _i;
	_ecm = getNumber (configFile >> "CfgMagazines" >> _mag >> "AWS_ECMJAMMER");

	if (_ecm == 1) then
	{
		_range = _range + 5000;
		_sleep_time = _sleep_time + 10;
		_cooltime = _cooltime - 10;		
	};
}; 

sleep 2;

_plane vehicleChat format["SYSTEM: SENSOR JAMMING INITIATED. TIME : %1 sec",_sleep_time];

_getunits = _plane nearEntities [["Air","Tank"],_range];

{
      if(side _x != _side) then 
	  {
			_enemy_check = [_side, side _x] call BIS_fnc_sideIsEnemy;
			if (_enemy_check) then
			{
				_hostiles = _hostiles + [_x];
			};
	  };
}  foreach _getunits;

_hostiles_count = count _hostiles;

for "_i" from 0 to _hostiles_count-1 do
{
	_unit = _hostiles select _i;
	_unit_type = typeof _unit;
	_component = "getText (_x >> 'componentType') == 'ActiveRadarSensorComponent'" configClasses (configFile >> "CfgVehicles" >> _unit_type >> "Components" >> "SensorsManagerComponent" >> "Components");
	if (count _component >= 1) then
	{
		_compopick = _component select 0;
		_componame = configname _compopick;
		_unit enableVehicleSensor [_componame,false];
	};

}; 

 sleep _sleep_time;
 
_plane vehicleChat format ["SYSTEM: SENSOR JAMMING COMPLETED. COOLTIME IN PROGRESS. COOLTIME : %1 sec",_cooltime];

for "_i" from 0 to _hostiles_count-1 do
{
	_unit = _hostiles select _i;
	
	if (alive _unit) then
	{
		_unit_type = typeof _unit;
		_component = "getText (_x >> 'componentType') == 'ActiveRadarSensorComponent'" configClasses (configFile >> "CfgVehicles" >> _unit_type >> "Components" >> "SensorsManagerComponent" >> "Components");
		if (count _component >= 1) then
		{
			_compopick = _component select 0;
			_componame = configname _compopick;
			_unit enableVehicleSensor [_componame,true];
		};		
	};


}; 


sleep _cooltime;

_plane setVariable ["AWS_EW_ACTIVE","no",true];
_plane vehicleChat "SYSTEM: SENSOR JAMMER STAND-BY.";
 