/*
Anti-ship missile intercept error system
based on percentage for missile intercept with aa missile.
if interceptor is aircraft, 100% miss. due to gaming balance.
if interceptor is not aircraft, depends on missiles error value.

if enemy missile has Active/PassiveRadarComponent, Missile will be jammed.

*/

private _planearray = _this select 0;
private _plane = _planearray select 0;
private _enemyweapon = _planearray select 1;
private _enemy = _planearray select 2;

if (not alive _plane) exitWith {};

_missile_sensor_list = (configProperties [configFile >> "cfgammo" >> _enemyweapon >> "Components" >> "SensorsManagerComponent" >> "Components", "isClass _x"]) apply {gettext (_x >> "componentType")};
_missile_sensor_act = _missile_sensor_list find "ActiveRadarSensorComponent";

if (_enemy isKindOf "Plane" or _enemy isKindof "Helicopter") then
{
	_mssl = nearestobject [_enemy, _enemyweapon];

	waitUntil {_mssl distance _plane < 800};

	_ewdir = getdir _mssl;
	_ewdir = _ewdir - 180;
	_mssl setdir _ewdir;
	sleep 0.01;

	deletevehicle _mssl;	
}
else 
{
	_rnd = random 100;
	
	if ((_missile_sensor_act >= 0) and _rnd < 15) then
	{
		_mssl = nearestobject [_enemy, _enemyweapon];

		waitUntil {_mssl distance _plane < 800};

		_ewdir = getdir _mssl;
		_ewdir = _ewdir - 180;
		_mssl setdir _ewdir;
		sleep 0.01;

		deletevehicle _mssl;
	}
	else
	{
		//not jammed
	};
};


