/*New Fire Control System by Firewill */

private _array = _this select 0;
private _plane = _array select 0;
private _weapon = _array select 1;
private _mode = _array select 3;
private _ammoname = _array select 4;
private _magname = _array select 5;
private _projectile = _array select 6;
private _gunner = _array select 7;
private _pylon = 0;

private _gps_bomb = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_GPS_Bomb_Guide");
private _crater = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_Crater");
private _cg = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_CG");
private _cg_only = getText (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_CG_ONLY");
private _BS = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_BS");
private _AB = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_Proxfuze");
private _FAEB = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_FAEB");
private _target = "";
private _lock = false;
private _guide_mode = "";

if (_FAEB == 1) then
{
	_firecbu97 = [_projectile] execVM "\FIR_AirWeaponSystem_US\script\WEP\BLU118.sqf";
};

if (_AB == 1) then
{
	_fireab = [_projectile,_ammoname] execVM "\FIR_AirWeaponSystem_US\script\WEP\bomb_airburst.sqf";
};

if (_BS == 1) then
{
	_firecbu97 = [_projectile] execVM "\FIR_AirWeaponSystem_US\script\WEP\BLU109.sqf";
};

private _gps_array = _plane getVariable ["AWS_ITGT_GPS_ARRAY",0];
private _keylist = keys _gps_array;

if (_gps_array isEqualTo 0) exitWith {_plane vehicleChat "CAUTION : I-TGT NOT INITIALIZED.";};

for "_i" from 0 to (count _gps_array)-1 do
{
	
	private _pylon_code = _keylist select _i;
	private _pylon_data = _gps_array get _pylon_code;

	private _pylon_ammo_count = _pylon_data select 0;
	private _wep_name = _pylon_data select 1;
	private _tgt_id = _pylon_data select 2;
	private _islock = _pylon_data select 3;
	private _gmode = _pylon_data select 4;
	private _pylon_num = _pylon_data select 5;

	private _current_ammo = _plane ammoOnPylon _pylon_num;

	if (_pylon_ammo_count != _current_ammo) exitWith
	{
		_gps_array set [_pylon_code,[_current_ammo,_wep_name,_tgt_id,_islock,_gmode,_pylon_num]];
		_target = _tgt_id;
		_lock = _islock;
		_guide_mode = _gmode;
	};
};

_plane setVariable ["AWS_ITGT_GPS_ARRAY",_gps_array,true];

if (_mode != "Cruise") exitWith {_plane vehicleChat "CAUTION : GPS MODE NOT SELECTED. WEAPON GUIDANCE WILL BE DISABLE OR TURN TO OWN GUIDANCE.";};
if (not _lock or _target isEqualTo "") exitWith {_plane vehicleChat "CAUTION : GPA DATA NOT FOUND. WEAPON GUIDANCE WILL BE DISABLE."};

_plane vehicleChat "SYSTEM : GPS MODE ACTIVATED.";

if (_gps_bomb == 1) then
{
	_jdam_guide = [_projectile,_plane,_ammoname,_gunner,_target,_guide_mode] execVM "\FIR_AirWeaponSystem_US\script\TGTSystem\GUIDE\Guide_JDAM.sqf";
};

if (_cg == 1) then
{
	if (_cg_only == "no") then
	{
		_cg_guide = [_projectile,_plane,_ammoname,_gunner,_guide_mode] execVM "\FIR_AirWeaponSystem_US\script\TGTSystem\CG\cg_start.sqf";	
	}
	else 
	{
		_cg_guide = [_projectile,_plane,_ammoname,_gunner] execVM "\FIR_AirWeaponSystem_US\script\TGTSystem\CG\cg_start_only.sqf";		
	};
};

