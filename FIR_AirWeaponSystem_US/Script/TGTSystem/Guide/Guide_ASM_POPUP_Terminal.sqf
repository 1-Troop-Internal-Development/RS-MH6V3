private _missile = _this select 0;
private _plane = _this select 1;
private _ammoname = _this select 2;
private _des_target = _this select 3;
private _pilot = driver _plane;

private _alt = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_ASM_SK_ALT");
private _popup_alt = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_ASM_POPUP_ALT");

private _dis = _des_target distance _missile;
_dis = _dis / 2;

private _spd_ary = getArray (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_ASM_SPEED");
private _initial_speed = _spd_ary select 0;

//400;
_missile_speed = _initial_speed;

while {alive _missile} do
{
	_eta = (_des_target distance _missile) / _missile_speed;

	_tgt_dir = [_missile, _des_target] call BIS_fnc_DirTo;
	_missile setDir _tgt_dir;

//pop-up climb and down
	if (_des_target distance _missile >= _dis) then
	{
		_tgt_pitch = asin (((getPosASL _missile select 2) - ((getPosASL _des_target select 2) + _popup_alt)) / (_des_target distance _missile));
		_tgt_pitch = (_tgt_pitch * -1);
		[_missile, _tgt_pitch, 0] call BIS_fnc_setPitchBank;
		
	
		_Missile_velocityX = (((getPosASL _des_target) select 0) - ((getPosASL _missile) select 0)) / _eta;
		_Missile_velocityY = (((getPosASL _des_target) select 1) - ((getPosASL _missile) select 1)) / _eta;
		_Missile_velocityZ = ((((getPosASL _des_target) select 2) + _popup_alt) - ((getPosASL _missile) select 2)) / _eta;	

		_missile setVelocity [_Missile_velocityX,_Missile_velocityY,_Missile_velocityZ];
	}
	else
	{
		_tgt_pitch = asin ((((getPosASL _missile) select 2) - ((getPosASL _des_target) select 2)) / (_des_target distance _missile));
		_tgt_pitch = (_tgt_pitch * -1);
		[_missile, _tgt_pitch, 0] call BIS_fnc_setPitchBank;
	
		_Missile_velocityX = (((getPosASL _des_target) select 0) - ((getPosASL _missile) select 0)) / _eta;
		_Missile_velocityY = (((getPosASL _des_target) select 1) - ((getPosASL _missile) select 1)) / _eta;
		_Missile_velocityZ = (((getPosASL _des_target) select 2) - ((getPosASL _missile) select 2)) / _eta;	

		_missile setVelocity [_Missile_velocityX,_Missile_velocityY,_Missile_velocityZ];	
	};	
	
	sleep 0.03;	
};
