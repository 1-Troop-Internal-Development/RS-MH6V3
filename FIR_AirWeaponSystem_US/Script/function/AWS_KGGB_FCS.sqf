/*
	Original leaflet function made by Karel Moricky
    Modify by Firewill
*/


private _array = _this select 0;
private _plane = _array select 0;
private _weapon = _array select 1;
private _mode = _array select 3;
private _ammoname = _array select 4;
private _magname = _array select 5;
private _projectile = _array select 6;
private _gunner = _array select 7;

if (_mode != "Overfly") exitWith {systemChat "CAUTION : KGGB MODE NOT SELECTED. WEAPON GUIDANCE WILL BE DISABLE OR TURN TO OWN GUIDANCE.";};

_jdam_guide = [_projectile,_plane] execVM "\FIR_AirWeaponSystem_US\script\TGTSystem\Guide\Guide_KGGB.sqf";