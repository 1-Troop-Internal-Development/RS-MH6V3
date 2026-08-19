/*

AWS EW "Electronic Support Measure - ESM"  
provide the ECM for friendly aircrafts in jamming range.


by Firewill
*/
private ["_jammerpos","_pylon","_pylon_c","_range","_component","_componame","_compopick","_getunits","_frnds","_frnds_count","_ecmhandle_ary"];

_plane = vehicle player;
_pilot = driver _plane;
_planetype = typeof _plane;

_side = side _plane;
_frnds = [];
_ecmhandle_ary = [];

if (not(_plane iskindof "Plane") and not(_plane isKindOf "Helicopter")) ExitWith {player vehiclechat "You Must get in the Aircraft!";};

_active = _plane getVariable "AWS_ESM_STATUS";

if (_active == "yes") exitWith {_plane vehicleChat "ERROR: ESM IN PROGRESS.";};

_range = 5000;
_jammerpos = getpos _plane;

_pylon = getPylonMagazines _plane;
_pylon_c = count _pylon;

_plane setVariable ["AWS_ESM_STATUS","yes",true];

for "_i" from 0 to _pylon_c-1 do
{
	_mag = _pylon select _i;
	_ecm = getNumber (configFile >> "CfgMagazines" >> _mag >> "AWS_ECMJAMMER");

	if (_ecm == 1) then
	{
		_range = _range + 5000;
	};
}; 


_plane vehicleChat "SYSTEM: ESM ACTIVATED";

sleep 2;

while {alive _plane and _plane getvariable "AWS_ESM_STATUS" == "yes" and (driver _plane != objnull)} do
{
	_getunits = _plane nearEntities ["Air",_range];

	{
		if(side _x == _side) then 
		{
			_frnds = _frnds + [_x];
		};
	}  foreach _getunits;

	_frnds_count = count _frnds;

	_plane vehicleChat format ["SYSTEM: ESM FOR %1 planes",_frnds_count];

	for "_i" from 0 to _frnds_count-1 do
	{
		_unit = _frnds select _i;
		_ecmhandle = _unit addEventHandler ["incomingMissile", {[_this] execVM "\FIR_AirWeaponSystem_US\script\EW\EW_ESM_START.sqf"}];
		_ecmhandle_ary = _ecmhandle_ary + [_ecmhandle];
		[[_unit,"SYSTEM: FRIENDLY ESM IN EFFECT"],"vehicleChat"] call BIS_fnc_MP;
		// _unit vehicleChat "SYSTEM: FRIENDLY ESM IN EFFECT";
	}; 

	sleep 60;
	 
	for "_i" from 0 to _frnds_count-1 do
	{
		_unit = _frnds select _i;
		
		if (alive _unit) then
		{
			_ecmhandle = _ecmhandle_ary select _i;
			_unit removeEventHandler ["incomingMissile", _ecmhandle];	
		};


	}; 
	_frnds = [];
	sleep 2;
};

sleep 0.1;

_plane vehicleChat "SYSTEM: ESM DEACTIVATED";
 