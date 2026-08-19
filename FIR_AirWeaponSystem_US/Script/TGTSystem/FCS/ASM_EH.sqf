/*New Fire Control System by Firewill */
// for Anti-Ship Missile
// using vanilla flight modes, Cruise = sea-skimming , Top-down = sea-skimming and pop-up

private _array = _this select 0;
private _plane = _array select 0;
private _weapon = _array select 1;
private _muzzle = _array select 2;
private _mode = _array select 3;
private _ammoname = _array select 4;
private _magname = _array select 5;
private _projectile = _array select 6;
private _gunner = _array select 7;

private _pilot = driver _plane;
private _side = side _plane;

[_projectile,_ammoname,_side,_gunner,_plane] execVM "FIR_AirWeaponSystem_US\Script\TGTSystem\Guide\ASM_target_attach.sqf";

_getshotParent = getShotParents _projectile;
_shooter = _getshotParent select 1;

if (_shooter != player) exitWith {};

private _tgt = cursorTarget;

// if (_tgt isEqualTo objNull) exitWith {systemChat "SYSTEM : MSSL FIRED WITH NO TARGET";};

switch (_mode) do
{
    case "Cruise":
    {	
		_plane vehiclechat "SYSTEM : SEA-SKIMMING MODE";
		[_projectile,_plane,_ammoname,_tgt] execVM "FIR_AirWeaponSystem_US\Script\TGTSystem\Guide\Guide_ASM_SeaSkim.sqf";

    };
    case "TopDown":
    {
		_plane vehiclechat "SYSTEM : SEA-SKIMMING AND POP-UP MODE";
		[_projectile,_plane,_ammoname,_tgt] execVM "FIR_AirWeaponSystem_US\Script\TGTSystem\Guide\Guide_ASM_Popup.sqf";		
    };
    default
    {
		_plane vehiclechat "SYSTEM : DIRECT MODE";
		[_projectile,_plane,_ammoname,_tgt] execVM "FIR_AirWeaponSystem_US\Script\TGTSystem\Guide\Guide_ASM_Direct.sqf";				
    };
};
