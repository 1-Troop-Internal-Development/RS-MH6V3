/*New Fire Control System by Firewill */

private _array = _this select 0;
private _weapon = _array select 1;
private _ammoname = _array select 4;
private _magname = _array select 5;
private _projectile = _array select 6;
private _gunner = _array select 7;

private _plane = _array select 0;

if (_weapon == "FIR_CMLauncher") exitWith {};

_missobj = nearestobject[_plane, _ammoname];

private _gps_bomb = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_GPS_Bomb_Guide");
private _DUAL = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_DUAL");
private _gps_mssl = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_GPS_Mssl_Guide");
private _tv_mssl = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_TV_Mssl_Guide");
private _tv_bomb = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_TV_Bomb_Guide");
private _agm65b = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AGM65B_Guide");
private _cg = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_CG");
private _cg_only = getText (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_CG_ONLY");
private _crater = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_Crater");
private _SFW = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_SFW");
private _ARPB = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_ARPB");
private _FAEB = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_FAEB");
private _BS = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_BS");
private _WP = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_WP");
private _WP_Airburst = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_WP_Airburst");
private _RP_Airburst = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_RP_Airburst");
private _TARPS = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_TARPS");
private _SARH = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_SARH");
private _AB = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_Proxfuze");


//temporary disabled due to shake in Dedi //
// if (_weapon == "FIR_M61A2" or _weapon == "FIR_GAU8") then
// {
	// _gunshake = [_weapon] execVM "\FIR_AirWeaponSystem_US\script\function\AWS_GunShake.sqf";
// };

if (_gps_bomb == 1) then
{
	_jdam_guide = [_projectile,_plane,_ammoname,_gunner] execVM "\FIR_AirWeaponSystem_US\script\TGTSystem\GUIDE\Guide_JDAM.sqf";
};

if (_gps_mssl == 1) then
{
	_gps_guide = [_projectile,_plane,_ammoname,_gunner] execVM "\FIR_AirWeaponSystem_US\script\TGTSystem\GUIDE\Guide_GPS_MSSL.sqf";
};

if (_cg == 1) then
{
	if (_cg_only == "no") then
	{
		_cg_guide = [_projectile,_plane,_ammoname,_gunner] execVM "\FIR_AirWeaponSystem_US\script\TGTSystem\CG\cg_start.sqf";	
	}
	else 
	{
		_cg_guide = [_projectile,_plane,_ammoname,_gunner] execVM "\FIR_AirWeaponSystem_US\script\TGTSystem\CG\cg_start_only.sqf";		
	};
};

if (_tv_bomb == 1) then
{
	_tv_guide = [_projectile,_plane] execVM "\FIR_AirWeaponSystem_US\script\TGTSystem\GUIDE\Guide_TV_Bomb.sqf";
};

if (_tv_mssl == 1) then
{
	_tv_guide = [_projectile,_plane] execVM "\FIR_AirWeaponSystem_US\script\TGTSystem\GUIDE\Guide_TV_MSSL.sqf";
};

if (_agm65b == 1) then
{
	_tv_guide = [_projectile,_plane] execVM "\FIR_AirWeaponSystem_US\script\TGTSystem\GUIDE\Guide_AGM65B.sqf";
};

if (_TARPS == 1) then
{
	_TARPS = execVM "\FIR_AirWeaponSystem_US\script\WEP\TARPS.sqf";
};

if (_SFW == 1) then
{
		_firecbu97 = [_projectile] execVM "\FIR_AirWeaponSystem_US\script\WEP\SFW.sqf";
};

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

if (_ARPB == 1) then
{
		_fireblu107 = [_projectile] execVM "\FIR_AirWeaponSystem_US\script\WEP\BLU107.sqf";
};

if (_WP == 1) then
{
	_wp_effect = [_projectile] execVM "\FIR_AirWeaponSystem_US\script\WEP\WP_Hit.sqf";
};

if (_WP_Airburst == 1) then
{
	_wp_effect = [_projectile] execVM "\FIR_AirWeaponSystem_US\script\WEP\WP_Airburst.sqf";
};

if (_RP_Airburst == 1) then
{
	_wp_effect = [_projectile] execVM "\FIR_AirWeaponSystem_US\script\WEP\RP_Airburst.sqf";
};

// if (_SARH == 1) then
// {
	// _SARH = [_projectile,_plane] execVM "\FIR_AirWeaponSystem_US\script\TGTSystem\GUIDE\Guide_SARH.sqf";
// };

switch (_crater) do
{  
	case 1:
    {
		_crater_500lb = [_projectile,"500lb"] execVM "\FIR_AirWeaponSystem_US\script\WEP\crater.sqf";
    };
	case 2:
    {
		_crater_1000lb = [_projectile,"1000lb"] execVM "\FIR_AirWeaponSystem_US\script\WEP\crater.sqf";
    };
	case 3:
    {
		_crater_2000lb = [_projectile,"2000lb"] execVM "\FIR_AirWeaponSystem_US\script\WEP\crater.sqf";
    };
	default{};
};

