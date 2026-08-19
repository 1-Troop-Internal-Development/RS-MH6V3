_missile = _this select 0;
_plane = _this select 1;
_ammoname = _this select 2;
_WhoShot = _this select 3;
_target = _this select 4;
_mode = _this select 5;

if (_mode != "GPS" and _mode != "DUAL" and _mode != "CGT") exitWith {systemChat "CAUTION : GPS DATA NOT FOUND"};

_pilot = driver _plane;

_tgt_array = _plane getVariable "AWS_ITGT_GPS_TGTLIST";
_tgt_path = [_tgt_array,_target] call BIS_fnc_findNestedElement;


// _tgt_pos = _plane getvariable ["ITGT_C_DATA",""];
// _check = _plane getvariable ["ITGT_NEW","no"];
_DUAL = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_DUAL");
_CG = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_CG");

_tgt_selected_path = _tgt_path select 0;
_tgt_pos = ((_tgt_array select _tgt_selected_path)select 2);

// _dual_check = _plane getvariable ["ITGT_TYPE","GPS"];
// if (_check == "no") ExitWith {systemChat "CAUTION : GPS DATA NOT FOUND";};

_faketarget = "Land_HelipadEmpty_F" createVehicleLocal _tgt_pos;	
_missile_speed = (speed _missile) * 0.6;

// waitUntil {_faketarget distance _missile <= 2500};
systemChat "SYSTEM : TARGET ACQUIRED";

while {alive _missile} do
{
	_eta = (_faketarget distance _missile) / _missile_speed;

	if ((_faketarget distance _missile <= 1000) and (_mode == "DUAL") and (_DUAL == 1)) exitWith {[_plane,_missile,_ammoname] execVM "FIR_AirWeaponSystem_US\Script\TGTSystem\Guide\Guide_DualMode_MSSL.sqf";}; 	
	if ((_faketarget distance _missile <= 6000) and (_mode == "CGT") and (_CG == 1)) exitWith {[_missile,_plane,_ammoname,_WhoShot] execVM "FIR_AirWeaponSystem_US\Script\TGTSystem\CG\cgt.sqf";}; 	
	
	_tgt_dir = [_missile, _faketarget] call BIS_fnc_DirTo;
	_missile setDir _tgt_dir;

	_tgt_pitch = asin ((((getPosASL _missile) select 2) - ((getPosASL _faketarget) select 2)) / (_faketarget distance _missile));
	_tgt_pitch = (_tgt_pitch * -1);
	[_missile, _tgt_pitch, 0] call BIS_fnc_setPitchBank;
	
	if (_faketarget distance _missile >= 300) then
	{
		_Missile_velocityX = (((getPosASL _faketarget) select 0) - ((getPosASL _missile) select 0)) / _eta;
		_Missile_velocityY = (((getPosASL _faketarget) select 1) - ((getPosASL _missile) select 1)) / _eta;
		_Missile_velocityZ = ((((getPosASL _faketarget) select 2) + 100) - ((getPosASL _missile) select 2)) / _eta;	

		_missile setVelocity [_Missile_velocityX,_Missile_velocityY,_Missile_velocityZ];
	}
	else
	{
		_Missile_velocityX = (((getPosASL _faketarget) select 0) - ((getPosASL _missile) select 0)) / _eta;
		_Missile_velocityY = (((getPosASL _faketarget) select 1) - ((getPosASL _missile) select 1)) / _eta;
		_Missile_velocityZ = (((getPosASL _faketarget) select 2) - ((getPosASL _missile) select 2)) / _eta;	

		_missile setVelocity [_Missile_velocityX,_Missile_velocityY,_Missile_velocityZ];	
	};

	sleep 0.03;	
};

deletevehicle _faketarget;

