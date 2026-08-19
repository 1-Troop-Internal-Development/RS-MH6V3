/*Loadout Dialog By Firewill*/

private ["_plane"];

_plane = vehicle player;

If (not Local _plane) ExitWith {};
if (not(_plane iskindof "Plane")) ExitWith {player vehiclechat "You Must get in the Plane!";};
_handle= CreateDialog "FIR_HUD_Slider";
disableSerialization;
_mydisplay = findDisplay 9920;
// _myctrl = _mydisplay displayCtrl 2160;

sliderSetRange [1900, 0, 100];
sliderSetRange [1901, 0, 100];
sliderSetRange [1902, 0, 100];
sliderSetRange [1903, 0, 100];

_check = _plane getvariable ["AWS_HCS_CHECK","no"];

if (_check == "no") then
{
	_plane setVariable ["AWS_HCS_CHECK","yes",true];
	_plane setVariable ["AWS_HCS_RED",50,true];	
	_plane setVariable ["AWS_HCS_GREEN",50,true];	
	_plane setVariable ["AWS_HCS_BLUE",50,true];	
	_plane setVariable ["AWS_HCS_ALPHA",50,true];	
}
else
{

};

_red = _plane getVariable "AWS_HCS_RED";
_green = _plane getVariable "AWS_HCS_GREEN";
_blue = _plane getVariable "AWS_HCS_BLUE";
_alpha = _plane getVariable "AWS_HCS_ALPHA";

sliderSetPosition [1900, _red];
sliderSetPosition [1901, _green];
sliderSetPosition [1902, _blue];
sliderSetPosition [1903, _alpha];