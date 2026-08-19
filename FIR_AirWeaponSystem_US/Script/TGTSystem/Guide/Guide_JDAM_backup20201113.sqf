private ["_bomb","_plane","_pilot","_tgt_pos","_check","_faketarget","_bomb_speed","_eta","_tgt_dir","_tgt_pitch","_tgt_pos","_bomb_velocityX","_bomb_velocityY","_bomb_velocityZ"];

_bomb = _this select 0;
_plane = _this select 1;
_ammoname = _this select 2;
_WhoShot = _this select 3;
_pilot = driver _plane;

_tgt_pos = _plane getvariable ["ITGT_C_DATA",""];
_check = _plane getvariable ["ITGT_NEW","no"];

_dual_check = _plane getvariable ["ITGT_TYPE","GPS"];
_DUAL = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_DUAL");
_CG = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_CG");

if (_check == "no") ExitWith {systemChat "CAUTION : GPS DATA NOT FOUND";};

_faketarget = "Land_HelipadEmpty_F" createVehicleLocal _tgt_pos;	

sleep 5;
_bomb_speed = 140;

while {alive _bomb} do
{
	_eta = (_faketarget distance _bomb) / _bomb_speed;
	
	if ((_faketarget distance _bomb <= 500) and (_dual_check == "DUAL") and (_DUAL == 1)) exitWith {[_plane,_bomb,_ammoname] execVM "FIR_AirWeaponSystem_US\Script\TGTSystem\Guide\Guide_DualMode.sqf";}; 
	if ((_faketarget distance _bomb <= 5000) and (_dual_check == "CGT") and (_CG == 1)) exitWith {[_bomb,_plane,_ammoname,_WhoShot] execVM "FIR_AirWeaponSystem_US\Script\TGTSystem\CG\cgt.sqf";}; 		
	
	_tgt_dir = [_bomb, _faketarget] call BIS_fnc_DirTo;
	_bomb setDir _tgt_dir;

	_tgt_pitch = asin ((((getPosASL _bomb) select 2) - ((getPosASL _faketarget) select 2)) / (_faketarget distance _bomb));
	_tgt_pitch = (_tgt_pitch * -1);
	[_bomb, _tgt_pitch, 0] call BIS_fnc_setPitchBank;


	if (_faketarget distance _bomb >= 300) then
	{
		_bomb_velocityX = (((getPosASL _faketarget) select 0) - ((getPosASL _bomb) select 0)) / _eta;
		_bomb_velocityY = (((getPosASL _faketarget) select 1) - ((getPosASL _bomb) select 1)) / _eta;
		_bomb_velocityZ = ((((getPosASL _faketarget) select 2) + 100) - ((getPosASL _bomb) select 2)) / _eta;	

		_bomb setVelocity [_bomb_velocityX,_bomb_velocityY,_bomb_velocityZ];
	}
	else
	{
		_bomb_velocityX = (((getPosASL _faketarget) select 0) - ((getPosASL _bomb) select 0)) / _eta;
		_bomb_velocityY = (((getPosASL _faketarget) select 1) - ((getPosASL _bomb) select 1)) / _eta;
		_bomb_velocityZ = (((getPosASL _faketarget) select 2) - ((getPosASL _bomb) select 2)) / _eta;	

		_bomb setVelocity [_bomb_velocityX,_bomb_velocityY,_bomb_velocityZ];	
	};	
	

	sleep 0.03;	
};

deletevehicle _faketarget;
