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

	// switch (_crater) do
	// {  
	// case 1:
	// {
		// _crater_500lb = [_projectile,"500lb"] execVM "\FIR_AirWeaponSystem_US\script\WEP\crater.sqf";
	// };
	// case 2:
	// {
		// _crater_1000lb = [_projectile,"1000lb"] execVM "\FIR_AirWeaponSystem_US\script\WEP\crater.sqf";
	// };
	// case 3:
	// {
		// _crater_2000lb = [_projectile,"2000lb"] execVM "\FIR_AirWeaponSystem_US\script\WEP\crater.sqf";
	// };
	// default{};
	// };	






if (_mode != "Cruise") exitWith {systemChat "CAUTION : I-TGT MODE NOT SELECTED. WEAPON GUIDANCE WILL BE DISABLE OR TURN TO OWN GUIDANCE.";};


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


