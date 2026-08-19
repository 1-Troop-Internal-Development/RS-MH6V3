/*Simple ECM System by Firewill */

Private ["_planearray","_plane","_enemy","_mssl","_missile_sensor_list","_missile_sensor_act","_missile_sensor_pas"];

_planearray = _this select 0;
_plane = _planearray select 0;
_enemyweapon = _planearray select 1;
_enemy = _planearray select 2;

if (not alive _plane) exitWith {};
/*
new ECM system based on SensorsManagerComponent

if enemy missile has Active/PassiveRadarComponent, Missile will be jammed. if not, missile will be not jammed and warn to player for drop the flares.

*/

_missile_sensor_list = (configProperties [configFile >> "cfgammo" >> _enemyweapon >> "Components" >> "SensorsManagerComponent" >> "Components", "isClass _x"]) apply {gettext (_x >> "componentType")};
_missile_sensor_act = _missile_sensor_list find "ActiveRadarSensorComponent";
_missile_sensor_pas = _missile_sensor_list find "PassiveRadarSensorComponent";
if (_missile_sensor_act >= 0 or _missile_sensor_pas >= 0) then
{
	_mssl = nearestobject [_enemy, _enemyweapon];

	waitUntil {_mssl distance _plane < 1000};

	_ewdir = getdir _mssl;
	_ewdir = _ewdir - 180;
	_mssl setdir _ewdir;
	sleep 0.001;
	_plane vehiclechat "SYSTEM: ENEMY MSSL JAMMED";
	deletevehicle _mssl;
}
else
{
	_plane vehiclechat "SYSTEM: IR MSSL DETECTED - DROP CM NOW";
};

