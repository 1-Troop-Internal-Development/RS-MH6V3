/*
	Original leaflet function made by Karel Moricky
    Modify by Firewill
*/

private _array = _this select 0;
private _obj = _array select 0;
private _weapon = _array select 1;
private _ammoname = _array select 4;
private _magname = _array select 5;
private _projectile = _array select 6;

if (!local _obj) exitwith{};

sleep 2;

private _pos = getpos _projectile;
deleteVehicle _projectile;

_leaflets = objnull;
_leafletsParams = "FIR_Leaflets" call bis_fnc_getCloudletParams;

private _leafletClass = gettext (configfile >> "CfgMagazines" >> _magname >> "leafletClass");
private _leafletScript = gettext (configfile >> "CfgLeaflets" >> ("script" + _leafletClass));
(_leafletsParams select 0) set [17,_leafletScript];

private _cfg = [["CfgLeaflets",_leafletClass],configfile >> "CfgLeaflets" >> "Default"] call bis_fnc_loadClass;
if (istext (_cfg >> "model")) then {(_leafletsParams select 0 select 0) set [0,gettext (_cfg >> "model")];};

_leaflets = "#particlesource" createVehicle _pos;
_leaflets setParticleClass "FIR_Leaflets";			
_leaflets setParticleParams (_leafletsParams select 0);
_leaflets setParticleRandom (_leafletsParams select 1);
_leaflets setDropInterval (_leafletsParams select 2);

sleep 3;

deletevehicle _leaflets;
	

	