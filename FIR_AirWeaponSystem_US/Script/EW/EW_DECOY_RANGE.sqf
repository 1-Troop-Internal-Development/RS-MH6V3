/* Open MFD By Firewill */
private ["_plane","_range_str","_range","_range_temp"];

_plane = vehicle player;
_status = _this select 0;

_mydisplay = findDisplay 5590;

_range_txt = _mydisplay displayCtrl 2003;

_range = _plane getVariable "AWS_EW_RANGE";
_range_temp = _range;
if (_status == "inc") then
{
	if (_range == 10000) exitWith {_plane vehicleChat "Maximum Range is 10km.";};
	_range_temp = _range + 500;
	_range = _range_temp;
};

if (_status == "dec") then
{
	if (_range == 1000) exitWith {_plane vehicleChat "Minimum Range is 1km."};
	_range_temp = _range - 500;
	_range = _range_temp;
};

_range_str = str _range;
_range_txt ctrlSetText _range_str;
//ctrlSetText [2003, _range_str];

_plane setVariable ["AWS_EW_RANGE",_range,true];

