private _missile = _this select 0;
private _decoy = _this select 1;
private _gunner = _this select 2;
private _plane = _this select 3;

_efc = effectiveCommander _plane;
if (_efc == _gunner) then
{
	_gunner addRating 2001;
}
else
{
	_efc addRating 2001;
};

waitUntil 
{
	if (not alive _missile or not alive _decoy) exitWith {true};false;
}; 

detach _decoy;

{_decoy deleteVehicleCrew _x} forEach crew _decoy;
deleteVehicle _decoy;

if (not(_missile isEqualTo objNull)) then
{
	deleteVehicle _missile;
};

