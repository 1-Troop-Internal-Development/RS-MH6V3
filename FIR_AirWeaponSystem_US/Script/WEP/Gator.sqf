/* script for CBU-89 Gator Mine Cluster
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

_sub = "FIR_CBU89_Deploy" createvehicle _cbu103pos;
_subpos = getpos _sub;
_subdir = getdir _sub;
_subheight = _subpos select 2;
_range = 100;

_sub setdir _cbu103dir;
_sub setvelocity _cbu103speed;

sleep 0.05;
_apmine = 0;
_subpos = getpos _sub;

/*94 rounds for mine. 22 rounds is ap mine, 72 rounds is AT Mine*/
for [{_i=0}, {_i < 94}, {_i=_i+1}] do
{
	if (_apmine <= 22) then
	{
    _submunition = createvehicle ["APERSMine_Range_Ammo", _subpos, [], _range, ""];
	
	_submunition setposATL [getPosATL _submunition select 0, getPosATL _submunition select 1, 0.01];
	
	_apmine = _apmine + 1;
	}
	else
	{
    _submunition = createvehicle ["ATMine_Range_Ammo", _subpos, [], _range, ""];
	
	_submunition setposATL [getPosATL _submunition select 0, getPosATL _submunition select 1, 0.01];
	};

};
