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

private _DUAL = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_DUAL");
private _gps_mssl = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_GPS_Mssl_Guide");
private _cg = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_CG");
private _cg_only = getText (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_CG_ONLY");
private _target = "";
private _lock = false;
private _guide_mode = "";

private _gps_array = _plane getVariable ["AWS_ITGT_GPS_ARRAY",0];

if (_gps_array isEqualTo 0) exitWith {systemChat "CAUTION : I-TGT NOT INITIALIZED.";};

for "_i" from 0 to (count _gps_array)-1 do
{
	private _pylon_code = ((_gps_array select _i)select 0);
	private _pylon_num = ((_gps_array select _i) select 1);
	private _pylon_ammo_count = ((_gps_array select _i) select 2);
	private _wep_name = ((_gps_array select _i) select 3);
	private _tgt_id = ((_gps_array select _i) select 4);
	private _islock = ((_gps_array select _i) select 5);
	private _gmode = ((_gps_array select _i) select 6);

	private _current_ammo = _plane ammoOnPylon _pylon_num;

	if (_pylon_ammo_count != _current_ammo) exitWith
	{
		_gps_array set [_i,[_pylon_code,_pylon_num,_current_ammo,_wep_name,_tgt_id,_islock,_gmode]];
		_target = _tgt_id;
		_lock = _islock;
		_guide_mode = _gmode;
	};
};

_plane setVariable ["AWS_ITGT_GPS_ARRAY",_gps_array,true];

if (_mode != "Cruise") exitWith {systemChat "CAUTION : GPS MODE NOT SELECTED. WEAPON GUIDANCE WILL BE DISABLE OR TURN TO OWN GUIDANCE.";};
if ((not _lock or _target isEqualTo "") and _guide_mode != "CG") exitWith {systemChat "CAUTION : GPS DATA NOT FOUND. WEAPON GUIDANCE WILL BE DISABLE."};

systemChat "SYSTEM : GPS MODE ACTIVATED.";

if (_gps_mssl == 1) then
{
	_gps_guide = [_projectile,_plane,_ammoname,_gunner,_target,_guide_mode] execVM "\FIR_AirWeaponSystem_US\script\TGTSystem\GUIDE\Guide_GPS_MSSL.sqf";
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
