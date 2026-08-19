_bomb = _this select 0;
_plane = _this select 1;
_pilot = driver _plane;

_tgt = cursorTarget;
if (isNull _tgt) ExitWith{};
sleep 0.5;
_bomb_speed = 140;


while {alive _bomb} do
{
	_eta = (_tgt distance _bomb) / _bomb_speed;
	
	_tgt_dir = [_bomb, _tgt] call BIS_fnc_DirTo;
	_bomb setDir _tgt_dir;

	_tgt_pitch = asin ((((getPosASL _bomb) select 2) - ((getPosASL _tgt) select 2)) / (_tgt distance _bomb));
	_tgt_pitch = (_tgt_pitch * -1);
	[_bomb, _tgt_pitch, 0] call BIS_fnc_setPitchBank;

	_bomb_velocityX = (((getPosASL _tgt) select 0) - ((getPosASL _bomb) select 0)) / _eta;
	_bomb_velocityY = (((getPosASL _tgt) select 1) - ((getPosASL _bomb) select 1)) / _eta;
	_bomb_velocityZ = (((getPosASL _tgt) select 2) - ((getPosASL _bomb) select 2)) / _eta;
	
	_bomb setVelocity [_bomb_velocityX,_bomb_velocityY,_bomb_velocityZ];

	sleep 0.03;	
};
