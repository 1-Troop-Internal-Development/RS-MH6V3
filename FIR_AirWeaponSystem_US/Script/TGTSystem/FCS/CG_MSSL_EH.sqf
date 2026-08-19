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
private _preGPS = 0;
_preGPS = getNumber (Configfile >> "CfgVehicles" >> typeOf _plane >> "FIR_PreGPS_Bird");
private _target = "";
private _lock = false;
private _guide_mode = "";

if (_preGPS isEqualTo 0) exitWith {};
if (_mode != "Cruise") exitWith {systemChat "CAUTION : CG MODE IS NOT SELECTED. WEAPON GUIDANCE WILL BE DISABLE OR TURN TO OWN GUIDANCE.";};

if (_cg == 1) then
{
	if (_cg_only == "no") then
	{
		_cg_guide = [_projectile,_plane,_ammoname,_gunner,"CG"] execVM "\FIR_AirWeaponSystem_US\script\TGTSystem\CG\cg_start.sqf";	
	}
	else 
	{
		_cg_guide = [_projectile,_plane,_ammoname,_gunner] execVM "\FIR_AirWeaponSystem_US\script\TGTSystem\CG\cg_start_only.sqf";		
	};
};
