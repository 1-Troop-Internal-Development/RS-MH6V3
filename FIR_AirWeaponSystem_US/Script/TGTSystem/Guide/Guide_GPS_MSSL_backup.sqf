_missile = _this select 0;
_plane = _this select 1;
_pilot = driver _plane;

if (_plane animationPhase "set_target_switch" >= 0.1) ExitWith {_plane vehiclechat "WARNING : OLD SYSTEM IS DETECTED";};

_tgt_pos = _plane getvariable "ITGT_C_DATA";
_check = _plane getvariable "ITGT_NEW";

if (_check == "no") ExitWith {_plane vehiclechat "CAUTION : GPS DATA NOT FOUND";};

_faketarget = "Land_HelipadEmpty_F" createVehicleLocal _tgt_pos;	
_missile_speed = speed _missile;

while {alive _missile} do
{
	_eta = (_faketarget distance _missile) / _missile_speed;
	
	_tgt_dir = [_missile, _faketarget] call BIS_fnc_DirTo;
	_missile setDir _tgt_dir;

	_tgt_pitch = asin ((((getPosASL _missile) select 2) - ((getPosASL _faketarget) select 2)) / (_faketarget distance _missile));
	_tgt_pitch = (_tgt_pitch * -1);
	[_missile, _tgt_pitch, 0] call BIS_fnc_setPitchBank;

	_Missile_velocityX = (((getPosASL _faketarget) select 0) - ((getPosASL _missile) select 0)) / _eta;
	_Missile_velocityY = (((getPosASL _faketarget) select 1) - ((getPosASL _missile) select 1)) / _eta;
	_Missile_velocityZ = (((getPosASL _faketarget) select 2) - ((getPosASL _missile) select 2)) / _eta;
	
	_missile setVelocity [_Missile_velocityX,_Missile_velocityY,_Missile_velocityZ];

	sleep 0.03;	
};

deletevehicle _faketarget;

