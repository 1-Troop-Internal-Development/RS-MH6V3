/* script for CBU-103 WCMD Cluster, use Anti-Personal Submunition.
   is Effect for Personal and Soft-Skin Vehicle.
   Made by Firewill 
 */

_blu118 = _this select 0;
_blu118zpos = getpos _blu118 select 2;

if (not alive _blu118 and _blu118zpos < 30) exitwith {};
sleep 0.03;


while {_blu118zpos > 30} do
{
	_blu118zpos = getpos _blu118 select 2;
	sleep 0.03;
};

_blu118speed = velocity _blu118;
_blu118pos = getpos _blu118;
_blu118dir = getdir _blu118;

deletevehicle _blu118;

_sub = "FIR_BLU118_B" createvehicle _blu118pos;
_sub setpos [(getpos _sub select 0),(getpos _sub select 1),30];
_sub setdamage 1;

sleep 0.8;

_sub_ex = "FIR_BLU118_EX" createvehicle _blu118pos;
_sub_ex setpos [(getpos _sub_ex select 0),(getpos _sub_ex select 1),30];
_sub_ex setdamage 1;
