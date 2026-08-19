/*New Fire Control System by Firewill */

private _array = _this select 0;
private _plane = _array select 0;
private _weapon = _array select 1;
private _ammoname = _array select 4;
private _magname = _array select 5;
private _projectile = _array select 6;
private _gunner = _array select 7;

private _agm65b = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AGM65B_Guide");

if (_agm65b == 1) then
{
	_tv_guide = [_projectile,_plane] execVM "\FIR_AirWeaponSystem_US\script\TGTSystem\GUIDE\Guide_AGM65B.sqf";
};

