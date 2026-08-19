/*
Semi-Active Radar Homing system
by Firewill
*/

private _array = _this select 0;
private _plane = _array select 0;
private _weapon = _array select 1;
private _ammoname = _array select 4;
private _magname = _array select 5;
private _projectile = _array select 6;

private _randomElement = selectRandom [70,-70];

private _des_target = cursorTarget;
if (isNull _des_target) exitWith {_plane vehicleChat "SYSTEM: TARGET NOT FOUND";};

while {alive _projectile} do
{
	private _new_target = cursorTarget;
	private _reldir = _plane getRelDir _des_target;
	if((_reldir > 80 and _reldir < 280) or (_new_target != _des_target)) exitWith
	{
		_mssldir = getdir _projectile;
		_mssldir = _mssldir + (_randomElement);
		_projectile setdir _mssldir;
		_plane vehiclechat "SYSTEM: TRACKING SIGNAL LOST";
		sleep 2;
		deleteVehicle _projectile;	
	};
	sleep 0.03;
};
