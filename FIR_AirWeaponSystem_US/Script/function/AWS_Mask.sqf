
private ["_pilot","_check","_goggles"];

_pilot = player;
If (not Local _pilot) ExitWith {};
_helmet = headgear _pilot;

_check_helmet = getNumber (configFile >> "CfgWeapons" >> _helmet >> "fir_mask");

if (_check_helmet == 1) then
{
	_get_helmet = getText (configFile >> "CfgWeapons" >> _helmet >> "fir_mask_toggle");
	removeHeadgear _pilot;
	_pilot addHeadgear _get_helmet;
};

