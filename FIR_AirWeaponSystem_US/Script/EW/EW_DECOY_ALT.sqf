/* Open MFD By Firewill */
private ["_plane","_alt_str","_alt","_alt_temp"];

_plane = vehicle player;
_status = _this select 0;

_alt = _plane getVariable "AWS_EW_ALT";
_alt_temp = _alt;

_mydisplay = findDisplay 5590;
_alt_txt = _mydisplay displayCtrl 2004;


if (_status == "inc") then
{
	if (_alt == 10000) exitWith {_plane vehicleChat "Maximum Altitude is 10km.";};
	_alt_temp = _alt + 100;
	_alt = _alt_temp;
};

if (_status == "dec") then
{
	if (_alt == 1000) exitWith {_plane vehicleChat "Minimum Altitude is 1km."};
	_alt_temp = _alt - 100;
	_alt = _alt_temp;
};

_alt_str = str _alt;
_alt_txt ctrlSetText _alt_str;

_plane setVariable ["AWS_EW_alt",_alt,true];

