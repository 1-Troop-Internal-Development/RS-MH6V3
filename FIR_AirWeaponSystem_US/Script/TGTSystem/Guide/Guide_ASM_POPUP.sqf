private _missile = _this select 0;
private _plane = _this select 1;
private _ammoname = _this select 2;
private _des_target = _this select 3;
private _pilot = driver _plane;

if (_des_target isEqualTo objNull) exitWith {		_plane vehiclechat "SYSTEM : MSSL FIRED WITH NO TARGET";};

private _start_dis = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_ASM_SK_START_DIS");
private _end_dis = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_ASM_SK_END_DIS");
private _alt = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_ASM_SK_ALT");

private _asm_dir = getdir _missile;
private _reldir = _des_target getRelDir _missile;
private _start_pos = _plane getRelPos [_start_dis, _asm_dir];
private _end_pos = _plane getRelPos [_end_dis, _asm_dir];
private _start_target = "Land_HelipadEmpty_F" createVehicleLocal _start_pos;	
private _end_target = "Land_HelipadEmpty_F" createVehicleLocal _end_pos;	

_start_target setposASL [(getposASL _start_target select 0),(getposASL _start_target select 1),(getposASL _plane select 2)];
_end_target setPosASL [(getPosASL _end_target select 0),(getposASL _end_target select 1),_alt];

private _spd_ary = getArray (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_ASM_SPEED");
private _initial_speed = _spd_ary select 0;

//400;
_missile_speed = _initial_speed;

while {alive _missile} do
{
	_eta = (_start_target distance _missile) / _missile_speed;
	
	if (_start_target distance _missile <= 5) exitWith {[_missile,_plane,_ammoname,_end_target,_des_target] execVM "FIR_AirWeaponSystem_US\Script\TGTSystem\Guide\Guide_ASM_Popup_down.sqf";}; 		
	
	_tgt_dir = [_missile, _start_target] call BIS_fnc_DirTo;
	_missile setDir _tgt_dir;

	_tgt_pitch = asin ((((getPosASL _missile) select 2) - ((getPosASL _start_target) select 2)) / (_start_target distance _missile));
	_tgt_pitch = (_tgt_pitch * -1);
	[_missile, _tgt_pitch, 0] call BIS_fnc_setPitchBank;
	
	_Missile_velocityX = (((getPosASL _start_target) select 0) - ((getPosASL _missile) select 0)) / _eta;
	_Missile_velocityY = (((getPosASL _start_target) select 1) - ((getPosASL _missile) select 1)) / _eta;
	_Missile_velocityZ = (((getPosASL _start_target) select 2) - ((getPosASL _missile) select 2)) / _eta;	

	_missile setVelocity [_Missile_velocityX,_Missile_velocityY,_Missile_velocityZ];

	sleep 0.03;	
};

deletevehicle _start_target;
