/*New Fire Control System by Firewill */

private _array = _this select 0;
private _plane = _array select 0;
private _weapon = _array select 1;
private _ammoname = _array select 4;
private _magname = _array select 5;
private _projectile = _array select 6;
private _gunner = _array select 7;

private _gps_bomb = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_GPS_Bomb_Guide");
private _SFW = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_SFW");


// if (_gps_bomb == 1) then
// {
	// _jdam_guide = [_projectile,_plane,_ammoname,_gunner] execVM "\FIR_AirWeaponSystem_US\script\TGTSystem\GUIDE\Guide_JDAM.sqf";
// };

if (_SFW == 1) then
{
	_firecbu97 = [_projectile] execVM "\FIR_AirWeaponSystem_US\script\WEP\SFW.sqf";
};
