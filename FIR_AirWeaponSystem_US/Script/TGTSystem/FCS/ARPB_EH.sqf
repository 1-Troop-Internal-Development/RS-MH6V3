/*New Fire Control System by Firewill */

private _array = _this select 0;
private _plane = _array select 0;
private _weapon = _array select 1;
private _ammoname = _array select 4;
private _magname = _array select 5;
private _projectile = _array select 6;
private _gunner = _array select 7;


private _ARPB = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_ARPB");

if (_ARPB == 1) then
{
		_fireblu107 = [_projectile] execVM "\FIR_AirWeaponSystem_US\script\WEP\BLU107.sqf";
};

