/*New Fire Control System by Firewill */

private _array = _this select 0;
private _plane = _array select 0;
private _weapon = _array select 1;
private _ammoname = _array select 4;
private _magname = _array select 5;
private _projectile = _array select 6;
private _gunner = _array select 7;

private _WP = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_WP");
private _WP_Airburst = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_WP_Airburst");
private _RP_Airburst = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_RP_Airburst");


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
