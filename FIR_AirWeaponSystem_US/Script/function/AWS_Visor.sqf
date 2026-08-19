
private ["_pilot","_check","_goggles"];

_pilot = player;
If (not Local _pilot) ExitWith {};
_goggles = goggles _pilot;
_helmet = headgear _pilot;

_check_visor = getNumber (configFile >> "CfgGlasses" >> _goggles >> "fir_visor");
_check = getText (configFile >> "CfgGlasses" >> _goggles >> "fir_visor_reverse_code");

if (_check_visor == 1) then
{
	removeGoggles _pilot;

	_pilot addGoggles _check;
};

_check_helmet = getNumber (configFile >> "CfgWeapons" >> _helmet >> "fir_visor");

if (_check_helmet == 1) then
{
	_get_helmet = getText (configFile >> "CfgWeapons" >> _helmet >> "fir_visor_reverse_code");
	removeHeadgear _pilot;
	_pilot addHeadgear _get_helmet;
};

