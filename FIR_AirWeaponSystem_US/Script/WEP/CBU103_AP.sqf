/* script for CBU-103 WCMD Cluster, use Anti-Personal Submunition.
   is Effect for Personal and Soft-Skin Vehicle.
   Made by Firewill 
 */

_cbu103 = _this select 0;
_cbu103zpos = getpos _cbu103 select 2;

if (not alive _cbu103 and _cbu103zpos < 50) exitwith {};
sleep 0.03;


while {_cbu103zpos > 100} do
{
	_cbu103zpos = getpos _cbu103 select 2;
	sleep 0.03;
};

_cbu103speed = velocity _cbu103;
_cbu103pos = getpos _cbu103;
_cbu103dir = getdir _cbu103;

deletevehicle _cbu103;

_sub = "FIR_CBU103_Deploy" createvehicle _cbu103pos;
_subpos = getpos _sub;
_subdir = getdir _sub;
_subheight = _subpos select 2;
_range = 120;

_sub setdir _cbu103dir;
_sub setvelocity _cbu103speed;

for [{_i=0}, {_i < 60}, {_i=_i+1}] do
{
	_radius = random (_range)-(_range/2);
    _submunition = "FIR_CBU103_AP_Submunition" createvehicle [(_subpos select 0)+_radius , (_subpos select 1)+_radius , (_subpos select 2)]; 

	_dir = -10 + floor random 30;
	
	_submunition setvelocity [((_cbu103speed select 0) * cos(_dir)) + ((_cbu103speed select 1) * sin(_dir)) * 1, ((_cbu103speed select 0) * sin(_dir)) + ((_cbu103speed select 1) * cos(_dir)) * 1, (_cbu103speed select 2) * ((30 + random 100) / 100)];
	_submunition setdir _subdir;
};

_sub setVelocity 
[
	(_cbu103speed select 0) - (sin _cbu103dir * 20), 
	(_cbu103speed select 1) - (cos _cbu103dir * 20), 
	(_cbu103speed select 2)
];