private _missile = _this select 0;
private _plane = _this select 1;
private _ammoname = _this select 2;
private _end_target = _this select 3;
private _des_target = _this select 4;
private _pilot = driver _plane;

private _alt = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_ASM_SK_ALT");

private _spd_ary = getArray (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_ASM_SPEED");
private _initial_speed = _spd_ary select 2;

//400;
_missile_speed = _initial_speed;


while {alive _missile} do
{
	_eta = (_end_target distance _missile) / _missile_speed;
	
	if (_end_target distance _missile <= 100) exitWith {[_missile,_plane,_ammoname,_des_target] execVM "FIR_AirWeaponSystem_US\Script\TGTSystem\Guide\Guide_ASM_popup_mid.sqf";}; 		
	
	_tgt_dir = [_missile, _end_target] call BIS_fnc_DirTo;
	_missile setDir _tgt_dir;

	_tgt_pitch = asin ((((getPosASL _missile) select 2) - ((getPosASL _end_target) select 2)) / (_end_target distance _missile));
	_tgt_pitch = (_tgt_pitch * -1);
	[_missile, _tgt_pitch, 0] call BIS_fnc_setPitchBank;
	
	_Missile_velocityX = (((getPosASL _end_target) select 0) - ((getPosASL _missile) select 0)) / _eta;
	_Missile_velocityY = (((getPosASL _end_target) select 1) - ((getPosASL _missile) select 1)) / _eta;
	_Missile_velocityZ = (((getPosASL _end_target) select 2) - ((getPosASL _missile) select 2)) / _eta;	

	_missile setVelocity [_Missile_velocityX,_Missile_velocityY,_Missile_velocityZ];

	sleep 0.03;	
};

deletevehicle _end_target;
