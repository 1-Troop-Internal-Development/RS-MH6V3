//airburst type bomb
//by firewill

private _bomb = _this select 0;
private _ammoname = _this select 1;
private _bombzpos = getpos _bomb select 2;

private _airburst = getText (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_Proxfuze_bomb");


waitUntil {getpos _bomb select 2 < 16 };

private _bombpos = getpos _bomb;

deletevehicle _bomb;

private _sub = _airburst createvehicle _bombpos;
_sub setpos [(getpos _sub select 0),(getpos _sub select 1),12];
_sub setdamage 1;

