/* script for Sensor-Fuzed Weapon
   Made by Firewill 
 */

_cbu103 = _this select 0;
_cbu103zpos = getpos _cbu103 select 2;

if (not alive _cbu103 and _cbu103zpos < 50) exitwith {};
sleep 0.03;


while {_cbu103zpos > 200} do
{
	_cbu103zpos = getpos _cbu103 select 2;
	sleep 0.03;
};

_cbu_pb = _cbu103 call BIS_fnc_getPitchBank;
_cbu_p = _cbu_pb select 0;
_cbu_b = _cbu_pb select 1;
_cbu103speed = velocity _cbu103;
_cbu103pos = getpos _cbu103;
_cbu103dir = getdir _cbu103;

deletevehicle _cbu103;

_sub = "FIR_CBU97_Deploy" createvehicle _cbu103pos;
_subpos = getpos _sub;
_subdir = getdir _sub;

_subheight = _subpos select 2;
_range = 50;

_sub setdir _cbu103dir;
[_sub, _cbu_p, _cbu_b] call BIS_fnc_setPitchBank;

_sub setvelocity _cbu103speed;


_cbu_pb2 = _sub call BIS_fnc_getPitchBank;
_cbu_p2 = _cbu_pb2 select 0;
_cbu_b2 = _cbu_pb2 select 1;

for [{_i=0}, {_i < 10}, {_i=_i+1}] do
{
	_sdir = getdir _sub;
	_radius = random (_range)-(_range/2);
	
    _submunition = "FIR_BLU108" createvehicle position _sub;
	_submunition setdir _sdir;
	_submunition setpos [(getpos _sub select 0)+_radius,(getpos _sub select 1)+_radius, (getpos _sub select 2)];
	[_submunition, _cbu_p2, _cbu_b2] call BIS_fnc_setPitchBank;

	_dir = -10 + floor random 30;
	
	_submunition setVelocity 
	[
		(_cbu103speed select 0) - (sin _cbu103dir * random 20), 
		(_cbu103speed select 1) - (cos _cbu103dir * random 20), 
		(_cbu103speed select 2)
	];
	
};

while {_subheight > 50} do
{
	_subheight = getpos _sub select 2;
	sleep 0.03;
};

_skeetpos = getpos _sub;
_skeetdir = getdir _sub;
_range = 300;
_skeetcount = 40;

_tgt_list = _sub nearEntities [["Car", "Motorcycle", "Tank"], 300];
_tgt_list_count = count _tgt_list;

_notgt = _skeetcount - _tgt_list_count;

private ["_airburst","_skeet_exp"];

for [{_i=0}, {_i < _tgt_list_count}, {_i=_i+1}] do
{

	sleep (0.01 + random 0.05);
	

	_airburst = "ATMine_Range_Ammo" createvehicle position (_tgt_list select _i);
	sleep 0.00003;
	_airburst setpos [(getpos _airburst select 0),(getpos _airburst select 1),15];
	_airburst setdamage 1;
	
	_skeet_exp = "FIR_SFW_Skeet" createvehicle position (_tgt_list select _i); 	
	_skeet_exp setpos [(getpos _skeet_exp select 0),(getpos _skeet_exp select 1),1];
	_skeet_exp setdamage 1;	

};

for "_j" from 0 to _notgt do
{
	sleep (0.01 + random 0.05);
	
	_r = random 359;
	_radius = random (_range)-(_range/2);
    _no_skeet = "ATMine_Range_Ammo" createvehicle [(_skeetpos select 0)-_radius*sin(_r) , (_skeetpos select 1)-_radius*cos(_r) , 15]; 
	_no_skeet setdamage 1;
};
