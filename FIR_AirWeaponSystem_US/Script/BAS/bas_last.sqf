_gen = _this select 0;
_caller = _this select 1;
_id = _this select 2;
_arg = _this select 3;

if (slideshows_status == "off") exitWith {hint "slideshows not running";};

slideshows_current = slideshows_count-1; 

publicVariable "slideshows_current";

_current_slide = slideshows select slideshows_current;

_slide = _current_slide select 0;
_type = _current_slide select 1;

//stop video first
[""] remoteExec ["BIS_fnc_playVideo",([0,-2] select isDedicated),true];

if (_type == "photo") then
{
	_arg setObjectTextureGlobal [0,_slide];
};
if (_type == "video") then
{
	_arg setObjectTextureGlobal [0, _slide];
	[_slide, [10,10]] remoteExec ["BIS_fnc_playVideo",([0,-2] select isDedicated),true];
};
