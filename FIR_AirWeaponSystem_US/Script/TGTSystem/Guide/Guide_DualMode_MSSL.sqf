private ["_missile","_plane","_pilot","_tgt_pos","_check","_faketarget","_missile_speed","_eta","_tgt_dir","_tgt_pitch","_tgt_pos","_missile_velocityX","_missile_velocityY","_missile_velocityZ","_target_list","_tgt"];

_plane = _this select 0;
_missile = _this select 1;
_ammoname = _this select 2;
_pilot = driver _plane;

systemChat "SYSTEM: DUAL MODE ACTIVATED";

_missile_speed = (speed _missile) * 0.6;
_DUAL_Type = getText (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_DUAL_Type");


if (_DUAL_Type == "Laser") then
{
	_target_list = _missile nearEntities ["LaserTarget", 1800];
	_tgt = _target_list select 0;
};

if (_DUAL_Type == "IR" or _DUAL_Type == "Vis") then
{
	_target_list = _missile nearEntities [["Car", "Motorcycle", "Tank"], 1800];
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


while {alive _missile} do
{
	if (isNull _tgt) exitWith {systemChat "SYSTEM: TARGET LOST";};
	_eta = (_tgt distance _missile) / _missile_speed;
	
	_tgt_dir = [_missile, _tgt] call BIS_fnc_DirTo;
	_missile setDir _tgt_dir;

	_tgt_pitch = asin ((((getPosASL _missile) select 2) - ((getPosASL _tgt) select 2)) / (_tgt distance _missile));
	_tgt_pitch = (_tgt_pitch * -1);
	[_missile, _tgt_pitch, 0] call BIS_fnc_setPitchBank;

	_missile_velocityX = (((getPosASL _tgt) select 0) - ((getPosASL _missile) select 0)) / _eta;
	_missile_velocityY = (((getPosASL _tgt) select 1) - ((getPosASL _missile) select 1)) / _eta;
	_missile_velocityZ = (((getPosASL _tgt) select 2) - ((getPosASL _missile) select 2)) / _eta;
	
	_missile setVelocity [_missile_velocityX,_missile_velocityY,_missile_velocityZ];

	sleep 0.03;	
};
