private ["_bomb","_plane","_pilot","_tgt_wp","_check","_faketarget","_bomb_speed","_eta","_tgt_dir","_tgt_pitch","_tgt_pos","_bomb_velocityX","_bomb_velocityY","_bomb_velocityZ"];

_bomb = _this select 0;
_plane = _this select 1;
_pilot = driver _plane;

_tgt_wp = customWaypointPosition;

if (_tgt_wp isEqualTo []) ExitWith {systemChat "CAUTION : WAYPOINT NOT FOUND";};
if not(("ItemGPS" in (AssignedItems _pilot)) or ("FIR_PDU" in (AssignedItems _pilot))) exitWith {systemChat "CAUTION : GPS,PDU NOT EQUIPPED";};

_faketarget = "Land_HelipadEmpty_F" createVehicleLocal _tgt_wp;	

sleep 5;
_bomb_speed = 140;

while {alive _bomb} do
{
	_eta = (_faketarget distance _bomb) / _bomb_speed;
	
	_tgt_dir = [_bomb, _faketarget] call BIS_fnc_DirTo;
	_bomb setDir _tgt_dir;

	_tgt_pitch = asin ((((getPosASL _bomb) select 2) - ((getPosASL _faketarget) select 2)) / (_faketarget distance _bomb));
	_tgt_pitch = (_tgt_pitch * -1);
	[_bomb, _tgt_pitch, 0] call BIS_fnc_setPitchBank;

	_bomb_velocityX = (((getPosASL _faketarget) select 0) - ((getPosASL _bomb) select 0)) / _eta;
	_bomb_velocityY = (((getPosASL _faketarget) select 1) - ((getPosASL _bomb) select 1)) / _eta;
	_bomb_velocityZ = (((getPosASL _faketarget) select 2) - ((getPosASL _bomb) select 2)) / _eta;
	
	_bomb setVelocity [_bomb_velocityX,_bomb_velocityY,_bomb_velocityZ];

	sleep 0.03;	
};

deletevehicle _faketarget;
