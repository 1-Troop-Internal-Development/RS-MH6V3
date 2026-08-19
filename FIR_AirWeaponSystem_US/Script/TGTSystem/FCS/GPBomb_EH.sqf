/*New Fire Control System by Firewill */

private _array = _this select 0;
private _plane = _array select 0;
private _weapon = _array select 1;
private _ammoname = _array select 4;
private _magname = _array select 5;
private _projectile = _array select 6;
private _gunner = _array select 7;

private _crater = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_Crater");
private _FAEB = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_FAEB");
private _BS = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_BS");
private _AB = getnumber (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_Proxfuze");

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

if (isNil "AWS_MakeCrater_Old") then 
{
	diag_log "No create old version crater.";
}
else
{
	diag_log "create old version crater.";
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
};



