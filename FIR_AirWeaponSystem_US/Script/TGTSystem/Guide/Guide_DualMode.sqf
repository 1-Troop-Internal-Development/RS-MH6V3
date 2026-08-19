private ["_bomb","_plane","_pilot","_tgt_pos","_check","_faketarget","_bomb_speed","_eta","_tgt_dir","_tgt_pitch","_tgt_pos","_bomb_velocityX","_bomb_velocityY","_bomb_velocityZ","_target_list","_tgt"];

_plane = _this select 0;
_bomb = _this select 1;
_ammoname = _this select 2;
_pilot = driver _plane;

systemChat "SYSTEM: DUAL MODE ACTIVATED";

_DUAL_Type = getText (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_DUAL_Type");


if (_DUAL_Type == "Laser") then
{
	_target_list = _bomb nearEntities ["LaserTarget", 1800];
	_tgt = _target_list select 0;
};

if (_DUAL_Type == "IR" or _DUAL_Type == "Vis") then
{
	_target_list = _bomb nearEntities [["Car", "Motorcycle", "Tank"], 1800];
	_tgt = selectRandom _target_list;
};

//Multi seeker
if (_Dual_Type == "Multi") then
{
	//laser first, IR and Vis laster when if no laser target found.
		_laser_list = _bomb nearEntities ["LaserTarget",1800];
		
		if (count _laser_list == 0) then
		{
			_target_list = _bomb nearEntities [["Car", "Motorcycle", "Tank"], 1800];
			_tgt = selectRandom _target_list;		
		}
		else
		{
			_tgt = _laser_list select 0;
		};
};

if (isNil "_tgt") exitWith {systemChat "SYSTEM: TARGET NOT FOUND";};
_bomb_speed = 140;


while {alive _bomb} do
{
	if (isNull _tgt) exitWith {systemChat "SYSTEM: TARGET LOST";};
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
