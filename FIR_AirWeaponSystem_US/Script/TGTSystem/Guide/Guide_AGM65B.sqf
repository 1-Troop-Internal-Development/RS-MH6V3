private ["_tgt","_missile","_missile_speed"];
_missile = _this select 0;
_plane = _this select 1;
_pilot = driver _plane;

_tgt = _plane getVariable ["AWS_MAV_TGT","no"];
_tgt_stat = _plane getVariable ["AWS_MAV_TGT_Stat","no"];

if (_tgt_stat == "yes") then
{
	_missile_speed = speed _missile;

	while {alive _missile} do
	{
		_eta = (_tgt distance _missile) / _missile_speed;
		
		_tgt_dir = [_missile, _tgt] call BIS_fnc_DirTo;
		_missile setDir _tgt_dir;

		_tgt_pitch = asin ((((getPosASL _missile) select 2) - ((getPosASL _tgt) select 2)) / (_tgt distance _missile));
		_tgt_pitch = (_tgt_pitch * -1);
		[_missile, _tgt_pitch, 0] call BIS_fnc_setPitchBank;

		_Missile_velocityX = ((((getPosASL _tgt) select 0) - ((getPosASL _missile) select 0)) / _eta)*0.6;
		_Missile_velocityY = ((((getPosASL _tgt) select 1) - ((getPosASL _missile) select 1)) / _eta)*0.6;
		_Missile_velocityZ = ((((getPosASL _tgt) select 2) - ((getPosASL _missile) select 2)) / _eta)*0.6;
		
		_missile setVelocity [_Missile_velocityX,_Missile_velocityY,_Missile_velocityZ];

		sleep 0.03;	
	};
};

	_plane setVariable ["AWS_MAV_TGT","no",true];
	_plane setVariable ["AWS_MAV_TGT_Stat","no",true];	



