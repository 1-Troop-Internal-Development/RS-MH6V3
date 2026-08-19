private _bomb = _this select 0;
private _plane = _this select 1;
private _ammoname = _this select 2;
private _WhoShot = _this select 3;
private _target = _this select 4;
private _mode = _this select 5;

if (_mode != "GPS" and _mode != "DUAL" and _mode != "CGT") exitWith {systemChat "CAUTION : GPS DATA NOT FOUND"};

private _pilot = driver _plane;

_tgt_array = _plane getVariable "AWS_ITGT_GPS_TGTLIST";
_tgt_path = [_tgt_array,_target] call BIS_fnc_findNestedElement;

_tgt_selected_path = _tgt_path select 0;
_tgt_pos = ((_tgt_array select _tgt_selected_path)select 2);

_DUAL = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_DUAL");
_CG = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_CG");

_faketarget = "Land_HelipadEmpty_F" createVehicleLocal _tgt_pos;	

sleep 5;
_bomb_speed = 140;
systemChat "SYSTEM : TARGET ACQUIRED";

while {alive _bomb} do
{
	_eta = (_faketarget distance _bomb) / _bomb_speed;
	
	if ((_faketarget distance _bomb <= 500) and (_mode == "DUAL") and (_DUAL == 1)) exitWith {[_plane,_bomb,_ammoname] execVM "FIR_AirWeaponSystem_US\Script\TGTSystem\Guide\Guide_DualMode.sqf";}; 
	if ((_faketarget distance _bomb <= 5000) and (_mode == "CGT") and (_CG == 1)) exitWith {[_bomb,_plane,_ammoname,_WhoShot] execVM "FIR_AirWeaponSystem_US\Script\TGTSystem\CG\cgt.sqf";}; 		
	
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
