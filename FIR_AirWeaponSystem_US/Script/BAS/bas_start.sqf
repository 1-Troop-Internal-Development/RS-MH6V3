_computer = _this select 0;
_caller = _this select 1;
_id = _this select 2;
_arg = _this select 3;


private _screen = _computer getVariable "AWS_BAS_SELECTED_SCREEN";
private _slide = _computer getVariable "AWS_BAS_SELECTED_SLIDE";
private _count = _computer getVariable "AWS_BAS_COUNT";

private _slideshow_data = [["CfgAWS_BAS_Slideshow",_slide],configfile] call bis_fnc_loadclass;
private _slideshow_slide = getArray (_slideshow_data >> "slides");

private _status = _computer getVariable "AWS_BAS_STATUS";

if (_status == "on") exitWith {systemChat "slideshow is already running";};

_computer setVariable ["AWS_BAS_CURRENT",0,true];
_computer setVariable ["AWS_BAS_STATUS","on",true];

private _first_slide = _slideshow_slide select 0;

private _slide = _first_slide param [0,"#(rgb,8,8,3)color(1,1,1,1)"];
private _type = _first_slide param [1,"photo"];
private _keep = _first_slide param [2,"yes"];
private _music = _first_slide param [3,""];

//keep music playin or stop and play new music
if (_keep isEqualTo "yes") then
{
//keep playing
}
else
{
	[""] remoteExec ["playMusic",([0,-2] select isDedicated),true];
};

//stop video first
[""] remoteExec ["BIS_fnc_playVideo",([0,-2] select isDedicated),true];

switch (_type) do
{
	case "photo":
	{
		_screen setObjectTextureGlobal [0,_slide];
	};
	case "video":
	{
		_screen setObjectTextureGlobal [0, _slide];
		[_slide, [10,10]] remoteExecCall ["BIS_fnc_playVideo",0,true];		
	};
	case "photomusic":
	{
		_screen setObjectTextureGlobal [0,_slide];
		[_music] remoteExec ["playMusic",([0,-2] select isDedicated),true];
	};
};

